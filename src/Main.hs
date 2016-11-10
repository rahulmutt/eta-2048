import System.Random (newStdGen, StdGen)
import FRP.Yampa (Event(..), SF, arr, tag, (>>>))
import JavaFX hiding (Event)
import JavaFX.Picture
import JavaFX.FRP

import Types
import Game
import Rendering

-- | Our game uses up, down, left and right arrows to make the moves, so
-- the first thing we want to do is to parse the Gloss Event into something
-- we are happy to work with (Direction data type)
parseInput :: SF (Event KeyEvent) GameInput
parseInput = arr f
  where f event@(Event e)
          | is keyUP    = event `tag` Types.Up
          | is keyDOWN  = event `tag` Types.Down
          | is keyLEFT  = event `tag` Types.Left
          | is keyRIGHT = event `tag` Types.Right
          | otherwise   = event `tag` None
          where is = equals (getCode e)
        f event = event `tag` None

-- | After parsing the game input and reacting to it we need to draw the
-- current game state which might have been updated
drawGame :: SF GameState Picture
drawGame = arr drawBoard

-- | Our main signal function which is responsible for handling the whole
-- game process, starting from parsing the input, moving to the game logic
-- based on that input and finally drawing the resulting game state to
-- Gloss' Picture
mainSF :: StdGen -> SF (Event KeyEvent) Picture
mainSF g = parseInput >>> wholeGame g >>> drawGame

main :: IO ()
main = do
    g <- newStdGen
    playYampa ("2048 game", white, 410, 500) (mainSF g)
