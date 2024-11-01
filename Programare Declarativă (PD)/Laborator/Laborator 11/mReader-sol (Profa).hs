
---Monada Reader


newtype Reader env a = Reader { runReader :: env -> a }


instance Monad (Reader env) where
  return x = Reader (\_ -> x)
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env



instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance Functor (Reader env) where              
  fmap f ma = pure f <*> ma     

  
ask :: Reader env env
ask = Reader id

local :: (r -> r) -> Reader r a -> Reader r a
local f ma = Reader $ (\r -> (runReader ma)(f r))

-- Reader Person String

data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN p = let x =  name p in ("NAME:"++ x)
    
showPersonA :: Person -> String
showPersonA p = let y =  age p in ("AGE:"++ (show y))
    

showPerson :: Person -> String
showPerson p = let 
                 x = showPersonN p
                 y = showPersonA p                  
               in ("("++ x ++","++y++")") 
 
    
    
mshowPersonN ::  Reader Person String 
mshowPersonN  =  do 
                  p <- ask
                  return  ("NAME:"++ (name p))     


mshowPersonA ::  Reader Person String
mshowPersonA  =  do 
                  p <- ask
                  return  ("AGE:"++ (show (age p)))   

mshowPerson :: Reader Person String
mshowPerson = do 
                x <- mshowPersonN
                y <- mshowPersonA
                return ("("++x++","++y++")")               
                 