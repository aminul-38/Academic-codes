% Function to perform linear convolution
function convolution_result = performLinearConvolution(input_signal, impulse_response)
    % Get lengths of input signal and impulse response
    signal_length = length(input_signal);
    impulse_length = length(impulse_response);
    
    % Calculate the length of the output signal
    output_length = signal_length + impulse_length - 1;
    
    % Initialize the output signal with zeros
    convolution_result = zeros(1, output_length);
    
    % Perform convolution using nested loops
    for output_index = 1:output_length
        for signal_index = 1:signal_length
            impulse_index = output_index - signal_index + 1;
            if impulse_index > 0 && impulse_index <= impulse_length
                convolution_result(output_index) = convolution_result(output_index) + ...
                                                   input_signal(signal_index) * impulse_response(impulse_index);
            end
        end
    end
end

% Prompt the user for input signal and impulse response
fprintf("Enter the values of the input signal (x): ");
input_signal = str2num(input('', 's')); %#ok<ST2NM>

fprintf("Enter the values of the impulse response (h): ");
impulse_response = str2num(input('', 's')); %#ok<ST2NM>

% Calculate convolution using the custom function
fprintf("Convolution result using custom function:\n");
custom_convolution_result = performLinearConvolution(input_signal, impulse_response);
disp(custom_convolution_result);

% Calculate convolution using MATLAB's built-in function
fprintf("Convolution result using built-in function:\n");
builtin_convolution_result = conv(input_signal, impulse_response);
disp(builtin_convolution_result);

% Plotting
figure;

% Plot the input signal
subplot(3, 1, 1);
stem(input_signal, 'filled');
xticks(0:length(input_signal) + 1);
title("Input Signal X[n]");
xlabel("n");
ylabel("Amplitude");

% Plot the impulse response
subplot(3, 1, 2);
stem(impulse_response, 'filled');
xticks(0:length(impulse_response) + 1);
title("Impulse Response h[n]");
xlabel("n");
ylabel("Amplitude");

% Plot the convolution result
subplot(3, 1, 3);
stem(custom_convolution_result, 'filled');
xticks(0:length(custom_convolution_result) + 1);
title("Convolution Result Y[n]");
xlabel("n");
ylabel("Amplitude");
