# Laboratorul 7

import numpy as np


def metIacobi(B, eps, tol):
    """

    B: matricea simetrica
    eps: eroarea
    -----------------
    return: valori si vectori proprii
    
    """
    
    A=np.copy(B)
    n=np.shape(A)[0]
    modul_A = 0
    T = np.eye(n, n)
    
    for i in range(n):
        for j in range(n):
            if i != j:
                modul_A += A[i][j] ** 2
                
    modul_A = np.sqrt(modul_A)
    while modul_A >= eps:
        max = abs(A[1][0])
        p = 0
        q = 1
        for j in range(n):
            for i in range(j + 1, n):
                if abs(A[i][j]) > max:
                    max = abs(A[i, j])
                    p = j
                    q = i
                    
        if abs(A[p, p] - A[q, q]) <= tol:
            teta = np.pi / 4
        else:
            teta = 1 / 2 * np.arctan(2 * A[p, q] / (A[q, q]-A[p, p]))
            
        c = np.cos(teta)
        s = np.sin(teta)

        R = np.eye(n, n)
        R[p, p] = c
        R[p, q] = s
        R[q, p] = -s
        R[q, q] = c
        A = np.transpose(R)@A@R

        T = T@R
        modul_A = 0
        for i in range(n):
            for j in range(n):
                if i != j:
                    modul_A += A[i][j] ** 2
        modul_A = np.sqrt(modul_A)

    return A, T



B = np.array([[17, -2, 3 * np.sqrt(3)],
              [-2, 8, 2 * np.sqrt(3)], 
              [3 * np.sqrt(3), 2 * np.sqrt(3), 11]], float)
A, T = metIacobi(B, 10 ** (-3), 10 ** (-7))
print(A)
print(T)



B1 = np.array([[1, 1, 0],
               [1, 1, 0],
               [0, 0, 2]], float)

A1, T = metIacobi(B1, 10 ** (-3), 10 ** (-7))
print(A1)
print(T)

# Verificare
print(np.transpose(T)@B1@T)
v = T[:, 0]
print(B1@v - A1[0, 0] * v)