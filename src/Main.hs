module Main where

import System.Environment
import App.Alphabet
import App.Control
import App.Transition
import App.Simulation
import App.Storage.Storage

main :: IO ()
main = do
  let (alphabet, valid) = symbolSpace ['0','1']
  let (tapeSymbols, validTape) = symbolSpace ['X','Y']
  let table = [ Cell (Just '0', 0) (Just 'X', Rightward, 1)
              , Cell (Just 'Y', 0) (Just 'Y', Rightward, 3)
              , Cell (Just '0', 1) (Just '0', Rightward, 1)
              , Cell (Just '1', 1) (Just 'Y', Leftward,  2)
              , Cell (Just 'Y', 1) (Just 'Y', Rightward, 1)
              , Cell (Just '0', 2) (Just '0', Leftward,  2)
              , Cell (Just 'X', 2) (Just 'X', Rightward, 0)
              , Cell (Just 'Y', 2) (Just 'Y', Leftward,  2)
              , Cell (Just 'Y', 3) (Just 'Y', Rightward, 3)
              , Cell (Nothing,  3) (Nothing,  Rightward, 4)
              ]
  let controlHead = Control {
    acceptingStates = [4],
    transitions = table,
    terminals = alphabet,
    nonterminals = tapeSymbols
  }
  putStrLn "Is 0"
  putStrLn $ show $ solve controlHead "0" 
  putStrLn "Is 01"
  putStrLn $ show $ solve controlHead "01" 
  putStrLn "Is 011"
  putStrLn $ show $ solve controlHead "011" 
  putStrLn "Is 11"
  putStrLn $ show $ solve controlHead "11" 
  putStrLn "Is 0011"
  putStrLn $ show $ solve controlHead "0011" 
