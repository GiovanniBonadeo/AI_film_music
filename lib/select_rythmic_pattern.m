function [rythm_to_secs, time_signature] = select_rythmic_pattern(name_of_rythmic_pattern, bpm)
    % This function takes as input the name of the desired rythmic patten and
    % the bpm, outputs an array of floats wich are the single durations of the
    % notes

    % Calculate the duration of a quarter note in seconds
    quarter_note_duration = 60/bpm;

    % Define rhythmic patterns as fractions of the quarter note
    switch lower(name_of_rythmic_pattern)
        case 'tresillo'
            % Tresillo: [3/8, 3/8, 2/8]
            rythm_to_secs = [3/8, 3/8, 2/8] * quarter_note_duration * 4;
            time_signature = [4, 2, 24, 8];
        
        case 'gallop'
            % Gallop: [1/4, 1/8, 1/8]
            rythm_to_secs = [1/4, 1/8, 1/8] * quarter_note_duration * 4;
            time_signature = [4, 2, 24, 8];
        
        case 'habanera'
            % Habanera: [3/8, 1/8, 1/4, 1/4]
            rythm_to_secs = [3/8, 1/8, 1/4, 1/4] * quarter_note_duration * 4;
            time_signature = [4, 2, 24, 8];
        
        case 'standard'
            % Standard: [1/4, 1/4, 1/4, 1/4] (regular 4/4 rock rhythm)
            rythm_to_secs = [1/4, 1/4, 1/4, 1/4] * quarter_note_duration * 4;
            time_signature = [4, 2, 24, 8];
        
        case 'aksak'
            % Aksak: [2/8, 3/8, 2/8] (example for a 7/8 pattern)
            rythm_to_secs = [2/8, 3/8, 2/8] * quarter_note_duration * 4;
            time_signature = [9, 3, 24, 8];
        
        otherwise
            error('Unknown rhythmic pattern: %s', name_of_rythmic_pattern);
    end
end