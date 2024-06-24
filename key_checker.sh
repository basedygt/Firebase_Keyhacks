#!/bin/bash

if [[ $# -ne 1 && $# -ne 2 ]]; then
  echo -e "\nUsage: $0 <key_to_check> [<file_to_write_valid_key_to>]\n"
  echo -e "Example:"
  echo -e " ./key_checker.sh AIzaSyBoLkjS3zdlqscfqv2scaB-IOe98QRadsc output.txt"
  exit 0
fi

check_key() {
  local api_key="$1"
  local output_file="$2"
  local data='{"longDynamicLink": "https://sub.example.com/?link=https://example.org"}'
  response=$(curl -s -X POST "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$api_key" -H 'Content-Type: application/json' -d "$data")
  
  if [[ $response != *"API key not valid"* ]]; then
    echo "[+] Your Firebase API key $api_key is valid"
    if [[ -n $output_file ]]; then
      echo "[+] Saved to $output_file"
      echo "$api_key" > "$output_file"
    fi
    exit 0

  else
    echo "[+] Your Firebase API key $api_key is invalid"
    exit 1
  fi
}

check_key "$1" "$2"
