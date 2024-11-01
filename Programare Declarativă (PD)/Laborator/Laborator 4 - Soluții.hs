import Numeric.Natural


-- Ex1)
produsRec :: [Integer] -> Integer
produsRec [] = 1
produsRec (x:xs) = x * produsRec xs

produsFold :: [Integer] -> Integer
produsFold l = foldr (*) 1 l


-- Ex2)
andRec :: [Bool] -> Bool
-- andRec l = and [ x | x <- l]
andRec x = True
andRec (x:xs) = x && andRec xs

andFold :: [Bool] -> Bool
andFold l = foldr (&&) True l


-- Ex3)
concatRec :: [[a]] -> [a]
concatRec [] = []
concatRec (x:xs) = x ++ concatRec xs

concatFold :: [[a]] -> [a]
concatFold l = foldr (++) [] l


-- Ex4)
rmChar :: Char -> String -> String
rmChar _ [] = []
rmChar a l = [ x | x <- l, x /= a]

rmCharsRec :: String -> String -> String
rmCharsRec [] a = a
rmCharsRec (x:xs) y = rmCharsRec xs $ rmChar x y
{-
test_rmchars :: Bool
test_rmchars = rmCharsRec ['a'..'l'] "fotbal" == "ot"
-}

rmCharsFold :: String -> String -> String
rmCharsFold xs l = foldr (rmChar) l xs





-- EVALUARE LENEȘĂ
logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
  where
    f 0 = start
    f n = rate * f (n - 1) * (1 - f (n - 1))

logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079


-- Ex1)
ex1 :: Natural
ex1 = undefined


-- Ex2)
ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3]  -- durează

ex21 :: Fractional a => a
ex21 = head ex20

ex22 :: Fractional a => a
ex22 = ex20 !! 2

ex23 :: Fractional a => [a]
ex23 = drop 2 ex20

ex24 :: Fractional a => [a]
ex24 = tail ex20         -- durează


-- Ex3)
ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2

ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7

ex33 :: Bool
ex33 = ex31 5

ex34 :: Bool
ex34 = ex31 7    -- durează

ex35 :: Bool
ex35 = ex32 5    -- durează

ex36 :: Bool
ex36 = ex32 7    -- durează
