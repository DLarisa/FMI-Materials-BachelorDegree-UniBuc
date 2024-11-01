# Tema 3 - Exercițiul 2 


# Librării
import numpy as np
import matplotlib.pyplot as plt





# Date Generale
def f(x):
    return (x[0] - 2)**4 + (x[0] - 2 * x[1])**2

# Gradient în funcție de f
def gradient(x):
    return np.array([4 * x[0]**3 - 24 * x[0]**2 + 50 * x[0] - 4 * x[1] - 32, (-4) * (x[0] - 2 * x[1])], float)





# Metode Gradient Proiectat   -->  Subpunct a)
### cu Backtracking
def MGP_BT(eps, alpha, r, x, c, ok, f_star):
    d = []
    k = 0
    
    if ok == 'unu':
        while f(x) - f_star > eps:
            k += 1
            d.append(f(x) - f_star)
            x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
            aux = f(x) - c / alpha * np.linalg.norm(x_new - x)**2
            # print(f(x))
            # print(f_star)
            
            while f(x_new) > aux:
                alpha *= 0.99
                aux = f(x) - c / alpha * np.linalg.norm(x_new - x)**2
                x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
                
            x = x_new
    else:
        while True:
            k += 1
            x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
            aux = f(x) - c / alpha * np.linalg.norm(x_new - x)**2
            
            while f(x_new) > aux:
                alpha *= 0.99
                aux = f(x) - c / alpha * np.linalg.norm(x_new - x)**2
                x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
                
            d.append(np.linalg.norm(x_new - x))
            if np.linalg.norm(x_new - x) <= eps:
                break
                
            x = x_new

    return x, k, np.array(d, float)



### cu Pas Constant
def MGP_Const(eps, alpha, r, x, c, ok, f_star):
    d = []
    k = 0
    
    if ok == 'unu':
        while f(x) - f_star > eps:
            k += 1
            d.append(f(x) - f_star)
            x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
            aux = f(x) - 1 / (2 * alpha) * np.linalg.norm(x_new - x)**2
            # print(f(x))
            # print(f_star)
            
            while f(x_new) > aux:
                alpha *= 0.99
                aux = f(x) - 1 / (2 * alpha) * np.linalg.norm(x_new - x)**2
                x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
                
            x = x_new
    else:
        while True:
            k += 1
            x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
            aux = f(x) - 1 / (2 * alpha) * np.linalg.norm(x_new - x)**2
            
            while f(x_new) > aux:
                alpha *= 0.99
                aux = f(x) - 1 / (2 * alpha) * np.linalg.norm(x_new - x)**2
                x_new = min(1, r / np.linalg.norm(x - alpha * gradient(x))) * (x - alpha * gradient(x))
                
            d.append(np.linalg.norm(x_new - x))
            if np.linalg.norm(x_new - x) <= eps:
                break
                
            x = x_new

    return x, k, np.array(d, float)





# Subpunct b)
### Date
eps = 10**(-5)
alpha = 0.5
r = 2
x_start = np.array([7, 7], float)
c = 0.3
x_min = np.array([1.78959811, 0.89293818], float)     # cerința cere ca norma să fie <= 2    

### Soluții 
x1, k1, d1 = MGP_Const(eps, alpha, r, x_start, c, 'unu', f(x_min))
print(x1)
x2, k2, d2 = MGP_Const(eps, alpha, r, x_start, c, 'doi', f(x_min))
print(x2)
x3, k3, d3 = MGP_BT(eps, alpha, r, x_start, c, 'unu', f(x_min))
print(x3)
x4, k4, d4 = MGP_BT(eps, alpha, r, x_start, c, 'doi', f(x_min))
print(x4)




# Figură 1
maxi = max(k1, k3)
a = np.zeros(maxi, float)
b = np.zeros(maxi, float)
a[:d1.shape[0]] = d1
b[:d3.shape[0]] = d3

plt.plot(np.linspace(1, maxi, maxi), b, '--',  color='r')
plt.plot(np.linspace(1, maxi, maxi), a, '-',  color='g')
plt.legend(['MGP_Const', 'MGP_BT'])
plt.xlabel('k')
plt.ylabel('f(x) - f*')
plt.title('f(x) - f*')
plt.show()




# Figură 2
# print(k2)
# print(k4)
maxi = max(k2, k4)
a = np.zeros(maxi, float)
b = np.zeros(maxi, float)
a[:d2.shape[0]] = d2
b[:d4.shape[0]] = d4

plt.plot(np.linspace(1, maxi, maxi), b, '--',  color='r')
plt.plot(np.linspace(1, maxi, maxi), a, '-',  color='g')
plt.legend(['MGP_Const', 'MGP_BT'])
plt.xlabel('k')
plt.ylabel('||gradient(x)||')
plt.title('||gradient(x)||')
plt.show()