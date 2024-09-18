function note_based_mel = choose_base_note(mel_seq, base_note)
%takes a sequence of midi pitches in C and remaps it on the base note
    
    note_based_mel = [];
    transp_value = 0;

    switch base_note
        case {'C', 'B#'}
            transp_value = 0;
        case {'C#', 'Db'}
            transp_value = 1;
        case {'D'}
            transp_value = 2;
        case {'D#', 'Eb'}
            transp_value = 3;
        case {'E', 'Fb'}
            transp_value = 4;
        case {'F', 'E#'}
            transp_value = 5;
        case {'F#', 'Gb'}
            transp_value = 6;
        case {'G'}
            transp_value = 7;
        case {'G#', 'Ab'}
            transp_value = 8;
        case {'A'}
            transp_value = 9;
        case {'A#', 'Bb'}
            transp_value = 10;
        case {'B', 'Cb'}
            transp_value = 11;
    end

    for i = 1:length(mel_seq)

        note_based_mel = [note_based_mel, mel_seq(i) + transp_value];
    end
end