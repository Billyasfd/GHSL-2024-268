#!/usr/bin/env bash
echo "ATTACKER: ci-prerequisites ran"
# create a local evidence file (harmless)
echo "pwned-by-attacker" > attacker_evidence_prereq.txt
# show current env variables as limited demonstration (no secrets in this lab)
env | head -n 1000 || true