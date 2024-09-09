function rhythm_fraction = convert_duration_to_rhythm(duration_beats, fractions)
    % converts in beat fractions
    
    % find nearest beat fraction
    [~, idx] = min(abs(duration_beats - fractions));
    
    rhythm_fraction = fractions(idx);
end