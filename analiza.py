import numpy as np, math, csv
from scipy.integrate import quad
from scipy.optimize import brentq
from pathlib import Path
p=Path(__file__).parent
x=np.memmap(p/'ell.bin',dtype=np.int8,mode='r'); N=len(x)
idx=np.flatnonzero(x); k=idx+1; logk=np.log(k); coeff=x[idx].astype(float)/k; late=k>10**7
rows=[]
def run(a,r,u,kind):
    # Scale integrand to avoid loss of accuracy for high degree.
    def logf(v):
        if v<=0: return -math.inf
        return -a*v+r*math.log(-math.expm1(-v))-3*math.log(v)
    if r>3:
        mode=brentq(lambda v: -a+r/math.expm1(v)-3/v,1e-8, min(100, r/a+10))
        peak=logf(mode)
    else: peak=0.
    def f(v): return math.exp(logf(v)-peak) if v>0 else (math.exp(-peak) if r==3 else 0.)
    J=quad(f,0,np.inf,epsabs=1e-11,limit=250)[0]
    logI=peak+math.log(J)
    v1=u*math.log(10**7); v2=u*math.log(N)
    m1=quad(f,0,v1,epsabs=1e-11)[0]/J; m2=quad(f,v1,v2,epsabs=1e-11)[0]/J; m3=quad(f,v2,np.inf,epsabs=1e-11)[0]/J
    v=u*logk; ker=np.exp(-a*v+r*np.log(-np.expm1(-v))-logI-2*math.log(u)) if k[0]>1 else np.exp(-a*v+r*np.log(np.maximum(-np.expm1(-v),1e-300))-logI-2*math.log(u))
    q=coeff*ker; early=q[~late].sum(); later=q[late].sum();
    row=[kind,a,r,u,math.exp(logI),early,later,early+later,m1,m2,m3, later/m2 if m2 else float('nan')]
    rows.append(row)
    print(kind,a,r,u, 'Z=',round(early+later,3),'late=',round(later,3),'mass=',[round(100*t,3) for t in (m1,m2,m3)],'late/mass',round(row[-1],3),flush=True)
for u in [.05,.1,.2]:
    for r in [3,4,6,8,10,12,16,20]: run(1,r,u,'Newton')
u=.05; v0=u*math.log(10**7.5)
for r in [10,20,40,80,160,320]:
    a=max(1,round(r/math.expm1(v0)-3/v0)); run(a,r,u,'localized')
with open(p/'wielomiany.csv','w') as f:
    w=csv.writer(f);w.writerow(['family','a','r','u','I','Z_early','Z_late','Z_truncated','model_mass_early','model_mass_late','model_mass_tail','Z_late_over_model_mass']);w.writerows(rows)
