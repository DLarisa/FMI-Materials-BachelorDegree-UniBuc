import Control.Monad


data Binar a = Gol | Nod (Binar a) a (Binar a)
exemplu2 :: Binar (Int, Float)
exemplu2 =
  Nod
    (Nod (Nod Gol (2, 3.5) Gol) (4, 1.2) (Nod Gol (5, 2.4) Gol))
    (7, 1.9)
    (Nod Gol (9, 0.0) Gol)

data Directie = Stanga | Dreapta
  deriving Eq
type Drum = [Directie]

test211, test212 :: Bool
test211 = plimbare [Stanga, Dreapta] exemplu2 == Just (5, 2.4)
test212 = plimbare [Dreapta, Stanga] exemplu2 == Nothing

plimbare :: Drum -> Binar a -> Maybe a
plimbare _ Gol = Nothing
plimbare [] (Nod _ x _) = Just x
plimbare (x:xs) n@(Nod y z w)
  | x == Stanga = plimbare xs y
  | otherwise = plimbare xs w

--
type Cheie = Int
type Valoare = Float


newtype WriterString a = Writer { runWriter :: (a, String) }
instance Monad WriterString where
  return x = Writer (x, "")
  ma >>= k = let (x, logx) = runWriter ma
                 (y, logy) = runWriter (k x)
             in Writer (y, logx ++ logy)

tell :: String -> WriterString ()
tell s = Writer ((), s)

instance Functor WriterString where
  fmap f mx = do { x <- mx ; return (f x) }
instance Applicative WriterString where
  pure = return
  mf <*> ma = do { f <- mf ; a <- ma ; return (f a) }

test221, test222 :: Bool
test221 = runWriter (cauta 5 exemplu2) == (Just 2.4, "Stanga; Dreapta; ")
test222 = runWriter (cauta 8 exemplu2) == (Nothing, "Dreapta; Stanga; ")

cauta :: Cheie -> Binar (Cheie, Valoare) -> WriterString (Maybe Valoare)
cauta _ Gol = Writer(Nothing, "")
cauta x (Nod a b@(ch, val) c)
  | x < fst(b) = do tell("Stanga; ")
                    cauta x a
  | x > fst(b) = do tell("Dreapta; ")
                    cauta x c
  | x == fst(b) = do return (Just val)
