clc, clear, close all;

addpath("miditoolbox/");
addpath("model1/");

%main creates txt files of sequence of grades for each file midi in the
%specified directory. 

midi_read_files_matr = create_coll_midi_file('model1');

for i=1:length(midi_read_files_matr)
    
    nmat = midi_read_files_matr{i};

    %nmat = readmidi('bday.mid'); % midi file 2 matrix

    %nmat = shift(nmat, 'pitch', +33); % transpose pitch

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

save('model1.mat', 'grades_data');

%%

loaded_data = load('model1.mat', 'grades_data');
grades_data = loaded_data.grades_data;

transition_matrix = create_markov_chain_tm(grades_data);

% Visualizza la matrice di transizione
disp('Matrice di transizione normalizzata:');
disp(transition_matrix);


%mc = dtmc(transition_matrix);

%%
new_mel_seq = generate_seq_frm_mc(transition_matrix, 8)

%%

moded_mel = add_mode_to_mel(new_mel_seq)