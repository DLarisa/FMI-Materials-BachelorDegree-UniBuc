# https://www.gurobi.com/documentation/9.1/examples/qp_py.html

import numpy as np
from qpsolvers import solve_qp


"""
    Constrângeri: Ax = b 
                  și 
                  x >= 0 => -x <= 0 (Gx <= h), deci h = 0 și G = -1 * I
    
    Date generate random.
"""

# a)
n = 2
m = 3

M = np.random.randn(n, n)
H = np.dot(np.transpose(M), M) # hessiană simetrică (M_transpusă * M)

# Construim conform cerinței
q = np.dot(np.random.randn(1, n), M).reshape((n, ))
G = -np.eye(n)
h = np.zeros((n, ))
A = np.random.randn(m, n)
b = np.random.randn(m, )

# Calculez acum x, deoarece avem toate datele.
# x = punct de minim
# Hessiana este pozitiv semidefinită (transpusă * matrice) => funcție convexă => punct minim
x = solve_qp(H, q, G, h, A, b)
print(f"Punct găsit: {x}")





# b)
"""
    i) funcția tb să fie convexă => am dem la subpunctul a) cum tb să generăm hessiana
       a.î. funcția să fie convexă.
"""
M = np.array([[2., 1., 1.],
              [1., 3., 0.],
              [5., 0., 4.]])
H = np.dot(np.transpose(M), M)



"""
    ii) Mulțime fezabilă (din costrângeri) = {x | x >= 0} și x = punct minim => x = (0, 0, ..., 0) (ca să fie pe frontieră)
        Deci b = 0.
"""
A = np.array([
    [7., 0., 0.],
    [0., 7., 0.],
    [0., 0., 8.]
])
b = np.zeros((n, ))
x = solve_qp(H, q, G, h, A, b)
print(f"Punct găsit: {x}")