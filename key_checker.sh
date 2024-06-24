#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo -e "\nUsage: $0 <key_to_check>\n"
  echo -e "Example:"
  echo -e " ./key_checker.sh AIzaSyBoLkjS3zdlqscfqv2scaB-IOe98QRadsc"
  exit 0
fi

check_key() {
  local api_key="$1"
  local data='{"longDynamicLink": "https://sub.example.com/?link=https://example.org"}'
  response=$(curl -s -X POST "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$api_key" -H 'Content-Type: application/json' -d "$data")
  if [[ $response!= *"API key not valid"* ]]; then
    echo "[+] Your Firebase api key is valid"
    exit 0
  else
    exit 1
  fi
}

check_key "$1"
