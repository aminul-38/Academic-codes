% Function to compute circular convolution
function circular_result = computeCircularConvolution(input_signal, impulse_response)
    % Determine the length for zero-padding to make signals of equal length
    signal_length = max(length(input_signal), length(impulse_response));

    % Zero-pad the signals to the same length
    input_signal = [input_signal, zeros(1, signal_length - length(input_signal))];
    impulse_response = [impulse_response, zeros(1, signal_length - length(impulse_response))];

    % Initialize the result array
    circular_result = zeros(1, signal_length);

    % Perform circular convolution
    for output_index = 1:signal_length
        for signal_index = 1:signal_length
            % Circular indexing using modulo operation
            circular_result(output_index) = circular_result(output_index) + ...
                                            input_signal(signal_index) * ...
                                            impulse_response(mod(output_index - signal_index, signal_length) + 1);
        end
    end
end

% Main script to compute and compare circular convolution
fprintf("Enter the values of the input signal (x): ");
input_signal = str2num(input('', 's')); %#ok<ST2NM>

fprintf("Enter the values of the impulse response (h): ");
impulse_response = str2num(input('', 's')); %#ok<ST2NM>

% Compute circular convolution manually
fprintf("Circular convolution of x and h (manual computation):\n");
manual_result = computeCircularConvolution(input_signal, impulse_response);
disp(manual_result);

% Compute circular convolution using MATLAB's built-in function
fprintf("Circular convolution of x and h (built-in function):\n");
builtin_result = cconv(input_signal, impulse_response, max(length(input_signal), length(impulse_response)));
disp(builtin_result);
