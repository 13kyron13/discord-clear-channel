#!/bin/bash

set -e

cd "$(dirname "$0")"

if [ ! -f .env ]; then
  echo "ERROR: .env not found. Copy .env.example to .env and fill it in."
  exit 1
fi

set -a
source .env
set +a

exec /usr/bin/python3 bot.py
