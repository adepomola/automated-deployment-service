#!/bin/bash

URL="http://localhost:8080"

if curl -f -s "$URL" > /dev/null; then
    echo "$(date): APPLICATION HEALTHY"
else
    echo "$(date): APPLICATION DOWN"
    exit 1
fi
