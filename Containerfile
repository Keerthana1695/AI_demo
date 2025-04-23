FROM registry.access.redhat.com/ubi9/python-311

# Install only necessary Python packages
RUN pip install --no-cache-dir \
    transformers \
    torch \
    sentencepiece \
    accelerate  # For better CPU/GPU utilization

COPY ai_cli_helper.py ./

# Use a different model that doesn't need Ollama
ENV MODEL_NAME="google/flan-t5-small"

CMD ["python3", "ai_cli_helper.py"]
