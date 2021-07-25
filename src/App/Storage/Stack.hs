module App.Storage.Stack where

import App.Storage.Storage

data Stack = Stack (Maybe Char) String 

instance Storage Stack where
  focus Stack Nothing _ = Nothing
  focus Stack top remain = (Maybe top, remain)
  write symbol


