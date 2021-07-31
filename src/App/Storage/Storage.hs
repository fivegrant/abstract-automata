module App.Storage.Storage where


data Direction = Leftward | Rightward deriving (Eq, Ord)

data Input = Input (Maybe Char) String 

class Storage s where
  focus :: s -> Maybe Char
  write :: Maybe Char -> s -> s
  shift :: s -> Direction -> s


instance Storage Input where
  focus (Input top _) = top
  write _ x = x
  shift (Input _ (x:[])) _ = Input Nothing ""
  shift (Input _ (x:xs)) _ = Input (Just x) xs
