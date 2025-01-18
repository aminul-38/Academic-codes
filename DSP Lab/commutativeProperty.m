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

% Function to check the commutative property of linear convolution
function verifyCommutativeProperty(input_signal, impulse_response)
    % Compute x * h
    fprintf("Computing convolution: x * h\n");
    convolution_xh = computeLinearConvolution(input_signal, impulse_response);
    disp(convolution_xh);

    % Compute h * x
    fprintf("Computing convolution: h * x\n");
    convolution_hx = computeLinearConvolution(impulse_response, input_signal);
    disp(convolution_hx);

    % Verify if the two results are equal
    if isequal(convolution_xh, convolution_hx)
        fprintf("Commutative property is proved.\n");
    else
        fprintf("Commutative property is not proved.\n");
    end
end

% Main script to get inputs and verify the commutative property
fprintf("Enter the values of the input signal (x): ");
input_signal = str2num(input('', 's')); %#ok<ST2NM>

fprintf("Enter the values of the impulse response (h): ");
impulse_response = str2num(input('', 's')); %#ok<ST2NM>

% Check the commutative property of linear convolution
verifyCommutativeProperty(input_signal, impulse_response);
