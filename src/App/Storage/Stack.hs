module App.Storage.Stack where

import App.Storage.Storage

data Stack = Stack (Maybe Char) String 

instance Storage Stack where
  focus Stack Nothing _ = Nothing
  focus Stack top remain = (Maybe top, remain)
  write Nothing (Stack top "") = Stack Nothing ""
  write Nothing (Stack top (x:xs)) = Stack Maybe x xs 
  write x (Stack top remain) = Stack x (top:remain)
