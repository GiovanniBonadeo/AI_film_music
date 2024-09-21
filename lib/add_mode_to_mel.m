function moded_mel = add_mode_to_mel(gen_mel_seq, mode, bass_clef)
% takes a sequence of grades  as an array and generates the moledy according
% to the specified mode

if nargin < 3
  bass_clef = 0;
end


 % Define the modes intervals (in semitones) starting from Ionian (C major)
    
    all_modes = struct( ...
        'Ionian', [0 2 4 5 7 9 11 12 14 16 17 19 21 23], ... % Ionian (C major)
        'Dorian', [0 2 3 5 7 9 10 12 14 15 17 19 21 22], ... % Dorian
        'Phrygian', [0 1 3 5 7 8 10 12 13 15 17 19 20 22], ... % Phrygian
        'Lydian', [0 2 4 6 7 9 11 12 14 16 18 19 21 23], ... % Lydian
        'Mixolydian', [0 2 4 5 7 9 10 12 14 16 17 19 21 22], ... % Mixolydian
        'Aeolian', [0 2 3 5 7 8 10 12 14 15 17 19 20 22], ... % Aeolian (natural minor)
        'Locrian', [0 1 3 5 6 8 10 12 13 15 17 18 20 22] ... % Locrian
    );

    if ~isfield(all_modes, mode)
        error('Invalid mode specified.');
    end

    mode_intervals = all_modes.(mode);

    moded_mel = [];

    c_midi = 60;

    if bass_clef == 1
        c_midi = 36;
    end

    for i = 1:length(gen_mel_seq)
     
        grade = gen_mel_seq(i);
        
        if grade < 1 || grade > 14
            error('Scale degree %d is out of valid range (1-14).', grade);
        end
        new_note = c_midi + mode_intervals(grade);
        moded_mel = [moded_mel, new_note];
    end

end