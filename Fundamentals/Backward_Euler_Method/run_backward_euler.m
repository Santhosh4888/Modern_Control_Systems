clear;
clc;

% initail state
x0 = [2;0];

% discritization constant
h = 0.001;

% discrete-time simulation time
simulation_time = 0 : h : 1000*h; % [s]

% simulate the dynamics using Backward Euler method

[ts,stateTrajectoryOde45] = ode45(@Backward_euler_propogation,simulation_time,x0);
 
 
% simulate the dynamics by using the backward Euler method
stateTrajectoryBackwardEuler=SolveBackwardEuler(length(simulation_time),x0,h,@Backward_euler_propogation);
stateTrajectoryBackwardEuler=stateTrajectoryBackwardEuler';
 
error = zeros(1, length(simulation_time)); % Preallocate error array
for i=1:length(simulation_time)
   error(i)= norm(stateTrajectoryBackwardEuler(i,:)-stateTrajectoryOde45(i,:),2)/norm(stateTrajectoryOde45(i,:),2);
end

disp(length(simulation_time));
disp(size(stateTrajectoryBackwardEuler,1));

% plot the results
figure(1)
hold on
plot(error,'k');
figure(2)
plot(stateTrajectoryOde45(:,2),'k')
hold on 
plot(stateTrajectoryBackwardEuler(:,2),'m')


% plot the results
figure; 
N = min(length(simulation_time), size(stateTrajectoryBackwardEuler,1));
subplot(3,1,1);
plot(simulation_time(1:N), stateTrajectoryOde45(1:N,1), 'b', 'LineWidth', 1.5); hold on;
plot(simulation_time(1:N), stateTrajectoryBackwardEuler(1:N,1), 'r--', 'LineWidth', 1.5);
...
subplot(3,1,2);
plot(simulation_time(1:N), stateTrajectoryOde45(1:N,2), 'b', 'LineWidth', 1.5); hold on;
plot(simulation_time(1:N), stateTrajectoryBackwardEuler(1:N,2), 'r--', 'LineWidth', 1.5);
...
subplot(3,1,3);
plot(simulation_time(1:N), error(1:N), 'k', 'LineWidth', 1.5);
