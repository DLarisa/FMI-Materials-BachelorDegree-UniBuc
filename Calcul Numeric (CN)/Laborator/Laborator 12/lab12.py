# -*- coding: utf-8 -*-
"""
Created on Mon Jan  4 09:58:31 2021

@author: Larisa
"""


import numpy as np
import sympy as sym 
import matplotlib.pyplot as plt
import math




### Proceduri -> Ex1
def difFinProg(X, Y):
    """
    x oarecare  ->  f'(x) = (f(x+h) - f(x)) / h
    
    pt discretizare xi  ->  f'(xi) = (f(xi+1) - f(xi)) / (xi+1 - xi), unde
    xi + 1  => nodul i + 1 al vectorului x

    """
    n = len(X)
    df = np.zeros((n - 1, 1))
    
    for i in range(n - 1):
        df[i] = (Y[i+1] - Y[i]) / (X[i+1] - X[i])
    
    return df


def difFinReg(X, Y):
    """
    x oarecare  ->  f'(x) = (f(x) - f(x-h)) / h
    
    pt discretizare xi  ->  f'(xi) = (f(xi) - f(xi-1)) / (xi - xi-1), unde
    xi-1  => nodul i-1 al vectorului x

    """
    n = len(X)
    df = np.zeros((n, 1))
    
    for i in range(1, n):
        df[i] = (Y[i] - Y[i - 1]) / (X[i] - X[i - 1])
    
    return df


def difFinCen(X, Y):
    """
    x oarecare  ->  f'(x) = (f(x+h) - f(x-h)) / (2*h)
    
    pt discretizare xi  ->  f'(xi) = (f(xi+1) - f(xi-1)) / (xi+1 - xi-1), unde
    xi-1  => nodul i-1 al vectorului x

    """
    n = len(X)
    df = np.zeros((n - 1, 1))
    
    for i in range(1, n - 1):
        df[i] = (Y[i + 1] - Y[i - 1]) / (X[i + 1] - X[i - 1])
    
    return df




### Exercițiul 1

def f(x):
    return np.sin(x)

a = 0
b = np.pi
n = 100
x_graf = np.linspace(a, b, n)
y_graf = f(x_graf)

x = sym.symbols('x')
f_expr = sym.sin(x)   
df = sym.diff(f_expr, x)
dfFunc = sym.lambdify(x, df)

plt.plot(x_graf, dfFunc(x_graf), linewidth = 2)
plt.grid(True)

dfaprox = difFinProg(x_graf, y_graf)
plt.plot(x_graf[0:n-1], dfaprox, linewidth = 2)
plt.show()

err = np.zeros((n - 1, 1))
for i in range(n - 1):
    err[i] = abs(dfFunc(x_graf[i]) - dfaprox[i])

plt.plot(x_graf[0:n-1], err, linewidth = 2)
plt.grid(True)
plt.show()

# Pasul
print(x_graf[1] - x_graf[0])


# Metoda Reg
dfaprox2 = difFinReg(x_graf, y_graf)
plt.plot(x_graf[1:n], dfaprox2[1:n], linewidth = 2)
plt.grid(True)
plt.show()

err = np.zeros((n, 1))
for i in range(1, n):
    err[i] = abs(dfFunc(x_graf[i]) - dfaprox2[i])

plt.plot(x_graf[1:n], err[1:n], linewidth = 2)
plt.grid(True)
plt.show()


# Metoda Cen
dfaprox3 = difFinCen(x_graf, y_graf)
plt.plot(x_graf[1:n-1], dfaprox3[1:n-1], linewidth = 2)
plt.grid(True)
plt.show()

err = np.zeros((n-1, 1))
for i in range(1, n-1):
    err[i] = abs(dfFunc(x_graf[i]) - dfaprox3[i])

plt.plot(x_graf[1:n-1], err[1:n-1], linewidth = 2)
plt.grid(True)
plt.show()
















### Proceduri -> Ex2
def MetRichardson(phi, x, h, n):
    """
    Parameters
    ----------
    phi : formula de aproximare a derivatei cu un ordin inferior.
    x : punctul în care calculez derivata.
    h : pasul.
    n : ordinul de aproximare al derivatei (superior).

    Returns
    -------
    df = derivata aproximativă

    """
    Q = np.zeros((n, n))
    for i in range(n):
        Q[i, 0] = phi(x, h / 2 ** i)
    
    for i in range(1, n):
        for j in range(1, i + 1):
            Q[i, j] = Q[i, j - 1] + 1 / (2 ** j - 1) * (Q[i, j - 1] - Q[i - 1, j - 1])
    
    return Q[n - 1 , n - 1]



# Exercițiul 2
def phi(x, h):
    return (f(x + h) - f(x)) / h


df_richardson = np.zeros((n, 1))
N = 3 # ordinul de aproximare la care dorim să ajungem cu met Richardson

for i in range(len(x_graf)):
    # pas echidistant
    df_richardson[i] = MetRichardson(phi, x_graf[i], x_graf[1] - x_graf[0], N)

plt.plot(x_graf, df_richardson, linewidth = 2)
plt.show()

err = np.zeros((n, 1))
for i in range(n):
    err[i] = abs(dfFunc(x_graf[i]) - df_richardson[i])
plt.plot(x_graf, err, linewidth = 2)
plt.show()



# d.
# Aproximeaza a doua derivata si are ordinul de aproximare h^2
def phi2(x, h):
    return (f(x + h) - 2 * f(x) + f(x - h)) / h ** 2


N = 5 # eroarea creste din cauza rotunjirilor făcute de pc (erori interne)
d2f_richardson = np.zeros((n, 1))
for i in range(len(x_graf)):
    d2f_richardson[i] = MetRichardson(phi2, x_graf[i], (x_graf[1] - x_graf[0]), N - 1)


plt.figure(9)
plt.plot(x_graf, d2f_richardson, linewidth=3)
plt.show()

d2f = sym.diff(df, x)
d2f_func = sym.lambdify(x, d2f)

err2 = np.zeros((n, 1))
for i in range(n):
    err2[i] = np.abs(d2f_func(x_graf[i]) - d2f_richardson[i])


plt.figure(10)
plt.plot(x_graf, err2, linewidth=3)
plt.show()
        










































