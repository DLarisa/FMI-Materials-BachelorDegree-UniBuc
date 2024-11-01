#include <iostream>
#include <math.h>
using namespace std;
int i, j;

int DI(int nr, int N, int i1, int j1, int i2, int j2)
{
    if(N==1)
    {
        if(nr%4==1)      i=i1+1, j=j1+1;
        else if(nr%4==2) i=i1+2, j=j1+2;
        else if(nr%4==3) i=i1+1, j=j1+2;
        else             i=i1+2, j=j1+1;
        return 0;
    }

    if(1<=nr && nr<=pow(2, N)) //Cadran 1
    {
        N--;
        i2=j2=pow(2, N)-1;
    }
    else if(pow(2, N)+1<=nr && nr<=2*pow(2, N)) //Cadran 2
    {
        N--; i1=pow(2, N); j1=i1;
    }
    else if(2*pow(2, N)+1<=nr && nr<=3*pow(2, N)) //Cadran 3
    {
        N--; j1=pow(2, N); i2=j1-1;
    }
    else //Cadran 4
    {
        N--; i1=pow(2, N); j2=i1-1;
    }
    DI(nr, N, i1, j1, i2, j2);
}

int main()
{
    int N, nr;
    cout<<"Nr cautat: "; cin>>nr;
    cout<<"N: "; cin>>N;
    DI(nr, N, 0, 0, pow(2, N)-1, pow(2, N)-1);
    cout<<"Solutie: "<<i<<" "<<j<<endl;

    return 0;
}
