module App.Storage.Stack where

import App.Storage.Storage

data Stack = Stack Input Input 

instance Storage Stack where
  focus Stack input pile = [focus input , focus pile]
  write x (Stack input (Input top remain)) = Stack input (Input x remain)
  shift (Stack input (Input Nothing remaining)) _ = Stack (shift input) (shift remaining)
  shift (Stack input remaining) _ = Stack (shift input) remaining
