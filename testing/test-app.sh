#!/bin/bash

NAMESPACE=${1:-student-10}

echo "Testing app availability..."

# node external address
ADDRESS=$(kubectl -n "$NAMESPACE" get node -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')

# frontend service NodePort
PORT=$(kubectl -n "$NAMESPACE" get svc frontend -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null)

# port-forward if NodePort not available
if [ -z "$PORT" ]; then
    echo "NodePort not found, trying port-forward method..."
    kubectl -n "$NAMESPACE" port-forward svc/frontend 8080:8080 &
    PF_PID=$!
    sleep 5
    
    URL="localhost:8080/healthz"
    RESULT=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL" --max-time 10)
    
    kill $PF_PID 2>/dev/null
else
    URL="$ADDRESS:$PORT/healthz"
    RESULT=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL" --max-time 10)
fi

echo "Testing URL: $URL"
echo "HTTP Status: $RESULT"

if [ "$RESULT" = "200" ]; then
    echo "Successfully connected to application"
    exit 0
else
    echo "Failed to connect to application (HTTP $RESULT)"
    exit 1
fi