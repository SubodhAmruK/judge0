#!/bin/bash

test_lib() {
    echo "Testing $1..."
    RESPONSE=$(curl -s -X POST "http://localhost:2358/submissions?base64_encoded=false" \
      -H "Content-Type: application/json" \
      -d "{\"source_code\":\"import $1\\nprint('$1 OK')\",\"language_id\":10,\"memory_limit\":256000}")
    
    TOKEN=$(echo $RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)
    sleep 2
    RESULT=$(curl -s "http://localhost:2358/submissions/$TOKEN")
    STATUS=$(echo $RESULT | jq -r '.status.description')
    STDOUT=$(echo $RESULT | jq -r '.stdout')
    echo "  Status: $STATUS | Output: $STDOUT"
}

test_lib "numpy"
test_lib "pandas"
test_lib "sklearn"
test_lib "matplotlib"
test_lib "scipy"
test_lib "seaborn"
test_lib "kneed"
