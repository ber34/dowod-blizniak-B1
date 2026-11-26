"""Certyfikat znaku: dokładne całkowite przedziały t=k^(-1/20),
Decimal z zaokrągleniem skierowanym dla dodatnich działań.
Uruchom: python certyfikat.py /ścieżka/ell.bin
Wynik jest warunkowy względem poprawności danych ell.bin (generator test.cpp).
"""
import sys, hashlib
from decimal import Decimal as D, localcontext, ROUND_FLOOR, ROUND_CEILING
from fractions import Fraction
import numpy as np
from pathlib import Path
N=100_000_000; a=3730; r=5120; A=a+20; S=10**30; SCALE=D('1e2619')
# wszystkie potęgi całkowite liczone przez mnożenia z zaokrągleniem skierowanym

def pw(x,n):
    z=D(1)
    while n:
        if n&1: z=z*x
        n//=2
        if n:x=x*x
    return z

def tbr(k):
    lo,hi=0,S+1; rhs=S**20
    while hi-lo>1:
        m=(lo+hi)//2
        if k*m**20<=rhs:lo=m
        else:hi=m
    return Fraction(lo,S), Fraction(min(S,lo+1),S)

def dec(f):return D(f.numerator)/D(f.denominator)

def val(tlo,thi,b,upper):
    with localcontext() as c:
        c.prec=75;c.rounding=ROUND_CEILING if upper else ROUND_FLOOR
        x=dec(thi if upper else tlo)
        y=dec(1-tlo if upper else 1-thi)
        return SCALE*pw(x,b)*pw(y,r)

def wbr(k):
    l,h=tbr(k)
    return val(l,h,A,False),val(l,h,A,True)

def peak():
    p=Fraction(A,A+r)
    return val(p,p,A,True)

path=Path(sys.argv[1] if len(sys.argv)>1 else 'ell.bin')
x=np.memmap(path,dtype=np.int8,mode='r');assert len(x)==N and x.min()>=-24 and x.max()<=24
assert np.all(x%2==0)
# g(t)=t^(a+20)(1-t)^r, rośnie do t*=A/(A+r), potem maleje.
# stąd minimum na końcach, maksimum na końcach albo w t*.
turn=Fraction(A+r,A)**20
upper=D(0);lower=D(0); early_upper=D(0);late_upper=D(0)
with localcontext() as c:
    c.prec=65;c.rounding=ROUND_CEILING
    for k in range(1,N+1,100_000):
        end=min(N,k+99_999); v=x[k-1:end]
        pos=int(v[v>0].sum(dtype=np.int64));neg=int(-v[v<0].sum(dtype=np.int64))
        l1,h1=wbr(k);l2,h2=wbr(end); l=min(l1,l2);h=max(h1,h2)
        if k<=turn<=end:h=max(h,peak())
        # neg*l: iloczyn dolny; minus jest wtedy ograniczeniem górnym
        with localcontext() as cl:
            cl.prec=65;cl.rounding=ROUND_FLOOR
            cost=D(neg)*l
        b=D(pos)*h-cost
        upper+=b
        if end<=10**7:early_upper+=b
        else:late_upper+=b
    tl,th=tbr(N)
    rate=Fraction(a)-r*th/(1-th);assert rate>0
    # 1/k P(k^-u) maleje dla k>=N; integral test, D=a-r*t_N/(1-t_N)
    # tail <= 24*20*P(t_N)/D, skalowany przez SCALE
    with localcontext() as cl:
        cl.prec=75;cl.rounding=ROUND_FLOOR
        rate_lo=dec(rate)
    tail=D(480)*val(tl,th,a,True)/rate_lo
    total=upper+tail
    print('sha256',hashlib.file_digest(path.open('rb'),'sha256').hexdigest())
    print('sum_ell',int(x.sum(dtype=np.int64)))
    print('scale',SCALE,'block_size',100000)
    print('early_upper',early_upper,'late_upper',late_upper)
    print('finite_upper',upper,'tail_upper',tail,'full_upper',total)
    assert total<0, 'brak certyfikatu znaku'
