function transition_matrix = create_markov_chain_mel(grades_data)

    % takes one or more sequences of intervals and creates the transition
    % matrix
    
    all_possible_states = [-1 1 2 3 4 5 6 7 8 9 10 11 13 14];
    num_states = length(all_possible_states);

    % Initialize the transition matrix considering an extra row and column for
    % the initial state (-1)
    transition_matrix = zeros(num_states);

    for i = 1:length(grades_data)

        % Add initial state -1 to the sequence
        sequence = [-1, grades_data{i}];

        %disp(sequence)
        
        % Process transitions within the sequence
        for j = 1:length(sequence) - 1
            current_state = sequence(j);
            next_state = sequence(j + 1);
            
            % Get indices from the state-to-index map
            current_state_index = find(current_state == all_possible_states);
            next_state_index = find(next_state == all_possible_states);

            transition_matrix(current_state_index, next_state_index) = transition_matrix(current_state_index, next_state_index) + 1;
        end
        sequence = [];
    end

    % Normalize the transition probabilities for each state
    for j = 1:size(transition_matrix, 1)
        row_sum = sum(transition_matrix(j, :)); 
        if row_sum > 0
            transition_matrix(j, :) = transition_matrix(j, :) / row_sum;
        else
            transition_matrix(j, :) = 0;
        end
    end
end