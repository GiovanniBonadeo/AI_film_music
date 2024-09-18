function transition_matrix_dur = create_markov_chain_dur(durations_data)

    % define BPM
    bpm = 120;
    
    % all possible beat fractions
    all_possible_durations = [-1, 1/64, 3/64, 1/32, 3/32, 1/16, 3/16, 1/8, 3/8, 1/4, 3/8, 1/2, 3/4, 1];
    num_durations = length(all_possible_durations);
    
    % Initialize the transition matrix considering an extra row and column for
    % the initial state (-1)
    transition_matrix_dur = zeros(num_durations);

    for k = 1:length(durations_data)

        % Get beat franction based on bpm and duration
        rhythmic_pattern = get_rhythmic_pattern_from_durations(durations_data{k}, bpm);
        
        % Add initial state -1 to the sequence
        sequence = [-1, rhythmic_pattern];
        
        % Process transitions within the sequence
        for j = 1:length(sequence) - 1
            current_duration = sequence(j);
            next_duration = sequence(j + 1);

            % Get indices from the state-to-index map
            current_duration_index = find(current_duration == all_possible_durations);
            next_duration_index = find(next_duration == all_possible_durations);

            transition_matrix_dur(current_duration_index, next_duration_index) = transition_matrix_dur(current_duration_index, next_duration_index) + 1;
        end
    end

    % Normalize the transition probabilities for each state
    for j = 1:size(transition_matrix_dur, 1)
        row_sum = sum(transition_matrix_dur(j, :)); 
        if row_sum > 0
            transition_matrix_dur(j, :) = transition_matrix_dur(j, :) / row_sum;
        else
            transition_matrix_dur(j, :) = 0;
        end
    end
end
