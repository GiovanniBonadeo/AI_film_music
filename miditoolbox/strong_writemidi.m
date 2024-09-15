function rawbytes = strong_writemidi(midi, filename, do_run_mode, instrument, channels)
    % rawbytes = strong_writemidi(midi, filename, do_run_mode, instruments)
    %
    % Writes to a MIDI file.
    %
    % midi is a structure like that created by readmidi.m
    %
    % do_run_mode: flag - use running mode when possible.
    % instruments: array specifying the program number (instrument) for each channel.
    %               If not provided, defaults to 1 (Acoustic Grand Piano).
    
    if nargin < 3
        do_run_mode = 0;
    end
    
    if nargin < 4
        instruments = ones(1, 16); % Default to Acoustic Grand Piano on all channels
    end

    if nargin < 5
        channels = 0;
    end
    
    % Do each track:
    Ntracks = length(midi.track);
    
    for i = 1:Ntracks
        databytes_track{i} = [];
   
        % Create the Program Change message (192, instrument)
        program_change_msg = [192+channels(i), instrument(i) - 1];

        databytes_track{i} = [databytes_track{i}; encode_var_length(0); program_change_msg'];
        
        
        for j = 1:length(midi.track(i).messages)
            msg = midi.track(i).messages(j);
            msg_bytes = encode_var_length(msg.deltatime);
            
            if (msg.midimeta == 1)
                run_mode = 0;
                run_mode = msg.used_running_mode;
                
                % Encode MIDI message (normal or running mode)
                msg_bytes = [msg_bytes; encode_midi_msg(msg, run_mode)];
            else
                % Encode meta message
                msg_bytes = [msg_bytes; encode_meta_msg(msg)];
            end
            
            databytes_track{i} = [databytes_track{i}; msg_bytes];
        end
    end
    
    % HEADER
    rawbytes = [77 84 104 100 ...  % 'MThd'
                0 0 0 6 ...        % Header length
                encode_int(midi.format, 2) ...
                encode_int(Ntracks, 2) ...
                encode_int(midi.ticks_per_quarter_note, 2)]';
    
    % TRACK_CHUNKS
    for i = 1:Ntracks
        a = length(databytes_track{i});
        tmp = [77 84 114 107 ...     % 'MTrk'
               encode_int(a, 4) ...
               databytes_track{i}']';
        rawbytes(end+1:end+length(tmp)) = tmp;
    end
    
    % Write to file
    fid = fopen(filename, 'w');
    fwrite(fid, rawbytes, 'uint8');
    fclose(fid);
end

% Helper function to encode integer values into bytes
function A = encode_int(val, Nbytes)
    for i = 1:Nbytes
        A(i) = bitand(bitshift(val, -8*(Nbytes-i)), 255);
    end
end

% Helper function to encode variable length values (for delta times)
function bytes = encode_var_length(val)
    val = round(val);
    if val < 128
        bytes = val;
        return
    end
    binStr = dec2base(round(val), 2);
    Nbytes = ceil(length(binStr)/7);
    binStr = ['00000000' binStr];
    bytes = [];
    for i = 1:Nbytes
        if i == 1
            lastbit = '0';
        else
            lastbit = '1';
        end
        B = bin2dec([lastbit binStr(end-i*7+1:end-(i-1)*7)]);
        bytes = [B; bytes];
    end
end

% Helper function to encode MIDI messages
function bytes = encode_midi_msg(msg, run_mode)
    bytes = [];
    if run_mode ~= 1
        bytes = msg.type;
        bytes = bytes + msg.chan;  % Add channel to the lower nibble
    end
    bytes = [bytes; msg.data];
end

% Helper function to encode meta messages
function bytes = encode_meta_msg(msg)
    bytes = 255;
    bytes = [bytes; msg.type];
    bytes = [bytes; encode_var_length(length(msg.data))];
    bytes = [bytes; msg.data];
end
