function instrument_numbers = get_instruments_from_mode(mode)
    % This function returns an array of MIDI instrument numbers based on the given mode.
    % The output array is in the order: [melody, harmony, bass]

    % Define MIDI instrument numbers for each mode
    instruments = struct(... 
        'Ionian', struct('Melody', 1, 'Harmony', 48, 'Bass', 43), ... % Piano, String Enseble, Double Bass
        'Dorian', struct('Melody', 69, 'Harmony', 24, 'Bass', 43), ... % English Horn, Guitar (Nylon), Contrabass
        'Phrygian', struct('Melody', 1, 'Harmony', 46, 'Bass', 72), ... % Piano, Bass (Voices), Bass Clarinet
        'Lydian', struct('Melody', 72, 'Harmony', 8, 'Bass', 47), ... % Piccolo, Celesta, Timpani
        'Mixolydian', struct('Melody', 57, 'Harmony', 61, 'Bass', 58), ... % Trumpet, Brass Ensemble, Tuba
        'Aeolian', struct('Melody', 42, 'Harmony', 48, 'Bass', 57), ... % Solo Cello, String Enseble, Bass Trombone
        'Locrian', struct('Melody', 73, 'Harmony', 19, 'Bass', 38) ... % Bass Flute, Organ, Synth Bass
    );

    % Check if the mode is valid
    if isfield(instruments, mode)
        % Return the MIDI instrument numbers for the given mode
        instrument_numbers = [instruments.(mode).Melody, instruments.(mode).Harmony, instruments.(mode).Bass];
    else
        error('Invalid mode. Please choose from: Ionian, Dorian, Phrygian, Lydian, Mixolydian, Aeolian, Locrian.');
    end
end
