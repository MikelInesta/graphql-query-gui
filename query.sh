#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: No GraphQL query provided."
  echo "Usage: $0 '<graphql_query>' '<api_endpoint>'"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Error: No endpoint provided."
  echo "Usage: $0 '<graphql_query>' '<api_endpoint>'"
  exit 1
fi

API_ENDPOINT="$2"

QUERY="$1"

curl -X POST \
  -H "Content-Type: application/json" \
  -d "{\"query\": \"$QUERY\"}" \
  "$API_URL"
