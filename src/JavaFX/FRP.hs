module JavaFX.FRP where

import Control.Monad (when)
import Data.IORef (newIORef, writeIORef, readIORef)
import JavaFX.Picture (Picture, blank)
import JavaFX.Types (Color, KeyEvent)
import JavaFX.Main (playFX)
import FRP.Yampa (Event(..), SF, reactInit, react)

playYampa :: (String, Color, Double, Double) -> SF (Event KeyEvent) Picture -> IO ()
playYampa display mainSF = do
  picRef <- newIORef blank

  handle <- reactInit
    (return NoEvent)
    (\_ updated pic -> when updated (picRef `writeIORef` pic) >> return False)
    mainSF

  playFX display 0
         (const $ readIORef picRef)
         (\e t -> react handle (delta, Just (Event e)) >> return (t + delta))
         (\d t -> let delta' = realToFrac d - t
                  in if delta' > 0
                     then react handle (delta', Just NoEvent) >> return 0.0
                     else return (-delta'))

  where delta = 0.01 / frequency
        frequency = 60


