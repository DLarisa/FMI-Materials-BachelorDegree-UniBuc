# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 10:09:30 2020

@author: Larisa
"""


import numpy as np


def metSubDesc(A, b, tol):
    """

    Parameters
    ----------
    A : matrice pătratică, superior triunghiulară, cu toate elementele de pe diagonala principală nenule.
    b : vectorul termenilor liberi.
    tol : toleranță = valoare numerică foarte mică în raport cu care vom compara numerele apropiate de 0.

    Returns
    -------
    x = Soluția Sistemului.

    """
    
    # Verificăm dacă matricea este pătratică
    m, n = np.shape(A)
    if m!= n:
        print("Matricea nu este pătratică. Introduceți altă matrice.")
        x = None
        return x
    
    # Verificăm dacă matricea este superior triunghiulară
    for i in range(m):
       for j in range(i):
           if abs(A[i][j] > tol):
               print("Matricea nu este superior triunghiulară.")
               x = None
               return x
    
    # Verificam dacă toate elementele de pe diagonala principală sunt nenule => Si. este compatibil ddeterminat (adică am soluție unică)
    for i in range(n):
        if A[i][i] == 0:
            print("Sistemul nu este compatibil determinat.")
            x = None
            return x
    
    x = np.zeros((n, 1))
    x[n - 1] = b[n - 1] / A[n - 1][n - 1]
    
    k = n - 2
    while k >= 0:
        s = 0
        for j in range(k + 1, n):
            s += x[j] * A[k][j]
            
        x[k] = (1 / A[k][k]) * (b[k] - s)
        k -= 1
    
    return x


# Gauss fără Pivotare
def GaussFP(A, b, tol):
    """

    Parameters
    ----------
    A : matrice pătratică.
    b : vectori termeni liberi.
    tol : toleranță => valoare cu care comparăm numerele nenule.

    Returns
    -------
    x = Soluția Sistemului.

    """
    
    # Verificăm dacă matricea este pătratică
    m, n = np.shape(A)
    if m != n:
        print("Matricea nu este pătratică. Introduceți altă matrice.")
        x = None
        return x
    
    A_extins = np.concatenate((A, b), axis = 1) # axis = 1  =>  pentru concatenare coloane; dacă aveam 0, concatenam linii
    """ SAU: A_extins = np.column_stack((A, b)) # concatenare special pentru coloane  ---> DAR, atunci trebuie să fiu 
    atentă cum definesc b-ul (Nu merge ([1, 2, 3]); ci trebuie ([[1], [2], [3]]))"""
    
    for k in range(n - 1):       # coloane
    
        p = None
        for j in range(k, n):
            if abs(A[j][k]) > tol:
                p = j
                break
        
        if p == None:
            print("Sistemul nu admite solutie unică.")
            x = None
            return x
        
        if p != k:
            A_extins[[p, k]] = A_extins[[k, p]]   # swap linia p cu linia k
        
        for j in range(k + 1, n):
            A_extins[j] = A_extins[j] - (A_extins[j][k] / A_extins[k][k]) * A_extins[k]
    
        
    if abs(A_extins[n - 1][n - 1]) <= tol:
        print("Sistemul nu admite soluție unică.")
        x = None
        return x
    
    x = metSubDesc(A_extins[:, 0:n], A_extins[:, n], tol)
    return x  


# Gauss cu Pivotare Parțială
def GaussPP(A, b, tol):
    """

    Parameters
    ----------
    A : matrice pătratică.
    b : vectori termeni liberi.
    tol : toleranță => valoare cu care comparăm numerele nenule.

    Returns
    -------
    x = Soluția Sistemului.

    """
    
    # Verificăm dacă matricea este pătratică
    m, n = np.shape(A)
    if m != n:
        print("Matricea nu este pătratică. Introduceți altă matrice.")
        x = None
        return x
    
    A_extins = np.concatenate((A, b), axis = 1) # axis = 1  =>  pentru concatenare coloane; dacă aveam 0, concatenam linii
    # SAU: A_extins = np.column_stack((A, b)) # concatenare special pentru coloane
    
    for k in range(n - 1):       # coloane
        max = A_extins[k][k]
        p = k
        for j in range(k + 1, n):
            if abs(A_extins[j][k]) > abs(max):
                max = A_extins[j][k]
                p = j
        
        if abs(max) <= tol:
            print("Sistemul nu admite solutie unică.")
            x = None
            return x
        
        if p != k:
            A_extins[[p, k]] = A_extins[[k, p]]   # swap linia p cu linia k
        
        for j in range(k + 1, n):
            A_extins[j] = A_extins[j] - (A_extins[j][k] / A_extins[k][k]) * A_extins[k]
    
        
    if abs(A_extins[n - 1][n - 1]) <= tol:
        print("Sistemul nu admite soluție unică.")
        x = None
        return x
    
    x = metSubDesc(A_extins[:, 0:n], A_extins[:, n], tol)
    return x


# Definirea Metodei Gauss cu Pivotare Totală
def GaussPivTot(A, b, tol):
    """

    Parameters
    ----------
    Ax = b.

    Returns
    -------
    x = Soluția.

    """
    
    # Verificăm dacă matricea este pătratică
    m, n = np.shape(A)
    if m != n:
        print("Matricea nu este pătratică. Introduceți altă matrice.")
        x = None
        return x
    
    A = np.column_stack((A, b)) # concatenare coloană termeni liberi la matrice A -> matrice extinsă
    n = len(b)
    
    index = np.array(range(n))
    
    for k in range(n - 1):
        p = k
        m = k
      
        for i in range(k, n):
            for j in range(k, n):
                if abs(A[p][m]) < abs(A[i][j]):
                    p = i
                    m = j
    
        if A[p][m] == 0:
            print("Sistem Incompatibil sau Compatibil Nedeterminat!")
            break
        
        """
        !!! ATENȚIE: Tb să pun np.array
        A = np.array([[1, 2, 3],
                      [4, 5, 6],
                      [7, 8, 9]])

        A[[1, 0]] = A[[0, 1]] #linii
        A[:,[2,1]] = A[:,[1,2]] #coloane
        """
        if p != k:
            A[[p, k]] = A[[k, p]] # interschimb linia p cu linia k
        
        if m != k:
            A[:, [m, k]] = A[:, [k, m]] # interschimb coloana m cu coloana k
            index[[m, k]] = index[[k, m]]       
        
        for l in range(k + 1, n):
            m = A[l][k] / A[k][k]
            A[l] = A[l] - m * A[k]
        
        if A[n - 1][n - 1] == 0:
            print("Sistem Incompatibil sau Compatibil Nedeterminat!")
            break
        
        y = metSubDesc(A[:, 0:n], A[:, [n]], tol)
        x = np.zeros(len(y))
        for i in range(n):
            x[index[i]] = y[i]
             
    return x



# -------------------------------- Lab4
def rang(A, tol):
    """

    Parameters
    ----------
    A : matrice cu m linii si n coloane.
    tol : toleranța.

    Returns
    -------
    rang = rangul matricei.

    """
    h = 0
    k = 0
    rang = 0
    
    m, n = np.shape(A)
    
    while h < m and k < n:
        
        p = h
        for j in range(h, m):
            if abs(A[j][k]) > abs(A[p][k]):
                p = j
        
        if abs(A[p][k]) <= tol:
            k += 1
            continue
        
        if p != h:
            A[[p, h]] = A[[h, p]]
            
        for l in range(h+1, m):
            aux = A[l][k] / A[h][k]
            A[l] = A[l] - aux * A[h]
        
        h += 1
        k += 1
        rang += 1
        #print(f'Matrice:{A}')
        
        
    return rang
         


def naturaSi(A, b, tol):
    """

    Parameters
    ----------
    A : matrice cu m linii si n coloane.
    b : matricea termenilor liberi.
    tol : toleranța.

    Returns
    -------
    Mesaj cu tipul Sistemului.

    """
    
    m, n = np.shape(A)
    A_extins = np.concatenate((A, b), axis = 1)
    rang_A = rang(A, tol)
    rang_A_extins = rang(A_extins, tol)
    
    if rang_A == rang_A_extins and rang_A == n:
        print("Sistem Compatibil Determinat.")
        return
    
    if rang_A == rang_A_extins and rang_A < n:
        print("Sistem Compatibil Nedeterminat.")
        return
    
    if rang_A != rang_A_extins:
        print("Sistem Incompatibil.")
        return
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        