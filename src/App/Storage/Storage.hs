module App.Storage.Storage where

class Storage s where
  focus :: s -> Maybe Char 
  write :: Maybe Char -> s -> s
  shift :: s -> a -> s

instance Storage String where
  focus "" = Nothing
  focus (x:xs) = x
  write _ word = word
  shift word _ = word

