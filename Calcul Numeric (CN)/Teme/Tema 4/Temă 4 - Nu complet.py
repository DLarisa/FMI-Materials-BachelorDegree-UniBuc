import numpy as np
import matplotlib.pyplot as plt


# Datele Problemei
n = 20

def liniar(x):
    return x

def exponential(x):
    return np.exp(x + 2)

def patratic(x):
    return x ** 2




# Funcții Auxiliare
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
        
        for j in range(k + 1, n):
            m = A_extins[j][k] / A_extins[k][k]
            A_extins[j] = A_extins[j] - m * A_extins[k]
    
        
    if abs(A_extins[n - 1][n - 1]) <= tol:
        print("Sistemul nu admite soluție unică.")
        x = None
        return x
    
    x = metSubDesc(A_extins[:, 0:n], A_extins[:, n], tol)
    return x







# Funcții -> Regresii
def RegresieLiniara(X, Y):
    A = np.zeros((2, 2))
    w = np.zeros((2, 1))
    
    for i in range(n):
        A[0][0] += X[i] ** 2
        A[0][1] += X[i]
        A[1][0] += X[i]
        w[0][0] += X[i] * Y[i]
        w[1][0] += Y[i]
    A[1][1] = n
    
    sol = GaussPP(A, w, 10 ** (-10))
    a = sol[0][0]
    b = sol[1][0]
    
    return a, b



def RegresieP(X, Y):
    A = np.zeros((3,3))
    w = np.zeros((3, 1))
    
    for i in range(n):
        A[0][0] += X[i] ** 4
        A[0][1] += X[i] ** 3
        A[0][2] += X[i] ** 2
        A[1][0] += X[i] ** 3
        A[1][1] += X[i] ** 2
        A[1][2] += X[i]
        A[2][0] += X[i] ** 2
        A[2][1] += X[i]
        w[0][0] += Y[i] * X[i] ** 2
        w[1][0] += Y[i] * X[i]
        w[2][0] += Y[i]
    A[2][2] = n
    
    sol = GaussPP(A, w, 10 ** (-10))
    a = sol[0][0]
    b = sol[1][0]
    c = sol[2][0]
    
    return a, b, c



def RegresieExp(X, Y):
    A = np.zeros((2,2))
    w = np.zeros((2,1))
    
    for i in range(n):
        A[0][0] += X[i] ** 2
        A[0][1] += X[i]
        A[1][0] += X[i]
        w[0][0] += np.log(Y[i]) * X[i]
        w[1][0] += np.log(Y[i])
    A[1][1] = n
    
    sol = GaussPP(A, w, 10 ** (-10))
    a = sol[0][0]
    b_prim = sol[1][0]
    b = np.exp(b_prim)
    
    return a, b








X = np.linspace(1, n, n)
Y = np.random.rand(n)
Y1 = liniar(X) + Y
print("Valorile Random: " + str(Y))



a, b = RegresieLiniara(X, Y1)
p1 = a * X[0] + b
p2 = a * X[n-1] + b

plt.plot(X, Y1, 'o', color = 'r', markersize = 10)
plt.plot([X[0], X[n-1]], [p1, p2], '-', color = 'b')
plt.show()





Y2 = patratic(X) + Y
a, b, c = RegresieP(X, Y2)
Y_aux = []
for i in range(n):
    Y_aux.append(a * X[i] ** 2 + b * X[i] + c)
plt.plot(X, Y2, 'o', color = 'r', markersize = 10)
plt.plot(X, Y_aux, '-', color = 'b')
plt.show()




Y3 = exponential(X) + Y
a, b = RegresieExp(X, Y3)
Y_aux = []
for i in range(n):
    Y_aux.append(b * np.exp(a * X[i]))
plt.plot(X, Y3, 'o', color = 'r', markersize = 10)
plt.plot(X, Y_aux, '-', color = 'b')
plt.show()