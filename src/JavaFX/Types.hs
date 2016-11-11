{-# LANGUAGE MagicHash, TypeFamilies #-}
module JavaFX.Types where

data {-# CLASS "javafx.application.Application" #-} Application
  = Application (Object# Application)

data {-# CLASS "javafx.scene.Node" #-} Node
  = Node (Object# Node)

type instance Super Node = Object

instance Class Node where
  obj = Node
  unobj (Node o) = o

data {-# CLASS "javafx.stage.Stage" #-} Stage
  = Stage (Object# Stage)

type instance Super Stage = Object

instance Class Stage where
  obj = Stage
  unobj (Stage o) = o

data {-# CLASS "javafx.scene.Scene" #-} Scene
  = Scene (Object# Scene)

type instance Super Scene = Object

instance Class Scene where
  obj = Scene
  unobj (Scene o) = o

data {-# CLASS "javafx.scene.Parent" #-} Parent
  = Parent (Object# Parent)

type instance Super Parent = Node

instance Class Parent where
  obj = Parent
  unobj (Parent o) = o

data {-# CLASS "javafx.scene.Group" #-} Group
  = Group (Object# Group)

instance Class Group where
  obj = Group
  unobj (Group o) = o

type instance Super Group = Parent

data {-# CLASS "javafx.scene.paint.Color" #-} Color = Clr (Object# Color)

instance Class Color where
  obj = Clr
  unobj (Clr o) = o

type instance Super Color = Paint

data {-# CLASS "javafx.scene.paint.Paint" #-} Paint = Paint (Object# Paint)

instance Class Paint where
  obj = Paint
  unobj (Paint o) = o

data {-# CLASS "javafx.scene.input.KeyCode" #-} KeyCode = KeyCode (Object# KeyCode)

instance Class KeyCode where
  obj = KeyCode
  unobj (KeyCode o) = o

type instance Super KeyCode = Object

data {-# CLASS "javafx.scene.input.KeyEvent" #-} KeyEvent = KeyEvent (Object# KeyEvent)

type instance Super KeyEvent = InputEvent

instance Class KeyEvent where
  obj = KeyEvent
  unobj (KeyEvent o) = o

data {-# CLASS "javafx.scene.input.InputEvent" #-} InputEvent = InputEvent (Object# InputEvent)

type instance Super InputEvent = Event

instance Class InputEvent where
  obj = InputEvent
  unobj (InputEvent o) = o

data {-# CLASS "javafx.event.Event" #-} Event = Event (Object# Event)

type instance Super Event = Object

instance Class Event where
  obj = Event
  unobj (Event o) = o

data {-# CLASS "javafx.event.EventHandler" #-} EventHandler a
  = EventHandler (Object# (EventHandler a))

instance Class (EventHandler a) where
  obj = EventHandler
  unobj (EventHandler o) = o

data {-# CLASS "javafx.scene.canvas.Canvas" #-} Canvas = Canvas (Object# Canvas)

type instance Super Canvas = Node

instance Class Canvas where
  obj = Canvas
  unobj (Canvas o) = o

data {-# CLASS "javafx.scene.canvas.GraphicsContext" #-} GraphicsContext
  = GraphicsContext (Object# GraphicsContext)

type instance Super GraphicsContext = Object

instance Class GraphicsContext where
  obj = GraphicsContext
  unobj (GraphicsContext o) = o


data {-# CLASS "javafx.animation.AnimationTimer" #-} AnimationTimer
  = AnimationTimer (Object# AnimationTimer)

type instance Super AnimationTimer = Object

instance Class AnimationTimer where
  obj = AnimationTimer
  unobj (AnimationTimer o) = o

data {-# CLASS "javafx.collections.ObservableList a" #-} ObservableList a
  = ObservableList (Object# (ObservableList a))

instance Class (ObservableList a) where
  obj = ObservableList
  unobj (ObservableList o) = o

data {-# CLASS "javafx.scene.text.TextAlignment" #-} TextAlignment
  = TextAlignment (Object# TextAlignment)

data {-# CLASS "javafx.geometry.VPos" #-} VPos
  = VPos (Object# VPos)
