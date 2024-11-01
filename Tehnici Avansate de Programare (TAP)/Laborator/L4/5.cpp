#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct spectacol
{
    int x, y, w;
};

bool cmp(spectacol i, spectacol j)
{
    if(i.y>j.y) return false;
    return true;
}

int main()
{

    int i, j, n, size=0, maxi=0, maxval=0, prev[100], profit[100];
    vector<spectacol> s;

    cout<<"Nr Activitati: "; cin>>n;
    cout<<"Dati Intervalul si Ponderea pt fiecare Activitate: "<<endl;
    for(i=0; i<n; i++)
    {
        spectacol aux;
        cin>>aux.x>>aux.y>>aux.w;
        s.push_back(aux);
    }

    sort(s.begin(), s.end(), cmp);

    for(i=0; i<n; i++)
        profit[i]=s[i].w, prev[i]=-1;

    for(i=1; i<n; i++)
        for(int j=0; j<i; j++)
            if(s[j].y<=s[i].x)
            {
                if(profit[j]+s[i].w>profit[i])
                {
                    profit[i]=profit[j]+s[i].w;
                    prev[i]=j;

                }
                if(maxval<profit[i])
                {
                    maxi=i;
                    maxval=profit[i];
                }
            }

    vector<spectacol> aux;
    i=maxi;
    while(prev[i]!=-1)
    {
        aux.push_back(s[i]);
        i=prev[i];
        size++;
    }
    aux.push_back(s[i]);
    size++;

    int sum=0;
    cout<<"Raspuns: "<<endl;
    for(j=size-1; j>=0; j--)
        cout<<aux[j].x<<' '<<aux[j].y<<endl, sum+=aux[j].w;
    cout<<"Total: "<<sum<<endl;

    return 0;
}
