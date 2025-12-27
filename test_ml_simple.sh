#!/bin/bash
curl -s -X POST "http://localhost:2358/submissions?base64_encoded=false" \
  -H "Content-Type: application/json" \
  -d '{"source_code":"import matplotlib\nmatplotlib.use(\"Agg\")\nimport numpy, pandas, sklearn, scipy, seaborn, kneed, sympy, networkx, mlxtend\nprint(\"All ML libs OK!\")\nprint(\"kneed:\", kneed.__version__)","language_id":10,"memory_limit":768000,"wall_time_limit":30}' | jq -r '.token' > /tmp/token.txt

sleep 5
curl -s "http://localhost:2358/submissions/$(cat /tmp/token.txt)" | jq -r '.stdout, .stderr, .status.description'
