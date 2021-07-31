module App.Control where

import App.Alphabet
import App.Transition

-- Finite Automata pg. 45-77
-- Start state is always assumed to be q0
-- Maybe.Nothing will be used in place of ϵ
-- Instead

data Control = Control { 
    acceptingStates :: [Int], 
    transition :: [Transition],
    terminals :: Alphabet,
    nonterminals :: Alphabet
    } deriving (Eq)

-- pg. 230 Instantaneous Descriptions shall be referred to as 'Instant'
data Instant storage = Instant { 
   control :: Control,
   config :: (Int, storage) -- usually
   }

