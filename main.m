addpath("miditoolbox/");
addpath("lib/");

%% Takes variabale grades_data and durations_data from the .mat file

loaded_data = load('model1_mel.mat', 'grades_data');
grades_data = loaded_data.grades_data;

loaded_data = load('model1_durations.mat', 'durations_data');
durations_data = loaded_data.durations_data;


%% Create transition matrix for melody

transition_matrix_mel = create_markov_chain_mel(grades_data);

% Display trainsition matrix
%disp('Normalized melody transition matrix:');
%disp(transition_matrix_mel);

%% Create transition matrix for durations

transition_matrix_dur = create_markov_chain_dur(durations_data);
% Display trainsition matrix
%disp('Normalized durations transition matrix:');
%disp(transition_matrix_dur);

%% Select bpm, number of notes for the melody and number of bars
bpm = 100;
number_of_notes = 8;
number_of_bars = 8;

%% Select rythm for bass
[single_bass_notes_durations, time_signature] = select_rythmic_pattern('standard', bpm);

%for tresillo, gallop and aksak use 3
%for habanera and standard use multiples of 4

%% Generate new melody
generated_mel_seq = generate_seq_frm_mc(transition_matrix_mel, number_of_notes);

%% Generate new durations
generated_dur_index_for_mel = generate_seq_frm_mc(transition_matrix_dur, number_of_notes);
generated_dur_for_mel = remap_to_fractions(generated_dur_index_for_mel);

%% Generate bass line
generated_bass_seq = generate_seq_frm_mc(transition_matrix_mel, number_of_bars);

%% Choose mode and base note

mode = ["Ionian", "D"];

moded_mel = add_mode_to_mel(generated_mel_seq, mode(1));
final_mel = choose_base_note(moded_mel, mode(2));

%% Choose harmonic succession

harmonic_succ = get_harmonic_succ(mode(1));

%% Create new nmat

rythm_armonic_track = strong_create_midi_track(final_mel, single_bass_notes_durations, number_of_bars, harmonic_succ, mode(2), bpm);

%% Create melody
melody_track = create_melody_midi_track(final_mel, single_bass_notes_durations, bpm);
%% Create Harmony
harmony_track = create_harmony_midi_track(harmonic_succ, mode(2), number_of_bars, bpm, time_signature);
%% Create Bass
bass_track = create_bass_midi_track(generated_bass_seq, single_bass_notes_durations, number_of_bars, bpm, time_signature);
%% Listen to melody using Matlab
%playsound(rythm_armonic_track);

%%
midi_new_mel = strong_matrix2midi(melody_track, 300, time_signature, bpm);
strong_writemidi(midi_new_mel, 'melody.mid');
%%
midi_new_harm = strong_matrix2midi(harmony_track, 300, time_signature);
strong_writemidi(midi_new_harm, 'harmony.mid');
%%
midi_new_bass = strong_matrix2midi(bass_track, 300, time_signature, bpm);
strong_writemidi(midi_new_bass, 'bass.mid');


