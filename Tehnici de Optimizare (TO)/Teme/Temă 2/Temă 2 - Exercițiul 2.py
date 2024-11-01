# Librării
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d





# Date Generale
def f(x):
    return x[0]**2 + x[1]**2


# Gradient în funcție de f 
def gradient(x):
    return np.array([2 * x[0], 2 * x[1]], float)





# Metoda 1 -> Backtracking (Algoritm Seminar 2)
def Newton_BT(H, x, alpha, c, eps, ok):
    f_star = f(np.array([0, 0], float))
    d = []
    k = 0
    if ok == 'unu':
        while f(x) - f_star > eps:
            k += 1
            d.append(f(x) - f_star)
            first = f(x - alpha * gradient(x))
            second = f(x) - c * alpha * gradient(x).transpose() @ np.linalg.inv(H) @ gradient(x)
            while first > second:
                alpha = alpha * 0.9
                first = f(x - alpha * gradient(x))
                second = f(x) - c * alpha * gradient(x).transpose() @ np.linalg.inv(H) @ gradient(x)
            x_new = x - alpha * np.linalg.inv(H) @ gradient(x)
            x = x_new
    else:
        while np.linalg.norm(gradient(x)) > eps:
            k += 1
            d.append(np.linalg.norm(gradient(x)))
            first = f(x - alpha * gradient(x))
            second = f(x) - c * alpha * gradient(x).transpose() @ np.linalg.inv(H) @ gradient(x)
            while first > second:
                alpha = alpha * 0.9
                first = f(x - alpha * gradient(x))
                second = f(x) - c * alpha * gradient(x).transpose() @ np.linalg.inv(H) @ gradient(x)
            x_new = x - alpha * np.linalg.inv(H) @ gradient(x)
            x = x_new
        
    return x, k, np.array(d, float)



# Metoda 2 -> cu Pas Constant (alpha = 1) (Algoritm Seminar 2)
def Newton_Const(H, x, eps, ok):
    d = []
    k = 0
    f_star = f(np.array([0, 0], float))
    if ok == 'unu':
        while f(x) - f_star > eps:
            k += 1
            d.append(f(x) - f_star)
            d.append(np.linalg.norm(gradient(x)))
            x_new = x - np.linalg.inv(H) @ gradient(x)
            x = x_new
    else:
        while np.linalg.norm(gradient(x)) > eps:
            k += 1
            d.append(np.linalg.norm(gradient(x)))
            x_new = x - np.linalg.inv(H) @ gradient(x)
            x = x_new
    return x, k, np.array(d, float)





# Rezolvare
eps = 10**(-17)
H = np.array([[2, 0], [0, 2]], float)
alpha = 0.5
x1, k1, d1 = Newton_BT(H, np.array([5, 7], float), alpha, 1, eps, 'unu')
x2, k2, d2 = Newton_BT(H, np.array([5, 7], float), alpha, 1, eps, 'doi')
x3, k3, d3 = Newton_Const(H, np.array([5, 7], float), eps, 'unu')
x4, k4, d4 = Newton_Const(H, np.array([5, 7], float), eps, 'doi')
print(x1)
print(x2)
print(x3)
print(x4)



# Grafic 1
maxi = max(k1, k3)
a = np.zeros(maxi, float)
b = np.zeros(maxi, float)
a[:d3.shape[0]] = d3
b[:d1.shape[0]] = d1

plt.plot(np.linspace(1, maxi, maxi), b, '--',  color='r')
plt.plot(np.linspace(1, maxi, maxi), a, '-',  color='g')
plt.legend(['Newton Backtracking', 'Newton Pas Const'])
plt.xlabel('k')
plt.ylabel('f(x) - f*')
plt.title('Metoda Distanței f(x) - f*')
plt.show()



# Grafic 2
maxi = max(k2, k4)
a = np.zeros(maxi, float)
b = np.zeros(maxi, float)
a[:d4.shape[0]] = d4
b[:d2.shape[0]] = d2

plt.plot(np.linspace(1, maxi, maxi), b, '--',  color='r')
plt.plot(np.linspace(1, maxi, maxi), a, '-',  color='g')
plt.legend(['Newton Backtracking', 'Newton Pas Const'])
plt.xlabel('k')
plt.ylabel('||gradient(x)||')
plt.title('Metoda Normei Gradientului: ||gradient(x)||')
plt.show()