import Test.QuickCheck
import Test.QuickCheck.Gen
import Data.Maybe
import Data.Char


double :: Int -> Int
double x = x + x
triple :: Int -> Int
triple x = 3*x
penta :: Int -> Int
penta x = x * 5
test x = (double x + triple x) == (penta x)
myLookUp :: Int -> [(Int,String)]-> Maybe String
--myLookUp x list = let l = [s | (i,s)<-list,i==x] in if length l == 0 then Nothing else Just $ head l
myLookUp nr [] = Nothing
myLookUp nr (x : xs)
     | fst x == nr = Just (snd x)
     | otherwise = myLookUp nr xs

-- *Main> myLookUp 2 [(1,"mere"),(2,"pere")]
-- Just "pere"
-- *Main> myLookUp 2 [(1,"mere"),(2,"pere"),(2,"caisa")]
-- Just "pere"
-- *Main> myLookUp 2 [(1,"mere")]
-- Nothing
-- *Main> myLookUp 1 [(1,"")]
-- Just ""
-- *Main> myLookUp 1 []
-- Nothing
-- *Main> myLookUp 3 [(1,"mere"),(2,"pere"),(2,"caisa")]
-- Nothing
-- *Main> myLookUp 2 [(1,"mere"),(2,"")]
-- Just ""


testLookUp :: Int -> [(Int,String)] -> Bool
testLookUp x l = myLookUp x l == lookup x l

testLookUpCond :: Int -> [(Int,String)] -> Property
testLookUpCond n list = n > 0 && n `div` 5 == 0 ==> testLookUp n list

myLookUp' :: Int -> [(Int, String)] -> Maybe String
myLookUp' nr [] = Nothing
myLookUp' nr ((n, sirul) : t)
     | n == nr && sirul == "" = Just ""
     | n == nr = let (c:sir ) = sirul in Just ((toUpper c) : sir)  --sau daca vrem ca restul sa fie litere mici
     | otherwise = myLookUp' nr t                                  -- punem (map toLower sir) in loc de sir

-- *Main> myLookUp' 2 [(1,"mere"),(2,"pere")]
-- Just "Pere"
-- *Main> myLookUp' 2 [(1,"mere"),(2,"pere"),(2,"caisa")]
-- Just "Pere"
-- *Main> myLookUp' 2 [(1,"mere")]
-- Nothing
-- *Main> myLookUp' 1 [(1,"")]
-- Just ""
-- *Main> myLookUp' 1 []
-- Nothing
-- *Main> myLookUp' 3 [(1,"mere"),(2,"pere"),(2,"caisa")]
-- Nothing
-- *Main> myLookUp' 2 [(1,"mere"),(2,"")]
-- Just ""


testLookUp' :: Int -> [(Int,String)] -> Bool
testLookUp' x l = myLookUp' x l == lookup x l

-- *Main> quickCheck testLookUp'
-- *** Failed! Falsified (after 58 tests and 13 shrinks):
-- -44
-- [(-44,"a")]  --normal, pt ca myLookUp' schimba afisarea


capitalized :: String -> String
capitalized (h:t) = (toUpper h): t
capitalized [] = []

testLookUpCond2 :: Int -> [(Int,String)] -> Property
testLookUpCond2 n list = foldr (&&) True (map (\x ->(capitalized (snd x)) == (snd x)) list) ==> testLookUp' n list

-- *Main> quickCheck testLookUpCond2
-- +++ OK, passed 100 tests; 747 discarded.
-- *Main> quickCheck testLookUpCond2
-- +++ OK, passed 100 tests; 708 discarded.
-- *Main> quickCheck testLookUpCond2
-- +++ OK, passed 100 tests; 537 discarded.


quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = smalls ++ [x] ++ bigs
 where smalls = quicksort [n | n <- xs, n <= x]
       bigs = quicksort [n | n <- xs, n > x]
quicksortBuggy :: Ord a => [a] -> [a]
quicksortBuggy [] = []
quicksortBuggy (x:xs) = smalls ++ [x] ++ bigs
 where smalls = quicksortBuggy [n | n <- xs, n < x] -- oops
       bigs = quicksortBuggy [n | n <- xs, n > x]
testQs1 :: [Integer] -> Bool
testQs1 l = quicksort(quicksort l) == quicksort l
testQs2 :: [Integer] -> Bool
testQs2 l = quicksort l == quicksort(reverse l)
testQs3 :: Integer -> Bool
testQs3 n = quicksort [1..n] == [1..n]
testQs4 :: [Integer] -> Bool
testQs4 l = length (quicksort l) == length l

testQsB1 :: [Integer] -> Bool
testQsB1 l = quicksortBuggy(quicksortBuggy l) == quicksortBuggy l
testQsB2 :: [Integer] -> Bool
testQsB2 l = quicksortBuggy l == quicksortBuggy(reverse l)
testQsB3 :: Integer -> Bool
testQsB3 n = quicksortBuggy [1..n] == [1..n]
testQsB4 :: [Integer] -> Bool
testQsB4 l = length (quicksortBuggy l) == length l

data ElemIS = I Int | S String
     deriving (Show,Eq)



-- instance Arbitrary ElemIS where
  -- arbitrary = do
    -- i <- arbitrary
    -- s <- arbitrary
    -- elements[I i, S s]

instance Arbitrary ElemIS where
  arbitrary = oneof [geni,gens]
                where
                    f = (unGen (arbitrary :: Gen Int ))
                    g = (unGen (arbitrary :: Gen String ))
                    geni = MkGen (\ s i -> let x = f s i in (I x ))
                    gens = MkGen (\ s i -> let x = g s i in (S x ))

myLookUpElem :: Int -> [(Int,ElemIS)]-> Maybe ElemIS
myLookUpElem x list = let l = [s | (i,s)<-list,i==x] in if length l == 0 then Nothing else Just $ head l

-- *Main> myLookUpElem 2 [(2,S "caisa"),(1, I 1)]
-- Just (S "caisa")
-- *Main> myLookUpElem 3 [(2,S "caisa"),(1, I 1)]
-- Nothing
-- *Main> myLookUpElem 2 [(2,S ""),(1, I 1)]
-- Just (S "")
-- *Main> myLookUpElem 2 []
-- Nothing
-- *Main> myLookUpElem 1 [(2,S "caisa"),(1, I 1)]
-- Just (I 1)

testLookUpElem :: Int -> [(Int,ElemIS)] -> Bool
testLookUpElem x l = myLookUpElem x l == lookup x l

 -- * No instance for (Arbitrary ElemIS)
        -- arising from a use of `quickCheck'  --fara Arbitrary

-- *Main> quickCheck testLookUpElem
-- +++ OK, passed 100 tests.
