# -*- coding: utf-8 -*-
import numpy as np



"""
Funcție care caută intervalele pe care funcția are o soluție.
f(a) * f(b) < 0 -> EXISTENȚA
"""
def cauta_intervale(f, a, b, n):
    """
    Parameters
    ----------
    f : funcția asociată ecuației f(x)=0.
    a : capătul din stânga interval.
    b : capătul din dreapta interval.
    n : nr de subintervale în care împărțim intervalul global (a, b).

    Returns
    -------
    Matricea 'intervale' cu 2 linii; prima linie -> capăt st interval curent
    si a doua linie -> capat dr
    si un nr de coloane = nr radacini
    """
    
    x = np.linspace(a, b, n+1)   #returnează n+1 numere, situate la distanțe egale, din cadrul intervalului [a, b]
    for i in range(len(x)):   #range: for i = 0, len(x); i++
        if(f(x[i]) == 0):     #capetele intervalelor mele nu au voie să fie 0; tb să avem soluțiile în intervale, nu la capete
            print("Schimba nr de Intervale")
            exit(0)

    matrice = np.zeros((2, 1000))  #returnează un nou vector plin de 0; pt că am (2, 1000) -> matrice cu 2 rânduri și 1000 coloane
    z = 0
    for i in range(n):
        if f(x[i]) * f(x[i+1]) < 0:  #existență soluție
            matrice[0][z] = x[i]
            matrice[1][z] = x[i + 1]
            z += 1 
    
    matrice_finala = matrice[:, 0:z]   #iei ambele 2 linii și doar coloanele de la 0 la z (numărat mai sus)
    return matrice_finala



"""
    Funcție care implementează algoritmul metodei bisecției.
"""
def bisectie(f, xmin, xmax, eps):
    """
    Parameters
    ----------
    f : f(x) = 0.
    xmin, xmas: capete intervale.
    eps : toleranța / eroarea (epsilon).

    Returns
    -------
    Soluția aproximativă, dar și numărul de iterații N necesar pt a obține soluția cu eroarea eps.
    """
    
    c = (xmin + xmax) / 2
    N = np.floor(np.log2((xmax-xmin)/eps))  #floor: cel mai mare int, dar mai mic decât val. mea
    for i in range(int(N)):
        if f(c) == 0:
            break                           #am gasit soluția
        elif f(xmin) * f(c) < 0:
            xmax = c
        elif f(xmin) * f(c) > 0:
            xmin = c
        
        c = (xmin + xmax) / 2
    return c, N



"""
    Funcție care implementează algoritmul metodei bisecției.
    ---> Pt Lab2.Ex4.
"""
def bisectie2(f, xmin, xmax, eps):
    
    x_old = (xmin + xmax) / 2
    k = 1
    while True:
        if f(x_old) == 0:
            x_new = x_old      
            break                    
        elif f(xmin) * f(x_old) < 0:
            xmax = x_old
        elif f(xmin) * f(x_old) > 0:
            xmin = x_old
        
        x_new = (xmin + xmax) / 2
        k += 1
        if abs(x_new - x_old) / abs(x_old) < eps:
            break
        x_old = x_new
        
    return x_new, k



"""
    Metoda Newton-Raphson
"""       
def NewtonRap(f, df, x0, eps):
    """
    Parameters
    ----------
    f : functia pt care cautam solutia f(x) = 0.
    df : derivata functiei.
    x0 : valoare de pornire.
    eps : epsilon / toleranta.

    Returns
    -------
    solutia (xk), nr de iteratii (N).
    """
    
    x_old = x0
    N = 1
    while True:
        #Calculăm noua iteratie
        x_new = x_old - (f(x_old) / df(x_old))
        N += 1
        if(abs(x_new - x_old) / abs(x_old) < eps):
            break
        x_old = x_new
    
    return x_new, N   
            
        
    
    
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            