function notes_sequence = get_note_from_pitch(pitch_only_nmat)
%takes a sequence (nmat) of midi pitches and converts to american notation

american_notes = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};
notes_sequence = cell(size(pitch_only_nmat));

    for i=1:length(pitch_only_nmat)
        pitch = pitch_only_nmat(i);
        octave = floor(pitch / 12) - 1;
        note_index = mod(pitch, 12) + 1;
        notes_sequence{i} = [american_notes{note_index} num2str(octave)];
    end
end