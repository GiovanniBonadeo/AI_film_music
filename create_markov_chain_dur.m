function transition_matrix_dur = create_markov_chain_dur(durations_data)

    % Definisci il BPM
    bpm = 120;
    
    % Definisci tutte le frazioni di battito possibili
    all_possible_durations = [-1, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1];
    num_durations = length(all_possible_durations);
    
    % Inizializza la matrice di transizione con una riga e una colonna aggiuntive per lo stato iniziale
    transition_matrix_dur = zeros(num_durations);

    % Itera su ciascun array di durate nella cella
    for k = 1:length(durations_data)
        rhythmic_pattern = get_rhythmic_pattern_from_durations(durations_data{k}, bpm);
        
        % Aggiungi stato iniziale (-1)
        sequence = [-1, rhythmic_pattern];
        
        % Processa le transizioni nella sequenza
        for j = 1:length(sequence) - 1
            current_duration = sequence(j);
            next_duration = sequence(j + 1);

            % Get indices from the state-to-index map
            current_duration_index = find(current_duration == all_possible_durations);
            next_duration_index = find(next_duration == all_possible_durations);

            transition_matrix_dur(current_duration_index, next_duration_index) = transition_matrix_dur(current_duration_index, next_duration_index) + 1;
        end
    end

    % Normalizza le probabilità di transizione per ogni stato
    for j = 1:size(transition_matrix_dur, 1)
        row_sum = sum(transition_matrix_dur(j, :)); 
        if row_sum > 0
            transition_matrix_dur(j, :) = transition_matrix_dur(j, :) / row_sum;
        else
            transition_matrix_dur(j, :) = 0;
        end
    end
end
