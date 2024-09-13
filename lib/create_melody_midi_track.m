function M_melody = create_melody_midi_track(pitches, durations, tempo)
    % Crea una traccia MIDI solo per la melodia
    % pitches: array delle altezze (note) della melodia
    % durations: array delle durate per ogni nota
    % tempo: il tempo in BPM

    n_pitches = length(pitches);
    
    % Se ci sono meno durate che altezze, ripeti le durate
    while n_pitches > length(durations)
        durations = [durations, durations];
    end

    % Preallocazione della matrice M per la melodia
    M_melody = zeros(n_pitches, 6); % MIDI matrix per la melodia
    onset_time = 0;
    note_idx = 1;
    
    % Conversione del tempo da BPM a secondi per durata
    seconds_per_beat = 60 / tempo;
    
    % Inserimento delle note della melodia nella matrice MIDI
    for i = 1:n_pitches
        M_melody(note_idx, 1) = 1; % Track (default a 1)
        M_melody(note_idx, 2) = 1; % Channel (default a 1)
        M_melody(note_idx, 3) = pitches(i); % Pitch della nota MIDI
        M_melody(note_idx, 4) = 100; % Velocità (default a 100)
        M_melody(note_idx, 5) = onset_time; % Tempo di inizio (in secondi)
        M_melody(note_idx, 6) = onset_time + durations(i) * seconds_per_beat; % Tempo di fine (in secondi)

        % Aggiorna il tempo di inizio per la prossima nota
        onset_time = onset_time + durations(i) * seconds_per_beat;
        note_idx = note_idx + 1;
    end
end
