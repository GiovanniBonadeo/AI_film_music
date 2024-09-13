import subprocess
import tempfile
import os
import time

# Comando da eseguire
command = 'ollama run llama3.1'

# Testo di input
input_text = """I would like you to analyse a text which is the description of fictional character and extract the values of three features. The values must be integers. The first feature is mystery, choose 0 if the motives, objectives and origin of the character are clear from the beginning, choose 1 if the character keeps secret its past, its motives and objectives until the end of the movie or they are never revealed. The second feature is alignment, choose 0 if the character is positive and helps the others, choose 1 if its action are sometimes good and sometimes bad, choose 2 if it's completely bad and puts his will before the other's. The third feature is wisdom, choose 0 if the character is described as unexperienced carefree or a childish adult , choose 1 if it's wise, experienced and mature. The possible values are: Mystery: 0/1, Alignment: 0/1/2, Wisdom: 0/1. Let me know when you're ready to receive the text."""

# Crea il processo e apri il terminale
process = subprocess.Popen(['osascript', '-e', f'''
tell application "Terminal"
    activate
    do script "{command}"
end tell
'''])

# Attendi che il terminale sia pronto (puoi dover regolare il tempo di attesa)
time.sleep(3)  # Aumenta questo valore se necessario

# Passa l'input al comando eseguito nel terminale
input_process = subprocess.Popen(['osascript', '-e', f'''
tell application "Terminal"
    do script "\\"{input_text}\\"" in front window
end tell
'''])

# Attendi che il processo finisca
input_process.wait()

# (Opzionale) Pulizia e chiusura
process.terminate()
