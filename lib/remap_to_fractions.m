function mapped_array = remap_to_fractions(integer_array)
    % All possible states
    fractions = [-1, 1/64, 3/64, 1/32, 3/32, 1/16, 3/16, 1/8, 3/8, 1/4, 3/8, 1/2, 3/4, 1];

    % Initialize output
    mapped_array = zeros(size(integer_array));
    
    % Remap
    for i = 1:length(integer_array)
        
        mapped_array(i) = fractions(integer_array(i));
    end
end
