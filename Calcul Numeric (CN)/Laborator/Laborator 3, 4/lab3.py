# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 10:44:49 2020

@author: Larisa
"""

import sistemeEcuatiiLiniare as sel # si. ecuații liniare
import numpy as np


# Testăm metSubDesc
# Test 1
A = np.array([[1, 2, 3],
              [4, 5, 6]])
b = np.array([1, 4, 5])
tol = 10 ** (-16)

x = sel.metSubDesc(A, b, tol)
print(f'Test 1: {x}\n')


# Test 2
A = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]])
b = np.array([[1], [4], [5]])
tol = 10 ** (-16)

x = sel.metSubDesc(A, b, tol)
print(f'Test 2: {x}\n')


# Test 3
A = np.array([[0, 2, 3],
              [0, 5, 6],
              [0, 0, 9]])
b = np.array([1, 4, 5])
tol = 10 ** (-16)

x = sel.metSubDesc(A, b, tol)
print(f'Test 3: {x}\n')


# Test 4
A = np.array([[1, 2, 3],
              [0, 5, 6],
              [0, 0, 8]])
b = np.array([1, 4, 5])
tol = 10 ** (-16)

x = sel.metSubDesc(A, b, tol)
print(f'Test 4: \n{x}')

# Verificare
print("Verificare 1:")
print(A@x)
print("Verificare 2:")
print(np.dot(A, x))
print('\n')



# Exercițiul 3.b)
A = np.array([[0, 1, 1],
              [2, 1, 5],
              [4, 2, 1]])
b = np.array([[3], [5], [1]])
x = sel.GaussFP(A, b, tol)
print(f'Soluția Sistemului 1 - GaussFP: \n{x}')
x = sel.GaussPP(A, b, tol)
print(f'Soluția Sistemului 1 - GaussPP: \n{x}')
print(f'Verificare (Ax - b = 0): \n{A@x-b}\n')

A = np.array([[0, 1, -2],
              [1, -1, 1],
              [1, 0, -1]])
b = np.array([[4], [6], [2]])
x = sel.GaussFP(A, b, tol)
print(f'Soluția Sistemului 2 - GaussFP: \n{x}')
x = sel.GaussPP(A, b, tol)
print(f'Soluția Sistemului 2 - GaussPP: \n{x}')
print(f'Determinantul Matricei A din Sistemul 2: {np.linalg.det(A)}\n') # determinantul matricei



# Exercițiul 3.c)
eps = 10 ** -20
tol1 = 10 ** -30
tol2 = 10 ** -16
A = np.array([[eps, 1],
              [1, 1]])
b = np.array([[1], [2]])
x = sel.GaussFP(A, b, tol1)
print(f'Soluție 1: \n{x}')
x = sel.GaussFP(A, b, tol2)
print(f'Soluție 2: \n{x}')