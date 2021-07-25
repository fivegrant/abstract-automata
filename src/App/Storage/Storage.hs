module App.Storage.Storage where

class Storage s where
  focus :: s -> (Maybe Char, s)
  write :: Char -> s -> s

instance Storage String where
  focus "" = Nothing
  focus (x:xs) = (Just x, xs)
  write symbol word = [symbol] ++ word


