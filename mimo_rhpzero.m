clear all;
clc;
s=tf('s')
G_actual=zpk([(s-1)/(s+2) 4/(s+2); 4.5/(s+2) 2*(s-1)/(s+2)])
G=zpk([(s+1)/(s+2) 4/(s+2); 4.5/(s+2) 2*(s+1)/(s+2)])
% sys=ss(A,B,C,[0 0;0 0])
% G=zpk(tf(sys))
G_inv=inv(G)
v11=G_actual(1,1)*G_inv(1,1)
v12=G_actual(1,2)*G_inv(2,1)
v21=G_actual(2,1)*G_inv(1,2)
v22=G_actual(2,2)*G_inv(2,2)


%--------------------------
% Inverse 0 based contrller (working but rhp zero of overall system is not reserved)
% C11=2*(s+2)/(s*(s+1));
% C22=1*(s+2)/(s*(s+1));
% G_inv0=[1/4 2/4;2.25/4 0.5/4];
% k=[C11 0; 0 C22]*G_inv0;

%----------------------------

%C11=1;
%C22=1;
%----------------------------

% Inverse based contrller on s=1(working but settling at higher value)
% G2= [0 4/3; 4.5/3 0]
% G2_inv=inv(G2)
% 
% GP=G_actual*G2_inv;
% C11=1/(s);
% C22=1/(s);
% k=[C11 0; 0 C22]*G2_inv;

%----------------------------


% Inverse based contrller on s=1(working but settling at higher value)
G2=[1/4 1/2; 4.5/4 1/2] % [0 4/3; 4.5/3 0]
G2_inv=inv(G2)

GP=G_actual*G2_inv;
C11=1*(s+2)/(s*(s+4));
C22=1*(s+2)/(s*(s+4));
k=[C11 0; 0 C22]*G2_inv;

%----------------------------

% Inverse based contrller on s=2(not working)

% G2= [1/4 1/2; 4.5/4 1/2]
% G2_inv=inv(G2)
% 
% GP=G_actual*G2_inv;
% C11=2/(s);
% C22=2/(s);
% k=[C11 0; 0 C22]*G2_inv;

G_GC=G_actual*k

M=inv([eye(2)]+G_GC)*G_GC;
figure(1)
step(M(1,1))
figure(2)
step(M(1,2))
figure(3)
step(M(2,1))
figure(4)
step(M(2,2))

figure(5)
step(M(1,1)+M(1,2))
figure(6)
step(M(1,2)+M(2,2))