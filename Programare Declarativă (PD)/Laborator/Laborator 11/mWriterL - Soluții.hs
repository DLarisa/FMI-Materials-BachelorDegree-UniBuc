
--- Monada Writer



newtype WriterLS a = Writer { runWriter :: (a, [String]) }
      deriving Show


instance  Monad WriterLS where
  return va = Writer (va, [])
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 ++ log2)


instance  Applicative WriterLS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance  Functor WriterLS where
  fmap f ma = pure f <*> ma

tell :: String -> WriterLS ()
tell log = Writer ((), [log])



-- 2.
logIncrement :: Int  -> WriterLS Int
logIncrement x = Writer (x + 1, ["Incrementez " ++ show x ++ "; "])

logIncrementN :: Int -> Int -> WriterLS Int
logIncrementN x 1 = logIncrement x
logIncrementN x n =  do
  y <- logIncrement x
  logIncrementN y (n-1)



-- 3.
isPos :: Int -> WriterLS Bool
isPos x = if (x>= 0) then (Writer (True, ["poz"])) else (Writer (False, ["neg"]))

mapWriterLS :: (a -> WriterLS b) -> [a] -> WriterLS [b]
mapWriterLS f [] = return []
mapWriterLS f (x:xs) = do fx <- f x
                          fxs <- mapWriterLS f xs
                          return $ fx:fxs

-- SAU
mapWriterLS1 :: (a -> WriterLS b) -> [a] -> WriterLS [b]
mapWriterLS1 f xs = Writer (list2, list3)
  where
    list1 = map runWriter $ map f xs
    list2 = map fst list1
    list3 = concat $ map snd list1
