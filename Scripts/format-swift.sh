#!/bin/bash
# Format staged or changed Swift files using SwiftFormat.
#
# Usage:
#   Scripts/format-swift.sh          # Format staged Swift files (pre-commit use)
#   Scripts/format-swift.sh --all    # Format all Swift files in the project
#   Scripts/format-swift.sh <file>   # Format specific file(s)

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"

if ! command -v swiftformat &>/dev/null; then
    echo "error: swiftformat is not installed. Run: brew install swiftformat" >&2
    exit 1
fi

if [ $# -eq 0 ]; then
    # Format staged Swift files
    files=$(git diff --cached --name-only --diff-filter=ACM | grep '\.swift$' || true)
    if [ -z "$files" ]; then
        # Fall back to unstaged changes
        files=$(git diff --name-only --diff-filter=ACM | grep '\.swift$' || true)
    fi
    if [ -z "$files" ]; then
        echo "No changed Swift files to format."
        exit 0
    fi
    echo "Formatting changed Swift files..."
    echo "$files" | while IFS= read -r file; do
        echo "  $file"
    done
    echo "$files" | xargs swiftformat --config "$REPO_ROOT/.swiftformat"
elif [ "$1" = "--all" ]; then
    echo "Formatting all Swift files..."
    swiftformat "$REPO_ROOT"
else
    echo "Formatting specified files..."
    swiftformat --config "$REPO_ROOT/.swiftformat" "$@"
fi
