module App.Alphabet where

import Data.Maybe
import qualified Data.Set as Set

-- pg. 28
type Alphabet = Set.Set Char

nextString :: Alphabet -> String -> String
nextString alphabet word 
                       | null alphabet = ""
                       | otherwise = let
                               size = length word
                               min = Set.findMin alphabet
                               max = Set.findMax alphabet
                               last = replicate size max
                               swapSymbol i symbol string = left ++ [symbol] ++ (tail right)
                                                          where (left,right) = splitAt i string
                               nextSymbol = fromJust . (`Set.lookupGT` alphabet)
                               changeSymbol i string 
                                                    | size == 0 = [min]
                                                    | i == -1 = [min] ++ string
                                                    | string !! i == max = changeSymbol (i-1) (swapSymbol i min string)
                                                    | otherwise = swapSymbol i (nextSymbol (string !! i)) string
                          in 
                          changeSymbol (size - 1) word

symbolSpace :: [Char] -> (Alphabet, String -> Bool)
symbolSpace characters = (alphabet, (allPossible))
                       where alphabet = Set.fromList characters
                             -- pg. 29 Power of an Alphabet
                             allPossible
                                        | null alphabet = \x -> False
                                        | otherwise = ((`Set.member`alphabet) `all`)

