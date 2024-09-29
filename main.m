clc, clear, close all;

addpath("miditoolbox/");
addpath("lib/");
addpath("trained_models/");

description_text("character");

%%
%Please insert the values for Mystery, Alignment and Wisdom that you
%received in order
[transition_matrix_mel, transition_matrix_dur] = select_file_to_load(0, 0, 1);

%% Select bpm, number of notes for the melody and number of bars
bpm = 72;
number_of_notes = 6;
number_of_bars = 8;

%% Select rythm for bass
%choose between 'standard', 'tresillo', 'gallop', 'habanera'
[single_bass_notes_durations, time_signature] = select_rythmic_pattern('habanera');

%% Generate new melody
generated_mel_seq = generate_seq_frm_mc(transition_matrix_mel, number_of_notes);

%% Generate new durations
generated_dur_index_for_mel = generate_seq_frm_mc(transition_matrix_dur, number_of_notes);
generated_dur_for_mel = remap_to_fractions(generated_dur_index_for_mel);

%% Generate bass line
generated_bass_seq = generate_seq_frm_mc(transition_matrix_mel, length(single_bass_notes_durations));

%% Choose mode based on the scene description

description_text("scene");

%%

%Specify the musical mode (choose from 'Ionian', 'Dorian', 'Phrygian', 
%'Lydian', 'Mixolydian', 'Aeolian', 'Locrian') and se base note.
mode = ["Aeolian", "A"];

instruments = get_instruments_from_mode(mode(1));

moded_mel = add_mode_to_mel(generated_mel_seq, mode(1));
final_mel = choose_base_note(moded_mel, mode(2));

moded_bass = add_mode_to_mel(generated_bass_seq, mode(1), 1);
final_bass = choose_base_note(moded_bass, mode(2));

%% Choose harmonic succession

harmonic_succ = get_harmonic_succ(mode(1));

%% Create melody
melody_track = create_melody_midi_track(final_mel, generated_dur_for_mel, number_of_bars, bpm, time_signature);
%% Create Harmony
harmony_track = create_harmony_midi_track(harmonic_succ, mode(2), number_of_bars, bpm, time_signature);
%% Create Bass
bass_track = create_bass_midi_track(final_bass, single_bass_notes_durations, number_of_bars, bpm, time_signature);
%%
midi_new_mel = strong_matrix2midi(melody_track, 480, time_signature, bpm);
strong_writemidi(midi_new_mel, 'melody.mid', 0, instruments(1));
%%
midi_new_harm = strong_matrix2midi(harmony_track, 480, time_signature, bpm);
strong_writemidi(midi_new_harm, 'harmony.mid', 0, instruments(2));
%%
midi_new_bass = strong_matrix2midi(bass_track, 480, time_signature, bpm);
strong_writemidi(midi_new_bass, 'bass.mid', 0, instruments(3));
%%
combined_midi = create_full_midi_file(final_mel, generated_dur_for_mel, final_bass, single_bass_notes_durations, harmonic_succ, mode(2), number_of_bars, bpm, time_signature);
midi_new_partiture = strong_matrix2midi(combined_midi, 480, time_signature, bpm);
strong_writemidi(midi_new_partiture, 'partiture.mid', 0, instruments, [0 1 2]);