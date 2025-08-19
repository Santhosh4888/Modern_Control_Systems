% Constants
clc
clear all
np = 2;                         
Rr = 1 + 038 * 10^-3; 
Rs = 1 + 300 * 10^-3; 
M = 0.30555;
Lr = 0.005974 + M ;         
Ls = 0.005974 + M;
sigma = (Ls *Lr - M^2)/(Lr); 
J = 0.02;              
Tl = 5;                
Vd = -20;               
Vq = 150;              


F = @(x)[(((3*np*M)/(2*J*Lr))*x(4)*x(2)) - (Tl/J); 
        ((-Rr/Lr) * x(2)) + (((Rr * M)/Lr) * x(3)); 
        (-(((M^2*Rr)/(sigma*Lr^2)) + (Rs/sigma)) * x(3)) + (((Rr * M)/(sigma * Lr^2)) * x(2)) + (np*x(1)*x(4)) + ((Rr * M * x(4)^2)/(Lr * x(2))) + (Vd/sigma); 
        (-(((M^2 * Rr)/(sigma * Lr^2)) + (Rs/sigma)) * x(4)) - (((M * np)/(sigma * Lr)) * x(1) * x(2)) - (np * x(1) * x(3)) - ((Rr * M * x(4) * x(3))/(Lr * x(2))) + ((Vq)/sigma)];

% Initial guesses  {rpm , flux , iq current , id current        
x0 = [      200   ,          1  ,         10 ,           5  ]; 

% Solver options
options = optimoptions('fsolve', 'Display', 'iter', 'MaxFunctionEvaluations', 5000000, 'MaxIter', 5000000, 'TolFun', 1e-4, 'TolX', 1e-4);

% Solving using fsolve
[x_sol, fval, exitflag] = fsolve(F, x0, options);

% Results
disp('Solution for steady-state variables:');
disp(['omega_r: ', num2str(x_sol(1))]);
disp(['psi: ', num2str(x_sol(2))]);
disp(['id: ', num2str(x_sol(3))]);
disp(['iq: ', num2str(x_sol(4))]);
