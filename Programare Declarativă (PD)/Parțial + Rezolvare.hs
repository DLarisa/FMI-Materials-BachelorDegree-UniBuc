------------            Parțial            ------------


{-
	Exercițiul 1:                 -> Maxim Punctaj
	a) Scrieti o functie care transforma un caracter c in corespondentul sau din limba pasareasca, astfel:  
		- daca e vocala, se adaua un 'p' si vocala din nou, e.g., 'a' -> "apa"
		- daca nu e vocala, ramane asa, e.g., 'p' -> "p"

	b) Transformati un text in varianta lui pasareasca, substitutind fiecare  caracter cu corespondentul sau in pasareasca
	   Exemplu: "Mi-e foame" -> "Mipi-epe fopoapamepe"
	   Puteti folosi doar descrieri de liste (list comprehension) si  functii din categoriile A si B si functia de la subpunctul a. 

Pentru punctaj maxim trebuie sa scrieti prototipurile functiilor.
-}

---- Rezolvare:
-- a)
import Data.Char

transChar :: Char -> [Char]
transChar x = if elem x "aeiouAEIOU" then concat [[x], "p", [toLower x]]
                      else [x]

-- b
transStr :: String -> String
transStr l = [ y | x <- l, y <- transChar x]




{-
	Exercițiul 2:                 -> Maxim Punctaj
	Sa se scrie o functie care primeste ca parametru o matrice (lista de liste) de numere intregi si un numar n intreg si verifica daca liniile care au toate elementele mai mari decat n sunt de lungime para.
	f [[1,2,3],[11,6,8,8],[2,3,4,5,6,7,8],[6,6,7,8,8,9]] 4 = True
	Rezolvati aceasta problema folosind functii de nivel inalt (fara recursie si descrieri de liste).

Pentru punctaj maxim trebuie sa scrieti prototipurile functiilor.
-}

---- Rezolvare:
-- iau toate liniile care au toate elementele mai mari decat n
aux :: [[Int]] -> Int -> [[Int]]
aux lista n = filter (\x -> minimum x > n) lista

-- iau liniile care au lungime pară
aux2 :: [[Int]] -> [[Int]]
aux2 lista = filter (\x -> even (length x)) lista


f :: [[Int]] -> Int -> Bool
f lista n = aux2 (functie) == functie
        where functie = aux lista n




{-
	Exercițiul 3:                 -> 1.5/2.0
	Se dau urmatoarele tipuri de date:

		data Pereche a b = MyP  a b deriving Show
		data ListaP a = MyL  [a] deriving  Show

	Si clasa: 

		class MyMapping m where
		mymap :: (Pereche a b -> Pereche b a) -> m (Pereche a b) -> m (Pereche b a)
		myfilter :: (Pereche a b -> Bool) -> m(Pereche a b) -> m (Pereche a b)

	Sa se instantieze clasa MyMapping pentru tipul de date ListaP, astfel incat mymap sa functioneze similar cu map (pe liste) si myfilter cu filter(pe liste). 
		lp :: ListaP (Pereche Int Char)
		lp = MyL [MyP 97 'a', MyP 3 'b', MyP 100 'd']
-}

---- Rezolvare: 
data Pereche a b = MyP a b
   deriving Show

data ListaP a = MyL [a]
   deriving Show

class MyMapping m where
   mymap :: (Pereche a b -> Pereche b a) -> m (Pereche a b) -> m                               (Pereche b a)
   myfilter :: (Pereche a b -> Bool) -> m (Pereche a b) -> m (Pereche a b)

 

instance MyMapping ListaP where
   mymap f (MyL []) = MyL []
   mymap f (MyL (h:t)) = MyL (f(h) : t_aux)
               where t_aux = mymap f (MyL t)

   myfilter f (MyL []) = MyL []
   myfilter f (MyL ((h@(MyP a b)):t)) = if f(h) then (MyP a b):t_aux else t_aux
                                     where t_aux = myfilter f (MyL t)