
clc
% Assigning x_sol the steady-state values
omega_r_ss = x_sol(1);
psi_ss = x_sol(2);
id_ss = x_sol(3);
iq_ss = x_sol(4);

% Define symbolic variables for linearization
syms omega_r psi id iq Vd Vq 

f1 = (((3*np*M)/(2*J*Lr))*psi*iq) - (Tl/J); 
f2 = ((-Rr/Lr) * psi) + (((Rr * M)/Lr) * id); 
f3 = (-(((M^2*Rr)/(sigma*Lr^2)) + (Rs/sigma)) * id) + (((Rr * M)/(sigma * Lr^2)) * psi) + (np*omega_r*iq) + ((Rr * M * iq^2)/(Lr * psi)) + (Vd/sigma); 
f4 = (-(((M^2 * Rr)/(sigma * Lr^2)) + (Rs/sigma)) * iq) - (((M * np)/(sigma * Lr)) * omega_r * psi) - (np * omega_r * id) - ((Rr * M * iq * id)/(Lr * psi)) + ((Vq)/sigma);

% Jacobians
A = jacobian([f1, f2, f3, f4], [omega_r, psi, id, iq]);
B = jacobian([f1, f2, f3, f4], [Vd, Vq]);

% Evaluating the Jacobians at the steady-state values
A_lin = double(subs(A, [omega_r, psi, id, iq], [omega_r_ss, psi_ss, id_ss, iq_ss]));
B_lin = double(subs(B, [omega_r, psi, id, iq], [omega_r_ss, psi_ss, id_ss, iq_ss]));

% Output matrix 
C_lin = [1 0 0 0; 0 1 0 0];  % First row for omega_r, second for psi

% Direct transmission matrix 
D_lin = zeros(2,2);

sys_lin = ss(A_lin, B_lin, C_lin, D_lin);
tf_sys = tf(sys_lin);

% Extract individual transfer functions
G11 = tf_sys(1,1);  % Transfer function from Vd to omega_r
G12 = tf_sys(1,2);  % Transfer function from Vq to omega_r
G21 = tf_sys(2,1);  % Transfer function from Vd to psi
G22 = tf_sys(2,2);  % Transfer function from Vq to psi

% Display individual transfer functions
disp('Transfer function G11 (Vd to omega_r):');
G11;

disp('Transfer function G12 (Vq to omega_r):');
G12;

disp('Transfer function G21 (Vd to psi):');
G21;

disp('Transfer function G22 (Vq to psi):');
G22;

% Required Plant Transfer Functions :

Vq_omega = G12
Vd_psi = G21


% Root locus for Vq to omega_r (G12)
figure;
rlocus(Vq_omega);
title('Root Locus for Vq to omega_r (G12)');

% Root locus for Vd to psi (G21)
figure;
rlocus(Vd_psi);
title('Root Locus for Vd to psi (G21)');