#!/bin/bash

echo "Testing ML libraries..."
RESPONSE=$(curl -s -X POST "http://localhost:2358/submissions?base64_encoded=false" \
  -H "Content-Type: application/json" \
  -d '{"source_code":"import numpy, pandas, sklearn, matplotlib, scipy, seaborn, kneed, sympy, networkx, mlxtend\nprint(\"All ML libraries loaded successfully!\")","language_id":10}')

TOKEN=$(echo $RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)
echo "Token: $TOKEN"

sleep 3
curl -s "http://localhost:2358/submissions/$TOKEN" | jq '.stdout, .stderr, .status'
