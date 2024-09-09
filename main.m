clc, clear, close all;

addpath("miditoolbox/");
addpath("model1/");

%main creates txt files of sequence of grades for each file midi in the
%specified directory. 

midi_read_files_matr = create_coll_midi_file("model1");

for i=1:length(midi_read_files_matr)
    
    nmat = midi_read_files_matr{i};
    
    % durations analysis
    note_durations = extract_note_durations(nmat);
    disp(note_durations)
    
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

%% Takes variabale grades_data and durations_data from the .mat file

loaded_data = load('model1_mel.mat', 'grades_data');
grades_data = loaded_data.grades_data;

loaded_data = load('model1_durations.mat', 'durations_data');
durations_data = loaded_data.durations_data;


%% Create transition matrix for melody

transition_matrix_mel = create_markov_chain_mel(grades_data);

% Display trainsition matrix
disp('Normalized melody transition matrix:');
disp(transition_matrix_mel);

%% Create transition matrix for durations

transition_matrix_dur = create_markov_chain_dur(durations_data);
% Display trainsition matrix
disp('Normalized durations transition matrix:');
disp(transition_matrix_dur);

%% Select rythm for bass
bpm = 100;
single_notes_durations = select_rythmic_pattern('standard', bpm);

%% Declare number of notes for you your melody

%for tresillo, gallop and aksak use 3
%for habanera and standard use multiples of 4
number_of_notes = 4;

%% Generate new melody
generated_mel_seq = generate_seq_frm_mc(transition_matrix_mel, number_of_notes);

%% Generate new durations
generated_dur_for_mel = generate_seq_frm_mc(transition_matrix_dur, number_of_notes);
%% Choose mode and base note

mode = ["Ionian", "D"];

moded_mel = add_mode_to_mel(generated_mel_seq, mode(1));
final_mel = choose_base_note(moded_mel, mode(2));

%% Choose harmonic succession

harmonic_succ = get_harmonic_succ(mode(1));

%% Choose number of bars

number_of_bars = 8;

%% Create new nmat

rythm_armonic_track = create_midi_track(final_mel, single_notes_durations, number_of_bars, harmonic_succ, mode(2), bpm);

%% Listen to melody using Matlab
playsound(rythm_armonic_track);


%%
writemidi(rythm_armonic_track, 'melody.mid');

writemidi(nmat, 'test.mid');

