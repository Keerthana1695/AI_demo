import subprocess
from transformers import pipeline

# Load Mistral-7B (or use Ollama's API)
pipe = pipeline("text-generation", model="mistralai/Mistral-7B-Instruct-v0.1")

def get_bash_command(query):
    prompt = f"""Convert this query to a Linux Bash command. Output ONLY the command.
    Query: {query}
    Command:"""
    response = pipe(prompt, max_new_tokens=50, truncation=True)
    return response[0]['generated_text'].split("Command:")[-1].strip()

# Demo loop
while True:
    query = input("\nAsk for a Bash command (or 'exit'): ")
    if query.lower() == 'exit':
        break
    command = get_bash_command(query)
    print(f"\nAI Suggests: `{command}`\n")
    execute = input("Run this? (y/n): ")
    if execute.lower() == 'y':
        subprocess.run(command, shell=True, check=True)
