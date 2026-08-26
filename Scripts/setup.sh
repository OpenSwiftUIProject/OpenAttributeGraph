#!/usr/bin/env bash

set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
PROJECT_ROOT="$(dirname "$SCRIPTS_DIR")"
MISE_ARGS=()

usage() {
    printf '%s\n' \
        "Usage: $(basename "$0") [--compute]" \
        "" \
        "Options:" \
        "  --compute  Use mise.compute.toml while installing tools and generating the workspace."
}

run_mise() {
    if [[ ${#MISE_ARGS[@]} -gt 0 ]]; then
        mise "${MISE_ARGS[@]}" "$@"
    else
        mise "$@"
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --compute)
            MISE_ARGS=(--env compute)
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            usage >&2
            exit 2
            ;;
    esac
    shift
done

cd "$PROJECT_ROOT"
mise trust "$PROJECT_ROOT/mise.toml"
if [[ ${#MISE_ARGS[@]} -gt 0 ]]; then
    mise trust "$PROJECT_ROOT/mise.compute.toml"
fi
run_mise install
run_mise exec -- tuist install
run_mise exec -- tuist generate --no-open
