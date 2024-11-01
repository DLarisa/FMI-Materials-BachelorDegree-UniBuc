"""
Created on Mon Nov 16 09:57:55 2020

@author: Larisa

Laborator: 6
"""



import numpy as np
import matplotlib.pyplot as plt
import sympy as sym
import sympy.utilities.lambdify as lam



"""
Exercițiul 1:
Fie f(x, y) = x^2 / 4 + y^2 si domeniul (x, y) aparține [-6, 6] X [-4, 4].
"""

# a) Să se construiască această suprafață (z = f(x, y)) pe domeniul dat.
(a, b) = (-6, 6)
(c, d) = (-4, 4)
(Nx, Ny) = (20, 20) #nr de puncte în care să fie împărțit intervalul

x_grafic = np.linspace(a, b, Nx)
y_grafic = np.linspace(c, d, Ny)

[X, Y] = np.meshgrid(x_grafic, y_grafic)
# print(X)
# print(Y)


plt.figure(1)
plt.plot(X, Y, 'o', markerfacecolor = 'red', markersize = 10)
plt.grid(True)
plt.title('Fig 1: Rețeaua de puncte care acoperă domeniul (a, b) X (c, d)')
plt.show()


f = lambda x, y: (x * x) / 4 + y * y
Z = f(X, Y)
# print(Z)


fig = plt.figure(2)
axes = plt.axes(projection = '3d')
surf = axes.plot_surface(X, Y, Z, cmap = plt.cm.jet)
fig.colorbar(surf)



# b) Să se afiseze în plan curbele de nivel Z = 2, 4, 8
fig = plt.figure(3)
axes = plt.axes(projection = '3d')
plt.contour(X, Y, Z, levels = [2, 4, 8])
plt.show()



# c) Afisare linia de nivel care trece prin punctul de coordonate (-2, 1)
x0 = -2
y0 = 1
plt.figure(4)
plt.plot(x0, y0, 'o', markerfacecolor = 'red', markersize = 10)
plt.contour(X, Y, Z, levels = [f(x0, y0)])
plt.show()



# d) Să se afle simbolic gradientul funcției
x, y = sym.symbols('x y')
f_expr = f(x, y)
df1 = [sym.diff(f_expr, x), sym.diff(f_expr, y)]
df2 = sym.lambdify((x, y), [df1[0], df1[1]])



# e) Calculați direcția funcției în raport cu care aceasta creste/descreste cel mai rapid
# Direcția pe care funcția creste cel mai rapid
v_max = df2(x0, y0)
v_max = v_max / np.sqrt(v_max[0] ** 2 + v_max[1] ** 2)
print(f'df calculat pentru ({x0}, {y0}): {v_max}')
plt.plot([x0, x0 + v_max[0]], [y0, y0 + v_max[1]], linewidth = 4)
plt.axis('equal')  # Pentru ca axele sa fie egale
# plt.show()

# Direcția pe care funcția descreste cel mai rapid
v_min = -v_max
print(f'df calculat pentru ({x0}, {y0}): {v_min}')
plt.plot([x0, x0 + v_min[0]], [y0, y0 + v_min[1]], linewidth = 4)
plt.axis('equal')  # Pentru ca axele sa fie egale
# plt.show()



# f) Construiți curba pe suprafața dată, care are reprezentarea parametrică
s = np.linspace(-7, 7, 30)  # parametrul din reprezentarea parametrică a curbei
x_curba = x0 + s * v_max[0]
y_curba = y0 + s * v_max[1]
z_curba = f(x_curba, y_curba)
axes = plt.axes(projection = '3d')
axes.plot3D(x_curba, y_curba, z_curba, linewidth = 3)
plt.show()



# g) Să se afle punctul de minim local de la ex1, folosind gradient descent
A = np.array([[1/2, 0], [0, 2]])
b = np.array([[0], [0]])
x_old = np.array([[x0], [y0]])
eps = 10 ** (-3)
k = 0
xk = []
xk.append([x_old[0], x_old[1]])

while True:
    v = df2(x_old[0], x_old[1])  # directia gradientului
    if np.sqrt(v[0] ** 2 + v[1] ** 2) < eps:
        break

    s = (np.transpose(v) @ (A @ x_old - b)) / (np.transpose(v) @ (A @ v))
    x_new = x_old - s * v
    xk.append([x_new[0], x_new[1]])
    k += 1
    x_old = x_new


print(x_old)  # soluția aproximativă
x_array = np.asarray(xk)


plt.figure(6)
for i in range(np.shape(x_array)[0]):
    plt.plot(x_array[i][0][0], x_array[i][1][0], '-o', linewidth = 3, 
             markerfacecolor = 'red', markersize = 10)
    plt.contour(X, Y, Z, levels=[f(x_array[i][0][0], x_array[i][1][0])])
    print(f(x_array[i][0][0], x_array[i][1][0]))
plt.axis('equal')
plt.show()