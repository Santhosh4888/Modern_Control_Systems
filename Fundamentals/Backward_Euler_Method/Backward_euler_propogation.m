%% Defining the system Dynamics
function dx = Backward_euler_propogation(~,x)
    K1 = 0.1; % System constant
    K2 = 5;   % System constant
    dx = zeros(2,1);
    dx(1) = x(2);
    dx(2) = -K1*x(2) - K2*sin(x(1));
    if any(isnan(dx)) || any(isinf(dx))
        error('Dynamics returned NaN or Inf!');
    end
end


