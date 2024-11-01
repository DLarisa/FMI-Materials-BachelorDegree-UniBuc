# Lab1 -> 12.10

import numpy as np
import matplotlib.pyplot as plt
import metode_numerice_ecuatii_algebrice as mnea
import sympy as sym




"""
Lab#2.Ex2.b: Să se identifice intervalele pe care funcția f admite o sol unică.
             f(x) = x^3 - 7*(x^2) + 14x - 6
             Interval (a, b) = (0, 4)
"""

def f(x):
    y = x**3 - 7*x**2 + 14*x - 6
    return y


(a, b) = (0, 4)
interval = mnea.cauta_intervale(f, a, b, 10)
print(interval)
dim = np.shape(interval)[1]  #shape: returnează dimensiunile matricei


#Desen Grafice
x_grafic = np.linspace(0, 4, 100)
y_grafic = f(x_grafic)
plt.plot(x_grafic, y_grafic, marker = 'o', color = 'blue', linewidth = 3)
plt.axvline(0, color = 'black')
plt.axhline(0, color = 'black')
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Lab#2.Ex2.b)')
plt.grid(True)
for i in range(dim):
    plt.plot(interval[:, i], np.zeros((2, 1)), color = 'red', linewidth = 10)
plt.show()




"""
Lab#2.Ex2.a: Pt datele de mai sus, să se afle toate rădăcinile conform
             metodei bisecției.
"""

r = np.zeros(dim)
for i in range(dim):
    r[i], N = mnea.bisectie(f, interval[0,i], interval[1, i], 10**-3)
    print("Metoda Bisectiei")
    print("Ecuația x^3 - 7*(x^2) + 14x - 6 = 0")
    print("Intervalul [{:.3f}, {:.3f}]".format(interval[0,i], interval[1,i]))
    print("Solutia Numerica: x *= {:.3f}".format(r[i]))
    print("-----------------------------------")

plt.plot(r, f(r), 'o-', color = 'green', markersize = 10)
plt.show()





# ---------------------------------------------
# Lab2 -> 19.10


"""
Lab#2.Ex3:
"""

x = sym.symbols('X')           # var simbolica
f_expr = f(x)                  # expresia simbolica
df_expr = sym.diff(f_expr, x)
df = sym.lambdify(x, df_expr)  # functie acum
print("--------------------------------------------------------------------------------------")
print(f'Expresia: {f_expr}')
print(f'Derivata calculata: {df_expr}')
print(f'Derivata de 2: {df(2)}')

#Construim functia pe [0, 4]
(a, b) = (0, 4)
n_noduri = 100
x_grafic = np.linspace(a, b, n_noduri)
y_grafic = f(x_grafic)
plt.plot(x_grafic, y_grafic, linewidth = 3)
plt.grid()
plt.axvline(0, color = 'black') #ax vertical line
plt.axhline(0, color = 'black')

# Definim x0 = vector cu valoarea de pornire pt fiecare radacina 
# Aleg x0 a.î. f(x0) * f''(x0) > 0
# f(x0) < 0 --> la stanga (pt prima radacina)
x0 = np.array([0.3, 2.5, 4])
sols = np.zeros(x0.shape)
iteratii = np.zeros(sols.shape)
eps = 10 ** (-6)
for i in range(len(x0)):
    sols[i], iteratii[i] = mnea.NewtonRap(f, df, x0[i], eps)

plt.plot(sols, f(sols), 'o', markerfacecolor = 'red', markersize = 10)
plt.show()




"""
Lab#2.Ex4:
"""

x_grafic = np.linspace(-1, 1.5, 100)
y_grafic = f(x_grafic)
plt.plot(x_grafic, y_grafic, linewidth = 3)
plt.grid()
plt.axvline(0, color = 'black') #ax vertical line
plt.axhline(0, color = 'black')
plt.show()
x0 = -1
eps = np.linspace(10 ** -13, 10 ** -3, 50)
N_bis2 = np.zeros(eps.shape)
N_NR = np.zeros(eps.shape)
for i in range(len(eps)):
    sol_bis, N_bis2[i] = mnea.bisectie2(f, -1, 1.5, eps[i])
    sol_NR, N_NR[i] = mnea.NewtonRap(f, df, x0, eps[i])

plt.plot(eps, N_bis2, 'b', linewidth = 2)
plt.plot(eps, N_NR, 'r', linewidth = 2)
plt.grid()
plt.axvline(0, color = 'black') 
plt.axhline(0, color = 'black')
plt.show()
































