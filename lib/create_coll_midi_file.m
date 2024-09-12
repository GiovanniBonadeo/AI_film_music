function midi_matrices = create_coll_midi_file(dir_path)

%takes a directory, selects the midi files and converts all of them in a
%cell of nm matrix, one for each file

% get every file with '.mid' or '.midi' extension
midi_files = dir(fullfile(dir_path, '*.mid'));
midi_files = [midi_files; dir(fullfile(dir_path, '*.midi'))];

num_files = length(midi_files);

%create a cell
midi_matrices = cell(num_files, 1);

    for i = 1:num_files
     
        midi_path = fullfile(dir_path, midi_files(i).name);
        midi_matrices{i} = readmidi(midi_path);
    end
end
