#include <iostream>
#include <string>
#include <string.h>
#include <vector>
#include <unordered_set>
#include <fstream>
#include <streambuf>
#include <math.h>
using namespace std;

int v1[1000], v2[1000];
int main()
{
    ifstream f1("f1.txt"), f2("f2.txt");
    std::string s1((std::istreambuf_iterator<char>(f1)), (std::istreambuf_iterator<char>()));
    std::string s2((std::istreambuf_iterator<char>(f2)), (std::istreambuf_iterator<char>()));

    int n=s1.length(), m=s2.length();
    char c1[n+1], c2[m+1], *p;

    strcpy(c1, s1.c_str());
    strcpy(c2, s2.c_str());

    vector<string> S1, S2;
    unordered_set<string> S;
    p=strtok(c1, " ,.");
    while(p)
    {
        S1.push_back(p);
        if(S.find(p)==S.end())
            S.insert(p);
        p=strtok(NULL, " ,.");
    }
    p=strtok(c2, " ,.");
    while(p)
    {
        S2.push_back(p);
        if(S.find(p)==S.end())
            S.insert(p);
        p=strtok(NULL, " ,.");
    }
    int z=0;
    for(auto i: S)
    {
        for(int j=0; j<S1.size(); j++)
            if(i==S1[j]) v1[z]++;
        for(int j=0; j<S2.size(); j++)
            if(i==S2[j]) v2[z]++;
        z++;
    }
    int sum=0, x=0, y=0;
    for(int i=0; i<n; i++) sum+=v1[i]*v2[i];
    for(int j=0; j<S.size(); j++) x+=v1[j]*v1[j];
    for(int j=0; j<S.size(); j++) y+=v2[j]*v2[j];

    //cout<<x<<" "<<y<<endl;
    double res=sqrt(x)*sqrt(y);
    res=sum/res;
    cout<<res;

//    for(int i=0; i<S1.size(); i++) cout<<S1[i]<<endl;
//    cout<<0<<endl;
//    for(int i=0; i<S2.size(); i++) cout<<S2[i]<<endl;
//    cout<<0<<endl;
//    for(auto i: S) cout<<i<<endl;

    return 0;
}
