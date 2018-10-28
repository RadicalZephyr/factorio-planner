#!/usr/bin/env bash

set -e

mv -v ~/.factorio/script-output/recipes.json recipes-out.json

jq -c '.' < recipes-out.json > recipes.min.json
jq    '.' < recipes-out.json > recipes.json

rm recipes-out.json
