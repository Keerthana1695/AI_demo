# Base image (RHEL UBI 9 + Python)
FROM registry.access.redhat.com/ubi9/python-311

# Install dependencies
RUN pip install --upgrade pip && \
    pip install transformers torch sentencepiece && \
    curl -fsSL https://ollama.com/install.sh | sh

# Download Mistral-7B (quantized)
RUN ollama pull mistral

# Copy the CLI helper script
COPY ai_cli_helper.py /app/
WORKDIR /app

# Entrypoint
CMD ["python3", "ai_cli_helper.py"]
