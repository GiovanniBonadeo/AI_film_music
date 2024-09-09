clc, clear, close all;

nmat = readmidi('BrohMartin.mid'); % midi file 2 matrix

nmat_all_pitches = pitch(nmat); % extract only pitch from nmat

% plotdist(pcdist1(nmat)); % plots distribution of used notes

sel_ch_mel = getmidich(nmat, 0); % get pitches from selected channel

% playsound(nmat) %listen from matlab

nmat_dropped = dropshortnotes(nmat,'beat', 1/16); % eliminates nodes shorter than
    
nmat_transpose = shift(nmat, 'pitch', +4); % transpose pitch

nmat_to_c = transpose2c(nmat_transpose); % transpose 2 c

%keymode(nmat); % 1 Major 2 Minor


keyname(kkkey(nmat))
keyname(kkkey(nmat_transpose))
keyname(kkkey(nmat_to_c))

%%

clc; clear;

nmat = readmidi('scale_c_major.mid');
%pitch(nmat);
C = pitch(transpose_2C(nmat));

nmat = readmidi('scale_a_major.mid');
%pitch(nmat);
A2C = pitch(transpose_2C(nmat));

%%
clear;
nmat = readmidi('scale_c_minor.mid');
%pitch(nmat);
c2C  = pitch(transpose2c(nmat));
nmat = readmidi('scale_dsharp_minor.mid');
%pitch(nmat);
ds2C = pitch(transpose2c(nmat));

%%

transition_matrix = create_markov_chain_tm(grades_data_test);

disp(transition_matrix)

%%
% Sintassi della matrice nmat:
% Colonna 1: Inizio della nota in secondi
% Colonna 2: Durata della nota in secondi
% Colonna 3: Numero della nota MIDI (Pitch)
% Colonna 4: Velocità (Velocity)
% Colonna 5: Canale MIDI

% Esempio: Crea una matrice di note MIDI
nmat = [
    0, 1, 60, 100, 1;  % Nota C4, durata 1 secondo, velocità 100, canale 1
    1, 1, 62, 100, 1;  % Nota D4
    2, 1, 64, 100, 1;  % Nota E4
];

% Scrittura del file MIDI
writemidi(nmat, 'melody.mid');  % 120 BPM
