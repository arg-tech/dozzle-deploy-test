#!/bin/bash

[[ -z "$SECRETS" ]] && { echo "No secrets specified, skipping step" ; exit 0; }

mkdir -p .secrets && cd "$_"

i=1
while secret=$(echo "$SECRETS" | cut -d "&" -f $i) ; [ -n "$secret" ] ;do
    i=$((i+1))

    key=$(echo "$secret" | cut -d "=" -f 1)
    value=$(echo "$secret" | cut -d "=" -f 2)

    echo "$value" > "$key"
done
