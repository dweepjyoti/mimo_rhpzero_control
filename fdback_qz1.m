s = tf('s');
L = 10e-6;
C = 22e-6;
R = 10
Vb = 9
Gvd = zpk(Vb/(L*C*s^2+(L*s/R)+1))
Gvil = zpk(s*L/(L*C*s^2+(L*s/R)+1))
C =1000*(s+1000)*(s+10000)/(s*(s+10000000))
%C = 1*(s+10)*(s+7000)/(s*(s+100000))
figure(1)
optf = series(C,Gvd)
bode(optf)
cltf = feedback(optf,1)
figure(2)
step(cltf)
