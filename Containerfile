FROM registry.access.redhat.com/ubi9/python-311

# Install Python deps as non-root user
RUN pip install --upgrade pip --user && \
    pip install transformers torch sentencepiece --user

# Copy your script
COPY ai_cli_helper.py /app/
WORKDIR /app

# Run as non-root
USER 1001
CMD ["python3", "ai_cli_helper.py"]
