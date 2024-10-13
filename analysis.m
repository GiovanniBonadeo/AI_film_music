clc, clear, close all;

addpath(genpath("miditoolbox"));
addpath(genpath("themes/"));
addpath(genpath("lib/"));
addpath(genpath("trained_models"));

%creates .mat files of sequence of grades for each file midi in the
%specified directory. 

feat_val = "011";

midi_read_files_matr = create_coll_midi_file("themes/"+feat_val);

for i=1:length(midi_read_files_matr)
    
    nmat = midi_read_files_matr{i};
    
    % durations analysis
    [note_durations, tempo] = extract_note_durations(nmat);
    
    % Get beat franction based on bpm and duration
    rhythmic_pattern = get_rhythmic_pattern_from_durations(note_durations, tempo);
    %disp(note_durations)
    
    if i == 1
        durations_data = {};
    end
    
    durations_data = all_sequences_of_model(rhythmic_pattern, durations_data);
  
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

%Create transition matrix for melody

transition_matrix_mel = create_markov_chain_mel(grades_data);

%Display trainsition matrix
%disp('Normalized melody transition matrix:');
%disp(transition_matrix_mel);

%Create transition matrix for durations

transition_matrix_dur = create_markov_chain_dur(durations_data);
% Display trainsition matrix
%disp('Normalized durations transition matrix:');
%disp(transition_matrix_dur);

save('trained_models/model'+feat_val+'_mel.mat', 'transition_matrix_mel');
save('trained_models/model'+feat_val+'_durations.mat', 'transition_matrix_dur');
