#!/bin/bash
set -e

# This command is executed on the theme directory.
# Check the THEME_PATH variable on the .env file.

TASK=${1:-""}

if [ -z "$1" ]
then
  echo "Parametter TASK is required. Usage: make frontend dev"
  exit 1
fi

echo "Running ./scripts/frontend-build dev"
npm install
npm run $TASK
