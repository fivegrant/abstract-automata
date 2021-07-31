module App.Transition where

import App.Storage.Storage
import App.Storage.Tape

data Transition = 
    Finite {
      fromState :: (Maybe Char, Int),
      resultState :: Int
    } |
    {-
    Stacked {
      fromStackState ::((Maybe Char, Maybe Char), Int),
      resultStackState :: (Maybe Char, Int)
    } |
    -}
    Cell {
      fromCell :: (Maybe Char, Int),
      toCell :: (Maybe Char, Direction, Int)
    } deriving (Eq, Ord)

concurrent :: Transition -> Transition -> Bool
concurrent (Finite (a, b) _) (Finite (x, y) _) = (x == a) && (b == y)
concurrent _ _ = False

transform :: [Transition] -> (Maybe Char, Int) -> [b]
transform transitionTable (input, state) = foldl (findTransform) [] transitionTable
          where target (x:[]) = (x, state)
	        target (x:y:[]) = ((x,y),state)
		incoming = target input
	        findTransform [] _ = []
                findTransform (Cell match result) xs = if match == incoming
		                                       then result:xs
						       else xs
                findTransform (Stacked match result) xs = if match == incoming
		                                       then result:xs
						       else xs
                findTransform (Finite match result) xs = if match == incoming
		                                       then result:xs
						       else xs



data AutomataStyle = Invalid | DFA | NFA | ENFA | TM 
                     deriving (Eq, Ord)

style :: [Transition] -> AutomataStyle
style transitions 
                 | checkCell transitions = TM
                 | checkStacked transitions = PDA
                 | not $ checkFinite transitions = Invalid
                 | scanEpsilon transitions = ENFA
                 | scanConcurrent transitions = NFA
                 | otherwise = DFA
                  where isFinite (Finite _ _) = True
                        isFinite _ = False
                        checkFinite :: [Transition] -> Bool
                        checkFinite = all isFinite

                        isCell (Cell _ _) = True
                        isCell _ = False
                        checkCell :: [Transition] -> Bool
                        checkCell = all isCell

                        epsilonExists (Finite (Nothing, _) _ ) = True
                        epsilonExists _ = False
                        scanEpsilon [] = False
                        scanEpsilon (x:xs) = if epsilonExists x then True else scanEpsilon xs

                        scanConcurrent [] = False
                        scanConcurrent (x:xs) = if (length (filter (x `concurrent`) xs)) >=2
                                                then True
                                                else scanConcurrent xs
validTable :: [Transition] -> Bool
validTable = (!= Invalid) . style 
