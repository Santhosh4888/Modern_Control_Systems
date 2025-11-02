clear
%pack
clc

%% DC Motor Parameters
J = 0.1;
b = 0.5;
Kt = 1;
R = 5;
Ke = 1;
L = 1;

%% Define the state space matrices
A = [ 0 1 0; 0 -b/J Kt/J; 0 -Ke/L -R/L];
fprintf('Vector A:\n');
disp(A);
B = [0; 0; 1/L];
fprintf('Vector B:\n');
disp(B);
C = [0 1 0];
fprintf('Vector C:\n');
disp(C);
D = 0;
W = [0; -1/J; 0]; % Disturbance input matrix
fprintf('Vector W (disturbance input):\n');
disp(W);
% combine the control input and disturbance matrices in a single matrix
Btotal=[B W];
fprintf('Combined input matrix Btotal:\n');
disp(Btotal);

%% Create state space system
sys = ss(A,Btotal,C,D);
fprintf('State space system:\n');
disp(sys);

%% Discretize the system
dt = 0.01; % Sampling time
t_final = 5; % final simulation time
discretization_time = 0:dt:t_final;
sys_d = c2d(sys, dt);
fprintf('Discrete state space system:\n');
disp(sys_d);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% system response to the step control input 

%% control input
figure(1)
control_step = ones(size(discretization_time))';
plot(discretization_time,control_step,'LineWidth',2)
xlabel('Time')
ylabel('Control input (voltage)')
title('Control Input Used for Simulation')
 
%% Simulate the system response
disturbance = zeros(size(discretization_time))';
% control input and disturbance
U_step=[control_step, disturbance]; 
% simulate the system
Ycontrol_step=lsim(sys,U_step,discretization_time); %lsim function for simulation of state space systems
 
%% plot the system output 
figure(2)
plot(discretization_time,Ycontrol_step,'LineWidth',2)
xlabel('Time')
ylabel('System output (angular velocity)')
title('System response to the step control input')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% system response to the sinusoidal control input 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% control input
figure(3)
control_sin = sin(2*pi*0.5*discretization_time)';
plot(discretization_time,control_sin,'LineWidth',2)
xlabel('Time')
ylabel('Control input (voltage)')
title('Control Input Used for Simulation')

%% Simulate the system response
disturbance = zeros(size(discretization_time))'; % zero disturbance
% control input and disturbance
U_sin=[control_sin, disturbance]; % combine control input and disturbance
fprintf('Size of U_sin: %d rows, %d columns\n', size(U_sin, 1), size(U_sin, 2));
% simulate the system
Ycontrol_sin=lsim(sys,U_sin,discretization_time);

%% plot the system output 
figure(4)   
plot(discretization_time,Ycontrol_sin,'LineWidth',2)
xlabel('Time')
ylabel('System output (angular velocity)')
title('System response to the sinusoidal control input')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% system response to non zero inital conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 = [1; 1; 1]; % non-zero initial conditions
Yinitial = initial(sys,x0,discretization_time);
%% Plot the system output
figure(5)   
plot(discretization_time,Yinitial,'LineWidth',2)
xlabel('Time')  
ylabel('System output (angular velocity)')
title('System response to non-zero initial conditions')

