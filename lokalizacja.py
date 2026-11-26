import numpy as np, math,csv
from scipy.integrate import quad
from pathlib import Path
p=Path(__file__).parent
x=np.memmap(p/'ell.bin',dtype=np.int8,mode='r'); N=len(x); idx=np.flatnonzero(x); k=idx+1; logk=np.log(k); coeff=x[idx].astype(float)/k; late=k>10**7
u=.05; v=u*logk; v0=u*math.log(10**7.5); v1=u*math.log(10**7); v2=u*math.log(N)
logone=np.log(np.maximum(-np.expm1(-v),1e-300)); rows=[]
for r in [320,640,1280,2560,5120]:
 a=max(1,round(r/math.expm1(v0)-3/v0))
 def l0(t):return -a*t+r*math.log(-math.expm1(-t))
 def l(t):return l0(t)-3*math.log(t)
 peak=l(v0); f=lambda t:math.exp(l(t)-peak) if t>0 else 0.
 # splitting at mode ensures narrow peak is captured
 J=quad(f,0,v0,epsabs=1e-13,limit=250)[0]+quad(f,v0,np.inf,epsabs=1e-13,limit=250)[0]
 logI=peak+math.log(J)
 m1=quad(f,0,v1,epsabs=1e-13,limit=250)[0]/J; m2=quad(f,v1,v0,epsabs=1e-13)[0]/J+quad(f,v0,v2,epsabs=1e-13)[0]/J; m3=quad(f,v2,np.inf,epsabs=1e-13)[0]/J
 ker=np.exp(-a*v+r*logone-logI-2*math.log(u)); q=coeff*ker; early=q[~late].sum(); later=q[late].sum()
 # explicit tail bound: log derivative w.r.t v of exp(-a*v)*(1-exp(-v))^r decreases; for v>=v2 <= -D
 D=a-r/math.expm1(v2); assert D>0
 tail=24*math.exp(l0(v2)-logI)/(u**3*D)
 row=[a,r,u,logI,early,later,early+later,m1,m2,m3,tail,early+later+tail]; rows.append(row)
 print(row,flush=True)
with open(p/'lokalizacja.csv','w') as f:
 w=csv.writer(f);w.writerow(['a','r','u','logI','Z_early','Z_late','Z_truncated','model_mass_early','model_mass_late','model_mass_tail','absolute_tail_bound','Z_upper']);w.writerows(rows)
