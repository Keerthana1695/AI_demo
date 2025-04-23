#!/bin/bash
# Merge datasets
yq eval-all '. as $item ireduce ({}; . *+ $item)' datasets/*.yaml > combined.yaml

# Train with Instruct Lab
ilab train \
  --input combined.yaml \
  --model-name models/trained_model \
  --lora-rank 16 \
  --num-epochs 3

# Version control
git add datasets/ models/trained_model/
git commit -m "Model update $(date +%Y%m%d)"
git tag -a "v$(date +%Y.%m.%d)" -m "Production release"
