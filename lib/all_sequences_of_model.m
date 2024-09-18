function data = all_sequences_of_model(sequence, data)
    % takes the sequence of grades and adds to the others of the same
    % model, if is empty creates a new one
    
    if isempty(data)
        data = {sequence};
    else
        data{end+1} = sequence;
    end
end