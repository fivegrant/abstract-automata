module App.Storage.Stack where

{-
import App.Storage.Storage

data Stack = Stack Input Input 

instance Storage Stack where
  focus (Stack input pile) = [(focus input) !! 0 , (focus pile) !! 0]
  write x (Stack input (Input top remain)) = Stack input (Input x remain)
  shift (Stack input (Input Nothing remain)) _ = Stack (shift input Rightward) (shift (Input Nothing remain) Rightward)
  shift (Stack input remaining) _ = Stack (shift input Rightward) remaining
-}
