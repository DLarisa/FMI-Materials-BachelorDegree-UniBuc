import Data.Maybe

{- Monada Maybe este definita in GHC.Base

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing


instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)

instance Functor Maybe where
  fmap f ma = pure f <*> ma
-}


-- Ex1
(<=<) :: (a -> Maybe b) -> (c -> Maybe a) -> c -> Maybe b
f <=< g = (\ x -> g x >>= f)
--- Ex1.1
f1 :: String -> Maybe Int
f1 x = if length x > 10 then Just $ length x else Nothing

g1 :: Int -> Maybe String
g1 x = if x > 0 then Just $ concat $replicate x "ab" else Nothing

f2, f3, f4 :: Int -> Maybe Int
f2 x = if x > 10 then Just $ x * x else Nothing
f3 x = if x > 15 then Just $ x + x else Nothing
f4 x = if x > 20 then Just $ x * x * x else Nothing
--- Ex1.2
asoc :: (Int -> Maybe Int) -> (Int -> Maybe Int) -> (Int -> Maybe Int) -> Int -> Bool
asoc f g h x = (h <=< (g <=< f) $ x) == ((h <=< g) <=< f $ x)



-- Ex2
pos :: Int -> Bool
pos  x = if (x>0) then True else False

foo :: Maybe Int ->  Maybe Bool
foo  mx =  mx  >>= (\x -> Just (pos x))
--- Ex2.1
{- Rulează în terminal:
1. foo Nothing
2. foo (Just 5) -}
--- Ex2.2
fooAux :: Maybe Int -> Maybe Bool
fooAux mx = do x <- mx
               return(pos x)



-- Ex3
addM :: Maybe Int -> Maybe Int -> Maybe Int
addM mx my = do x <- mx
                y <- my
                return $ x + y
-- SAU
addMNou :: Maybe Int -> Maybe Int -> Maybe Int
addMNou mx my = mx >>= (\x -> my >>= (\y -> Just $ x + y))

-- SAU
addMSablon :: Maybe Int -> Maybe Int -> Maybe Int
addMSablon (Just x) (Just y) = Just $ x + y
addMSablon _ _ = Nothing



-- Ex4
-- a)
cartesian_product xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))
-- Rezolvare:
cartesian_product1 xs ys = do
  x <- xs
  y <- ys
  return (x, y)


-- b)
prod f xs ys = [f x y | x <- xs, y<-ys]
-- Rezolvare:
prod1 f xs ys = do x <- xs
                   y <- ys
                   return [f x y]


-- c)
myGetLine :: IO String
myGetLine = getChar >>= \x ->
  if x == '\n' then return []
  else myGetLine >>= \xs -> return (x:xs)
-- Rezolvare:
myGetLine1 :: IO String
myGetLine1 = do x <- getChar
                if x == '\n' then return []
                else do xs <- myGetLine1
                        return (x:xs)


-- d)
prelNo noin = sqrt noin
ioNumber = do noin <- readLn :: IO Float
              putStrLn $ "Intrare\n" ++ (show noin)
              let noout = prelNo noin
              putStrLn $ "Iesire"
              print noout
