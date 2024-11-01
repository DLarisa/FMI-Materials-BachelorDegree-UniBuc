-- la nevoie decomentati liniile urmatoare:

import Data.Char
-- import Data.List




---------------------------------------------
-------RECURSIE: FIBONACCI-------------------
---------------------------------------------

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
  | n < 2     = n
  | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

{-| @fibonacciLiniar@ calculeaza @F(n)@, al @n@-lea element din secvența
Fibonacci în timp liniar, folosind funcția auxiliară @fibonacciPereche@ care,
dat fiind @n >= 1@ calculează perechea @(F(n-1), F(n))@, evitănd astfel dubla
recursie. Completați definiția funcției fibonacciPereche.

Indicație:  folosiți matching pe perechea calculată de apelul recursiv.
-}
fibonacciLiniar :: Integer -> Integer
fibonacciLiniar 0 = 0
fibonacciLiniar n = snd (fibonacciPereche n) -- snd = second (ia al doilea element din pereche) / fst = first
  where
    fibonacciPereche :: Integer -> (Integer, Integer) -- F(n-1), F(n)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n = (fn1, fn1 + fn2)
      where (fn2, fn1) = fibonacciPereche(n - 1)

-- SAU
fibonacciL1 :: Integer -> Integer
fibonacciL1 0 = 0
fibonacciL1 n = snd (fibonacciPereche n)
  where
    fibonacciPereche :: Integer -> (Integer, Integer)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n =
      let (fn2, fn1) = fibonacciPereche(n - 1) in (fn1, fn1 + fn2)

-- SAU
fibonacciL2 :: Integer -> Integer
fibonacciL2 0 = 0
fibonacciL2 n = snd (fibonacciPereche n)
  where
    fibonacciPereche :: Integer -> (Integer, Integer)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n =
      let p = fibonacciPereche(n - 1) in (snd p, fst p + snd p)
      -- EXPLICATIE: 2 + let z = 4 in z + 2 ---> 8




---------------------------------------------
----------RECURSIE PE LISTE -----------------
---------------------------------------------
semiPareRecDestr :: [Int] -> [Int]
semiPareRecDestr l
  | null l    = l
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where
    h = head l
    t = tail l
    t' = semiPareRecDestr t

semiPareRecEq :: [Int] -> [Int]
semiPareRecEq [] = []
semiPareRecEq (h:t)
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where t' = semiPareRecEq t

---------------------------------------------
----------DESCRIERI DE LISTE ----------------
---------------------------------------------
semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]




---------------------------------------------
----------EXERCIȚII -------------------------
---------------------------------------------

-- L2.3
inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec _ _ [] = []
inIntervalRec a b (h:t)
  | a <= h, h <= b = h : (inIntervalRec a b t)
  | otherwise = inIntervalRec a b t

-- SAU
inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp a b l = [ x | x <- l, x >= a && x<=b]


-- L2.4
pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0
pozitiveRec (h:t)
  | h > 0 = 1 + pozitiveRec(t)
  | otherwise = pozitiveRec(t)

-- SAU
pozitiveComp :: [Int] -> Int
pozitiveComp l = length[ x | x <- l , x > 0]


-- L2.5
pozitiiImpareRecAux :: Int -> [Int] -> [Int]
pozitiiImpareRecAux _ [] = []
pozitiiImpareRecAux p (h:t)
  | odd(h) = p : pozitiiImpareRecAux (p + 1) t -- p = pozitia in lista
  | otherwise = pozitiiImpareRecAux (p + 1) t
pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec l = pozitiiImpareRecAux 0 l

-- SAU
pozitiiImpareComp :: [Int] -> [Int]
-- pozitiiImpareComp l = [snd(x) | x <- zip l [0..], odd(fst(x))] -- SAU
pozitiiImpareComp l = [p | (x, p) <- zip l [0..], odd(x)]


-- L2.6
multDigitsRec :: String -> Int
multDigitsRec [] = 1
multDigitsRec (h:t)
  | isDigit(h) = digitToInt(h) * multDigitsRec(t)
  | otherwise = multDigitsRec(t)

-- SAU
multDigitsComp :: String -> Int
multDigitsComp l = product[ digitToInt(x) | x <- l, isDigit(x)]


-- L2.7
discountRec :: [Float] -> [Float]
discountRec [] = []
discountRec (h:t)
  | nr < 200 = nr : discountRec(t)
  | otherwise = discountRec(t)
    where nr = 0.75 * h

-- SAU
discountComp :: [Float] -> [Float]
discountComp l = [0.75 * x | x <- l, 0.75 * x < 200]

{- SAU
discountRec :: [Float] -> [Float]
discountRec [] = []
discountRec (x:xs)
   | discount x < 200 =  discount x : discountRec xs
   | otherwise = discountRec xs

discount :: Float -> Float
discount x = x - 0.25 * x


discountComp :: [Float] -> [Float]
discountComp xs = [ y | x<- xs, let y = discount x, y < 200]
-}
