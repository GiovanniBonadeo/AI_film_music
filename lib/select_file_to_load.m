function [grades_data, durations_data] = select_file_to_load(Mystery,Alignment, Wisdom)
    %Takes the values of the features, checks them and returns the rispective
    %models

    mel_file = sprintf('model%d%d%d_mel.mat', Mystery, Alignment, Wisdom);
    durations_file = sprintf('model%d%d%d_durations.mat', Mystery, Alignment, Wisdom);
    
    loaded_data = load(mel_file, 'grades_data');
    grades_data = loaded_data.grades_data;
    
    loaded_data = load(durations_file, 'durations_data');
    durations_data = loaded_data.durations_data;

end