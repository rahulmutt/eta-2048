-- Inspired from Graphics.Gloss.Data.Picture

module JavaFX.Picture where

import JavaFX.Types

data Picture
  = Blank
  | Rectangle Double Double
  | RoundRectangle Double Double Double Double
  | Text String
  | Color Color Picture
  | Translate Double Double Picture
  | Rotate Double Picture
  | Scale Double Double Picture
  | Pictures [Picture]

instance Monoid Picture where
  mempty      = blank
  mappend a b = Pictures [a, b]
  mconcat     = Pictures

blank :: Picture
blank = Blank

rectangleSolid :: Double -> Double -> Picture
rectangleSolid = Rectangle

roundedRect :: Int -> Double -> Double -> Double -> Picture
roundedRect _ w h r = RoundRectangle w h r r

text :: String -> Picture
text = Text

color :: Color -> Picture -> Picture
color = Color

translate :: Double -> Double -> Picture -> Picture
translate = Translate

rotate :: Double -> Picture -> Picture
rotate = Rotate

scale :: Double -> Double -> Picture -> Picture
scale = Scale

pictures :: [Picture] -> Picture
pictures = Pictures


