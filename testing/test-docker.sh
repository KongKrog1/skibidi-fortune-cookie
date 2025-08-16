#!/bin/bash

set -euo pipefail

echo "Testing Docker application availability..."

# test frontend
echo "Testing frontend..."
FRONTEND_URL="http://localhost:8080/healthz"
FRONTEND_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$FRONTEND_URL" --max-time 10)

echo "Frontend URL: $FRONTEND_URL"
echo "Frontend Status: $FRONTEND_STATUS"

if [ "$FRONTEND_STATUS" = "200" ]; then
    echo "Frontend health check passed"
else
    echo "Frontend health check failed (HTTP $FRONTEND_STATUS)"
    exit 1
fi

# test backend
echo "Testing backend..."
BACKEND_URL="http://localhost:9000/fortunes"
BACKEND_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$BACKEND_URL" --max-time 10)

echo "Backend URL: $BACKEND_URL"  
echo "Backend Status: $BACKEND_STATUS"

if [ "$BACKEND_STATUS" = "200" ]; then
    echo "Backend test passed"
else
    echo "Backend test failed (HTTP $BACKEND_STATUS)"
    exit 1
fi

echo "All Docker tests passed!"