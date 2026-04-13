#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

DOCKER="${DOCKER:-docker}"
IMAGE_TAG="${IMAGE_TAG:-x-directory-size-inventory-build}"
DOCKERFILE="${DOCKERFILE:-$ROOT/Dockerfile}"

"$DOCKER" build -f "$DOCKERFILE" -t "$IMAGE_TAG" "$ROOT"

mkdir -p "$ROOT/dist"
CID="$("$DOCKER" create "$IMAGE_TAG")"
cleanup() { "$DOCKER" rm -f "$CID" >/dev/null 2>&1 || true; }
trap cleanup EXIT

"$DOCKER" cp "$CID:/out/x-directory-size-inventory.jar" "$ROOT/dist/x-directory-size-inventory.jar"

echo "Output: $ROOT/dist/x-directory-size-inventory.jar"
