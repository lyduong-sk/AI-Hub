#!/bin/bash

# Email Writer Agent - Input Validation Script
# Validates required fields, tone enum, and injection patterns
# Usage: bash sanitize-input.sh [input_file] or cat input.json | bash sanitize-input.sh

set -e

# Read input from file or stdin
if [ $# -eq 1 ]; then
    input=$(cat "$1")
else
    input=$(cat)
fi

# Required fields
required_fields=("recipient" "subject" "purpose" "tone" "key_points" "sender_name")
valid_tones=("Professional" "Friendly" "Formal" "Apologetic" "Persuasive")

# Check if input is valid JSON
if ! echo "$input" | jq empty 2>/dev/null; then
    echo '{"valid": false, "error_message": "Invalid JSON format"}'
    exit 1
fi

# Check all required fields are present
for field in "${required_fields[@]}"; do
    if ! echo "$input" | jq -e ".$field" > /dev/null 2>&1; then
        echo "{\"valid\": false, \"error_message\": \"Missing required field: '$field'\"}"
        exit 1
    fi
done

# Extract tone value
tone=$(echo "$input" | jq -r '.tone')

# Validate tone enum
valid=false
for valid_tone in "${valid_tones[@]}"; do
    if [ "$tone" = "$valid_tone" ]; then
        valid=true
        break
    fi
done

if [ "$valid" = false ]; then
    valid_tones_str=$(IFS=' '; echo "${valid_tones[*]}")
    echo "{\"valid\": false, \"error_message\": \"Invalid tone value: '$tone'. Allowed values: $valid_tones_str\"}"
    exit 1
fi

# Extract purpose and key_points for injection detection
purpose=$(echo "$input" | jq -r '.purpose')
key_points=$(echo "$input" | jq -r '.key_points[]')

# Scan for injection patterns (case-insensitive)
injection_patterns=("ignore previous" "disregard" "system prompt" "act as" "you are now")

for pattern in "${injection_patterns[@]}"; do
    if echo "$purpose" | grep -iq "$pattern"; then
        echo "{\"valid\": false, \"error_message\": \"Injection pattern detected in purpose: '$pattern'\"}"
        exit 1
    fi

    if echo "$key_points" | grep -iq "$pattern"; then
        echo "{\"valid\": false, \"error_message\": \"Injection pattern detected in key_points: '$pattern'\"}"
        exit 1
    fi
done

# All validations passed
echo '{"valid": true}'
exit 0
