import Data.Char
import Control.Monad


{- Ca să ruleze exemplele:
1. Rulez programul (Ex: ioString & SHIFT+ENTER)
2. Scriu String (fără "") + Enter & SHIFT+ENTER
-}

-- Exemplul 1
prelStr strin = map toUpper strin
ioString = do
            strin <- getLine
            putStrLn $ "Intrare\n" ++ strin
            let  strout = prelStr strin
            putStrLn $ "Iesire"
            putStrLn strout


-- Exemplul 2
prelNo noin =  sqrt noin
ioNumber = do
            noin  <- readLn :: IO Double
            putStrLn $ "Intrare: " ++ (show noin)
            let  noout = prelNo noin
            putStrLn $ "Iesire: "
            print noout


-- Exemplul 3
inoutFile = do
               sin <- readFile "Input.txt"
               putStrLn $ "Intrare: " ++ sin
               let sout = prelStr sin
               putStrLn $ "Iesire: " ++ sout
               writeFile "Output.txt" sout



-- Exercițiul 1
ex1 :: IO()
ex1 = do n <- readLn :: IO Int
         ex1aux n [] 0
ex1aux :: Int -> [String] -> Int -> IO()
ex1aux 0 _ 0 = putStrLn $ "Nu există persoane!"
ex1aux 0 x _ = putStrLn $ concat $ x
ex1aux n x maxi = do
  nume <- getLine
  varsta <- readLn :: IO Int
  if varsta == maxi then ex1aux (n - 1) (nume:" ":x) varsta
  else if varsta > maxi then ex1aux (n - 1) [nume] varsta
       else ex1aux (n - 1) x maxi


-- Exercițiul 2
ex2 = do
  fisier <- readFile "ex2.in"
  let linii = lines (fisier)
  let persoane = map (\linie -> aux $ mySplit ',' linie "") linii
  let maximVarsta = foldr (\(_, b) c -> max b c) 0 persoane
  let persFilt = filter (\(a, b) -> b == maximVarsta) persoane
  putStrLn $ concat $ map fst persFilt

mySplit :: Char -> String -> String -> [String]
mySplit sep "" s = [s]
mySplit sep (c:cs) s
  | c == sep = [s] ++ mySplit sep cs ""
  | otherwise = mySplit sep cs (s ++ [c])

aux :: [String] -> (String, Int)
aux [a, b] = (a, read b)

-- SAU
split :: Char -> String -> [String]
split c = map (takeWhile (/= c)) . takeWhile (not . null) .
    iterate (dropWhile (==  ' ') . drop 1 . dropWhile (/= c))

ex2Nou :: IO ()
ex2Nou = do
          cin <- readFile "ex2.in"
          let continut = lines (cin)
          let l1 = map (split ',') continut
          -- print l1
          let l2 = [(n, v) | l <- l1, let n = l !! 0, let v = l !! 1]
          let maxv = maximum[ v | (n, v) <- l2]
          let nume = [n | (n, v) <- l2, v == maxv]
          putStrLn (show maxv ++ " " ++ concat nume)


-- Exercițiul 3
--- a)
palindrom :: Int -> Bool
palindrom x = (show $ x) == (reverse . show $ x)

ex3a :: IO()
ex3a = do n <- readLn :: IO Int
          print(show(palindrom n))

-- SAU
estePalindrom :: String -> Bool
estePalindrom x = (y == reverse y)
  where y = takeWhile (isDigit) x -- ca să elimin caracterul Enter

ex3aNou :: IO ()
ex3aNou = do
          nr <- getLine
          print(estePalindrom nr)

-- SAU
palindromNou :: Int -> IO()
palindromNou x
  | (show $ x) == (reverse . show $ x) = putStrLn $ "Este Palindrom!"
  | otherwise = putStrLn $ "NU este Palindrom!"

ex3aAux :: IO()
ex3aAux = do n <- readLn :: IO Int
             palindromNou n

--- b)
ex3b = do nr <- readLn :: IO Int
          forM_ [1..nr] $ \_ -> do ex3aAux  -- a nu se confunda cu forM





------------------------------       SAU          ------------------------------
-- Pentru exercițiile 1 și 2
type Nume = String
type Varsta = Int

-- Creez tipul de date Persoană
data Persoana = Pers Nume Varsta
  deriving Eq

-- Ordonarea Persoanelor se face după vârstă
instance Ord Persoana where
  (Pers _ age1) <= (Pers _ age2) = age1 <= age2

-- Citesc Datele unei Persoane de la Tastatură
citestePersoana :: IO Persoana
citestePersoana = do
  putStrLn "Nume: "
  nume <- getLine
  putStrLn "Vârstă: "
  varsta <- readLn :: IO Int
  return $ Pers nume varsta

-- Ctesc Datele a N Persoane de la Tastatură
citesteNPersoane :: IO [Persoana]
citesteNPersoane = do
  putStrLn "Nr de Persoane: "
  n <- readLn :: IO Int
  forM [1..n] $ \_ -> do citestePersoana

-- Afișez Persoanele cele mai în Vârstă
afisare :: [Persoana] -> IO()
afisare pers = do
  -- găsesc cea mai în vârstă persoană
  let persMax@(Pers nume varsta) = maximum pers
  let lista = filter (\(Pers n v) -> v == varsta) pers
  forM_ lista $ \(persoana@(Pers num var)) -> do
    putStrLn $ num ++ " are " ++ show var ++ " ani.\n"

rezolvareEx1 :: IO()
rezolvareEx1 = do pers <- citesteNPersoane
                  afisare pers


-- Citesc Persoane din Fișier
citestePersoaneDinFisier :: IO [Persoana]
citestePersoaneDinFisier = do
  cin <- readFile "ex2.in"
  let linii = lines cin
  forM linii $ \linie -> do
    let [nume, varsta] = split ',' linie
    return $ Pers nume (read varsta)

rezolvareEx2 :: IO()
rezolvareEx2 = do pers <- citestePersoaneDinFisier
                  afisare pers
