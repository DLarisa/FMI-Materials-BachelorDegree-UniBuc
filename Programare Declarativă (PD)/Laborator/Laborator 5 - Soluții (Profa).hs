-- http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/



import Data.Char
import Data.List


-- 1.
rotate :: Int -> [Char] -> [Char]
rotate n str
  | n > 0 && n < length str = str2 ++ str1
  | otherwise = error "N este invalid"
   where
      str1 = take n str
      str2 = drop n str

-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l

-- 3.
makeKey :: Int -> [(Char, Char)]
makeKey n = zip ['A'..'Z'] (rotate n ['A'..'Z'])

-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp c pairs
  | length list == 0 = c
  | otherwise = head list
  where
     list =  map snd ( filter (\ (c1,c2) -> c == c1) pairs )

-- 5.
encipher :: Int -> Char -> Char
encipher n c = lookUp c key
  where
    key = makeKey n


-- 6.
normalize :: String -> String
normalize str = map toUpper $  filter (`elem`(['a'..'z']++['A'..'Z']++['0'..'9'])) str

-- 7.
encipherStr :: Int -> String -> String
encipherStr n str = map (encipher n) $ normalize str

-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey pairs = map (\ (x,y) -> (y,x)) pairs

-- 9.
decipher :: Int -> Char -> Char
decipher n c = lookUp c rev
  where
    key = makeKey n
    rev = reverseKey key

decipherStr :: Int -> String -> String
decipherStr n str = map (decipher n) str
