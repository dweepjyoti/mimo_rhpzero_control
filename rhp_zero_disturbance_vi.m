clear all
clc
s = tf('s');
R = 9
Rl = 0.2
%c = 47e-6
c = 9e-3
Rc = 0.5
L = 330e-6
Vo = 20
Vi = 15
d = 1 - (Vi/Vo)
Il = 2
k = (1-2*d)*Rc *c;
k1 = Vo * (1-d) - Il * Rl
k2 = (1-d)^2 + Rl/R
gn = (1+k*s) * (k1 - Il * L * s)
gd = c * s * (L * s + Rl) + (1+k * s) * (k2 +(L*s/R))
g = zpk(gn/gd)
a1 = (s*L + Rl);
a2 = (1-d);
a3 = 1-2*d;
a4 = 1+a3*Rc * c * s
dn = 1
dd = a1 * ((a2/a1)+ (((c*s/a4) + (L/R))/a2))
d = zpk(dn/dd)
l1 = (a2^2/a1) + (1/R)
ldn = -a4/(c*s)
ldd = 1+((l1 *a4)/(c*s))
ld = zpk(ldn/ldd)
cn = 1.1e4*(s+790.3)*(s+242.4)
cd = s*(s+444.4) * (s+2.212e4)
%con = zpk(cn/cd)
con = 1
optf = series(g,con)
figure(1)
bode(optf)
title('OPTF Bode')
cltf = feedback(optf,1)
t = 0:0.01:5
figure (2)
step(cltf)
title('Step Respons')
S=1/(1+optf)
figure(3)
bode(S)
title('Sensitivity Bode')
