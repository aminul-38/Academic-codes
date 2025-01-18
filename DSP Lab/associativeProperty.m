% Function to perform linear convolution
function convolution_result = computeLinearConvolution(input_signal, impulse_response)
    signal_length = length(input_signal);
    response_length = length(impulse_response);
    output_length = signal_length + response_length - 1;

    % Initialize the output signal with zeros
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

% Function to check associativity of linear convolution
function verifyConvolutionAssociativity(input_signal, impulse1, impulse2)
    % Compute (input_signal * impulse1) * impulse2
    fprintf("Computing custom convolution: (x * h1) * h2\n");
    convolution1 = computeLinearConvolution(computeLinearConvolution(input_signal, impulse1), impulse2);
    disp(convolution1);

    % Compute input_signal * (impulse1 * impulse2)
    fprintf("Computing custom convolution: x * (h1 * h2)\n");
    convolution2 = computeLinearConvolution(input_signal, computeLinearConvolution(impulse1, impulse2));
    disp(convolution2);

    % Verify if the results are equal
    if isequal(convolution1, convolution2)
        fprintf("Associativity is proved.\n");
    else
        fprintf("Associativity is not proved.\n");
    end
end

% Main script to get inputs and check associativity
fprintf("Enter the values of the input signal (x): ");
input_signal = str2num(input('', 's')); %#ok<ST2NM>

fprintf("Enter the values of the first impulse response (h1): ");
impulse1 = str2num(input('', 's')); %#ok<ST2NM>

fprintf("Enter the values of the second impulse response (h2): ");
impulse2 = str2num(input('', 's')); %#ok<ST2NM>

% Check associativity of the convolution operation
verifyConvolutionAssociativity(input_signal, impulse1, impulse2);
