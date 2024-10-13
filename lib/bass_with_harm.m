function final_bass = bass_with_harm(transp_bass, harmonic_succ, n_bars, base_note)
    %Takes the bass line for a single bar and returns the full bass for all the
    %bars, following the harmony grades
    
    harmonic_succ = [harmonic_succ, harmonic_succ(1)];
    final_bass = transp_bass;
    transp_vals = [];
    chord = harmonic_succ(1);
    base_chord = get_chord_notes(chord, base_note);

    for i=2:length(harmonic_succ)
        
        chord = harmonic_succ(i);
        chord_notes = get_chord_notes(chord, base_note);
        shift = base_chord - chord_notes;
        transp_vals = [transp_vals, shift(1)];
        
    end
        
    while n_bars>length(transp_vals)
        transp_vals = [transp_vals, transp_vals];
    end

    for i=1:n_bars-1
        bass_bar = transp_bass - transp_vals(i);
        final_bass = [final_bass, bass_bar];
    end
    
end