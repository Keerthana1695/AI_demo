# Dockerfile
FROM registry.access.redhat.com/ubi9/python-39

# Install Instruct Lab
RUN pip install instruct-lab && \
    dnf install -y git-lfs && \
    git lfs install

COPY . /app
WORKDIR /app

ENTRYPOINT ["python3", "cli.py"]
