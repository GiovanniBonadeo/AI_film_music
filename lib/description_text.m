function []= description_text(prompt)
    if prompt == "character"

        scriptPath = 'llama_character_terminal.py';
        
        command = sprintf('python3 "%s"', scriptPath);
        
        status = system(command);
        
        if status ~= 0
            disp('Error: python not opened');
        end
    elseif prompt == "scene"

        scriptPath = 'llama_scene_terminal.py';
    
        command = sprintf('python3 "%s"', scriptPath);
    
        status = system(command);
    
        if status ~= 0
            disp('Error: python not opened');
        end
    else
        disp('Error: input not valid');
    end
end