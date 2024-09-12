function M_harmony = create_harmony_midi_track(harmonic_succ, base_note, n_bars, tempo, time_signature)
    % Crea una traccia MIDI solo per l'armonia (accordi)
    % harmonic_succ: array della successione armonica (accordi)
    % base_note: nota di base per la costruzione degli accordi
    % n_bars: numero di battute
    % tempo: il tempo in BPM
    % time_signature: la metrica (es. [4, 4] per 4/4)

    % Se la successione armonica è più corta del numero di battute, ripeti gli accordi
    while n_bars > length(harmonic_succ)
        harmonic_succ = [harmonic_succ, harmonic_succ];
    end
    
    % Calcolo della durata di una battuta in secondi
    beats_per_bar = time_signature(1); % Numero di battiti per battuta (es. 4 in 4/4)
    seconds_per_beat = 60 / tempo; % Secondi per battito
    bar_duration = beats_per_bar * seconds_per_beat; % Durata di una battuta in secondi

    % Preallocazione della matrice M per l'armonia
    % Poiché ci sono 3 note per accordo e un accordo per ogni battuta, la matrice avrà
    % `n_bars * 3` righe e 6 colonne
    M_harmony = zeros(n_bars * 3, 6);
    
    onset_time = 0;
    note_idx = 1;

    for bar = 1:n_bars
        % Ottieni le note dell'accordo corrente
        chord = harmonic_succ(bar);
        chord_notes = get_chord_notes(chord, base_note); % Funzione per generare le note dell'accordo
        
        % Inserimento delle note dell'accordo nella matrice MIDI
        for j = 1:3  % Assumendo che ci siano sempre 3 note per ogni accordo
            M_harmony(note_idx, 1) = 1; % Track (default a 1)
            M_harmony(note_idx, 2) = 1; % Channel (default a 1)
            M_harmony(note_idx, 3) = chord_notes(j); % Pitch della nota MIDI
            M_harmony(note_idx, 4) = 100; % Velocità (default a 100)
            M_harmony(note_idx, 5) = onset_time; % Tempo di inizio (in secondi)
            M_harmony(note_idx, 6) = onset_time + bar_duration; % Tempo di fine (in secondi)
            note_idx = note_idx + 1;
        end
        
        % Aggiorna il tempo di inizio per il prossimo accordo (inizio della prossima battuta)
        onset_time = onset_time + bar_duration;
    end
end
