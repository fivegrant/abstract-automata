module App.Simulation where

import App.Alphabet
import App.Transition
import App.Storage.Storage
import App.Storage.Stack
import App.Storage.Tape

-- Defaults
(inputSymbols, inputChecker) = symbolSpace ['a'...'z']
(tapeSymbols, tapeChecker) = symbolSpace ['X', 'Y', 'Z']

initiateTM :: Control -> String -> (Instant Turing, (String -> Bool, String -> Bool))
initiateTM controlHead input = Instant {
  control = controlHead , 
  config = (0, initTape input )
  }

step :: Storage a => Instance a -> Instance a
-- run :: Instance -> Instance
-- eval :: Storage -> (Char, Storage)
-- finish :: Instance -> Bool
-- (|-) :: Instance -> Instance -> Bool
-- (|-*) :: Instance -> Instance -> Bool
