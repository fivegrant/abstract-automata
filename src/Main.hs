module Main where

import System.Environment
import App.Alphabet

main :: IO ()
main = do
  let (alphabet, valid) = symbolSpace ['0','1']
  putStrLn $ show alphabet
  putStrLn $ show $ valid "001100"
  putStrLn $ show $ valid "101100"
  putStrLn $ show $ valid "10110a"
  putStrLn $ show $ valid "a10110"
  putStrLn "Turing Machine go brrrr"
