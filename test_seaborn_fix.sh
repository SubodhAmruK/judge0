#!/bin/bash

CODE=$(cat <<'PYTHON'
import matplotlib
matplotlib.use("Agg")
import seaborn
print("seaborn OK with Agg backend")
PYTHON
)

RESPONSE=$(curl -s -X POST "http://localhost:2358/submissions?base64_encoded=true" \
  -H "Content-Type: application/json" \
  -d "{\"source_code\":\"$(echo -n "$CODE" | base64 -w0)\",\"language_id\":10,\"memory_limit\":512000}")

TOKEN=$(echo $RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)
echo "Token: $TOKEN"
sleep 3
curl -s "http://localhost:2358/submissions/$TOKEN" | jq '.stdout, .stderr, .status'
