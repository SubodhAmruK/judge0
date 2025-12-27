#!/bin/bash
echo "Submitting numpy test with base64..."
RESPONSE=$(curl -s -X POST "http://localhost:2358/submissions?base64_encoded=true" \
  -H "Content-Type: application/json" \
  -d '{"source_code":"aW1wb3J0IG51bXB5CnByaW50KG51bXB5Ll9fdmVyc2lvbl9fKQ==","language_id":10}')

echo "Response: $RESPONSE"
TOKEN=$(echo $RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)
echo "Token: $TOKEN"

sleep 3
echo "Result:"
curl -s "http://localhost:2358/submissions/$TOKEN" | jq '."stdout", "stderr", "status"'
