%% function that simulates the dynamics by using the backward Euler method
%
% - input parameters: 
%                   - time_steps    - discrete-time simulation time 
%                   - x0            - initial state
%                   - h             - discretization constant
%                   - fcnHandle     - function handle that describes the
%                   system dynamics
% - output parameters:
%                   - STATE         - state trajectory
function STATE = SolveBackwardEuler(time_steps, x0, h, fcnHandle)
    % Pre-allocate state trajectory matrix
    STATE = zeros(length(x0), time_steps+1);
    
    options_fsolve = optimoptions('fsolve','Algorithm', 'trust-region','Display','off','UseParallel',false,'FunctionTolerance',1.0000e-8,'MaxIter',10000,'StepTolerance', 1.0000e-8);

    problem.options = options_fsolve;
    problem.objective = @objective_function;
    problem.solver = 'fsolve';
       
    % Simulate dynamics using Backward Euler method
    for o=1:time_steps
        if o==1
           % the first entry of the STATE trajectory is the initial state
           STATE(:,o)=x0; 
           % generate the initial guess
           problem.x0 = STATE(:,o)+h*fcnHandle(0,STATE(:,o));  % use the Forward Euler method to generate the initial guess
           STATE(:,o+1)=fsolve(problem);
        else
           % generate the initial guess
           problem.x0 = STATE(:,o)+h*fcnHandle(0,STATE(:,o));  % use the Forward Euler method to generate the initial guess
           STATE(:,o+1)=fsolve(problem);
        end
    end

%% Objective function for fsolve
   function f=objective_function(z)
        f=z-STATE(:,o)-h*fcnHandle(0,z);
    end
end