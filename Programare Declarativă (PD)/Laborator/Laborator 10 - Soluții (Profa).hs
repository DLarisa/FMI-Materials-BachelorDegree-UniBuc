import Test.QuickCheck
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

(<=<) :: (a -> Maybe b) -> (c -> Maybe a) -> c -> Maybe b
f <=< g = (\ x -> g x >>= f)

f1 :: String -> Maybe Int
f1 x = if length x > 10 then Just $ length x else Nothing

g1 :: Int -> Maybe String
g1 x = if x > 0 then Just $ concat $replicate x "ab" else Nothing

f2, f3, f4 :: Int -> Maybe Int
f2 x = if x > 10 then Just $ x * x else Nothing
f3 x = if x > 15 then Just $ x + x else Nothing
f4 x = if x > 20 then Just $ x * x * x else Nothing

asoc :: (Int -> Maybe Int) -> (Int -> Maybe Int) -> (Int -> Maybe Int) -> Int -> Bool
asoc f g h x = (h <=< (g <=< f) $ x) == ((h <=< g) <=< f $ x)

pos :: Int -> Bool
pos  x = if (x>=0) then True else False

foo :: Maybe Int ->  Maybe Bool
foo  mx =  do
     x <- mx
     return (pos x)

addM1 :: Maybe Int -> Maybe Int -> Maybe Int
addM1 (Just x) (Just y) = Just $ x + y
addM1 _ _ = Nothing


addM :: Maybe Int -> Maybe Int -> Maybe Int
addM mx my =  do
  x <- mx
  y <- my
  return $ x + y


isPos :: Int -> Maybe Bool
isPos x = if (x>= 0) then Just True else Just False


mapMaybeB :: (a -> Maybe b) -> [a] -> Maybe [b]
mapMaybeB f xs = Just $ map fromJust ( filter isJust (map f xs))
