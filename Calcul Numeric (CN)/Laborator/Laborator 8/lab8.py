"""
Created on Mon Dec  7 09:53:07 2020

@author: Larisa
"""

import numpy as np
import matplotlib.pyplot as plt





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



# Metoda Gauss PP Modificat
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
        
        for j in range(k + 1, n):
            A_extins[j, k + 1 : n + 1] = A_extins[j, k + 1 : n + 1] - (A_extins[j][k] / A_extins[k][k]) * A_extins[k, k + 1 : n + 1]
            A_extins[j, k] = 0
        
    if abs(A_extins[n - 1][n - 1]) <= tol:
        print("Sistemul nu admite soluție unică.")
        x = None
        return x
    
    x = metSubDesc(A_extins[:, 0:n], A_extins[:, n], tol)
    return x



def metDirecta(X, Y, x):
    n = len(X) - 1
    A = np.zeros((n + 1, n + 1))
    
    for i in range(n + 1):
        for j in range(n + 1):
            A[i][j] = X[i] ** j
    
    a = GaussPP(A, Y, 10 ** -10)
    
    Pn = 0
    for i in range(n + 1):
        Pn += a[i] * (x ** i)
    
    return Pn



def metodaLagrange(X, Y, x):
    n = len(X) - 1
    Pn = 0
    for k in range(1, n + 1):
        # produsul pentru fiecare k
        prod = 1  # == L[n, k]
        for j in range(n + 1):
            if j != k:
                prod *= (x - X[j]) / (X[k] - X[j])
        Pn += prod * Y[k]

    return Pn





# Exerciții

def f(x):
    return np.sin(x)

def f2(x):
    return 1 / (1 + 25 * (x ** 2))



def ex1():
    x_min = -np.pi / 2
    x_max = np.pi / 2
    
    x_graf = np.linspace(x_min, x_max, 100)
    y_graf = f(x_graf)
    # print(np.shape(x_graf))

    plt.figure(1)
    plt.plot(x_graf, y_graf, linewidth = 2, color = 'red')
    plt.grid(True)

    # Definim Modurile de Interpolare
    n = 5
    X = np.linspace(x_min, x_max, n + 1)
    X = X.reshape(-1, 1)  # îl transform pe X pentru a putea să îl concatenez mai tărziu cu o matrice
    Y = f(X)

    plt.plot(X, Y, 'o', markersize = 10, markerfacecolor = 'blue')

    Pn = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        Pn[i] = metDirecta(X, Y, x_graf[i])

    plt.plot(x_graf, Pn, linewidth = 2, color = 'green')
    plt.show()

    err = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        err[i] = np.abs(Pn[i] - y_graf[i])

    plt.plot(x_graf, err, linewidth = 2, color = 'red')
    plt.show()



def ex2():
    x_min = -1
    x_max = 1
    x_graf = np.linspace(x_min, x_max, 100)
    y_graf = f2(x_graf)
    print(np.shape(x_graf))

    plt.figure(2)
    plt.plot(x_graf, y_graf, linewidth = 2, color = 'red')
    plt.grid(True)

    n = 20

    # Alegem nodurile Chebyshev
    X = np.zeros((n + 1, 1))
    for i in range(n + 1):
        X[i] = np.cos(((n - i) * np.pi) / n)

    Y = f2(X)

    plt.plot(X, Y, 'o', markersize = 10, markerfacecolor = 'blue')

    Pn = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        Pn[i] = metDirecta(X, Y, x_graf[i])

    plt.plot(x_graf, Pn, linewidth = 2, color = 'yellow')
    plt.show()

    err = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        err[i] = np.abs(Pn[i] - y_graf[i])

    plt.plot(x_graf, err, linewidth = 2, color = 'red')
    plt.show()



def ex3():
    x_min = -np.pi / 2
    x_max = np.pi / 2
    x_graf = np.linspace(x_min, x_max, 100)
    y_graf = f(x_graf)
    print(np.shape(x_graf))

    plt.figure(3)
    plt.plot(x_graf, y_graf, linewidth = 2, color = 'red')
    plt.grid(True)

    n = 20
    
    # Alegem nodurile Chebyshev
    X = np.zeros((n + 1, 1))
    for i in range(n + 1):
        X[i] = np.cos(((n - i) * np.pi) / n)

    Y = f(X)

    plt.plot(X, Y, 'o', markersize = 10, markerfacecolor = 'blue')
    
    
    Pn = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        Pn[i] = metodaLagrange(X, Y, x_graf[i])

    plt.plot(x_graf, Pn, linewidth = 2, color = 'yellow')
    plt.show()

    err = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        err[i] = np.abs(Pn[i] - y_graf[i])

    plt.plot(x_graf, err, linewidth = 2, color = 'red')
    plt.show()



def ex4():
    x_min = -1
    x_max = 1
    x_graf = np.linspace(x_min, x_max, 100)
    y_graf = f2(x_graf)
    print(np.shape(x_graf))

    plt.figure(4)
    plt.plot(x_graf, y_graf, linewidth = 2, color = 'red')
    plt.grid(True)
    
    n = 20
   
    # Alegem nodurile Chebyshev
    X = np.zeros((n + 1, 1))
    for i in range(n + 1):
        X[i] = np.cos(((n - i) * np.pi) / n)

    Y = f2(X)

    plt.plot(X, Y, 'o', markersize =10, markerfacecolor = 'blue')
    
    
    Pn = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        Pn[i] = metodaLagrange(X, Y, x_graf[i])

    plt.plot(x_graf, Pn, linewidth = 2, color = 'yellow')
    plt.show()

    err = np.zeros(np.shape(x_graf))
    for i in range(len(x_graf)):
        err[i] = np.abs(Pn[i] - y_graf[i])

    plt.plot(x_graf, err, linewidth = 2, color = 'red')
    plt.show()



# Apelare Exerciții
ex1()
ex2()
ex3()
ex4()