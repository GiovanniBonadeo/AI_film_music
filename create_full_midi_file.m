function combined_midi = create_full_midi_file(melody_pitches, melody_durations, bass_pitches, bass_durations, harmonic_succ, base_note, n_bars, tempo, time_signature)
    % Creates a MIDI file with three parts: melody, bass, and harmony
    % melody_pitches: array of melody pitches
    % melody_durations: array of melody note durations
    % bass_pitches: array of bass pitches for each bar
    % bass_durations: array of bass note durations for each pitch
    % harmonic_succ: array of harmonic successions (chords)
    % base_note: base note for chord construction
    % n_bars: number of bars for the composition
    % tempo: tempo in BPM
    % time_signature: the time signature (e.g., [4, 4] for 4/4)
    % file_name: the output MIDI file name

    % Create the melody MIDI track
    melody_track = create_melody_midi_track(melody_pitches, melody_durations, n_bars, tempo, time_signature);
    
    % Create the bass MIDI track
    bass_track = create_bass_midi_track(bass_pitches, bass_durations, n_bars, tempo, time_signature);
    
    % Create the harmony MIDI track
    harmony_track = create_harmony_midi_track(harmonic_succ, base_note, n_bars, tempo, time_signature);
    
    % Combine all tracks into one MIDI matrix
    % Each track will have its own channel: 
    % Melody on channel 1, Bass on channel 2, Harmony on channel 3
    
    % Assign different channels to each track
    melody_track(:, 2) = 1; % Channel 1 for melody
    bass_track(:, 2) = 2;   % Channel 2 for bass
    harmony_track(:, 2) = 3; % Channel 3 for harmony
    
    % Concatenate all tracks
    combined_midi = [melody_track; bass_track; harmony_track];
    
end
