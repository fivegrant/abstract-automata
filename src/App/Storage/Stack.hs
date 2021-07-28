module App.Storage.Stack where

import App.Storage.Storage

data Stack = Stack Input Input 

instance Storage Stack where
  focus Stack Nothing _ = Nothing
  focus Stack top remain = (Maybe top, remain)
  write Nothing (Stack top "") = Stack Nothing ""
  write Nothing (Stack top (x:xs)) = Stack Maybe x xs 
  write x (Stack top remain) = Stack x (top:remain)

  focus (Input Nothing _) = [Nothing]
  focus (Input top remain) = [top]
  write _ x = x
  shift (Input _ (x:[])) _ = Input Nothing ""
  shift (Input _ (x:xs)) _ = Input (Just x) xs
