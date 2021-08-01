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
  shift (Tape left mid []) Rightward = Tape (left ++ [mid]) Nothing []
  shift (Tape left mid right) Rightward = Tape (left ++ [mid]) (head right) (tail right)
  shift (Tape [] mid right) Leftward = Tape [] Nothing (right)
  shift (Tape left mid right) Leftward = Tape (init left) (last left) (mid:right)

initTape "" = Tape [Nothing] Nothing [Nothing]
initTape (x:xs) = Tape [] (Just x) (map (\a -> Just a) xs)
