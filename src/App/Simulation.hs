module App.Simulation where

import App.Alphabet
import App.Transition
import App.Control
import App.Storage.Storage
import App.Storage.Tape

initiateTM :: Control -> String -> Instant Tape
initiateTM controlHead input = Instant {
    control = controlHead, 
    config = (initTape input, 0)
  }

step :: Storage a => Instant a -> [Instant a]
step instant = map toInstant $ transitionTable >>> incoming
          where transitionTable = transitions $ control instant
		(storage, currentState) = config instant 
		incoming = (focus storage, currentState)
		createInstant = Instant (control instant)
                toInstant (Finite _ newState) = createInstant (shift storage Rightward, newState)
                toInstant (Cell _ (symbol, direction, newState)) =  createInstant (shift (write symbol storage) direction, newState)

halted :: Storage a => Instant a -> Bool
halted x = null $ step x

accept :: Storage a => Instant a -> Bool
accept (Instant machine (storage, state)) = (elem state $ acceptingStates machine) && halted (Instant machine (storage, state))

-- Currently only works deterministically (only grabs first element of each step)
run :: Storage a => Instant a -> Bool
run x = if halted x
        then accept x
        else run $ (!!0) $ step x

solve :: Control -> String -> Bool
solve controlHead input = run $ initiateTM controlHead input

-- eval :: Storage -> (Char, Storage)
-- (|-) :: Instance -> Instance -> Bool
-- (|-*) :: Instance -> Instance -> Bool
