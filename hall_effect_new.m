s =tf('s');
Ac = 59.4e-6;
n2 = 2000;
kh = 5;
k = kh/(n2 * Ac);
lm = 0.3;
r = 140;
k2 = n2*Ac/kh;
k1 = kh * lm/(n2*Ac*r);
Gc = (3e6*(s+1))/(s*(s+20000));
optf = (1+s*k2)*(k1/(1+s*k1*k2))*Gc;
Gc_actual=(Gc+s*k2*(Gc-1))/(s)
optf_new=(Gc_actual+s*k2)*(k1/(1+s*k1*k2));
figure(1)
bode(optf)

cltf=feedback(optf,1);
cltf_new=feedback(optf_new,1);
figure(2)
step(cltf)

figure(3)
bode(optf_new)
figure(4)
step(cltf_new)
