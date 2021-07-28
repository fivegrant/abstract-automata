module App.Storage.Tape where

import App.Storage.Storage

data Direction = Left | Right deriving (Eq, Ord)

data Tape = 
  Single {
    leftSide :: [Maybe Char],
    tapeHead :: Maybe Char,
    rightSide :: [Maybe Char]
    }

instance Storage Tape where
  focus (Single _ Nothing _) = Nothing
  focus (Single _ mid _) = Just mid
  write x (Single left _ right) = Single left x right
  shift (Tape left mid [Nothing]) Right = Tape (left ++ [mid]) Nothing [Nothing]
  shift (Tape left mid right) Right = Tape (left ++ [mid]) (head right) (tail right)
  shift (Tape [Nothing] mid right) Left = Tape [Nothing] Nothing (right)
  shift (Tape left mid right) Left = Tape (init left) (last left)  (mid:right)

initTape "" = Single [Nothing] Nothing [Nothing]
initTape (x:xs) = Single [Nothing] (Maybe x) (map (\a -> Maybe a) xs)
