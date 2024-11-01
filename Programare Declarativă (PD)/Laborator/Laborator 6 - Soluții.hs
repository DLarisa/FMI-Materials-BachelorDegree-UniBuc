import Data.List (nub)
import Data.Maybe (fromJust)


-- Exercițiul 1
data Fruct
    = Mar String Bool
    | Portocala String Int
      deriving(Show)

{-
CA SĂ SCRIU INSTANȚĂ DE LA MINE:
  instance Show Fruct where
      show (Mar a b) = "Marul " ++ s ++ (if b then " are viermi." else " nu are viermi.")
      show (Portocala s i) = "Portocala " ++ s ++ " are " ++ show i ++ "felii."
-}

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False, Portocala "Sanguinello" 10, 
              Portocala "Valencia" 22, Mar "Golden Delicious" True, 
              Portocala "Sanguinello" 15, Portocala "Moro" 12, 
              Portocala "Tarocco" 3, Portocala "Moro" 12, 
              Portocala "Valencia" 2, Mar "Golden Delicious" False, 
              Mar "Golden" False, Mar "Golden" True]

-- a)
ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Mar _ _) = False
ePortocalaDeSicilia (Portocala specie _) = (specie == "Tarocco" || specie == "Moro" || specie == "Sanguinello")
{- SAU
ePortocalaDeSicilia (Portocala s i) = elem s ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia _ = False
-}

test_ePortocalaDeSicilia1 = ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 = ePortocalaDeSicilia (Mar "Ionatan" True) == False

-- b)
-- Funcție Auxiliară pt a scoate Nr de Felii dintr-o Portocală
iauFelii :: Fruct -> Int
iauFelii (Portocala specie x) = x

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (x:xs)
  | ePortocalaDeSicilia(x) == True = iauFelii x + nrFeliiSicilia xs
  | otherwise = nrFeliiSicilia xs

{- SAU
nrFeliiSicilia [] = 0
nrFeliiSicilia (x@(Portocala s i):xs) =       -- !!! super important x@(Portocala s i) i.e. x = (Portocala s i) și pot folosi în funcție de context ce mi se potrivește mai bine
(if ePortocalaDeSicilia x then i else 0) + nrFeliiSicilia xs
nrFeliiSicilia (_:xs) = nrFeliiSicilia xs

nrFeliiSiciliaComp list = sum [ i | Portocala s i <- list, elem s ["Tarocco", "Moro", "Sanguinello"]]
nrFeliiSiciliaComp2 list = sum [ i | x@(Portocala s i) <- list, ePortocalaDeSicilia x]
nrFeliiSiciliaHof list = foldr (+) 0 $ map (\ (Portocala s i) -> i)(filter ePortocalaDeSicilia list)
-}

test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

-- c)
areViermi :: Fruct -> Bool
areViermi (Portocala _ _) = False
areViermi (Mar specie x) = x

nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi (x:xs)
  | areViermi(x) = 1 + nrMereViermi xs
  | otherwise = nrMereViermi xs

{-SAU
nrMereViermi list = length [ s | Mar s True <- list]
-- nrMereViermi list = length [ s | Mar s b <- list, b]
-}

test_nrMereViermi = nrMereViermi listaFructe == 2



-- Exercițiul 2
type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa

-- a)
vorbeste :: Animal -> String
vorbeste (Pisica _) = "Meow!"
vorbeste (Caine _ _) = "Woof!"

-- b)
rasa :: Animal -> Maybe String
rasa (Pisica _) = Nothing
rasa (Caine n r) = Just r





-- Logica Propozițională
type Nume = String
data Prop
    = Var Nume
    | F
    | T
    | Not Prop
    | Prop :|: Prop
    | Prop :&: Prop
    | Prop :->: Prop
    | Prop :<->: Prop
    deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:


-- Exercițiul 1
p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R")))



-- Exercițiul 2
instance Show Prop where
    show(Var x) = x
    show(F) = "Fals"
    show(T) = "Adevărat"
    show(Not x) = "(" ++ "~" ++ show x ++ ")"
    show (a :|: b) = "(" ++ show a ++ " | " ++ show b ++ ")"
    show (a :&: b) = "(" ++ show a ++ " & " ++ show b ++ ")"
    show (a :->: b) = "(" ++ show a ++ " -> " ++ show b ++ ")"
    show (a :<->: b) = "(" ++ show a ++ " <-> " ++ show b ++ ")"

test_ShowProp :: Bool
test_ShowProp = show (Not (Var "P") :&: Var "Q") == "((~P) & Q)"





-- Evaluarea Expresiilor Logice
type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

-- Exercițiul 3
eval :: Prop -> Env -> Bool
eval (Var x) e = impureLookup x e
eval F e = False
eval T e = True
eval (Not x) e = not (eval x e)
eval (a :|: b) e = eval a e || eval b e
eval (a :&: b) e = eval a e && eval b e
eval (a :->: b) e = not (eval a e) || eval b e
eval (a :<->: b) e = (not (eval a e) || eval b e) && (not (eval b e) || eval a e)

test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True


-- Exercițiul 4
variabile :: Prop -> [Nume]
variabile (Var x) = [x]
variabile F = []
variabile T = []
variabile (Not x) = variabile x
variabile (a :|: b) = nub (variabile a ++ variabile b)
variabile (a :&: b) = nub (variabile a ++ variabile b)
variabile (a :->: b) = nub (variabile a ++ variabile b)
variabile (a :<->: b) = nub (variabile a ++ variabile b)

test_variabile = variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]


-- Exercițiul 5
envs :: [Nume] -> [Env]
envs [] = [[]]
envs [x] = [[(x, False)], [(x, True)]]
envs (x:xs) = [ (x, False):e | e <- envs xs] ++ [ (x, True):e | e <- envs xs]

{- SAU
envs :: [Nume] -> [Env]
envs [] = [[]]
envs (x:xs) = [ (x,False) : l | l <- aux ] ++ [ (x,True) : l | l <- aux ]
where
aux = envs xs

envs1 [] = [[]]
envs1 (x:xs) = [ (x,t) : l | l <- aux, t <- [True,False] ]
where
aux = envs xs
-}

test_envs =
      envs ["P", "Q"]
      ==
      [ [ ("P",False)
        , ("Q",False)
        ]
      , [ ("P",False)
        , ("Q",True)
        ]
      , [ ("P",True)
        , ("Q",False)
        ]
      , [ ("P",True)
        , ("Q",True)
        ]
      ]


-- Exercițiul 6
satisfiabila :: Prop -> Bool
satisfiabila p = or [ eval p e | e <- envs (variabile p)]

test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False


-- Exercițiul 7
valida :: Prop -> Bool
valida p = (satisfiabila (Not p)) == False

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True
