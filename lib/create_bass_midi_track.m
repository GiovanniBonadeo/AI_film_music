function bass = create_bass_midi_track(pitches, durations, n_bars, tempo, time_signature)
    % Creates a MIDI track for bass with specified pitches and durations
    % pitches: array of MIDI pitches to play
    % durations: array of note durations in fractions of a beat (e.g., [1/4, 1/4, 1/4, 1/4])
    % n_bars: number of bars to repeat the pattern
    % tempo: tempo in BPM
    % time_signature: MIDI time signature format [numerator, denominator, clocks_per_click, 32nd_notes_per_quarter]
    
    % Extract time signature values
    beats_per_bar = time_signature(1);  % Numerator (beats per measure)
    beat_value = 2 ^ time_signature(2);  % Denominator (beat note in powers of 2)

    % Calculate the duration of a beat in seconds
    seconds_per_beat = 60 / tempo;  % Seconds per beat
    
    % Calculate the duration of a bar in seconds
    bar_duration = beats_per_bar * seconds_per_beat;
    
    % Convert note durations from fractions to seconds
    note_durations = durations * (seconds_per_beat * (4 / beat_value));
    
    % Check if the total duration of the notes matches the length of a bar
    total_pattern_duration = sum(note_durations);
    if abs(total_pattern_duration - bar_duration) > 1e-6
        error('The total duration of the pattern does not match the length of a bar.');
    end
    
    % Repeat the pattern of pitches and durations for the specified number of bars
    repeated_pitches = repmat(pitches, 1, n_bars);  % Repeat the pitches for the number of bars
    repeated_durations = repmat(note_durations, 1, n_bars);  % Repeat the durations for the number of bars
    
    % Calculate the total number of notes
    total_notes = length(repeated_pitches);
    bass = zeros(total_notes, 6);  % Preallocate the matrix for the MIDI track
    
    onset_time = 0;  % Track the onset time for each note
    note_idx = 1;

    for i = 1:total_notes
        % Duration of the current note in seconds
        note_duration_seconds = repeated_durations(i);
        
        % Add the pitch and its duration to the matrix
        bass(note_idx, 1) = 1;  % Track (default to 1)
        bass(note_idx, 2) = 1;  % Channel (default to 1)
        bass(note_idx, 3) = repeated_pitches(i);  % MIDI pitch of the note
        bass(note_idx, 4) = 100;  % Velocity (default to 100)
        bass(note_idx, 5) = onset_time;  % Start time (in seconds)
        bass(note_idx, 6) = onset_time + note_duration_seconds;  % End time (in seconds)
        
        % Update the onset time for the next note
        onset_time = onset_time + note_duration_seconds;
        note_idx = note_idx + 1;
    end
end
