type Input = String
type Output = String
type InOutWorld = (Input, Output)
type MyIOState a = State InOutWorld a
newtype State s a = State {runState :: s -> (a,s)}

instance Monad (State s) where
  return x = State (\ s -> (x,s))
  ma >>= k = State f
      where f s1 = let
                      (va, s2) = runState ma s1
                      (vb, s3) = runState (k va) s2
                   in (vb, s3)

instance Applicative (State s) where
  pure = return
  mf <*> ma = do { f <- mf; a <- ma; return (f a) }
instance Functor (State s) where
  fmap f ma = do { a <- ma; return (f a) }

-- MyIOState a = State {runState :: (Input, Output) -> (a,(Input, Output))}


myGetChar :: MyIOState Char
myGetChar = State f
  where f (i,o) = (head i, (tail i, o))
 -- myGetChar = State (\ (c:i, o) -> (c,(i,o)))

myPutChar :: Char ->  MyIOState ()
myPutChar c = State (\ (i,o) -> ( () , (i, o ++ [c])))

runIO :: MyIOState () -> Input -> Output
runIO commad input = o
   where (a,(i,o)) = runState commad (input,"")

test1 = runState myGetChar ("abc","def")
test2 = runState (myPutChar 'c') ("abc", "def")
test3 = runIO (myPutChar 'c') "abc"
