function nmat_track = create_midi_track(pitches, durations, n_bars)
    % creates a midi track using pitches and duration per each pitch as input
    
    n_pitches = length(pitches);

    while n_pitches > length(durations)
         durations = [durations, durations];
    end

    nmat_track = zeros(n_pitches*n_bars, 7);
    onset_time = 0;

    for bar = 1:n_bars
        for i = 1:n_pitches
            % Calculate index for nmat_track
            bar_idx = (bar-1) * n_pitches + i;

            % Fill in the MIDI track information
            nmat_track(bar_idx, 1) = onset_time; % Onset (seconds)
            nmat_track(bar_idx, 2) = durations(i); % Duration (seconds)
            nmat_track(bar_idx, 3) = 1; % Channel (default to 1)
            nmat_track(bar_idx, 4) = pitches(i); % MIDI Pitch
            nmat_track(bar_idx, 5) = 127; % Velocity (maximum for now)
            nmat_track(bar_idx, 6) = onset_time; % Onset (seconds)
            nmat_track(bar_idx, 7) = durations(i); % Duration (seconds)

            % Update onset_time for the next note
            onset_time = onset_time + durations(i);
        end
    end 
end