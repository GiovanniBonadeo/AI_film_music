function grades_data = all_sequences_of_model(grades_sequence, grades_data)
    % takes the sequence of grades and adds to the others of the same
    % model, if is empty creates a new one
    
    if isempty(grades_data)
        grades_data = {grades_sequence};
    else
        grades_data{end+1} = grades_sequence;
    end
end
