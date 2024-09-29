function harmonic_succ = get_harmonic_succ(mode)
    % Takes as input the mode and returns an array of
    % the chords to use, assuming C as the base note
    
    harmonic_succ = strings(1, 4);

    % Define roman numeral chord progressions for each mode
    switch mode
        case 'Ionian'
            roman_succ = {'I', 'iv', 'V', 'I', 'iii', 'ii', 'V'};
        case 'Dorian'
            roman_succ = {'i', 'IV', 'v', 'i'};
        case 'Phrygian'
            roman_succ = {'i', 'IIb', 'v', 'i'};
        case 'Lydian'
            roman_succ = {'I', 'II', 'V', 'I'};
        case 'Mixolydian'
            roman_succ = {'I', 'VII', 'v', 'IV'};
        case 'Aeolian'
            roman_succ = {'i', 'iv', 'v', 'i'};
        case 'Locrian'
            roman_succ = {'idim', 'IIb', 'v', 'idim'};
        otherwise
            error('Mode not recognized');
    end

    % Dictionary mapping Roman numerals to chords
    roman_to_chord_map = containers.Map( ...
        {'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', ...            % Major chords
         'i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', ...            % Minor chords
         'idim', 'iidim', 'iiidim', 'ivdim', 'vdim', 'vidim', 'viidim', ... % Diminished chords
         'bII', 'bIII', 'bVI', 'bVII', ...                        % Flat chords
         'I#', 'II#', 'III#', 'IV#', 'V#', 'VI#', 'VII#', ...     % Sharp chords
         'Ib', 'IIb', 'IIIb', 'IVb', 'Vb', 'VIb', 'VIIb', ...     % Flat major chords
         'i#', 'ii#', 'iii#', 'iv#', 'v#', 'vi#', 'vii#', ...     % Sharp minor chords
         'ib', 'iib', 'iiib', 'ivb', 'vb', 'vib', 'viib', ...     % Flat minor chords
         'idim#', 'iidim#', 'iiidim#', 'ivdim#', 'vdim#', 'vidim#', 'viidim#', ... % Diminished sharp chords
         'idimb', 'iidimb', 'iiidimb', 'ivdimb', 'vdimb', 'vidimb', 'viidimb'}, ... % Diminished flat chords
        {'C', 'D', 'E', 'F', 'G', 'A', 'B', ...                   % Major chords
         'Cm', 'Dm', 'Em', 'Fm', 'Gm', 'Am', 'Bm', ...            % Minor chords
         'Cdim', 'Ddim', 'Edim', 'Fdim', 'Gdim', 'Adim', 'Bdim', ... % Diminished chords
         'Db', 'Eb', 'Ab', 'Bb', ...                              % Flat chords
         'C#', 'D#', 'E#', 'F#', 'G#', 'A#', 'B#', ...            % Sharp chords
         'Cb', 'Db', 'Eb', 'Fb', 'Gb', 'Ab', 'Bb', ...            % Flat major chords
         'C#m', 'D#m', 'E#m', 'F#m', 'G#m', 'A#m', 'B#m', ...     % Sharp minor chords
         'Cmb', 'Dmb', 'Emb', 'Fmb', 'Gmb', 'Amb', 'Bmb', ...     % Flat minor chords
         'Cdim#', 'Ddim#', 'Edim#', 'Fdim#', 'Gdim#', 'Adim#', 'Bdim#', ... % Diminished sharp chords
         'Cdimb', 'Ddimb', 'Edimb', 'Fdimb', 'Gdimb', 'Adimb', 'Bdimb'});  % Diminished flat chords

    % Map Roman numerals to chords using the dictionary
    for i = 1:length(roman_succ)
        harmonic_succ(i) = roman_to_chord_map(roman_succ{i});
    end
end
