module App.Alphabet where

import qualified Data.Set as Set

-- pg. 28
type Alphabet = Set.Set Char

nextString :: Alphabet -> String -> String
nextString alphabet word = word
                         where size = length word

symbolSpace :: [Char] -> (Alphabet,[String], String -> Bool)
symbolSpace characters = (alphabet, (`Set.member` allPossible))
                       where alphabet = Set.fromList characters
                             -- pg. 29 Power of an Alphabet
		             --allPossible = Set.map Set.elems (Set.powerSet alphabet)
		             allPossible = iterate (alphabet `nextString`) ""




