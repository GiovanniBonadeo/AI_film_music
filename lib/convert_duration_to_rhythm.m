function rhythm_fraction = convert_duration_to_rhythm(duration_beat, fractions)
    % converts in beat fractions
    
    % find nearest beat fraction
    [~, idx] = min(abs(fractions - duration_beat));
    
    rhythm_fraction = fractions(idx);
end