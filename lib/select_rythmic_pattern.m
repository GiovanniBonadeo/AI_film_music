function [rythm, time_signature] = select_rythmic_pattern(name_of_rythmic_pattern)
    % This function takes as input the name of the desired rythmic patten and
    % the bpm, outputs an array of floats wich are the single durations of the
    % notes

    % Define rhythmic patterns as fractions of the quarter note
    switch lower(name_of_rythmic_pattern)
        case 'tresillo'
            % Tresillo: [3/8, 3/8, 2/8]
            rythm = [3/8, 3/8, 2/8] * 4;
            time_signature = [4, 2, 24, 8];
        
        case 'gallop'
            % Gallop: [1/8, 1/16, 1/16]
            rythm = [1/8, 1/16, 1/16, 1/8, 1/16, 1/16, 1/8, 1/16, 1/16, 1/8, 1/16, 1/16];
            time_signature = [4, 2, 24, 8] * 4;
        
        case 'habanera'
            % Habanera: [3/8, 1/8, 1/4, 1/4]
            rythm = [3/16, 1/16, 1/8, 1/8] * 4;
            time_signature = [2, 2, 24, 8];
        
        case 'standard'
            % Standard: [1/4, 1/4, 1/4, 1/4] (regular 4/4 rock rhythm)
            rythm = [1/4, 1/4, 1/4, 1/4] * 4;
            time_signature = [4, 2, 24, 8];
      
        otherwise
            error('Unknown rhythmic pattern: %s', name_of_rythmic_pattern);
    end
end