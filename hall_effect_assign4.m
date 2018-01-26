s =tf('s');
Ac = 59.4e-6
n2 = 2000
kh = 5
k = kh/(n2 * Ac);
lm = 0.3
r = 140;
g = (lm/r)*(s+k)
c = 100000/(s*(1+s/20000))
c1 = zpk(c+((c-1) * s/k))
optf = (lm/n2) * ((n2 * s) + ((kh/Ac) * c1)) * (1/r)
cltf = feedback(optf,1)
figure(1)
bode(g)
figure(2)
bode(optf)
figure(3)
step(cltf);
