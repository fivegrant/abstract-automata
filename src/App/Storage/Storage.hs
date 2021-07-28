module App.Storage.Storage where

class Storage s where
  focus :: s -> [Maybe Char]
  write :: Maybe Char -> s -> s
  shift :: s -> a -> s

data Input = Input (Maybe Char) String 

instance Storage Input where
  focus (Input Nothing _) = [Nothing]
  focus (Input top remain) = [top]
  write _ x = x
  shift (Input _ (x:[])) _ = Input Nothing ""
  shift (Input _ (x:xs)) _ = Input (Just x) xs
