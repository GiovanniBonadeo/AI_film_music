function [note_durations, tempo] = extract_note_durations(nmat)
    % function extracts the durations of the midi notes in nmat and returns
    % array of this durations, also returns the tempo of the nmat.
    tempo = gettempo(nmat);
    % extract timestamps
    note_durations = nmat(:, 7);
    
    % filter for negative values
    note_durations = note_durations(note_durations > 0);
end
