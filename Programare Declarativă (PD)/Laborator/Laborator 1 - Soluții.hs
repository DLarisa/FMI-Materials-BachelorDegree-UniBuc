import Data.List
-- import Test.QuickCheck

myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x+x

triple :: Integer -> Integer
triple x = x+x+x

penta :: Integer -> Integer
penta x = x+x+x+x+x

test x = (double x + triple x) == (penta x)

testf x = (double x + double x) == (penta x)

--maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y

max3 x y z = let
             u = maxim x y
             in (maxim  u z)

testmax x y = ((maxim x y) >= x) && ((maxim x y) >= y)



-- L1.6
-- i)
sumaPatrate :: Integer -> Integer -> Integer
sumaPatrate el1 el2 = el1*el1 + el2*el2

-- ii)
paritate :: Integer -> String
paritate element
  | odd(element) = "Impar"
  | otherwise = "Par"

-- iii)
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1)

-- iv)
eDublu :: Integer -> Integer -> Bool
eDublu e1 e2
  | e1 >= 2*e2 = True
  | otherwise = False
