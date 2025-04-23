#!/bin/bash

# Install yq if missing (uncomment if needed)
# pip3 install yq 2>/dev/null || echo "yq already installed"

# Merge datasets (requires yq)
yq eval-all '. as $item ireduce ({}; . *+ $item)' datasets/*.yaml > combined.yaml

# Train with correct ilab syntax
ilab train \
  --input-dir ./combined.yaml \
  --model-dir ./models/trained_model \
  --lora-rank 16 \
  --num-epochs 3

# Version control
git add datasets/ models/trained_model/ combined.yaml
git commit -m "Model update $(date +%Y%m%d)"
