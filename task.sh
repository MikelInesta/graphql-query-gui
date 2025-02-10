#!/bin/bash

# Check if all required arguments are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Error: Missing arguments."
  echo "Usage: $0 '<time>' '<endpoint>' '<graphql_query>'"
  echo "Example: $0 '08:30' 'https://api.example.com/graphql' 'mutation { addUser_skills(user_id: \"282\", skill_id: \"2\", level: \"advanced\") { id } }'"
  exit 1
fi

# Parse the time input
TIME="$1"
HOUR=$(echo "$TIME" | cut -d':' -f1)
MINUTE=$(echo "$TIME" | cut -d':' -f2)

# Validate the time format
if ! [[ "$HOUR" =~ ^[0-9]+$ ]] || ! [[ "$MINUTE" =~ ^[0-9]+$ ]]; then
  echo "Error: Invalid time format. Use 'HH:MM'."
  exit 1
fi

if [ "$HOUR" -lt 0 ] || [ "$HOUR" -gt 23 ] || [ "$MINUTE" -lt 0 ] || [ "$MINUTE" -gt 59 ]; then
  echo "Error: Invalid time. Hour must be between 0 and 23, and minute between 0 and 59."
  exit 1
fi

# API endpoint and GraphQL query from arguments
ENDPOINT="$2"
QUERY="$3"

# Path to the run_graphql.sh script
SCRIPT_PATH="/path/to/run_graphql.sh"

# Log file path
LOG_FILE="/path/to/logfile.log"

# Add the job to the crontab
(crontab -l 2>/dev/null; echo "$MINUTE $HOUR * * * $SCRIPT_PATH '$ENDPOINT' '$QUERY' >> $LOG_FILE 2>&1") | crontab -

# Confirm the job was added
echo "Cron job added to run at $HOUR:$MINUTE daily."
echo "Endpoint: $ENDPOINT"
echo "Query: $QUERY"
