# -*- coding: utf-8 -*-
"""
Created on Mon Nov  2 09:57:31 2020

@author: Larisa
"""
import numpy as np
import sistemeEcuatiiLiniare as scl


# Lab 4
# Ex1
A = np.array([[2, -2, 0, 0],
              [2, 1, 0, 0],
              [-4, 4, 0, 0],
              [4, -1, 10 ** (-20), 10 ** (-20)]])
tol = 0 
rang = scl.rang(A, tol)
print(f'Rang: {rang}')    

tol = 10 ** (-20) 
rang = scl.rang(A, tol)
print(f'Rang: {rang}')

tol = 10 ** (-10) 
rang = scl.rang(A, tol)
print(f'Rang: {rang}\n')  


# Ex3
A = np.array([[0, -3, -6, 4],
              [-1, -2, -1, 3],
              [-2, -3, 0, 3],
              [1, 4, 5, -9]]) 
tol = 0 
rang = scl.rang(A, tol)
print(f'Rang: {rang}')    

tol = 10 ** (-20) 
rang = scl.rang(A, tol)
print(f'Rang: {rang}')

tol = 10 ** (-10) 
rang = scl.rang(A, tol)
print(f'Rang: {rang}\n')  

# Ex2
A = np.array([[0., 1., -2.],
              [1., -1., 1.],
              [1., 0., -1.]])
b = np.array([[4.], [6.], [2.]])
tol = 10 ** (-10)
scl.naturaSi(A, b, tol)   

A = np.array([[1., -2., 3.],
              [-2., 3., -4.],
              [3., -4., 5.]])
b = np.array([[4.], [-5.], [6.]])
scl.naturaSi(A, b, tol)   

A = np.array([[0., 1., 1.],
              [2., 1., 5.],
              [4., 2., 1.]])
b = np.array([[3.], [5.], [1.]])
tol = 10 ** (-10)
scl.naturaSi(A, b, tol)  