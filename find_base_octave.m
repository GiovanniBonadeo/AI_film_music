function num_octave = find_base_octave(nmat_only_pitch)
% given an nmat, searches and returns the base octave
num_octave = 10;

for i=1:length(nmat_only_pitch)

    if floor(nmat_only_pitch(i) / 12) < num_octave
        num_octave = floor(nmat_only_pitch(i) / 12);
    end
end

return