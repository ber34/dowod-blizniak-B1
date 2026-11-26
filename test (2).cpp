#include <bits/stdc++.h>
#include <omp.h>
using namespace std; using ll=long long;
const vector<int> ps={5,7,11,13,17,19,23,29};
struct Cell {long long cnt=0,plus=0,minus=0,zero=0,twin=0; long double w=0,sg=0;};
int main(){const ll B=5000000; vector<ll> As={10000000LL,100000000LL,1000000000LL,10000000000LL,100000000000LL,1000000000000LL}; int lim=sqrtl(6*(As.back()+B)+1);vector<bool> sieve(lim+1,true);sieve[0]=sieve[1]=false;vector<int> primes;for(int p=2;p<=lim;p++)if(sieve[p]){if(p>=5)primes.push_back(p);if((ll)p*p<=lim)for(int j=p*p;j<=lim;j+=p)sieve[j]=false;}
 cout<<"A,p,v,count,plus,minus,zero,twin,mass,sign\n"; cerr<<"A,r,weighted_sign5,weighted_mass5,weighted_sign0,weighted_mass0\n";
 for(ll A:As){vector<ll> rem(B);vector<int8_t> mu(B,1);vector<uint8_t> lprime(B,1),rprime(B,1);for(ll i=0;i<B;i++)rem[i]=6*(A+i)+1;ll maxn=6*(A+B-1)+1;for(int p:primes){if((ll)p*p>maxn)break;ll inv=(p%6==1?(5LL*p+1)/6:(p+1LL)/6); // 6*inv=1 mod p
 ll left=(inv-A%p+p)%p,right=(p-inv-A%p+p)%p;
 for(ll i=left;i<B;i+=p)lprime[i]=0;
 for(ll i=right;i<B;i+=p){rprime[i]=0;int e=0;while(rem[i]%p==0){rem[i]/=p;e++;}if(e>=2)mu[i]=0;else if(e==1)mu[i]=-mu[i];}
 }
 for(ll i=0;i<B;i++)if(rem[i]>1)mu[i]=-mu[i];
 vector<array<Cell,3>> tab(ps.size());array<long double,8> weights5{},sign5{},weights0{},sign0{};int rs[]={3,4,6,8,10,12,16,20};
 for(ll i=0;i<B;i++)if(lprime[i]){ll R=6*(A+i)+1;long double w=logl(R-2);for(size_t j=0;j<ps.size();j++){int p=ps[j],v=R%p?0:(R%((ll)p*p)?1:2);Cell &c=tab[j][v];int s=v==1?-mu[i]:mu[i];c.cnt++;c.plus+=s==1;c.minus+=s==-1;c.zero+=s==0;c.twin+=rprime[i];c.w+=w;c.sg+=w*s;}
 // nonnegative symmetric local beta/Newton kernels on exactly the measured interval; not global F.
 int v=R%5?0:(R%25?1:2);if(v!=2){long double x=(i+.5L)/B;long double base=4*x*(1-x);for(int j=0;j<8;j++){long double W=powl(base,rs[j])*w;if(v==1){weights5[j]+=W;sign5[j]-=W*mu[i];}else{weights0[j]+=W;sign0[j]+=W*mu[i];}}}
 }
 for(size_t j=0;j<ps.size();j++)for(int v=0;v<3;v++){auto c=tab[j][v];cout<<A<<','<<ps[j]<<','<<v<<','<<c.cnt<<','<<c.plus<<','<<c.minus<<','<<c.zero<<','<<c.twin<<','<<setprecision(17)<<c.w<<','<<c.sg<<'\n';}
 for(int j=0;j<8;j++)cerr<<A<<','<<rs[j]<<','<<setprecision(17)<<sign5[j]<<','<<weights5[j]<<','<<sign0[j]<<','<<weights0[j]<<'\n';
 }
}
