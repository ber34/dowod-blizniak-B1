#include <bits/stdc++.h>
#include <omp.h>
using namespace std; using ll=long long;
const int H[]={11,13,17,19,29,31}; int lut[64][64];
int main(int argc,char**argv){
 ll N=stoll(argv[1]); int bound=sqrtl(30*N+31)+1; vector<int> ps; vector<bool>b(bound+1,true); for(int p=2;p<=bound;p++)if(b[p]){if(p>5)ps.push_back(p);if(1LL*p*p<=bound)for(int j=p*p;j<=bound;j+=p)b[j]=false;}
 vector<array<int,6>> res; for(int p:ps){int iv=0;for(int t=1;t<=30;t++)if((1LL*t*p+1)%30==0){iv=(1LL*t*p+1)/30;break;} assert(30LL*iv%p==1);array<int,6> r;for(int j=0;j<6;j++)r[j]=(p-1LL*H[j]*iv%p)%p;res.push_back(r);}
 for(int r=0;r<64;r++)for(int p=0;p<64;p++)for(int i=0;i<6;i+=2)for(int j=0;j<6;j++)if(j/2!=i/2){int m=(3<<i)|(1<<j);if((r&m)==m)lut[r][p]+=2-2*((p>>i)&1)-2*((p>>(i+1))&1);}
 FILE *f=fopen(argv[2],"wb");if(!f)return 1; const int CH=1000000; int chunks=(N+CH-1)/CH; vector<ll> totals(chunks); vector<array<ll,3>> sign(chunks);
 #pragma omp parallel for schedule(dynamic) ordered num_threads(4)
 for(int c=0;c<chunks;c++) {ll start=1+1LL*c*CH;int len=min<ll>(CH,N-start+1);vector<unsigned char> r(len,63),m(len,63);vector<signed char> out(len);
 for(size_t t=0;t<ps.size();t++){ll p=ps[t];if(p*p>30*(start+len-1)+31)break;ll p3=p*p*p;ll lowr=max(start,(p3-31+29)/30);for(int j=0;j<6;j++){ll low=max(start,(p*p-H[j]+29)/30);int idx=(res[t][j]-low%p+p)%p;for(ll k=low+idx;k<start+len;k+=p)m[k-start]&=~(1<<j);if(lowr<start+len){idx=(res[t][j]-lowr%p+p)%p;for(ll k=lowr+idx;k<start+len;k+=p)r[k-start]&=~(1<<j);}}}
 ll tot=0;array<ll,3> s{};for(int i=0;i<len;i++){int val=lut[r[i]][m[i]];out[i]=val;tot+=val;s[(val>0)-(val<0)+1]++;assert(val>=-24&&val<=24);}totals[c]=tot;sign[c]=s;
 #pragma omp ordered
 {fwrite(out.data(),1,len,f);}
 } fclose(f); cerr<<"N="<<N<<" L="<<accumulate(totals.begin(),totals.end(),0LL)<<"\n";for(int c=0;c<chunks;c++)cerr<<1+1LL*c*CH<<","<<totals[c]<<","<<sign[c][0]<<","<<sign[c][1]<<","<<sign[c][2]<<"\n";
}
