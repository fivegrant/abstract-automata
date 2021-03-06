module App.Transition where

import App.Storage.Storage
import App.Storage.Tape

data Transition = 
    Finite {
      fromState :: (Maybe Char, Int),
      resultState :: Int
    } |
    Cell {
      fromCell :: (Maybe Char, Int),
      toCell :: (Maybe Char, Direction, Int)
    } deriving (Eq, Ord)

(>>>) :: [Transition] -> (Maybe Char, Int) -> [Transition]
(>>>) transitionTable incoming = filter match transitionTable
                                 where match (Finite start _) = start == incoming
                                       match (Cell start _) = start == incoming

concurrent :: Transition -> Transition -> Bool
concurrent (Finite (a, b) _) (Finite (x, y) _) = (x == a) && (b == y)
concurrent _ _ = False

data AutomataStyle = Invalid | DFA | NFA | ENFA | TM 
                     deriving (Eq, Ord)

style :: [Transition] -> AutomataStyle
style transitions 
                 | checkCell transitions = TM
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
validTable = (/= Invalid) . style 
