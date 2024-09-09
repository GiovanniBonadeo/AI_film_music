function rhythmic_pattern = get_rhythmic_pattern_from_durations(durations_data, bpm)
    % matches beat fractions based on bpm and duration of notes
    % Possible beat fractions
    fractions = [1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1];
    seconds_per_beat = 60 / bpm;
    rhythmic_pattern = [];

    % convert
    for i=1:length(durations_data)
        
        new_fraction = convert_duration_to_rhythm(durations_data(i) / seconds_per_beat, fractions);
        rhythmic_pattern = [rhythmic_pattern new_fraction];
    end
end
