{-# LANGUAGE MagicHash #-}
module JavaFX.Main where

import System.Environment
import Data.IORef
import System.IO.Unsafe
import Java
import JavaFX.Types
import JavaFX.Picture (Picture(..))
import JavaFX.Rendering

data {-# CLASS "org.eta.JavaFXApp extends javafx.application.Application" #-}
  JavaFXApp = JavaFXApp (Object# JavaFXApp)

type FX a = Java JavaFXApp a

playFX :: (String, Color, Double, Double)
       -> world
       -> (world -> IO Picture)
       -> (KeyEvent -> world -> IO world)
       -> (Float -> world -> IO world)
       -> IO ()
playFX (title, backgroundColor, width, height)
  worldStart worldToPicture worldHandleEvent worldAdvance = do
  worldSR <- newIORef worldStart
  writeIORef startRef (startAction worldSR)
  jargs <- getJavaArgs
  launch (getClass "org.eta.JavaFXApp") jargs
  where startAction worldSR stage = do
          root  <- newGroup
          scene <- newScene root width height backgroundColor
          canvas <- newCanvas width height
          gc <- canvas <.> getGraphicsContext2D
          animationTimer (mainLoop stage worldSR gc) <.> animationStart
          root <.> getChildren >- addChild canvas
          stage <.> (do
            setTitle title
            setScene scene
            showStage)

        mainLoop stage worldSR gc now = do
          world <- io $ readIORef worldSR
          picture <- io $ worldToPicture world
          width <- stage <.> getWidth
          height <- stage <.> getHeight
          gc <.> renderAction width height (drawPicture picture)

renderAction :: Double -> Double -> Render () -> Render ()
renderAction width height render = do
  clearRect 0 0 width height
  saveAndRestore $ do
    -- Center the coordinate system
    translate (width / 2) (height / 2)
    scale 1 (-1)
    render

drawPicture :: Picture -> Render ()
drawPicture = go []
  where go _ picture =
          case picture of
            Blank                    -> return ()
            Rectangle w h            -> fillRect (-w / 2) (h / 2) w h
            RoundRectangle w h rw rh -> fillRoundRect (-w / 2) (h / 2) w h rw rh
            Text t                   -> saveAndRestore $ scale 1 (-1) >> strokeText t 0 0
            Color c p                -> saveAndRestore $
              setFill c >> setStroke c >> go [] p
            Translate x y p -> saveAndRestore $
              translate x y >> go [] p -- TODO: Make a stack
            Rotate deg p -> saveAndRestore $
              rotate deg >> go [] p -- TODO: Make a stack
            Scale x y p -> saveAndRestore $
              scale x y >> go [] p -- TODO: Make a stack
            Pictures ps -> mapM_ (go []) ps

saveAndRestore :: Render () -> Render ()
saveAndRestore render = save >> render >> restore

startRef :: IORef (Stage -> FX ())
startRef = unsafePerformIO (newIORef undefined)

start :: Stage -> FX ()
start = unsafePerformIO (readIORef startRef)

foreign export java start :: Stage -> FX ()
