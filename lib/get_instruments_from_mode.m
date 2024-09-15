function instrument_numbers = get_instruments_from_mode(mode)
    % This function returns an array of MIDI instrument numbers based on the given mode.
    % The output array is in the order: [melody, harmony, bass]

    % Define MIDI instrument numbers for each suggested instrument
    instruments = struct(...
        'Ionian', struct('Melody', 41, 'Harmony', 60, 'Bass', 33), ... % Strings, French Horn, Double Bass
        'Dorian', struct('Melody', 73, 'Harmony', 71, 'Bass', 34), ... % Flute, Clarinets, Electric Bass Guitar
        'Phrygian', struct('Melody', 1, 'Harmony', 47, 'Bass', 39), ... % Piano, Timpani, Tuba
        'Lydian', struct('Melody', 46, 'Harmony', 57, 'Bass', 43), ... % Harp, Brass Section, Synth Bass
        'Mixolydian', struct('Melody', 65, 'Harmony', 25, 'Bass', 44), ... % Saxophone, Guitar, Electric Upright Bass
        'Aeolian', struct('Melody', 40, 'Harmony', 43, 'Bass', 35), ... % Solo Violin, Cello, Acoustic Bass Guitar
        'Locrian', struct('Melody', 69, 'Harmony', 54, 'Bass', 32) ... % Oboe, Harmonium, Bassoon
    );

    % Check if the mode is valid
    if isfield(instruments, mode)
        % Return the MIDI instrument numbers for the given mode
        instrument_numbers = [instruments.(mode).Melody, instruments.(mode).Harmony, instruments.(mode).Bass];
    else
        error('Invalid mode. Please choose from: Ionian, Dorian, Phrygian, Lydian, Mixolydian, Aeolian, Locrian.');
    end
end
