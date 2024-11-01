# -*- coding: utf-8 -*-
"""
Created on Mon Dec 14 10:01:06 2020

@author: Larisa
"""


import numpy as np
import matplotlib.pyplot as plt
import sympy as sym



# Interpolare Spline Liniară
def SplineLiniar(X, Y, x):
    n = len(X) - 1
    a = np.zeros((n, 1))
    b = np.zeros((n, 1))
    
    for i in range(n):
        a[i] = Y[i]
        b[i] = (Y[i + 1] - Y[i]) / (X[i + 1] - X[i])
    
    S = np.zeros((len(x), 1))
    for i in range(len(x)):
        for j in range(n):
            if x[i] >= X[j] and x[i] <= X[j + 1]:
                S[i] = a[j] + b[j] * (x[i] - X[j])
                break
    
    return S, a, b





def f(x):
    return np.sin(x)

def f1(x):
    return 1 / (1 + 25 * x**2)


n = 100
x_min = - np.pi / 2
x_max = np.pi / 2
X = np.linspace(x_min, x_max, n + 1)
Y = f1(X)
x_graf = np.linspace(x_min, x_max, 100)
y_graf = f1(x_graf)

S_graf, a, b = SplineLiniar(X, Y, x_graf)
print(S_graf)
print(f'a: \n{a}')
print(f'b: \n{b}')

plt.plot(x_graf, y_graf, color = 'red', linewidth = 3)
plt.plot(x_graf, S_graf, '--', color = 'blue', linewidth = 3)
plt.plot(X, Y, 'o', markersize = 10, markerfacecolor = 'yellow')
plt.show()

err_graf = abs(y_graf - S_graf.reshape(-1, ))
plt.plot(x_graf, err_graf, color = 'purple', linewidth = 3)
plt.show()









# Interpolare Spline Pătratică
def SplinePatratica(X, Y, x, dfa):
    n = len(X) - 1
    a = np.zeros((n, 1))
    b = np.zeros((n, 1))
    h = np.zeros((n, 1))
    c = np.zeros((n, 1))
    
    for i in range(n):
        a[i] = Y[i]
        h[i] = X[i + 1] - X[i]
    
    b[0] = dfa  # f prim de x1
    for i in range(n - 1):
        b[i + 1] = 2 / h[i] * (Y[i + 1] - Y[i]) - b[i]
        c[i] = 1 / h[i]**2 * (Y[i + 1] - Y[i] - h[i] * b[i])
    c[n - 1] = 1 / h[n - 1]**2 * (Y[n] - Y[n - 1] - h[n - 1] * b[n - 1])
    
    dS = np.zeros((len(x), 1))
    S = np.zeros((len(x), 1))
    for i in range(len(x)):
        for j in range(n):
            if x[i] >= X[j] and x[i] <= X[j + 1]:
                S[i] = a[j] + b[j] * (x[i] - X[j]) + c[j] * (x[i] - X[j]) ** 2
                dS[i] = b[j] + 2 * c[j] * (x[i] - X[j])
                break
    
    return S, dS, a, b, c

    
    
n = 2
x_min = - np.pi / 2
x_max = np.pi / 2
X = np.linspace(x_min, x_max, n + 1)
Y = f1(X)
x_graf = np.linspace(x_min, x_max, 100)
y_graf = f1(x_graf)

x = sym.symbols('x')
f_sym = f1(x)
d_sym = sym.diff(f_sym, x) # expresie simbolică
d = sym.lambdify(x, d_sym, 'numpy') # funcție
dfa = d(x_min)

S_graf, dS_graf, a, b, c = SplinePatratica(X, Y, x_graf, dfa)
print(S_graf)
print(f'a: \n{a}')
print(f'b: \n{b}')
print(f'c: \n{c}')


plt.plot(x_graf, y_graf, color = 'red', linewidth = 3)
plt.plot(x_graf, S_graf, '--', color = 'blue', linewidth = 3)
plt.plot(X, Y, 'o', markersize = 10, markerfacecolor = 'yellow')
plt.show()

err_graf = abs(y_graf - S_graf.reshape(-1, ))
plt.plot(x_graf, err_graf, color = 'purple', linewidth = 3)
plt.show()  

plt.plot(x_graf, dS_graf, color = 'purple', linewidth = 3)
plt.show()  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    