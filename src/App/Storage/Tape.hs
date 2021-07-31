module App.Storage.Tape where

import App.Storage.Storage

data Tape = 
  Tape {
    leftSide :: [Maybe Char],
    tapeHead :: Maybe Char,
    rightSide :: [Maybe Char]
    }

instance Storage Tape where
  focus (Tape _ mid _) = mid
  write x (Tape left _ right) = Tape left x right
  shift (Tape left mid [Nothing]) Rightward = Tape (left ++ [mid]) Nothing [Nothing]
  shift (Tape left mid right) Rightward = Tape (left ++ [mid]) (head right) (tail right)
  shift (Tape [Nothing] mid right) Leftward = Tape [Nothing] Nothing (right)
  shift (Tape left mid right) Leftward = Tape (init left) (last left) (mid:right)

initTape "" = Tape [Nothing] Nothing [Nothing]
initTape (x:xs) = Tape [Nothing] (Just x) (map (\a -> Just a) xs)
