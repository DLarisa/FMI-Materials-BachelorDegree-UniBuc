import Data.List (nub)
import Data.Maybe (fromJust)

data Fruct
    = Mar String Bool
    | Portocala String Int
  -- deriving(Show)

instance Show Fruct where
  show (Mar s b) = "Marul " ++ s ++ (if b then " are vierme " else " nu are vierme ")
  show (Portocala s i) = "Portocala " ++ s ++ " are " ++ show i ++ " felii"

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False, Portocala "Sanguinello" 10, Portocala "Valencia" 22, Mar "Golden Delicious" True, Portocala "Sanguinello" 15, Portocala "Moro" 12, Portocala "Tarocco" 3, Portocala "Moro" 12, Portocala "Valencia" 2, Mar "Golden Delicious" False, Mar "Golden" False, Mar "Golden" True]


ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala s i) = elem s ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia _ = False

test_ePortocalaDeSicilia1 = ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 = ePortocalaDeSicilia (Mar "Ionatan" True) == False

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (x@(Portocala s i):xs) =
  (if ePortocalaDeSicilia x then i else 0) + nrFeliiSicilia xs
nrFeliiSicilia (_:xs) = nrFeliiSicilia xs

nrFeliiSiciliaComp list = sum [ i | Portocala s i <- list, elem s ["Tarocco", "Moro", "Sanguinello"]]

nrFeliiSiciliaComp2 list = sum [ i | x@(Portocala s i) <- list, ePortocalaDeSicilia x]

nrFeliiSiciliaHof list = foldr (+) 0  $ map (\ (Portocala s i) -> i)(filter ePortocalaDeSicilia list)


test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

nrMereViermi :: [Fruct] -> Int
nrMereViermi list = length [ s  | Mar s True <- list]
-- nrMereViermi list = length [ s  | Mar s b <- list, b]

test_nrMereViermi = nrMereViermi listaFructe == 2

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa

vorbeste :: Animal -> String
vorbeste (Pisica _) = "miau"
vorbeste (Caine n r) = "ham"


rasa :: Animal -> Maybe String
rasa (Pisica _ ) = Nothing
rasa (Caine n r) = Just r

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

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: (Not (Var "P") :&: Not (Var "Q")) :&: (Not (Var "P") :&: Not (Var "R"))

instance Show Prop where
  show (Var nume)= nume
  show (a :|: b) = "("++show a ++ "|" ++ show b++")"
  show (a :&: b) = "("++show a ++ "&" ++ show b++")"
  show (a :->: b) = "("++show a ++ "->" ++ show b++")"
  show (a :<->: b) = "("++show a ++ "<->" ++ show b++")"
  show (Not p) = "(~"++show p++")"
  show F = "F"
  show T = "T"


test_ShowProp :: Bool
test_ShowProp =
    show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

impl :: Bool -> Bool -> Bool
impl False _ = True
impl _ x = x

echiv :: Bool -> Bool -> Bool
echiv x y = x==y

eval :: Prop -> Env -> Bool
eval (Var x) env = impureLookup x env
eval T _ = True
eval F _ = False
eval (Not p) env = not $ eval p env
eval (p :&: q) env = eval p env && eval q env
eval (p :|: q) env = eval p env || eval q env
eval (p :->: q) env = eval p env `impl` eval q env
eval (p :<->: q) env = eval p env `echiv` eval q env



test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True

variabile :: Prop -> [Nume]
variabile (Var p) = [p]
variabile (Not p) = nub $ variabile p
variabile (p :&: q) = nub $ variabile p ++ variabile q
variabile (p :|: q) = nub $ variabile p ++ variabile q
variabile (p :->: q) = nub $ variabile p ++ variabile q
variabile (p :<->: q) = nub $ variabile p ++ variabile q
variabile _ = [] -- T si F

test_variabile =
  variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]

envs :: [Nume] -> [[(Nume, Bool)]]
envs [] = []
envs [x] = [[(x,False)],[(x,True)]]
envs (str:xs) = let r = envs xs in  map (\x-> (str,False):x) r  ++ map (\x->(str,True):x) r

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

satisfiabila :: Prop -> Bool
satisfiabila p = or $ map (eval p) $ envs $ variabile p

test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida p = False== satisfiabila (Not p)

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True
