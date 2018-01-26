clear all;
clc;
J=2.75e-6; % motor inertia
B=4e-3; % frictional constant for rotor
K=10; % torsional spring sensitivity constant
theta=0.02; % delay for tracking the response
R=5.35; % Resistance of armature winding
L=3.93e-3; % Leakage inductance of armature coil
K1=0.0316; % Voltage sensitivity constant wrt speed
K2=0.0316; % Torque sensitivity wrt armature current
s=tf('s');
G=zpk(exp(-theta*s)*K1/((J*s^2+B*s+K)*(L*s+R)+K1*K2*s));
% Taking Pade approximation of 1st order
G_app=zpk(((1-theta*s/2)/(1+theta*s/2))*K1/((J*s^2+B*s+K)*(L*s+R)+K1*K2*s));
Gm=K1/((J*s^2+B*s+K)*(L*s+R)+K1*K2*s);% Minimal phase system
% C=zpk(60e6*(s+790)^2*(s+1326)/(s*(s+1000)*(s+2000)))
C=zpk(60e6*inv(Gm)/(s*(s+1000)*(s+2000)));
%C=1;
optf=G*C;
optf_appx=C*G_app;
figure(1)
bode(optf_appx)
title('Approximate model OPTF')
figure(2)
bode(optf)
title('Original model OPTF')
cltf=feedback(optf,1) % Over all closed loop TF
cltf_approx=feedback(optf_appx,1) % Over all approx closed loop TF
figure(3)
step(cltf)
title('Step Response of CLTF')
hold on
step(cltf_approx)
title('Step Response of Approximate CLTF')
% disturbance tf for load. It should nill out very fast.
t_d = zpk(1/(J*s^2+B*s + K))
cltf_dist=t_d/(1+optf);
figure(5)
step(cltf_dist)
title('Step Response for diturbance rejection')
S=1/(1+optf);
figure(6)
bode(S)
title('Sensitivity bode plot')