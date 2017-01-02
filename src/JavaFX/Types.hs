{-# LANGUAGE MagicHash, TypeFamilies, DataKinds #-}
module JavaFX.Types where

import Java

data {-# CLASS "javafx.application.Application" #-} Application
  = Application (Object# Application)
  deriving Class

data {-# CLASS "javafx.scene.Node" #-} Node
  = Node (Object# Node)
  deriving Class


data {-# CLASS "javafx.stage.Stage" #-} Stage
  = Stage (Object# Stage)
  deriving Class

data {-# CLASS "javafx.scene.Scene" #-} Scene
  = Scene (Object# Scene)
  deriving Class

data {-# CLASS "javafx.scene.Parent" #-} Parent
  = Parent (Object# Parent)
  deriving Class

type instance Inherits Parent = '[Node]

data {-# CLASS "javafx.scene.Group" #-} Group
  = Group (Object# Group)
  deriving Class

type instance Inherits Group = '[Parent]

data {-# CLASS "javafx.scene.paint.Color" #-} Color
  = Clr (Object# Color)
  deriving Class

type instance Inherits Color = '[Paint]

data {-# CLASS "javafx.scene.paint.Paint" #-} Paint = Paint (Object# Paint)
  deriving Class

data {-# CLASS "javafx.scene.input.KeyCode" #-} KeyCode = KeyCode (Object# KeyCode)
  deriving (Class, Eq)

data {-# CLASS "javafx.scene.input.KeyEvent" #-} KeyEvent = KeyEvent (Object# KeyEvent)
  deriving Class

type instance Inherits KeyEvent = '[InputEvent]

data {-# CLASS "javafx.scene.input.InputEvent" #-} InputEvent = InputEvent (Object# InputEvent)
  deriving Class

type instance Inherits InputEvent = '[Event]

data {-# CLASS "javafx.event.Event" #-} Event = Event (Object# Event)
  deriving Class

data {-# CLASS "javafx.event.EventHandler" #-} EventHandler a
  = EventHandler (Object# (EventHandler a))
  deriving Class

data {-# CLASS "javafx.scene.canvas.Canvas" #-} Canvas = Canvas (Object# Canvas)
  deriving Class

type instance Inherits Canvas = '[Node]

data {-# CLASS "javafx.scene.canvas.GraphicsContext" #-} GraphicsContext
  = GraphicsContext (Object# GraphicsContext)
  deriving Class

data {-# CLASS "javafx.animation.AnimationTimer" #-} AnimationTimer
  = AnimationTimer (Object# AnimationTimer)
  deriving Class

data {-# CLASS "javafx.collections.ObservableList a" #-} ObservableList a
  = ObservableList (Object# (ObservableList a))
  deriving Class

data {-# CLASS "javafx.scene.text.TextAlignment" #-} TextAlignment
  = TextAlignment (Object# TextAlignment)

data {-# CLASS "javafx.geometry.VPos" #-} VPos
  = VPos (Object# VPos)
