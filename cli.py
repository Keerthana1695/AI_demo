#!/usr/bin/env python3
import argparse
import subprocess
from pathlib import Path
import yaml
import git

REPO_ROOT = Path(__file__).parent

class RHELHelper:
    def __init__(self):
        self.repo = git.Repo(REPO_ROOT)
        self.model_path = REPO_ROOT / "models/trained_model"
        
    def query(self, natural_language):
        # Log query to audit trail
        with open(REPO_ROOT/"query_audit.log", "a") as f:
            f.write(f"{natural_language}\n")
        
        # Get response from Instruct Lab
        result = subprocess.run(
            ["ilab", "query", "--model", str(self.model_path), "--prompt", natural_language],
            capture_output=True, text=True
        )
        return result.stdout

    def commit_changes(self, message):
        self.repo.git.add(all=True)
        self.repo.index.commit(message)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("query", help="Natural language command query")
    args = parser.parse_args()
    
    helper = RHELHelper()
    response = helper.query(args.query)
    print(response)
    helper.commit_changes(f"Query: {args.query[:100]}")
