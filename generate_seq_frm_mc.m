function new_mel_seq = generate_seq_frm_mc(transition_matrix, len_seq)
%takes a transition matrix and the number of the states to generate

    if len_seq <= 0
            error('The length of the sequence must be a positive integer');
    end

    new_mel_seq = zeros(1, len_seq);
    
    % first row corresponds to the initial state
    current_state = 1; 

    for i = 1:len_seq
        
        current_probabilities = transition_matrix(current_state, :);
        next_state = randsample(1:length(current_probabilities), 1, true, current_probabilities);
        
        %scaling considering the initial state in the transition matrix
        new_mel_seq(i) = next_state-1;
        current_state = next_state;
    end
end