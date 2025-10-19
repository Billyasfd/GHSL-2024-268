echo "ATTACKER: ci-prerequisites ran"
echo "pwned-by-attacker" > attacker_evidence_prereq.txt
env | head -n 20 || true
