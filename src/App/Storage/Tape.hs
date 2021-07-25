module App.Storage.Tape where

data Tape = 
  Single {
    left :: String,
    tapeHead :: Maybe Char,
    right :: String
    } |
  Multiple [Single]

instance Read Tape where
  read = Single . decurry . words


