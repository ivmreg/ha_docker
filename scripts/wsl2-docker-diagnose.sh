#!/usr/bin/env bash
set -euo pipefail

# Simple diagnostic helper for Docker inside WSL2
if ! command -v docker >/dev/null 2>&1; then
    echo "docker command not found. Ensure Docker Desktop or dockerd is available inside WSL2." >&2
    exit 1
fi

echo "Docker information:" >&2
docker info --format '{{json .}}' | jq '.' 2>/dev/null || docker info

echo
printf "Docker contexts:\n" >&2
docker context ls
