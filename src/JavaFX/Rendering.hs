{-# LANGUAGE FlexibleContexts #-}
module JavaFX.Rendering where

import Java
import JavaFX.Types
import Data.Int (Int64)

type Render a = Java GraphicsContext a

-- Scene
foreign import java unsafe "@new"
  newScene :: (Extends a Parent, Extends b Paint)
           => a -> Double -> Double -> b -> Java c Scene

foreign import java unsafe "@new"
  newGroup :: Java c Group

foreign import java unsafe getWidth :: Java Stage Double
foreign import java unsafe getHeight :: Java Stage Double

foreign import java unsafe "@new" newCanvas :: Double -> Double -> Java a Canvas

-- Graphics Context
foreign import java unsafe getGraphicsContext2D :: Java Canvas GraphicsContext

foreign import java unsafe
  clearRect :: Double -> Double -> Double -> Double -> Render ()

foreign import java unsafe
  fillRect :: Double -> Double -> Double -> Double -> Render ()

foreign import java unsafe
  fillRoundRect :: Double -> Double -> Double -> Double
                -> Double -> Double -> Render ()

foreign import java unsafe setFill :: (Extends a Paint) => a -> Render ()

foreign import java unsafe setStroke :: (Extends a Paint) => a -> Render ()

foreign import java unsafe translate :: Double -> Double -> Render ()

foreign import java unsafe scale :: Double -> Double -> Render ()

foreign import java unsafe rotate :: Double -> Render ()

foreign import java unsafe save :: Render ()

foreign import java unsafe restore :: Render ()

foreign import java unsafe "@static @field javafx.scene.text.TextAlignment.CENTER"
  alignCenter :: TextAlignment

foreign import java unsafe "@static @field javafx.geometry.VPos.CENTER"
  vposCenter :: VPos

foreign import java unsafe setTextAlign    :: TextAlignment -> Render ()
foreign import java unsafe setTextBaseline :: VPos -> Render ()

foreign import java unsafe "strokeText" strokeText :: String -> Double -> Double -> Render ()

foreign import java unsafe "fillText" fillText :: String -> Double -> Double -> Render ()

-- Main Loop
foreign import java unsafe "@wrapper @abstract handle"
  animationTimer :: (Int64 -> Java AnimationTimer ()) -> AnimationTimer

foreign import java unsafe "start" animationStart :: Java AnimationTimer ()

-- Color
foreign import java unsafe "@static javafx.scene.paint.Color.rgb"
  makeColor :: Int -> Int -> Int -> Double -> Color

makeColorI :: Int -> Int -> Int -> Int -> Color
makeColorI r g b a = makeColor r g b (fromIntegral a / 255)

black, white :: Color
black = makeColorI 0   0   0   255
white = makeColorI 255 255 255 255

-- KeyCodes
foreign import java unsafe "@static @field javafx.scene.input.KeyCode.UP" keyUP :: KeyCode
foreign import java unsafe "@static @field javafx.scene.input.KeyCode.DOWN" keyDOWN :: KeyCode
foreign import java unsafe "@static @field javafx.scene.input.KeyCode.LEFT" keyLEFT :: KeyCode
foreign import java unsafe "@static @field javafx.scene.input.KeyCode.RIGHT" keyRIGHT :: KeyCode

-- KeyEvent
foreign import java unsafe getCode :: KeyEvent -> KeyCode

-- Event Handling
foreign import java unsafe "@wrapper handle"
  handleEvent :: (Extends a Event)
              => (a -> Java (EventHandler a) ())
              -> EventHandler a

foreign import java unsafe "setOnKeyPressed" setOnKeyPressed' ::
  EventHandler KeyEvent -> Java Scene ()

setOnKeyPressed :: (KeyEvent -> Java (EventHandler KeyEvent) ()) -> Java Scene ()
setOnKeyPressed f = setOnKeyPressed' (handleEvent f)

foreign import java unsafe "getChildren" getChildren :: (Extends c Parent) => Java c (ObservableList Node)

foreign import java unsafe "@interface add" addChild :: (Extends a Object, Extends b a) => b -> Java (ObservableList a) Bool

foreign import java unsafe "show" showStage :: Java Stage ()

foreign import java unsafe "setTitle" setTitle :: String -> Java Stage ()

foreign import java unsafe "setScene" setScene :: Scene -> Java Stage ()

foreign import java safe "@static javafx.application.Application.launch"
  launch :: JClass a -> JStringArray -> IO ()
