import subprocess
import tempfile
import os
import time

# Comando da eseguire
command = 'ollama run llama3.1'

# Testo di input
input_text = """I would like you to analyse a text which is the description of a cinematic sequence and define its mood, for each mood return the best musical mode to use for the soundtrack. Choose between Ionian, Dorian, Phrygian, Lydian, Mixolydian, Aeolian, and Locrian."""

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
