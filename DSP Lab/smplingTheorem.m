% Sampling Theorem Verification
% Summing two continuous waves, sampling, and reconstructing

% Define the sinc function
function sinc_value = custom_sinc(x)
    sinc_value = sin(pi * x) ./ (pi * x);  % Sinc function formula
    sinc_value(x == 0) = 1;  % Handle the case when x == 0
end

% Define a cosine signal generator
function signal_values = generate_signal(amplitude, frequency, time_vector)
    signal_values = amplitude * cos(2 * pi * frequency * time_vector);
end

% Input parameters for two signals
signal1_frequency = input('Frequency for Signal 1 (Hz): ');
signal1_amplitude = input('Amplitude for Signal 1: ');
signal2_frequency = input('Frequency for Signal 2 (Hz): ');
signal2_amplitude = input('Amplitude for Signal 2: ');

num_periods = 20; % Number of periods to display in the graph

% Calculate time periods for both signals
signal1_period = 1 / signal1_frequency;
signal2_period = 1 / signal2_frequency;

% Define the time vector with sufficient resolution
time_resolution = 1 / (100 * max(signal1_frequency, signal2_frequency));
time_vector = 0:time_resolution:num_periods * max(signal1_period, signal2_period);

% Plot the original continuous signals
figure;

% Plot Signal 1
subplot(2, 1, 1);
signal1 = generate_signal(signal1_amplitude, signal1_frequency, time_vector);
plot(time_vector, signal1, 'LineWidth', 1);
title('Signal 1');
xlabel(sprintf('Time (s), F = %f Hz, T = %f s', signal1_frequency, signal1_period));
ylabel(sprintf('Amplitude, A = %f', signal1_amplitude));
grid on;

% Plot Signal 2
subplot(2, 1, 2);
signal2 = generate_signal(signal2_amplitude, signal2_frequency, time_vector);
plot(time_vector, signal2, 'LineWidth', 1);
title('Signal 2');
xlabel(sprintf('Time (s), F = %f Hz, T = %f s', signal2_frequency, signal2_period));
ylabel(sprintf('Amplitude, A = %f', signal2_amplitude));
grid on;

% Summation of both signals
combined_signal = signal1 + signal2;

% Calculate Nyquist rate and sampling parameters
max_frequency = max(signal1_frequency, signal2_frequency);
nyquist_frequency = 2 * max_frequency; % Nyquist rate
sampling_interval = 1 / nyquist_frequency;
sampling_times = 0:sampling_interval:num_periods * max(signal1_period, signal2_period);

% Sample the combined signal
sampled_signal = generate_signal(signal1_amplitude, signal1_frequency, sampling_times) + ...
                 generate_signal(signal2_amplitude, signal2_frequency, sampling_times);

% Plot the combined and sampled signals
figure;

% Plot combined signal
subplot(3, 1, 1);
plot(time_vector, combined_signal, 'LineWidth', 1);
title('Summation of Signals');
xlabel(sprintf('Time (s), Max Frequency = %f Hz', max_frequency));
ylabel('Amplitude');
grid on;

% Plot sampled signal and overlay the original combined signal
subplot(3, 1, 2);
stem(sampling_times, sampled_signal, 'r.');
hold on;
plot(time_vector, combined_signal, 'b--', 'LineWidth', 0.5);
title('Sampling of Combined Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Sampled Signal', 'Original Signal');
grid on;

% Plot only the sampled signal
subplot(3, 1, 3);
stem(sampling_times, sampled_signal, 'LineWidth', 1);
title('Sampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Frequency domain representation
frequency_domain = abs(fft(sampled_signal));

figure;

% Plot frequency components
subplot(2, 1, 1);
plot(sampling_times, frequency_domain, 'LineWidth', 2);
title('Frequency Domain Representation');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;

% Reconstruction using sinc interpolation
reconstruction_time = time_vector;
reconstructed_signal = zeros(size(reconstruction_time));

for i = 1:length(reconstruction_time)
    for j = 1:length(sampling_times)
        reconstructed_signal(i) = reconstructed_signal(i) + ...
                                  sampled_signal(j) * custom_sinc((reconstruction_time(i) - sampling_times(j)) / sampling_interval);
    end
end

% Plot reconstructed signal
subplot(2, 1, 2);
plot(reconstruction_time, reconstructed_signal, 'r-', 'LineWidth', 1.5);
hold on;
plot(time_vector, combined_signal, 'b--', 'LineWidth', 0.5);
title('Reconstructed Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Reconstructed', 'Original');
grid on;
