clc, clear, close all;

addpath("miditoolbox/");
addpath("model1/");
addpath("lib/");

%main creates txt files of sequence of grades for each file midi in the
%specified directory. 

midi_read_files_matr = create_coll_midi_file("model1");

for i=1:length(midi_read_files_matr)
    
    nmat = midi_read_files_matr{i};
    
    % durations analysis
    note_durations = extract_note_durations(nmat);
    %disp(note_durations)
    
    if i == 1
        durations_data = {};
    end
    
    durations_data = all_sequences_of_model(note_durations, durations_data);
  
    % notes analysis
    transposed_2C = transpose2c(nmat); %transpose to C

    nmat_only_pitches = pitch(transposed_2C); % extract only pitch from nmat

    two_octave_ranged_pitches = two_octave_range(nmat_only_pitches); %restrict between 60 and 83

    notes_sequence = get_note_from_pitch(two_octave_ranged_pitches); %sequence of midi pitch to notes (american notation)

    grades_sequence = get_grade_from_note(notes_sequence); %sequence of notes to grades
    
    if i == 1 
        grades_data = {};
    end

    grades_data = all_sequences_of_model(grades_sequence, grades_data); %all sequences of the model
    
end

save('model1_mel.mat', 'grades_data');
save('model1_durations.mat', 'durations_data');
