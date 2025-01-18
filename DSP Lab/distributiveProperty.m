% Function to perform linear convolution
function convolution_result = computeLinearConvolution(input_signal, impulse_response)
    signal_length = length(input_signal);
    response_length = length(impulse_response);
    output_length = signal_length + response_length - 1;

    % Initialize the output array with zeros
    convolution_result = zeros(1, output_length);

    % Perform convolution using nested loops
    for output_index = 1:output_length
        for signal_index = 1:signal_length
            response_index = output_index - signal_index + 1;
            if response_index > 0 && response_index <= response_length
                convolution_result(output_index) = convolution_result(output_index) + ...
                                                   input_signal(signal_index) * impulse_response(response_index);
            end
        end
    end
end

% Function to check the distributive property of linear convolution
function verifyDistributiveProperty(input_signal, impulse1, impulse2)
    % Make impulse1 and impulse2 the same length by zero-padding
    max_length = max(length(impulse1), length(impulse2));
    impulse1(length(impulse1) + 1:max_length) = 0;
    impulse2(length(impulse2) + 1:max_length) = 0;

    % Compute x * (h1 + h2)
    fprintf("Computing convolution: x * (h1 + h2)\n");
    combined_convolution = computeLinearConvolution(input_signal, impulse1 + impulse2);
    disp(combined_convolution);

    % Compute (x * h1) + (x * h2)
    fprintf("Computing convolution: (x * h1) + (x * h2)\n");
    convolution_h1 = computeLinearConvolution(input_signal, impulse1);
    convolution_h2 = computeLinearConvolution(input_signal, impulse2);
    separate_convolutions = convolution_h1 + convolution_h2;
    disp(separate_convolutions);

    % Verify if the two results are equal
    if isequal(combined_convolution, separate_convolutions)
        fprintf("Distributive property is proved.\n");
    else
        fprintf("Distributive property is not proved.\n");
    end
end

% Main script to get inputs and verify the distributive property
fprintf("Enter the values of the input signal (x): ");
input_signal = str2num(input('', 's')); %#ok<ST2NM>

fprintf("Enter the values of the first impulse response (h1): ");
impulse1 = str2num(input('', 's')); %#ok<ST2NM>

fprintf("Enter the values of the second impulse response (h2): ");
impulse2 = str2num(input('', 's')); %#ok<ST2NM>

% Check the distributive property of linear convolution
verifyDistributiveProperty(input_signal, impulse1, impulse2);
