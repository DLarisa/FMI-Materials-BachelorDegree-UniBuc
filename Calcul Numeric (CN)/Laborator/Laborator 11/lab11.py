import numpy as np
import matplotlib.pyplot as plt
import metodeNumericePentruEcuatiiLiniare as sel
import sympy as sym


def f(x):
    return np.sin(x)


def f1(x):
    return 1/(1 + 25 * (x**2))


n = 20
x_min = -np.pi / 2
x_max = np.pi / 2
X = np.linspace(x_min, x_max, n+1)
Y = f1(X)

x_graf = np.linspace(x_min, x_max, 100)
y_graf = f1(x_graf)

x = sym.symbols('x')
fun = f1(x)
d_fun = sym.diff(fun,x)
dfun = sym.lambdify(x,d_fun,'numpy')
dfa = dfun(x_min)
dfb = dfun(x_max)


# S_graf,dS_graf,d2S_graf = sel.splineCubica(X,Y,x_graf, dfa,dfb)
#
# plt.plot(x_graf, y_graf, color='red', linewidth=3)
# plt.plot(x_graf, S_graf, '--', color='blue', linewidth=3)
# plt.plot(X, Y, 'o', markersize = 10, markerfacecolor='yellow')
# # plt.show()
#
# plt.plot(x_graf, dS_graf, '--', color='blue', linewidth=3)
# # plt.show()
#
# plt.plot(x_graf, d2S_graf, '--', color='blue', linewidth=3)
# # plt.show()
#
# err_graf = abs(y_graf.reshape(-1,1) - S_graf)
# plt.plot(x_graf, err_graf, color = 'red', linewidth=3)
# # plt.show()


# ex 2
# Modelam prima curba
X1 = np.array([1, 2, 5, 6, 7, 8, 10, 13, 17])
print(X1)

Y1 = np.array([3.0, 3.7, 3.9, 4.2, 5.7, 6.6, 7.1, 6.7, 4.5])

x_graf1 = np.linspace(X1[0], X1[len(X1) - 1], 100)

S_graf1, dS_graf1, d2S_graf1 = sel.splineCubica(X1, Y1, x_graf1, 1.0, -0.67)


# Modelam a doua curba
X2 = np.array([17, 20, 23, 24, 25, 27, 27.7])

Y2 = np.array([4.5, 7, 6.1, 5.6, 5.8, 5.2, 4.1])

x_graf2 = np.linspace(X2[0], X2[len(X2) - 1], 100)

S_graf2, dS_graf2, d2S_graf2 = sel.splineCubica(X2, Y2, x_graf2, 3.0, -4.0)


# Modelam a treia curba
X3 = np.array([27.7, 28, 29, 30])

Y3 = np.array([4.1, 4.3, 4.1, 3])

x_graf3 = np.linspace(X3[0], X3[len(X3) - 1], 100)

S_graf3, dS_graf3, d2S_graf3 = sel.splineCubica(X3, Y3, x_graf3, 0.33, -1.5)


plt.plot(x_graf1, S_graf1, '-', color='blue', linewidth=3)
plt.plot(x_graf2, S_graf2, '-', color='blue', linewidth=3)
plt.plot(x_graf3, S_graf3, '-', color='blue', linewidth=3)
plt.axis('equal')
plt.show()

