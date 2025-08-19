signal = randn(1, 1000);  % Replace this with your actual signal
Fs = 1000;  % Sampling frequency (example: 1000 Hz)

% Step 1: Compute FFT
Y = fft(out.simout.Data);

% Step 2: Compute Magnitude (Amplitude Spectrum)
magnitude = abs(Y);
magnitude(1) = [];
% Step 3: Find Maximum Amplitude
[maxAmplitude, indexOfMax] = max(magnitude);

% Display the maximum amplitude
fprintf('The maximum amplitude is: %.2f\n', maxAmplitude);

% Step 4: Find Corresponding Frequency
n = length(signal);  % Number of points in the signal
f = (1:n-1)*(Fs/n);  % Frequency axis

% Find the frequency corresponding to the maximum amplitude
maxFrequency = f(indexOfMax);

% Display the frequency corresponding to the maximum amplitude
fprintf('The frequency with the maximum amplitude is: %.2f Hz\n', maxFrequency);