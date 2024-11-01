"""
Laborator 5
"""

import numpy as np
import proceduri as proc
import time



# Exercițiul 1
A = np.array([[0., 1., 1.],
              [2., 1., 5.],
              [4., 2., 1.]])
b = np.array([[3.], [5.], [1.]])
tol = 10 ** (-10)
L, U, w = proc.FactLU(A, b, tol)

b_nou = np.copy(b)
for i in range(np.shape(b)[0]):
    b_nou[i] = b[w[i]]
    
y = proc.metSubAsc(L, b_nou, tol)
x = proc.metSubDesc(U, y, tol)
print(f'Soluția Sistemului: \n{x}')
# print(A@x)   # înmulțire de matrici (verificare dacă e egal cu b)





# Exercițiul 2
n = 100
tol = 10 ** (-10)
A = np.random.rand(n, n) * 10     # A -> matrice numere random
b = np.zeros((n, 1))              # b -> tb calculat după formulă cerință
for i in range(n):
    sum = 0
    for j in range(n):
        sum += A[i][j]
    b[i] = sum
# print(f'Matricea A: \n{A}')
# print(f'Matricea b: \n{b}')


# a) b)
L, U, w = proc.FactLU(A, b, tol)
b_nou = np.copy(b)
for i in range(np.shape(b)[0]):
    b_nou[i] = b[w[i]]
y = proc.metSubAsc(L, b_nou, tol)
x = proc.metSubDesc(U, y, tol)
# print(f'Soluție Sistem: \n{x}')


# c) d)
x_old = np.copy(x)
tic = time.time()
L, U, w = proc.FactLU(A, b, tol)
b_nou = np.zeros((n, 1))

for k in range(0, 100):
    b_nou = x_old[:] + 2
    for i in range(np.shape(b)[0]):
        b_nou[i] = b[w[i]]
        
    y = proc.metSubAsc(L, b_nou, tol)
    x_new = proc.metSubDesc(U, y, tol)
    
    x_old = x_new[:]

toc = time.time() - tic
#print("Sol la ultima iteratie\n",x_old)
print("In timp de", toc)

tic = time.time()
x_old = x
for k in range(0, 100):
    x_new = proc.GaussPP(A, x_old + 2, tol)
    x_old = x_new[:]
toc = time.time() - tic
#print("Sol la ultima iteratie\n",x_old)
print("In timp de", toc)
