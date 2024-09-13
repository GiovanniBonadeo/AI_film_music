function M_melody = create_bass_midi_track(pitches, note_durations, n_bars, tempo, time_signature)
    % Creates a MIDI track for a melody with single notes
    % pitches: array of MIDI pitches to play in each bar
    % note_durations: array of note durations in a bar (e.g., [1/4, 1/8, 1/8])
    % n_bars: number of bars
    % tempo: tempo in BPM
    % time_signature: the time signature in MIDI format [numerator, denominator, clicks per quarter note, 32nds per quarter note]

    % If the pitch list is shorter than the number of bars, repeat the pitches
    while n_bars > length(pitches)
        pitches = [pitches, pitches];
    end
    
    % If the duration list is shorter than the number of notes per bar, repeat the durations
    notes_per_bar = length(note_durations); % Number of notes per bar based on provided durations
    while notes_per_bar > length(note_durations)
        note_durations = [note_durations, note_durations];
    end
    
    % Calculate the duration of a bar in ticks
    ticks_per_quarter_note = 480; % Number of ticks per quarter note (typical default value)
    beats_per_bar = time_signature(1); % Number of beats per bar
    quarter_note_duration = 60 / tempo; % Duration of a quarter note in seconds
    bar_duration_seconds = beats_per_bar * quarter_note_duration; % Duration of a bar in seconds
    
    % Pre-calculate the duration of a tick in seconds
    tick_duration = quarter_note_duration / ticks_per_quarter_note;
    
    % Calculate the total number of ticks per bar
    ticks_per_bar = beats_per_bar * ticks_per_quarter_note;
    
    % Preallocate the matrix M for the melody
    % Number of rows = number of bars * number of notes per bar
    M_melody = zeros(n_bars * notes_per_bar, 6);
    
    onset_ticks = 0;
    note_idx = 1;

    for bar = 1:n_bars
        % Get the pitch and durations for the current bar
        pitch = pitches(bar);
        durations = note_durations; % Use the provided durations for the bar
        
        % Calculate total duration for all notes in the bar
        total_note_duration_ticks = 0;
        for j = 1:length(durations)
            % Convert note duration to ticks
            duration_ticks = durations(j) / tick_duration;
            
            M_melody(note_idx, 1) = 1; % Track (default to 1)
            M_melody(note_idx, 2) = 1; % Channel (default to 1)
            M_melody(note_idx, 3) = pitch; % MIDI pitch of the note
            M_melody(note_idx, 4) = 100; % Velocity (default to 100)
            M_melody(note_idx, 5) = onset_ticks; % Start time (in ticks)
            M_melody(note_idx, 6) = onset_ticks + duration_ticks; % End time (in ticks)
            note_idx = note_idx + 1;
            
            % Update the start time for the next note
            onset_ticks = onset_ticks + duration_ticks;
            
            total_note_duration_ticks = total_note_duration_ticks + duration_ticks;
        end
        
        % Update the start time for the next bar
        % Align to the start of the next bar by setting onset_ticks to 0
        onset_ticks = 0;
    end
end
