#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
from numpy import linalg as la
from scipy import optimize

## Metoda Gradient


## Date: Q, q
## f(x) = 1/2 x^TQx + q^Tx
Q = np.array([[1.52,1.5],[1.5,1.5]])
q = np.array([2,2])
f = lambda x: 0.5*x.T@Q@x + q.T@x


V = la.eigvals(Q)

print("")
print("")
print("#######################")
print("f (x) = 0.5*x^T Q x + q.T x")
print("Valori proprii Q:",V[0],V[1] )
print("Numar conditionare L/sigma: ", V[0]/V[1])
print("#######################")
print("")
print("Metoda Gradient cu pas constant alpha = 1/Lips")
print("")
print("#######################")

k1 = 0
eps = 10e-7
x0 = np.array([-9,9])
grad = Q@x0+q
grad0 = grad

### Constanta Lipschitz a gradientului
Lips = np.max(la.eigvals(Q))
mu = np.min(la.eigvals(Q))
nr_cond = Lips/mu


alpha = 1/Lips

all_x_i = [x0[0]]
all_y_i = [x0[1]]
all_f_i = [f(x0)]
criteriu_stop = la.norm(grad)
x = x0


while (criteriu_stop > eps):
    

    x = x - alpha*grad
    grad = Q@x+q
    
    criteriu_stop = la.norm(grad)
    k1 = k1+1

    all_x_i.append(x[0])
    all_y_i.append(x[1])
    all_f_i.append(f(x))

solMG = x      


id_all_x_i = [x0[0]]
id_all_y_i = [x0[1]]
id_all_f_i = [f(x0)]
criteriu_stop = la.norm(grad0)
x = x0
k2 = 0

while (criteriu_stop > eps):
    
    grad = Q@x+q
    alpha = (la.norm(grad)**2)/(grad.T@Q@grad)
    x = x - alpha*grad
    
    criteriu_stop = la.norm(grad)
    k2 = k2+1

    id_all_x_i.append(x[0])
    id_all_y_i.append(x[1])
    id_all_f_i.append(f(x))

solMG_id = x      
sol = -la.inv(Q)@q



    
#### Plot ####


x, y = np.mgrid[-10:10:0.1, -10:10:0.1]
x = x.T
y = y.T

fig = plt.figure(1, figsize=(4, 4))
plt.clf()
plt.axes([0, 0, 1, 1])


fcont = 0.5*Q[0,0]*(x**2) + 0.5*Q[1,1]*(y**2) + Q[1,0]*x*y + q[0]*x+ q[1]*y
contours = plt.contour(fcont, extent=[-10, 10, -10, 10],
                    cmap=plt.cm.gnuplot)


#Etichete pentru multimile izonivel
plt.clabel(contours, inline=1,
                fmt='%1.1f', fontsize=10)

plt.plot(id_all_x_i, id_all_y_i, 'm-', linewidth=2)
plt.plot(id_all_x_i, id_all_y_i, 'g+')
plt.plot(all_x_i, all_y_i, 'b-', linewidth=2)
plt.plot(all_x_i, all_y_i, 'k+')
plt.plot(sol[0], sol[1], 'rx', markersize = 14)





fig.savefig('MG_quad_cs.pdf')

print("#######################")
print("")
print("Numar conditionare problema: ",nr_cond)
print("")
print("Numar de iteratii pas constant: ",k1)
print("Numar de iteratii pas ideal: ",k2)
print("")
print("Solutie gasita de MG: ",'(',solMG[0],solMG[1],')')
print("Solutie optima: ",'(',sol[0],sol[1],')')
print("Valoare optima: ",f(sol))
print(0.5*(Q[0,0]*(sol[0]**2) + Q[1,1]*(sol[1]**2)) + Q[1,0]*sol[0]*sol[1] + q[0]*sol[0]+ q[1]*sol[1])
#print("Solutie gasita de MG: ",'(',solMG[0],solMG[1],')')
print("")
print("#######################")
