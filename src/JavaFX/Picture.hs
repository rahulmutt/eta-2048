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

-- instance Show Picture where
--   show Blank                    = "Blank"
--   show (Rectangle _ _)          = "Rectangle"
--   show (RoundRectangle _ _ _ _) = "RoundRectangle"
--   show (Text _)                 = "Text"
--   show (Color _ _)              = "Color"
--   show (Translate _ _ _)        = "Translate"
--   show (Rotate _ _)             = "Rotate"
--   show (Scale _ _ _)            = "Scale"
--   show (Pictures _)             = "Pictures"

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

isText :: Picture -> Bool
isText (Text _) = True
isText _        = False
