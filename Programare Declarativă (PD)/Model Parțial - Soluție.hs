-- Exercițiul 1
--- Varianta: Descrieri de Liste
sfChr :: Char -> Bool
sfChr x = x == '.' || x == '?' || x == '!' || x == ':'

nrProp :: String -> Int
nrProp l = length[ x | x <- l, sfChr x]
-- SAU: nrProp l = sum[ 1 | x <- l, sfChr x]


--- Varianta: Recursie
{- SAU (pt sfChr)
sfChr x
  | x == '.' || x == '?' || x == '!' || x == ':' = True
  | otherwise = False
-}
nrPropRec :: String -> Int
nrPropRec [] = 0
nrPropRec (x:xs)
  | sfChr x = 1 + nrPropRec xs
  | otherwise = nrPropRec xs





-- Exercițiul 2
--- Varianta 1
-- iau liniile de lungime n
linii :: [[Int]] -> Int -> [[Int]]
linii l n = filter (\x -> length x == n) l

-- ia doar liniile (de lungime n) care au doar elemente pozitive
liniiAux :: [[Int]] -> Int -> [[Int]]
liniiAux l n = filter (\x -> length x == n) $ map (takeWhile (>0)) (linii l n)

-- ca să fie True, lungime(liniiAux) == lungime(linii)
liniiN :: [[Int]] -> Int -> Bool
liniiN l n = length(linii l n) == length(liniiAux l n)


--- Varianta 2
-- folosesc funcția linii (de mai sus)
liniiN_2 :: [[Int]] -> Int -> Bool
liniiN_2 l n =  minimum (map minimum (linii l n)) > 0





-- Exercitiul 3
data Punct = Pt [Int]
  deriving Show

data Arb = Vid | F Int | N Arb Arb
  deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a


instance ToFromArb Punct where
  toArb (Pt []) = Vid
  toArb (Pt (x:xs)) = N (F x) (toArb (Pt xs))

  fromArb (Vid) = Pt []
  fromArb (F x) = Pt [x]
  fromArb (N a b) = Pt (getList(fromArb a) ++ getList(fromArb b))

getList :: Punct -> [Int]
getList (Pt []) = []
getList (Pt l) = l


{- SAU pt fromArb
fromArb (Vid) = Pt []
fromArb (F x) = Pt [x]
fromArb (N a b) = Pt (l ++ r)
  where
    Pt l = fromArb a
    Pt r = fromArb b
-}
