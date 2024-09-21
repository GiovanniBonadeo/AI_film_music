function [transition_matrix_mel, transition_matrix_dur] = select_file_to_load(Mystery, Alignment, Wisdom)
    % Takes the values of the features, checks them, and returns the respective models

    mel_file = sprintf('model%d%d%d_mel.mat', Mystery, Alignment, Wisdom);
    durations_file = sprintf('model%d%d%d_durations.mat', Mystery, Alignment, Wisdom);
    
    % Check if the files exist
    if ~exist(mel_file, 'file')
        error('File %s not found.', mel_file);
    end
    if ~exist(durations_file, 'file')
        error('File %s not found.', durations_file);
    end
    
    % Load mel transition matrix
    loaded_data = load(mel_file);
    if isfield(loaded_data, 'transition_matrix_mel')
        transition_matrix_mel = loaded_data.transition_matrix_mel;
    else
        error('Variable transition_matrix_mel not found in file %s.', mel_file);
    end
    
    % Load duration transition matrix
    loaded_data = load(durations_file);
    if isfield(loaded_data, 'transition_matrix_dur')
        transition_matrix_dur = loaded_data.transition_matrix_dur;
    else
        error('Variable transition_matrix_dur not found in file %s.', durations_file);
    end
end
