module App.Storage.Storage where

class Storage s where
  focus :: s -> (String, s)
  write :: Char -> s -> s

instance Storage String where
  focus "" = ""
  focus (x:xs) = (x, xs)
  write symbol word = [symbol] ++ word

