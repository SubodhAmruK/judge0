#!/bin/bash
CODE=cat test_numpy_simple.py
TOKEN=curl -s -X POST 'http://localhost:2358/submissions?base64_encoded=false' -H 'Content-Type: application/json' -d @- << JSON
{
  " source_code\: \\,
 \language_id\: 10
}
JSON
 | jq -r '.token'
echo Token: 
sleep 3
curl -s http://localhost:2358/submissions/ | jq '.'
