import Data.List
import Data.Maybe

type Name = String

data  Value  =  VBool Bool
        |VInt Int
        |VFun (Value -> Value)
        |VError

data  Hask  = HTrue | HFalse
              |HIf Hask Hask Hask
              |HLet Name Hask Hask  -- 4.4)
              |HLit Int
              |Hask :==: Hask
              |Hask :+:  Hask
              |Hask :*:  Hask   -- 4.2) adaug operația de înmulțire
              |HVar Name
              |HLam Name Hask
              |Hask :$: Hask
                deriving (Read, Show)

infix 4 :==:
infixl 6 :+:
infixl 7 :*:   -- 4.2) adaug operația de înmulțire
infixl 9 :$:

type  HEnv  =  [(Name, Value)]

showV :: Value -> String
showV (VBool b)   =  show b
showV (VInt i)    =  show i
showV (VFun _)    =  "<function>"
showV (VError)    =  "<error>"

eqV :: Value -> Value -> Bool
eqV (VBool b) (VBool c)    =  b == c
eqV (VInt i) (VInt j)      =  i == j
eqV (VFun _) (VFun _)      =  error "Unknown"
eqV (VError ) (VError)      =  error "Unknown"
eqV _ _               = False

hEval :: Hask -> HEnv -> Value
hEval HTrue r         =  VBool True
hEval HFalse r        =  VBool False

hEval (HIf c d e) r   =
  hif (hEval c r) (hEval d r) (hEval e r)
  where  hif (VBool b) v w  =  if b then v else w
         hif _ _ _ = VError
-- 4.3) înlocuire cu funcție error
--       hif _ _ _ = error "expresie booleana"

hEval (HLit i) r      =  VInt i

hEval (d :==: e) r     =  heq (hEval d r) (hEval e r)
  where  heq (VInt i) (VInt j) = VBool (i == j)
         heq  _ _ = VError
-- 4.3) înlocuire cu funcție error
--       heq  _ _ = error "egalitate "

hEval (d :+: e) r    =  hadd (hEval d r) (hEval e r)
  where  hadd (VInt i) (VInt j) = VInt (i + j)
         hadd _ _  = VError
-- 4.3) înlocuire cu funcție error
--       hadd _ _ = error "valori inregi"


-- 4.2) adaug operația de înmulțire
hEval (d :*: e) r    =  hmult (hEval d r) (hEval e r)
  where  hmult (VInt i) (VInt j) = VInt (i * j)
         hmult _ _  = VError
-- 4.3) înlocuire cu funcție error
--       hmult _ _ = error "valori inregi"

hEval (HVar x) r      =  fromMaybe VError (lookup  x r)

hEval (HLam x e) r    =  VFun (\v -> hEval e ((x,v):r))

-- 4.4)
hEval (HLet x ex e) r    =  hEval e ((x, (hEval ex r)):r)

hEval (d :$: e) r    =  happ (hEval d r) (hEval e r)
  where  happ (VFun f) v  =  f v
         happ _ _ = VError

run :: Hask -> String
run pg = showV (hEval pg [])

h0 =  (HLam "x" (HLam "y" ((HVar "x") :+: (HVar "y"))))
      :$: (HLit 3)
      :$: (HLit 4)

-- 4.1) operații ca să ne obișnuim cu sintaxa
h1 = HLet "x" (HLit 3) ((HLit 4) :*: HVar "x")


test_h0 = eqV (hEval h0 []) (VInt 7)
