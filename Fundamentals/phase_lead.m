% The bode plot of the open-loop system is given below.
W = tf(10,[1,1,0]);
figure(1)
bode(W)
grid on
Wfeedback = feedback(W,1);
figure(2)
step(Wfeedback)
grid on

%  formula to determine the parameter a
phiM =50 - 18;
phiMr = phiM*pi/180;
a= (1+sin(phiMr))/(1-sin(phiMr));

% finding corresponding frequency wc from the bode plot
wm = -10 * log10(a);
fprintf('The frequency wm is %f rad/s\n',wm);

%  The parameter T is then determined by
wc=4.15; % obtained from bode plot for corresponding wm
T=1/(sqrt(a)*wc);

% The lead compensator is then given by
Gc=tf([a*T 1],[T 1]);
Wcomp=Gc*W;
 
figure(3)
bode(Wcomp)
grid on
Wcomp_feedback = feedback(Wcomp,1);
figure(4)
step(Wcomp_feedback)    
grid on