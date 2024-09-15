function melody = create_melody_midi_track(pitches, durations, n_bars, tempo, time_signature)
    % Creates a MIDI track for the melody, filling any remaining bars with rests
    % pitches: array of pitch (note) values for the melody
    % durations: array of durations (in beats) for each note
    % tempo: the tempo in BPM (Beats Per Minute)
    % n_bars: number of bars (measures) to fill with notes or rests
    % time_signature: time signature in MIDI format
    
    n_pitches = length(pitches);

    % Calculate the total duration of each bar in seconds
    beats_per_bar = time_signature(1); % Numerator of time signature gives beats per bar
    seconds_per_beat = 60 / tempo;     % Duration of one beat in seconds
    bar_duration = beats_per_bar * seconds_per_beat; % Total duration of one bar in seconds

    % Calculate the total required duration of the melody
    total_duration = n_bars * bar_duration;

    % Preallocate the MIDI matrix for the melody
    melody = zeros(n_pitches, 6); % Matrix for storing the MIDI notes
    onset_time = 0;  % Track the start time of each note
    note_idx = 1;    % Index to fill in the melody matrix

    % Convert note durations from beats to seconds
    durations = durations * seconds_per_beat;

    % Insert the melody notes into the MIDI matrix
    for i = 1:n_pitches
        if onset_time >= total_duration
            break; % Exit if the melody exceeds the total duration
        end
        melody(note_idx, 1) = 1; % Track (set to 1 by default)
        melody(note_idx, 2) = 1; % Channel (set to 1 by default)
        melody(note_idx, 3) = pitches(i); % MIDI pitch of the note
        melody(note_idx, 4) = 100; % Velocity (set to 100 by default)
        melody(note_idx, 5) = onset_time; % Note start time (in seconds)
        melody(note_idx, 6) = onset_time + durations(i); % Note end time (in seconds)

        % Update the onset time for the next note
        onset_time = onset_time + durations(i);
        note_idx = note_idx + 1;
    end

    % Add rests to fill the remaining time up to the total duration
    while onset_time < total_duration
        % Add a rest with a duration of a quarter note, or shorter if needed
        rest_duration = min(bar_duration / 4, total_duration - onset_time);
        melody(note_idx, 1) = 1; % Track (set to 1 by default)
        melody(note_idx, 2) = 1; % Channel (set to 1 by default)
        melody(note_idx, 3) = 0; % MIDI pitch 0 represents a rest
        melody(note_idx, 4) = 0; % Velocity 0 for a rest
        melody(note_idx, 5) = onset_time; % Rest start time (in seconds)
        melody(note_idx, 6) = onset_time + rest_duration; % Rest end time (in seconds)

        % Update the onset time for the next rest
        onset_time = onset_time + rest_duration;
        note_idx = note_idx + 1;
    end
end