module Main where

import System.Environment
import App.Alphabet
import App.Control

main :: IO ()
main = do
  let (alphabet, valid) = symbolSpace ['0','1']
  let (tapeSymbols, validTape) = symbolSpace ['X','Y']
  let table = [ Cell (Maybe '0', 0) (Maybe 'X', Rightward, 1)
              , Cell (Maybe 'Y', 0) (Maybe 'Y', Rightward, 3)
              , Cell (Maybe '0', 1) (Maybe '0', Rightward, 1)
              , Cell (Maybe 'Y', 1) (Maybe 'Y', Rightward, 1)
              , Cell (Maybe '1', 1) (Maybe 'Y', Leftward,  2)
              , Cell (Maybe 'Y', 2) (Maybe 'Y', Leftward,  2)
              , Cell (Maybe '0', 2) (Maybe '0', Leftward,  2)
              , Cell (Maybe 'X', 2) (Maybe 'X', Rightward, 2)
              , Cell (Maybe 'Y', 3) (Maybe 'Y', Rightward, 3)
              , Cell (Nothing,   3) (Nothing,   Rightward, 4)
              ]
  let controlHead = Control {
    acceptingStates = [4],
    transition = table,
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
  putStrLn $ show alphabet
  putStrLn "Should be TRUE"
  putStrLn $ show $ valid "0"
  putStrLn $ show $ valid ""
  putStrLn $ show $ valid "001100"
  putStrLn $ show $ valid "101100"
  putStrLn "Should be FALSE"
  putStrLn $ show $ valid "10110a"
  putStrLn $ show $ valid "a10110"
  putStrLn "Print 0"
  putStrLn $ nextString alphabet ""
  putStrLn "Print 1"
  putStrLn $ nextString alphabet "0"
  putStrLn "Print 0000"
  putStrLn $ nextString alphabet "111"
  putStrLn "Print 1001"
  putStrLn $ nextString alphabet "1000"
  putStrLn "Print 1010"
  putStrLn $ nextString alphabet "1001"
  putStrLn "Basic Tests Complete"
