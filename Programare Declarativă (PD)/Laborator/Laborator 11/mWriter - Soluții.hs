import Control.Monad


-- Monada Writer
newtype WriterS a = Writer {runWriter :: (a, String)}
  deriving Show

instance Monad WriterS where
  return va = Writer (va, "")
  ma >>= k =
    let (va, log1) = runWriter ma
        (vb, log2) = runWriter (k va)
     in Writer (vb, log1 ++ log2)

instance Applicative WriterS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor WriterS where
  fmap f ma = pure f <*> ma

tell :: String -> WriterS ()
tell log = Writer ((), log)




-- 1.1
logIncrement :: Int -> WriterS Int
logIncrement x = Writer (x + 1, "Incrementez " ++ show x ++ "; ")

-- SAU
logIncrementAux :: Int -> WriterS Int
logIncrementAux x = do tell("Am incrementat " ++ show x)
                       return (x + 1)

logIncrement2 :: Int  -> WriterS Int
logIncrement2 x = do
    y <- logIncrement x
    logIncrement y


-- 1.2
logIncrementN :: Int -> Int -> WriterS [Int]
logIncrementN x n =  do forM [x..z] $ \x -> do tell("Am incrementat " ++ show x ++ "; ")
                                               return (x + 1)
                        where z = x + n - 1

-- SAU
logIncrementN1 :: Int -> Int -> WriterS Int
logIncrementN1 x n
  | n == 1 = logIncrement x
  | otherwise = logIncrementN1 x (n - 1) >>= logIncrement

-- SAU
logIncrementN2 :: Int -> Int -> WriterS Int
logIncrementN2 x 1 = logIncrement x
logIncrementN2 x n =  do
  y <- logIncrement x
  logIncrementN2 y (n-1)




-- 5.
isPos :: Int -> WriterS Bool
isPos x = if (x>= 0) then (Writer (True, ("poz; "))) else (Writer (False, ("neg; ")))

mapWriterLS :: (a -> WriterS b) -> [a] -> WriterS [b]
mapWriterLS f [] = return []
mapWriterLS f (x:xs) = do fx <- f x
                          fxs <- mapWriterLS f xs
                          return $ fx:fxs

-- SAU
mapWriterLS1 :: (a -> WriterS b) -> [a] -> WriterS [b]
mapWriterLS1 f xs = Writer (list2, list3)
    where
      list1 = map runWriter $ map f xs
      list2 = map fst list1
      list3 = concat $ map snd list1
