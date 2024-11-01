import numpy as np
import sympy as sym
from math import e

def f1(x):
    return e ** x

def CuadraturaNewton(func, a, b,):
    """
        Calculeaza Formula de cuadratura Newton pentru o diviziune de n = 3 subintervale echidistante pe [a,b]
    :param x:punctul in care trebuie calulata integrala
    :return: un vector de ponderi pentru fiecare dintre cele n+1 puncte din Cuadratura Newton Cotes inchisa
    """
    n_subint = 3
    n_noduri = 4
    x_noduri, h= np.linspace(a, b, n_noduri,retstep=True)
    print(f'a ={a}, b = {b}, h = {h}')
    w = np.zeros((n_noduri,), dtype=float)
    x_noduri[0] = a
    x_noduri[n_noduri - 1] = b
    sym.init_printing(pretty_print=True, use_unicode=False, wrap_line=False)
    t = sym.Symbol('t')
    expr = sym.Mul()

    for k in range(1, n_noduri + 1):
        w[k - 1] = 0
        t = sym.Symbol('t')
        expr = sym.Mul()
        for i in range(1, n_noduri + 1):
            if i != k:
                expr = expr * ( (t - i) / (k - i) )
        integral = sym.Integral(expr, t)
        w[k-1] = sym.integrate(expr, (t, 1, n_noduri))
        sym.pprint(integral)
        print(f'w[{k}]: {w[k-1]}')

    print(f'Ponderile obtinute: {w}')
    Inf = np.sum(np.array([w[k] * func(x_noduri[k]) for k in range(0, n_noduri)]))
    x_sym = sym.Symbol('x')
    f_sym = func(x_sym)
    actual = sym.integrate(f_sym, (x_sym, a, b))
    print(f'Integrala aproximata: {Inf}  - Integrala Corecta: {float(actual)} ')
    return Inf


def CuadraturaSumNewton(f, a, b, m):
    """Considerand ca pentru cuadratura Newton avem n=3 intervale, divizam acest interval in 3*m + 1 intervale """
    n_subint = 3
    n_noduri = 3 * m + 1
    x_noduri, h = np.linspace(a, b, n_noduri, retstep=True)
    print(f'noduri: {x_noduri}, h = {h}')
    if x_noduri[0] != a or x_noduri[n_noduri - 1] != b:
        print(f'ERROR in {x_noduri[0]} , {x_noduri[n_noduri - 1]}')

    If2 = np.sum(np.array([(3 * h / 8) * ( f(x_noduri[3*k-3]) + 3 * (f(x_noduri[3*k -2]) + f(x_noduri[3*k-1])) + f(x_noduri[3*k]) ) for k in range(1, m+1)] ))
    print(f'Aproximare Sum: {If2}')
    return If2


def CuadraturaSumTrapez(f, a, b, m):
    n_noduri = m + 1
    x, h = np.linspace(a, b, n_noduri, retstep=True)
    print(f'noduri: {x}, h = {h}')
    if x[0] != a or x[n_noduri - 1] != b:
        print(f'ERROR in {x[0]} , {x[n_noduri - 1]}')

    If1 = np.sum(np.array([ ( f(x[k-1]) + f(x[k]) ) * (x[k] - x[k-1]) / 2  for k in range(1, m + 1)]))
    If12 = (h/2) * ( f(x[0]) + 2 * np.sum(np.array([f(x[k]) for k in range(2, m)])) + f(x[m]))
    print(f'Aproximare Sum: {If1} Forumla2: {If12}')
    return If1


def CuadraturaSumDreptunghi(f, a, b, m):
    n_noduri = 2 * m + 1
    x, h = np.linspace(a, b, n_noduri, retstep=True)

    print(f'noduri: {x}, h = {h}')
    if x[0] != a or x[n_noduri - 1] != b:
        print(f'ERROR in {x[0]} , {x[n_noduri - 1]}')
    If0 = np.sum(np.array([f(x[2*k - 1]) * (- x[2 * k - 2] + x[2 * k]) for k in range(1, m + 1)]))
    If02 = 2 * h * np.sum(np.array([f(x[2 * k - 1]) for k in range(1, m + 1)]))
    print(f'Aproximare Sum: {If02}')
    return If02


def CuadraturaSumSimpson(f, a, b, m):
    n_noduri = 2 * m + 1
    x, h = np.linspace(a, b, n_noduri, retstep=True)

    print(f'noduri: {x}, h = {h}')
    if x[0] != a or x[n_noduri - 1] != b:
        print(f'ERROR in {x[0]} , {x[n_noduri - 1]}')
    If2 =  np.sum(np.array([ h *((1./3.) * f(x[2*k - 2]) + (4./3.) * f(x[2*k - 1]) + (1./3.) * f(x[2*k])) for k in range(1, m + 1)]))

    print(f'Aproximare Sum: {If2}')
    return If2

def Integrare(f, a, b, m, metoda):
    if metoda == 'trapez':
        return CuadraturaSumTrapez(f, a, b, m)
    if metoda == 'dreptunghi':
        return CuadraturaSumDreptunghi(f, a, b, m)
    if metoda == 'Simpson':
        return CuadraturaSumSimpson(f, a, b, m)
    if metoda == 'Newton':
        return CuadraturaSumNewton(f, a, b, m)
    return None

if __name__ == '__main__':
    x_sym = sym.Symbol('x')
    f_sym = f1(x_sym)
    a = 1
    b = 3
    m = 5
    Iactual = sym.integrate(f_sym, (x_sym, a, b))
    print(f'Integrala calculata exact :{float(Iactual)}')

    metode = ['trapez','Newton','Simpson','dreptunghi']

    for metoda in metode:
        print(f'Calculul prin metoda {metoda}')
        If = Integrare(f1, a, b, m, metoda)
        err = float(Iactual) - If
        print(f'Eroarea de calcul : {err}')
