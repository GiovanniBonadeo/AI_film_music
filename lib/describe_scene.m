function []= describe_scene()
    scriptPath = 'llama_scene_terminal.py';
    
    command = sprintf('python3 "%s"', scriptPath);
    
    status = system(command);
    
    if status ~= 0
        disp('Error: python not opened');
    end
end