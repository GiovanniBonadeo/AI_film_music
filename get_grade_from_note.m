function grades_sequence = get_grade_from_note(notes_sequence)
% takes a sequence of notes (american notaion witch octave number) and
% return the respective grade according to C Major scale, from C4 to B5

all_C_grades_dic = create_all_C_grades_dictionary();
grades_sequence = [];

    for i=1:length(notes_sequence)

        if isKey(all_C_grades_dic, notes_sequence(i))
            grades_sequence = [grades_sequence all_C_grades_dic(notes_sequence(i))];
        end  
    end
end