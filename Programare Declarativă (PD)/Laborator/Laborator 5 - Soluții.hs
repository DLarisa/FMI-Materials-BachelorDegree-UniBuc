-- http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/


import Data.Char
import Data.List


-- 1.
rotate :: Int -> [Char] -> [Char]
rotate _ [] = []
rotate 0 lista = lista
rotate n lista
  | n < 0 = error "Număr Negativ. Introduceți altă valoare!"
  | n >= length lista = error "Număr prea mare. Introduceți altă valoare!"
  | otherwise = b ++ a
    where (a, b) = splitAt n lista
{- SAU
rotate n (h:t)
  | n < 0 = error "n nu este pozitiv"
  | n > ((length t) + 1) = error "n este mai mare decat lungimea listei"
  | otherwise = rotate (n-1) (t ++ [h])
-}
{- SAU
rotate :: Int -> String -> String
rotate _ [] = []
rotate 0 lista = lista
rotate n lista
  | n < 0 = error "Număr Negativ. Introduceți altă valoare!"
  | n >= length lista = error "Număr prea mare. Introduceți altă valoare!"
  | otherwise = (drop n lista) ++ aux
        where aux = take n lista
-}


-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l


-- 3.
makeKey :: Int -> [(Char, Char)]
makeKey n = zip ['A'..] (rotate n "ABCDEFGHIJKLMNOPQRSTUVWXYZ")


-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp a [] = a
lookUp a (x:xs)
  | a == fst(x) = snd(x)
  | otherwise = lookUp a xs


-- 5.
encipher :: Int -> Char -> Char
encipher n a = lookUp a $ makeKey n


-- 6.
normalize :: String -> String
normalize [] = []
normalize (x:xs)
  | isDigit(x) = x : normalize xs
  | isLetter(x) = toUpper(x) : normalize xs
  | otherwise = normalize xs


-- 7.
encipherStr :: Int -> String -> String
encipherStr n sir = [ encipher n x | x <- normalize(sir)]


-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey lista = [ (b, a) | (a, b) <- lista ]


-- 9.
decipher :: Int -> Char -> Char
decipher n a = lookUp a $ reverseKey $ makeKey n

decipherStr :: Int -> String -> String
decipherStr n sir = [ decipher n x | x <- normalize(sir)]
