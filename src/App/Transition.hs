module App.Transition where

data Transition storage = Transition {
    given :: (Int, Char, storage),
    result ::(Int, storage)
    }


