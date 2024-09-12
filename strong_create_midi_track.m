function M = strong_create_midi_track(pitches, durations, n_bars, harmonic_succ, base_note, tempo)
    % Creates a MIDI track matrix using pitches and durations as input
    % Adds harmonic chords at the beginning of each bar based on harmonic_succ
    
    n_pitches = length(pitches);

    % durations adapted to requested notes
    while n_pitches > length(durations)
        durations = [durations, durations];
    end

    % harmonic succession adapted to requested bars
    while n_bars > length(harmonic_succ)
        harmonic_succ = [harmonic_succ, harmonic_succ];
    end

    % Preallocate M matrix for notes and chords
    total_notes = n_pitches * n_bars + length(harmonic_succ) * 3; % Estimate the total number of events
    M = zeros(total_notes, 6); % MIDI matrix, 6 columns as required by matrix2midi
    onset_time = 0;
    note_idx = 1;

    for bar = 1:n_bars
        % Get the chord notes for the current bar
        chord = harmonic_succ(bar);
        chord_notes = get_chord_notes(chord, base_note);
        
        % Chord notes at the start of the bar
        for j = 1:length(chord_notes)
            M(note_idx, 1) = 1; % Track (default to 1)
            M(note_idx, 2) = 1; % Channel (default to 1)
            M(note_idx, 3) = chord_notes(j); % MIDI Pitch for chord note
            M(note_idx, 4) = 100; % Velocity (default to 100)
            M(note_idx, 5) = onset_time; % Onset time (in seconds)
            M(note_idx, 6) = onset_time + durations(1); % Offset time (in seconds)
            note_idx = note_idx + 1;  % Move to the next position in the matrix
        end

        % Melodic notes for the bar
        for i = 1:n_pitches
            M(note_idx, 1) = 1; % Track (default to 1)
            M(note_idx, 2) = 1; % Channel (default to 1)
            M(note_idx, 3) = pitches(i); % MIDI Pitch
            M(note_idx, 4) = 100; % Velocity (default to 100)
            M(note_idx, 5) = onset_time; % Onset time (in seconds)
            M(note_idx, 6) = onset_time + durations(i); % Offset time (in seconds)

            % Update onset_time for the next note
            onset_time = onset_time + durations(i);
            note_idx = note_idx + 1;  % Move to the next position in the matrix
        end
    end 
    
    % Remove any unused preallocated rows
    M = M(1:note_idx-1, :);
end
