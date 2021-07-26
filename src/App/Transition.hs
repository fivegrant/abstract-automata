module App.Transition where

data Direction = Left | Right deriving (Eq, Ord)

data Transition = 
    Finite {
      fromState :: (Maybe Char, Int),
      resultState :: Int
    } |
    Stacked {
      fromStackState ::((Char, Char), Int),
      resultStackState :: (Maybe Char, Int)
    } |
    Cell {
      fromCell :: (Char, Int),
      toCell :: (Char, Direction, Int)
    } deriving (Eq, Ord)

concurrent :: Transition -> Transition -> Bool
concurrent (Finite (a, b) _) (Finite (x, y) _) = (x == a) && (b == y)
concurrent _ _ = False

data AutomataStyle = Invalid | DFA | NFA | ENFA | PDA | TM | MTM 
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

                        isStacked (Stacked _ _) = True
                        isStacked _ = False
                        checkStacked :: [Transition] -> Bool
                        checkStacked = all isStacked

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
