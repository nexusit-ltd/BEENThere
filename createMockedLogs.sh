#!/bin/bash

# File path to append the date and time
file_path="./mocked.log"

while true; do
  # Get the current date and time
  current_date=$(date +"%Y-%m-%d")
  current_time=$(date +"%H:%M:%S")

  # Append the date and time to the file
  echo "$current_date $current_time -- INFO -- LOCATION_REPORT: { \"witnessId\": \"XX\", \"ids\": ["", "", ""] }" >> "$file_path"

  sleep 1  # Wait for 1 second
done
