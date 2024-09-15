function midi=strong_matrix2midi(M,ticks_per_quarter_note,timesig,tempo)
% midi=strong_matrix2midi(M,ticks_per_quarter_note,timesig,tempo)
%
% M: input matrix:
%   1     2    3  4   5  6  
%  [track chan nn vel t1 t2] (any more cols ignored...)
%
% Adds a program change for the bass clef (Channel 2, Program 33 Acoustic Bass)

if nargin < 2
  ticks_per_quarter_note = 480;
end

if nargin < 3
  timesig = [4,2,24,8];
end

if nargin < 4
  tempo = 120;  % default tempo = 120 BPM
end

% Convert tempo from BPM to microseconds per quarter note
tempo_us_per_qnote = 60e6 / tempo;

tracks = unique(M(:,1));
Ntracks = length(tracks);

% start building 'midi' struct
if (Ntracks==1)
  midi.format = 0;
else
  midi.format = 1;
end

midi.ticks_per_quarter_note = ticks_per_quarter_note;

for i=1:Ntracks
  
  trM = M(tracks(i)==M(:,1),:);
  
  note_events_onoff = [];
  note_events_n = [];
  note_events_ticktime = [];
 
  % gather all the notes:
  for j=1:size(trM,1)
    % note on event:
    note_events_onoff(end+1)    = 1;
    note_events_n(end+1)        = j;
    note_events_ticktime(end+1) = 1e6 * trM(j,5) * ticks_per_quarter_note / tempo_us_per_qnote;
    
    % note off event:
    note_events_onoff(end+1)    = 0;
    note_events_n(end+1)        = j;
    note_events_ticktime(end+1) = 1e6 * trM(j,6) * ticks_per_quarter_note / tempo_us_per_qnote;
  end

  
  msgCtr = 1;
  
  % Set tempo
  midi.track(i).messages(msgCtr).deltatime = 0;
  midi.track(i).messages(msgCtr).type = 81;
  midi.track(i).messages(msgCtr).midimeta = 0;
  midi.track(i).messages(msgCtr).data = encode_int(round(tempo_us_per_qnote), 3);
  midi.track(i).messages(msgCtr).chan = [];
  msgCtr = msgCtr + 1;
  
  % Set time signature
  midi.track(i).messages(msgCtr).deltatime = 0;
  midi.track(i).messages(msgCtr).type = 88;
  midi.track(i).messages(msgCtr).midimeta = 0;
  midi.track(i).messages(msgCtr).data = timesig(:);
  midi.track(i).messages(msgCtr).chan = [];
  msgCtr = msgCtr + 1;

  % Insert Program Change for bass clef (channel 2, acoustic bass)
  if any(trM(:,2) == 2) % Check if any events are on channel 2
      midi.track(i).messages(msgCtr).deltatime = 0;
      midi.track(i).messages(msgCtr).type = 192; % Program Change
      midi.track(i).messages(msgCtr).midimeta = 1;
      midi.track(i).messages(msgCtr).chan = 1; % Channel 2 (0-based indexing in some systems, adjust if needed)
      midi.track(i).messages(msgCtr).data = 33; % Program 33 (Acoustic Bass)
      msgCtr = msgCtr + 1;
  end
  
  [junk,ord] = sort(note_events_ticktime);

  prevtick = 0;
  for j=1:length(ord)
    
    n = note_events_n(ord(j));
    cumticks = note_events_ticktime(ord(j));
    
    midi.track(i).messages(msgCtr).deltatime = cumticks - prevtick;
    midi.track(i).messages(msgCtr).midimeta = 1; 
    midi.track(i).messages(msgCtr).chan = trM(n,2);
    midi.track(i).messages(msgCtr).used_running_mode = 0;

    if (note_events_onoff(ord(j))==1)
      % note on:
      midi.track(i).messages(msgCtr).type = 144;
      midi.track(i).messages(msgCtr).data = [trM(n,3); trM(n,4)];
    else
      % note off with velocity 0 (common trick in MIDI)
      midi.track(i).messages(msgCtr).type = 144;
      midi.track(i).messages(msgCtr).data = [trM(n,3); 0];
    end
    msgCtr = msgCtr + 1;
    
    prevtick = cumticks;
  end

  % End of track:
  midi.track(i).messages(msgCtr).deltatime = 0;
  midi.track(i).messages(msgCtr).type = 47;
  midi.track(i).messages(msgCtr).midimeta = 0;
  midi.track(i).messages(msgCtr).data = [];
  midi.track(i).messages(msgCtr).chan = [];
  msgCtr = msgCtr + 1;
  
end

% Helper function to encode an integer (used in writemidi)
function A=encode_int(val,Nbytes)

A = zeros(Nbytes,1);  % ensure col vector
for i=1:Nbytes
  A(i) = bitand(bitshift(val, -8*(Nbytes-i)), 255);
end
