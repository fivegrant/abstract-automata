module App.Simulation where

import App.Alphabet
import App.Transition
import App.Control
import App.Storage.Storage
import App.Storage.Stack
import App.Storage.Tape

-- Defaults
(defaultInputSymbols, inputChecker) = symbolSpace ['a'...'z']
(defaultTapeSymbols, tapeChecker) = symbolSpace ['X', 'Y', 'Z']

initiateTM :: Control -> String -> (Instant Turing, (String -> Bool, String -> Bool))
initiateTM controlHead input = Instant {
    control = controlHead, 
    config = (0, initTape input)
  }

step :: Storage a => Instant a -> [Instant a]
step (Instant machine (state, storage)) = map updateInstant resulting
             where incoming = (focus storage, state)
                   resulting = (transition machine) `transform` incoming
		   createInstant newChar newDirection newState = Instant machine (newState, (write newChar) `shift` newDirection)
		   updateInstant (newChar, newDirection, newState) = createInstant newChar newDirection newState
		   updateInstant (newChar, newState) = createInstant newChar Right newState
		   updateInstant newState = createInstant Nothing Right newState
		   
halted :: Instant a -> Bool
halted x = step x == []

accept :: Instant a -> Bool
accept (Instant machine (state, storage)) = (elem state acceptingStates machine) && halted x

-- Currently only works deterministically (only grabs first element of each step)
run :: Instant a -> Instant a
run x = if halted x
        then accept x
	else run (x !! 0)

solve = accept . run . initiateTM

-- eval :: Storage -> (Char, Storage)
-- (|-) :: Instance -> Instance -> Bool
-- (|-*) :: Instance -> Instance -> Bool
