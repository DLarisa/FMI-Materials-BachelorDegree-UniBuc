#include <iostream>
using namespace std;
struct punct
{
    double x, y, z;
}A[3];
int verific(double a)
{
    if(A[2].x-A[0].x!=a*(A[1].x-A[0].x)) return 0;
    if(A[2].y-A[0].y!=a*(A[1].y-A[0].y)) return 0;
    if(A[2].z-A[0].z!=a*(A[1].z-A[0].z)) return 0;
    return 1;
}

int main()
{
    int i;
    for(i=0; i<3; i++)
    {
        cout<<"Dati Punctul "<<i+1<<": ";
        cin>>A[i].x>>A[i].y>>A[i].z;
    }
    if(A[0].x==A[1].x && A[0].y==A[1].y && A[0].z==A[1].z)
    {
        cout<<"Punctele sunt coliniare."<<endl;
        cout<<"A2 = 1*A1 + 0*A3";
    }
    else
    {
        double aux=A[1].x-A[0].x;
        if(aux!=0)
        {
            double a=(A[2].x-A[0].x)/aux;
            if(verific(a))
            {cout<<"Punctele sunt coliniare."<<endl;
            cout<<"A3 = "<<1-a<<"*A1 + "<<a<<"*A2"<<endl;}
            else cout<<"Nu sunt coliniare.";
        }
        else
        {
            aux=A[1].y-A[0].y;
            if(aux!=0)
            {
                double a=(A[2].y-A[0].y)/aux;
                if(verific(a))
                {cout<<"Punctele sunt coliniare."<<endl;
                cout<<"A3 = "<<1-a<<"*A1 + "<<a<<"*A2"<<endl;}
                else cout<<"Nu sunt coliniare.";
            }
            else
            {
                aux=A[1].z-A[0].z;
                if(aux!=0)
                {
                    double a=(A[2].z-A[0].z)/aux;
                    if(verific(a))
                    {cout<<"Punctele sunt coliniare."<<endl;
                    cout<<"A3 = "<<1-a<<"*A1 + "<<a<<"*A2"<<endl;}
                }
                else cout<<"Nu sunt coliniare.";
            }
        }
    }


    return 0;
}
