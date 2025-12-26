#!/bin/bash

# Submit code
echo "Submitting code..."
RESPONSE=$(curl -s -X POST "http://localhost:2358/submissions?base64_encoded=false" \
  -H "Content-Type: application/json" \
  -d '{"source_code":"print(55555)","language_id":10}')

# Extract token
TOKEN=$(echo $RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)
echo "Token: $TOKEN"

# Wait and check result
echo "Waiting 3 seconds..."
sleep 3

echo "Fetching result..."
curl -s "http://localhost:2358/submissions/$TOKEN" | jq '.'
