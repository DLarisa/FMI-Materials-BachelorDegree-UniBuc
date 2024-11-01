import Data.List


-- L3.1
{- Încercati sa gasiti valoarea expresiilor de mai jos si
   verificati raspunsul gasit de voi în interpretor:  -}
{-
[x^2 | x <- [1 .. 10], x `rem` 3 == 2]
[(x, y) | x <- [1 .. 5], y <- [x .. (x+2)]]
[(x, y) | x <- [1 .. 3], let k = x^2, y <- [1 .. k]]
[x | x <- "Facultatea de Matematica si Informatica", elem x ['A' .. 'Z']]
[[x .. y] | x <- [1 .. 5], y <- [1 .. 5], x < y ]
-}

-- 1)
factori :: Int -> [Int]
factori n = [ d | d <- [1..n], n `rem` d == 0]

-- 2)
prim :: Int -> Bool
prim n = ([1, n] == factori n)

-- 3)
numerePrime :: Int -> [Int]
numerePrime n = [ x | x <- [2..n], prim x == True]




-- L3.2
myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 _ _ [] = []
myzip3 [] _ _ = []
myzip3 _ [] _ = []
myzip3 (a:xa) (b:xb) (c:xc) = (a, b, c):myzip3 xa xb xc

myzip3V2 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3V2 l1 l2 l3 = [ (a, b, c) | ((a, b), c) <- zip (zip l1 l2) l3]




--------------------------------------------------------
---------- FUNCȚII DE NIVEL ÎNALT ----------------------
--------------------------------------------------------
-- Sintaxă Generală
aplica2 :: (a -> a) -> a -> a
--aplica2 f x = f (f x)
--aplica2 f = f.f
--aplica2 f = \x -> f (f x)
aplica2  = \f x -> f (f x)




-- L3.3
{-
map (\x -> 2 * x) [1 .. 10]
map (1 `elem` ) [[2, 3], [1, 2]]
map ( `elem` [2, 3] ) [1, 3, 4, 5]
-}

-- 1)
firstEl :: [(a, b)] -> [a]
firstEl ((a, b):xs) = map fst((a, b):xs)

firstEl1 :: [(a, b)] -> [a]
firstEl1 lista = map (\x -> fst(x)) lista


-- 2)
sumList :: [[Int]] -> [Int]
sumList l = map (\x -> sum(x)) l


-- 3)
prel2 :: [Int] -> [Int]
{-
prel2 [] = []
prel2 (l:xl)
  | even(l) = l `div` 2 : prel2(xl)
  | otherwise = l * 2 : prel2(xl)
-}
prel2 l = map (\x -> if even(x) then x `div` 2 else x * 2) l




-- L3.4
-- 1)
caractLista :: Char -> [String] -> [String]
caractLista a lista = filter (elem a) lista
-- caractLista a lista = filter (a `elem`) lista


-- 2)
patrat :: [Int] -> [Int]
patrat lista = map (\x -> x*x) $ filter (\x -> x `rem` 2 == 1) lista
-- patrat l = map (^2) (filter odd l)


-- 3)
patratImpar :: [Int] -> [Int]
patratImpar l = map (\x -> fst(x) ^ 2) $ filter (\x -> snd(x) `rem` 2 == 1) $ zip l [1..]
-- patratImpar x = map (\(x,y)->y^2) (filter (odd.fst) (zip [0..] x))


-- 4)
numaiVocale :: [String] -> [String]
numaiVocale x = map (\a -> filter (`elem` "aeiouAEIOU") a) x




-- L3.5
mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (h:t) = f(h) : t'
  where t' = mymap f t

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter f [] = []
myfilter f (h:t) = if f(h) then h:t' else t'
  where t' = myfilter f t




-- Material Suplimentar
numerePrimeCiur :: Int -> [Int]
numerePrimeCiur n = ciur [2..n]
  where
    ciur [] = []
    ciur (x:xs) = x : ciur (filter (\y -> y `mod` x /= 0) xs)




-- Exerciții Temă
-- 1)
ordonataNat :: [Int] -> Bool
ordonataNat [] = True
ordonataNat [x] = True
ordonataNat (x:xs) = and [ a < b | (a, b) <- zip (x:xs) xs]


-- 2)
ordonataNat1 :: [Int] -> Bool
ordonataNat1 [] = True
ordonataNat1 [x] = True
ordonataNat1 (x:xs)
  | x < y = True && ordonataNat1(xs)
  | otherwise = False
    where y = head(xs)
-- ordonataNat1 (x:y:xs) = x < y && ordonataNat1(y:xs)


-- 3)
ordonata :: [a] -> (a -> a -> Bool) -> Bool
ordonata [] f = True
ordonata [x] f = True
ordonata (x:xs) f = and [ f a b | (a, b) <- zip (x:xs) xs]


 -- 4)
compuneList :: (b -> c) -> [(a -> b)] -> [(a -> c)]
compuneList a b = [a.x | x <- b]

aplicaList :: a -> [(a -> b)] -> [b]
aplicaList a b = [f a | f <- b]

myzip3New :: [a] -> [a] -> [a] -> [(a, a, a)]
myzip3New a b c = map (\((x,y), z) -> (x,y,z)) (zip (zip a b) c)
