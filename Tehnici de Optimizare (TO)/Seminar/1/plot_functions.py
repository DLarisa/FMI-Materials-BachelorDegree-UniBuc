#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Patrascu Andrei-Mihai

Programul figureaza graficul functiei f(x) = x_1^2 + x_2^2
"""

import numpy as np
from scipy import optimize
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
from matplotlib import cm


# Se defineste functia obiectiv
x, y = np.mgrid[-10:10:.1, -10:10:.1]
x = x.T
y = y.T
z = x**2+y**2

fig = plt.figure(1, figsize=(7, 5))
plt.clf()
plt.axes([0, 0, 1, 1])
ax = fig.gca(projection='3d')


ax.plot_surface(x, y, z, rstride=8, cstride=8, alpha=0.6)
cset = ax.contour(x, y, z, zdir='z', offset=-40, cmap=cm.coolwarm)

ax.set_xlabel('X')
ax.set_xlim(-10, 10)
ax.set_ylabel('Y')
ax.set_ylim(-10, 10)
ax.set_zlabel('Z')
ax.set_zlim(-40, 100)

plt.show()
fig.savefig('quadratic_with_contour.pdf')

