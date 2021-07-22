module Main where

import System.Environment
import App.Alphabet

main :: IO ()
main = do
  let (alphabet, valid) = symbolSpace ['0','1']
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
