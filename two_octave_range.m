function two_octave_ranged_pitches = two_octave_range(nmat_only_pitches)
%takes array of pitches and remaps it between 60 and 83

two_octave_ranged_pitches = nmat_only_pitches;
base_octave = find_base_octave(nmat_only_pitches); % base octave; 

for i=1:length(two_octave_ranged_pitches)
    two_octave_ranged_pitches(i) = nmat_only_pitches(i) - (12*base_octave) + 60;

    if two_octave_ranged_pitches(i) > 83 % beyond this octave rescaling
        two_octave_ranged_pitches(i) = mod(two_octave_ranged_pitches(i),12) + 72;
    end
end

return