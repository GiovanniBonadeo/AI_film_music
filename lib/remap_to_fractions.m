function mapped_array = remap_to_fractions(integer_array)
    % All possible states
    fractions = [-1, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1];
    num_fractions = length(fractions);

    % Initialize output
    mapped_array = zeros(size(integer_array));
    
    % Remap
    for i = 1:length(integer_array)
        
        mapped_array(i) = fractions(integer_array(i));
    end
end
