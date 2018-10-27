#!/usr/bin/env bash

set -e

cat ~/.factorio/script-output/recipes.json | sed 's/\n/\n/g' > recipes-out.json

rm ~/.factorio/script-output/recipes.json

jq -c '.' < recipes-out.json > recipes.min.json
jq    '.' < recipes-out.json > recipes.json
rm recipes-out.json
