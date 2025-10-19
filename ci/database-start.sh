#!/usr/bin/env bash
echo "ATTACKER: database-start ran (harmless)"
echo "dbstart evidence" > attacker_evidence_dbstart.txt
env | head -n 20 || true
