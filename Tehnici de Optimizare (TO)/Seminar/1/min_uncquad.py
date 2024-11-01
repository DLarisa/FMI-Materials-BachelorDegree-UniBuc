#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
"""

import numpy as np
from scipy import optimize
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
from matplotlib import cm
from scipy.optimize import minimize

u, v = np.mgrid[-10:10:.1, -10:10:.1]
u = u.T
v = v.T

# Se defineste functia obiectiv
func = lambda x: x[0]**2+x[1]**2

# Se defineste punctul initial (din care porneste algoritmul)
x0 = np.ones((2,1))
optim = minimize(func,x0)
print(optim)

fig = plt.figure(1, figsize=(7, 5))
plt.clf()
plt.axes([0, 0, 1, 1])
ax = fig.gca(projection='3d')

z = u**2+v**2
#z = np.zeros((np.size(u),1))
#for i in np.size(u):
#    z[i] = func((u[i],v[i]))

ax.plot_surface(u, v, z, rstride=8, cstride=8, alpha=0.6)
cset = ax.contour(u, v, z, zdir='z', offset=-40, cmap=cm.coolwarm)

ax.set_xlabel('X')
ax.set_xlim(-10, 10)
ax.set_ylabel('Y')
ax.set_ylim(-10, 10)
ax.set_zlabel('Z')
ax.set_zlim(-40, 100)

plt.show()
fig.savefig('quadratic_with_contour.pdf')

