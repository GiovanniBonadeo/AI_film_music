function nmat_track = create_midi_track(pitches, durations, n_bars, harmonic_succ, base_note, tempo)
    % Creates a MIDI track using pitches and duration per each pitch as input
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

    % Preallocate nmat_track (considering both notes and chords)
    nmat_track = zeros((n_pitches + 3) * n_bars, 7); % Adjust size as needed
    onset_time = 0;
    note_idx = 1;

    for bar = 1:n_bars
        % Get the chord notes for the current bar
        chord = harmonic_succ(bar);
        chord_notes = get_chord_notes(chord, base_note);
        
        % Chord notes at the start of the bar
        for j = 1:length(chord_notes)
            nmat_track(note_idx, 1) = onset_time; % Onset (seconds)
            nmat_track(note_idx, 2) = durations(1); % Duration (same as the first note)
            nmat_track(note_idx, 3) = 1; % Channel (default to 1)
            nmat_track(note_idx, 4) = chord_notes(j); % MIDI Pitch for chord note
            nmat_track(note_idx, 5) = 100; % Velocity
            
            % Convert onset_time and duration to beats
            onset_in_beats = (onset_time / 60) * tempo;
            duration_in_beats = (durations(1) / 60) * tempo;

            % Fill column 6 and 7 with beats values
            nmat_track(note_idx, 6) = onset_in_beats; % Onset in beats
            nmat_track(note_idx, 7) = onset_in_beats + duration_in_beats; % Note-off in beats
            
            note_idx = note_idx + 1;  % Move to the next position in nmat_track
        end

        % Melodic notes for the bar
        for i = 1:n_pitches
            nmat_track(note_idx, 1) = onset_time; % Onset (seconds)
            nmat_track(note_idx, 2) = durations(i); % Duration (seconds)
            nmat_track(note_idx, 3) = 1; % Channel (default to 1)
            nmat_track(note_idx, 4) = pitches(i); % MIDI Pitch
            nmat_track(note_idx, 5) = 100; % Velocity 
            
            % Convert onset_time and duration to beats
            onset_in_beats = (onset_time / 60) * tempo;
            duration_in_beats = (durations(i) / 60) * tempo;

            % Fill column 6 and 7 with beats values
            nmat_track(note_idx, 6) = onset_in_beats; % Onset in beats
            nmat_track(note_idx, 7) = onset_in_beats + duration_in_beats; % Note-off in beats
            
            % Update onset_time for the next note
            onset_time = onset_time + durations(i);
            note_idx = note_idx + 1;  % Move to the next position in nmat_track
        end
    end 
end
