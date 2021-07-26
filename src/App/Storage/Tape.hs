module App.Storage.Tape where

data Tape = 
  Single {
    leftSide :: String,
    tapeHead :: Char,
    rightSide :: String
    } |
  Multiple [Tape]

{-
instance Read Tape where
  read = Single . decurry . words
-}


