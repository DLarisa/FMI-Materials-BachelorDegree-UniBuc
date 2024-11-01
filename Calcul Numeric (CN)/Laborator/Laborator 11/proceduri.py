# -*- coding: utf-8 -*-
"""
Created on Mon Dec 21 02:05:02 2020

@author: Larisa
"""


import numpy as np

# Laborator 11
def SplinePatratica(X, Y, dfa, dfb, x):
    n = len(X) - 1
    a = np.zeros((n, 1))
    b = np.zeros((n, 1))
    c = np.zeros((n, 1))
    d = np.zeros((n, 1))
    h = np.zeros((n, 1))
    for i in range(n):
        a[i] = Y[i]
        h[i] = X[i + 1] - X[i]

    # Rezolvam sistemul (20 curs11) in bj
    A = np.zeros((n + 1, n + 1))
    w = np.zeros((n + 1, 1))
    A[0][0] = 1
    A[n][n] = 1
    w[0] = dfa
    for j in range(1, n):
        A[j][j] = 2 / h[j] + 2 / h[j - 1]
        A[j][j - 1] = 1 / h[j - 1]
        A[j][j + 1] = 1 / h[j]
        w[j] = (-3 / (h[j - 1] * 2)) * Y[j - 1] + (3 / h[j - 1] * 2 - 3 / h[j] * 2) * Y[j] + (3 / h[j] * 2) * Y[j + 1]
    w[n] = dfb

    b = np.linalg.solve(A, w)
    # Calculam cj,dj din relatiile (19 curs11)
    for j in range(n):
        d[j] = - (2 / h[j] * 3) * (Y[j + 1] - Y[j]) + (1 / h[j] * 2) * (b[j + 1] + b[j])
        c[j] = (3 / h[j] ** 2) * (Y[j + 1] - Y[j]) - (1 / h[j]) * (b[j + 1] + 2 * b[j])

    S = np.zeros((len(x), 1))
    dS = np.zeros((len(x), 1))
    d2S = np.zeros((len(x), 1))

    for i in range(len(x)):
        for j in range(n):
            if x[i] >= X[j] and x[i] <= X[j + 1]:
                S[i] = a[j] + b[j] * (x[i] - X[j]) + c[j] * (x[i] - X[j]) ** 2 + d[j] * (x[i] - X[j]) * 3
                dS[i] = b[j] + 2 * c[j] * (x[i] - X[j]) + 3 * d[j] * (x[i] - X[j]) ** 2
                d2S[i] = 2 * c[j] + 6 * d[j] * (x[i] - X[j])
                break

    return S, dS, d2S















