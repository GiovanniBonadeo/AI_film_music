function harmony = create_harmony_midi_track(harmonic_succ, base_note, n_bars, tempo, time_signature)
    % Creates a MIDI track for harmony (chords)
    % harmonic_succ: array of harmonic succession (chords)
    % base_note: base note for chord construction
    % n_bars: number of bars
    % tempo: tempo in BPM
    % time_signature: the time signature

    % If the harmonic succession is shorter than the number of bars, repeat the chords
    while n_bars > length(harmonic_succ)
        harmonic_succ = [harmonic_succ, harmonic_succ];
    end
    
    % Calculate the duration of a bar in seconds
    beats_per_bar = time_signature(1); % Number of beats per bar (e.g., 4 in 4/4)
    seconds_per_beat = 60 / tempo; % Seconds per beat
    bar_duration = beats_per_bar * seconds_per_beat; % Duration of a bar in seconds

    % Preallocate the matrix M for harmony
    % Since there are 3 notes per chord and one chord per bar, the matrix will have
    % `n_bars * 3` rows and 6 columns
    harmony = zeros(n_bars * 3, 6);
    
    onset_time = 0;
    note_idx = 1;

    for bar = 1:n_bars
        % Get the notes of the current chord
        chord = harmonic_succ(bar);
        chord_notes = get_chord_notes(chord, base_note); % Function to generate chord notes
        
        % Insert the chord notes into the MIDI matrix
        for j = 1:3  % Assuming there are always 3 notes per chord
            harmony(note_idx, 1) = 1; % Track (default to 1)
            harmony(note_idx, 2) = 1; % Channel (default to 1)
            harmony(note_idx, 3) = chord_notes(j); % MIDI pitch of the note
            harmony(note_idx, 4) = 100; % Velocity (default to 100)
            harmony(note_idx, 5) = onset_time; % Start time (in seconds)
            harmony(note_idx, 6) = onset_time + bar_duration; % End time (in seconds)
            note_idx = note_idx + 1;
        end
        
        % Update the start time for the next chord (start of the next bar)
        onset_time = onset_time + bar_duration;
    end
end
