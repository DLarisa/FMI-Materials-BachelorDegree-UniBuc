"""
Created on Thu Oct 22 12:21:13 2020

@Author: Eu
@Grupa: 341
@Nr.Crt: 159
@Varianta: 15

"""


# Librării
import numpy as np                       # arrays
import matplotlib.pyplot as plt          # grafic




"""   Ex 1 -> Rezolvare   """

# Datele Problemei (Varianta 15)
def f(x):
    return x ** 3 - x ** 2 - 7 * x + 7
(a, b) = (-3, 3)
eps = 10 ** (-5)


"""
Funcție care caută intervalele pe care funcția are o soluție.
f(a) * f(b) < 0 -> EXISTENȚA
"""
def cauta_intervale(f, a, b, n):
    """
    Parameters
    ----------
    f : funcția asociată ecuației f(x) = 0.
    a : capătul din stânga interval.
    b : capătul din dreapta interval.
    n : nr de subintervale în care împărțim intervalul global (a, b).

    Returns
    -------
    Matricea 'intervale' cu 2 linii; prima linie -> capăt st interval curent
    si a doua linie -> capat dr
    si un nr de coloane = nr radacini
    """
    
    x = np.linspace(a, b, n+1)   #returnează n+1 numere, situate la distanțe egale, din cadrul intervalului [a, b]
    for i in range(len(x)):   #range: for i = 0, len(x); i++
        if(f(x[i]) == 0):     #capetele intervalelor mele nu au voie să fie 0; tb să avem soluțiile în intervale, nu la capete
            print("Schimba nr de Intervale")
            break

    matrice = np.zeros((2, 1000))  #returnează un nou vector plin de 0; pt că am (2, 1000) -> matrice cu 2 rânduri și 1000 coloane
    z = 0
    for i in range(n):
        if f(x[i]) * f(x[i+1]) < 0:  #existență soluție
            matrice[0][z] = x[i]
            matrice[1][z] = x[i + 1]
            z += 1 
    
    matrice_finala = matrice[:, 0:z]   #iei ambele 2 linii și doar coloanele de la 0 la z (numărat mai sus)
    return matrice_finala

interval = cauta_intervale(f, a, b, 8)
print(interval)
dim = np.shape(interval)[1]

# Subpunctul a) Metoda Secantei
def MetSecantei(f, x0, x1, eps):
    """

    Parameters
    ----------
    f : funcția definită mai sus.
    x0, x1 : 2 puncte ce aparțin intervalului (a, b) = (-4, 2); valori de pornire.
    eps : epsilon / toleranța.

    Returns
    -------
    soluția aproximativă
    N = nr de iterații

    """
    
    N = 2
    # x(k) = x2, x(k-1) = x1, x(k-2) = x0
    while abs(x1 - x0) >= abs(x0) * eps:
        N += 1
        x2 = (x0 * f(x1) - x1 * f(x0)) / (f(x1) - f(x0))
        
        if x2 < a or x2 > b:
            print("Introduceți alte Valori pt x0 si x1")
            break
            
        # Reatribui Variabilele   
        x0 = x1
        x1 = x2
    
    return x1, N


# Subpunctul b) Metoda Poziției False
def MetPozFalse(f, a, b, eps):
    """

    Parameters
    ----------
    f : funcția definită mai sus.
    a, b : capetele intervalului (definite mai sus).
    eps : epsilon / toleranța.

    Returns
    -------
    soluția aproximativă
    N = nr de iterații

    """
    
    N = 1
    conditie = True
    
    while conditie:
        
        x2 = a - (b - a) * f(a) / (f(b) - f(a))
        
        if f(x2) == 0: 
            break

        if f(a) * f(x2) < 0:
            b = x2
        else:
            a = x2

        N += 1
        conditie = abs(f(x2)) >= eps

    return x2, N
     

# Subpunctul c) Grafice si Rădăcini

f1 = np.vectorize(f) 
x_grafic = np.linspace(a, b, 100) # 100 de numere din intervalul [a, b]
y_grafic = f1(x_grafic)          # aplic funcția pe aceste 100 de numere

plt.plot(x_grafic, y_grafic, linewidth = 3)  # graficul funcției
plt.grid()
plt.title('Ex1: Metoda Secantei')
plt.axvline(0, color = 'black')   # trasează Oy
plt.axhline(0, color = 'black')   # trasează Ox  
r = np.zeros(dim)
for i in range(dim):
    r[i], N = MetSecantei(f, interval[0, i], interval[1, i], eps)
    print("Metoda Secantei")
    print("Ecuația x ** 3 - x ** 2 - 7 * x + 7 = 0")
    print("Intervalul [{:.2f}, {:.2f}]".format(interval[0, i], interval[1,i]))
    print("Solutia Numerica: x = {:.3f}".format(r[i]))
    print("-----------------------------------")
plt.plot(r, f(r), 'o', color = 'red', markersize = 10)
plt.show()
plt.show()

plt.plot(x_grafic, y_grafic, linewidth = 3)  # graficul funcției
plt.grid()
plt.title('Ex1: Metoda Poziției False')
plt.axvline(0, color = 'black')   # trasează Oy
plt.axhline(0, color = 'black')   # trasează Ox  
r = np.zeros(dim)
for i in range(dim):
    r[i], N = MetPozFalse(f, interval[0, i], interval[1, i], eps)
    print("Metoda Poziției False")
    print("Ecuația x ** 3 - x ** 2 - 7 * x + 7 = 0")
    print("Intervalul [{:.2f}, {:.2f}]".format(interval[0, i], interval[1,i]))
    print("Solutia Numerica: x = {:.3f}".format(r[i]))
    print("-----------------------------------")
plt.plot(r, f(r), 'o', color = 'red', markersize = 10)
plt.show()




"""   Ex 2 -> Rezolvare   """

# Datele Problemei (Varianta 15)
d = 18
f = -6
c = -3
n = 20
tol = 10 ** (-16)
A = [[0.0 for i in range(n)] for j in range(n)]
for i in range(n):
    A[i][i] = d * 1.0
for i in range(1, n):
    A[i][i - 1] = c * 1.0
    A[i - 1][i] = f * 1.0

b = [1.] * n
b[0] = b[n - 1] = 2.


# Metoda Substituției Descendente (Funcție Auxiliară pt implementarea Metodei Gauss)
def metSubDesc(A, b, tol):
    """

    Parameters
    ----------
    A : matrice pătratică, superior triunghiulară, cu toate elementele de pe diagonala principală nenule.
    b : vectorul termenilor liberi.
    tol : toleranță = valoare numerică foarte mică în raport cu care vom compara numerele apropiate de 0.

    Returns
    -------
    x = Soluția Sistemului.

    """
    
    # Verificăm dacă matricea este pătratică
    m, n = np.shape(A)
    if m!= n:
        print("Matricea nu este pătratică. Introduceți altă matrice.")
        x = None
        return x
    
    # Verificăm dacă matricea este superior triunghiulară
    for i in range(m):
       for j in range(i):
           if abs(A[i][j] > tol):
               print("Matricea nu este superior triunghiulară.")
               x = None
               return x
    
    # Verificam dacă toate elementele de pe diagonala principală sunt nenule => Si. este compatibil ddeterminat (adică am soluție unică)
    for i in range(n):
        if A[i][i] == 0:
            print("Sistemul nu este compatibil determinat.")
            x = None
            return x
    
    x = np.zeros((n, 1))
    x[n - 1] = b[n - 1] / A[n - 1][n - 1]
    
    k = n - 2
    while k >= 0:
        s = 0
        for j in range(k + 1, n):
            s += x[j] * A[k][j]
            
        x[k] = (1 / A[k][k]) * (b[k] - s)
        k -= 1
    
    return x
    
    
# Definirea Metodei Gauss cu Pivotare Totală
def GaussPivTot(A, b, tol):
    """

    Parameters
    ----------
    Ax = b.

    Returns
    -------
    x = Soluția.

    """
    
    # Verificăm dacă matricea este pătratică
    m, n = np.shape(A)
    if m != n:
        print("Matricea nu este pătratică. Introduceți altă matrice.")
        x = None
        return x
    
    A = np.column_stack((A, b)) # concatenare coloană termeni liberi la matrice A -> matrice extinsă
    n = len(b)
    
    index = np.array(range(n))
    
    for k in range(n - 1):
        p = k
        m = k
      
        for i in range(k, n):
            for j in range(k, n):
                if abs(A[p][m]) < abs(A[i][j]):
                    p = i
                    m = j
    
        if A[p][m] == 0:
            print("Sistem Incompatibil sau Compatibil Nedeterminat!")
            break
        
        """
        !!! ATENȚIE: Tb să pun np.array
        A = np.array([[1, 2, 3],
                      [4, 5, 6],
                      [7, 8, 9]])

        A[[1, 0]] = A[[0, 1]] #linii
        A[:,[2,1]] = A[:,[1,2]] #coloane
        """
        if p != k:
            A[[p, k]] = A[[k, p]] # interschimb linia p cu linia k
        
        if m != k:
            A[:, [m, k]] = A[:, [k, m]] # interschimb coloana m cu coloana k
            index[[m, k]] = index[[k, m]]       
        
        for l in range(k + 1, n):
            m = A[l][k] / A[k][k]
            A[l] = A[l] - m * A[k]
        
        if A[n - 1][n - 1] == 0:
            print("Sistem Incompatibil sau Compatibil Nedeterminat!")
            break
        
        y = metSubDesc(A[:, 0:n], A[:, [n]], tol)
        x = np.zeros(len(y))
        for i in range(n):
            x[index[i]] = y[i]
             
    return x


x = GaussPivTot(A, b, tol)  
print(x)



"""   Ex 3 -> Rezolvare   """

# Datele Problemei (Varianta 15)
A = np.array([[12., 9., 17.],
              [4., 2., 5.],
              [20., 22., 38.]])
b = np.array([[31.], [12.], [50.]])
tol = 10 ** (-16)


# Gauss cu Pivotare Parțială
def GaussPP(A, b, tol):
    """

    Parameters
    ----------
    A : matrice pătratică.
    b : vectori termeni liberi.
    tol : toleranță => valoare cu care comparăm numerele nenule.

    Returns
    -------
    x = Soluția Sistemului.

    """
    
    # Verificăm dacă matricea este pătratică
    m, n = np.shape(A)
    if m != n:
        print("Matricea nu este pătratică. Introduceți altă matrice.")
        x = None
        return x
    
    A_extins = np.concatenate((A, b), axis = 1) # axis = 1  =>  pentru concatenare coloane; dacă aveam 0, concatenam linii
    # SAU: A_extins = np.column_stack((A, b)) # concatenare special pentru coloane
    print(f'Matrice Extinsă Ințială: \n{A_extins}\n')
    
    for k in range(n - 1):       # coloane
        max = A_extins[k][k]
        p = k
        for j in range(k + 1, n):
            if abs(A_extins[j][k]) > abs(max):
                max = A_extins[j][k]
                p = j
        
        if abs(max) <= tol:
            print("Sistemul nu admite solutie unică.")
            x = None
            return x
        
        if p != k:
            A_extins[[p, k]] = A_extins[[k, p]]   # swap linia p cu linia k
            for j in range(k + 1, p):
                A_extins[[j, p]] = A_extins[[p, j]]
            print(f'Pasul = {k + 1}: Interschimbare Linii {p+1} <-> {k+1}:\n{A_extins}\n')
        else:
            print(f'Pasul = {k + 1}: NU S-AU INTERSCHIMBAT LINII!!!\n')
        
        for j in range(k + 1, n):
            m = A_extins[j][k] / A_extins[k][k]
            A_extins[j] = A_extins[j] - m * A_extins[k]
        
        # Afisare Matrice Extinsă Intermediară
        print(f'Pasul = {k + 1}: Transformarea Elementară: \n{A_extins}\n')
    
        
    if abs(A_extins[n - 1][n - 1]) <= tol:
        print("Sistemul nu admite soluție unică.")
        x = None
        return x
    
    x = metSubDesc(A_extins[:, 0:n], A_extins[:, n], tol)
    return x


x = GaussPP(A, b, tol)
print(f'\nSoluția Ecuației: \n{x}')
