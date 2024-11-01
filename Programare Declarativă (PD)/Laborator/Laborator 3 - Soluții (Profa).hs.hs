import   Data.List
import   Test.QuickCheck



factori n =[x | x<- [1..(abs n)], n`mod` x ==0]
prim  n = factori n == [1,n]
numerePrime n = [x | x <- [2..(abs n)], prim x]


numerePrimeCiur n = sieve [2..n]
          where
          sieve [] = []
          sieve (p:xs) = p : sieve [x | x <- xs, rem x p > 0]
-- https://wiki.haskell.org/Prime_numbers

ordonareNat [] = True
ordonareNat (x:xs) = and [ x <= y | (x,y) <- zip (x:xs) xs ]

myzip3 l1 l2 l3 = zipaux (zip l1 l2) l3
              where
                 zipaux [] _ = []
                 zipaux _ [] = []
                 zipaux ((x,y):xs) (z:zs) = (x,y,z):(zipaux xs zs)


--------------------------------------------------------
----------FUNCTII DE NIVEL INALT -----------------------
--------------------------------------------------------
aplica2 :: (a -> a) -> a -> a
--aplica2 f x = f (f x)
--aplica2 f = f.f
--aplica2 f = \x -> f (f x)
aplica2  = \f x -> f (f x)

(*<*) :: (Integer, Integer) -> (Integer, Integer) -> Bool
(x,y) *<* (z,t) = (sqrt . fromIntegral $ x^2 + y^2) <= (sqrt . fromIntegral $ z^2 + t^2)

firstEl xs = map fst xs


sumList :: [[Integer]] -> [Integer]
sumList = map sum

prel2 xs = map (\x -> if even(x) then (div x 2) else x*2) xs

compuneList :: (b -> c) -> [(a -> b)] -> [( a -> c)]
compuneList f xf = map (f.) xf

aplicaList x xf = map ($x) xf

myzip3' l1 l2 l3 = map (\((x,y), z) -> (x,y,z)) (zip (zip l1 l2) l3)

numaiVocale = map  (filter (`elem` "aeiouAEIOU") )
