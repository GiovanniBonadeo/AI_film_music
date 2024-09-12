function M_bass = create_bass_midi_track(pitches, durations_per_bar, n_bars, tempo, time_signature)
    % Crea una traccia MIDI per la melodia suonando un solo pitch per ogni battuta.
    % pitches: array dei pitch (note) della melodia
    % durations_per_bar: array delle durate (in unità di battito) per ogni battuta
    % n_bars: numero di battute
    % tempo: tempo in BPM
    % time_signature: metrica (es. [4, 4] per 4/4)
    
    n_pitches = length(pitches);
    
    % Se ci sono meno pitch delle battute, ripeti i pitch
    while n_bars > n_pitches
        pitches = [pitches, pitches];
        n_pitches = length(pitches);
    end
    
    % Numero di battiti per battuta (es. 4 in 4/4)
    beats_per_bar = time_signature(1);
    
    % Conversione del tempo da BPM a secondi per battito
    seconds_per_beat = 60 / tempo;
    
    % Calcolo della durata totale della battuta in secondi
    bar_duration = beats_per_bar * seconds_per_beat;
    
    % Preallocazione della matrice M per la melodia
    n_notes = n_bars * length(durations_per_bar); % Numero totale di note
    M_bass = zeros(n_notes, 6); % Matrice MIDI per la melodia
    onset_time = 0;
    note_idx = 1;
    
    % Inserimento delle note della melodia nella matrice MIDI
    for bar = 1:n_bars
        % Pitch corrente per la battuta
        pitch = pitches(bar);
        
        % Inserisci le note di questa battuta secondo le durate specificate
        for i = 1:length(durations_per_bar)
            duration = durations_per_bar(i);
            
            % Inserimento nella matrice MIDI
            M_bass(note_idx, 1) = 1; % Track (default a 1)
            M_bass(note_idx, 2) = 1; % Channel (default a 1)
            M_bass(note_idx, 3) = pitch; % Pitch della nota MIDI
            M_bass(note_idx, 4) = 100; % Velocità (default a 100)
            M_bass(note_idx, 5) = onset_time; % Tempo di inizio (in secondi)
            M_bass(note_idx, 6) = onset_time + duration * seconds_per_beat; % Tempo di fine (in secondi)

            % Aggiorna il tempo di inizio per la prossima nota
            onset_time = onset_time + duration * seconds_per_beat;
            note_idx = note_idx + 1;
        end
    end
end
