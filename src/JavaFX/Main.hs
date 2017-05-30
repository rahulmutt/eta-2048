{-# LANGUAGE MagicHash #-}
module JavaFX.Main where

import System.Environment
import Data.IORef
import Data.Proxy
import System.IO.Unsafe
import Java
import JavaFX.Types
import JavaFX.Picture (Picture(..), isText)
import JavaFX.Rendering

data {-# CLASS "org.eta.JavaFXApp extends javafx.application.Application" #-}
  JavaFXApp = JavaFXApp (Object# JavaFXApp)
  deriving Class

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
  launch (getClass (Proxy :: Proxy JavaFXApp)) jargs
  where startAction worldSR stage = do
          root  <- newGroup
          scene <- newScene root width height backgroundColor
          canvas <- newCanvas width height
          gc <- canvas <.> getGraphicsContext2D
          gc <.> setTextAlign alignCenter
          gc <.> setTextBaseline vposCenter
          animationTimer (mainLoop stage worldSR gc) <.> animationStart
          _ <- root <.> getChildren >- addChild canvas
          scene <.> setOnKeyPressed
            (\ke -> io $ do
                world <- readIORef worldSR
                world' <- worldHandleEvent ke world
                writeIORef worldSR world')
          stage <.> (do
            setTitle title
            setScene scene
            showStage)

        mainLoop stage worldSR gc _ = do
          world <- io $ readIORef worldSR
          picture <- io $ worldToPicture world
          width' <- stage <.> getWidth
          height' <- stage <.> getHeight
          gc <.> renderAction width' height' (drawPicture picture)
          io $ do
            world' <- worldAdvance (1 / 60) world
            writeIORef worldSR world'

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
  where go [] picture = do
          case picture of
            Blank                    -> return ()
            Rectangle w h            -> fillRect (-w / 2) (h / 2) w h
            RoundRectangle w h rw rh -> fillRoundRect (-w / 2) (h / 2) w h rw rh
            Text t                   -> fillText t 0 0
            Pictures ps              -> mapM_ (go []) ps
            _                        -> go [Blank] picture
        go ts picture = do
          case picture of
            Color     c   p -> go (Color     c   Blank : ts) p
            Translate x y p -> go (Translate x y Blank : ts) p
            Rotate    deg p -> go (Rotate    deg Blank : ts) p
            Scale     x y p -> go (Scale     x y Blank : ts) p
            p               -> saveAndRestore $ do
              mapM_ applyTrans (if isText p
                                then Scale 1 (-1) Blank : ts
                                else ts)
              go [] p
        applyTrans (Color     c   _) = setFill c >> setStroke c
        applyTrans (Translate x y _) = translate x y
        applyTrans (Rotate    deg _) = rotate deg
        applyTrans (Scale     x y _) = scale x y
        applyTrans _                 = return ()

saveAndRestore :: Render () -> Render ()
saveAndRestore render = save >> render >> restore

startRef :: IORef (Stage -> FX ())
startRef = unsafePerformIO (newIORef undefined)

start :: Stage -> FX ()
start = unsafePerformIO (readIORef startRef)

foreign export java start :: Stage -> FX ()
