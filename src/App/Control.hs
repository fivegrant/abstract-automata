module App.Control where

import App.Alphabet

-- Finite Automata pg. 45-77
-- Start state is always assumed to be q0
-- Maybe.Nothing will be used in place of ϵ
-- Instead
data States = States { states :: Int, final :: [Int]} deriving (Eq)
data Storage = Input Char String | 
               Stack Input Input | 
               Tape String | -- String instead of Char allows for MultiTrack
               MultiTape [Tape]
instance Show Storage where
    show Input focus remaining = focus ++ remaining
    show Stack input stack = show input ++ "\n" ++ show stack
    show Tape tape = "..." ++ tape ++ "..."
    show MultiTape tapes = foldl 
-- instance Read Storage where

data Transition = Transition {
    state :: Int

    }

data Control = Control { 
    states :: States, 
    transition :: [Transition],
    terminals :: Alphabet,
    nonterminals :: Alphabet,
    storage :: Storage
    } deriving (Eq)

-- pg. 230 Instantaneous Descriptions shall be referred to as 'Instant'
data Instant = Instant { 
   control :: Control,
   config :: (Int, Storage) -- usually
   }

-- automataClass :: Control -> String
-- eval :: Storage -> (Char, Storage)
-- finish :: Instance -> Bool
-- (|-) :: Instance -> Instance -> Bool
-- (|-*) :: Instance -> Instance -> Bool
-- step :: Instance -> Instance
-- run :: Instance -> Instance
