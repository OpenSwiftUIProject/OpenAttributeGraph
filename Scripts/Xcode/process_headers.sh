#!/bin/sh

set -e

# Post-process headers: replace #include <OpenAttributeGraphCxx/...> with #include <OpenAttributeGraph/...>
# Uses Xcode's SCRIPT_INPUT_FILE_LIST_* and SCRIPT_OUTPUT_FILE_LIST_* for sandbox compatibility

if [ "$SCRIPT_INPUT_FILE_LIST_COUNT" -eq 0 ]; then
    echo "error: No input file list specified"
    exit 1
fi

if [ "$SCRIPT_OUTPUT_FILE_LIST_COUNT" -eq 0 ]; then
    echo "error: No output file list specified"
    exit 1
fi

count=0

# Process input and output file lists line by line
while IFS= read -r input_file <&3 && IFS= read -r output_file <&4; do
    # Skip empty lines (skip both to keep lists in sync)
    [ -z "$input_file" ] && continue
    [ -z "$output_file" ] && continue

    # Create output directory if needed
    mkdir -p "$(dirname "$output_file")"

    # Replace #include <OpenAttributeGraphCxx/...> with #include <OpenAttributeGraph/...>
    sed 's|#include <OpenAttributeGraphCxx/|#include <OpenAttributeGraph/|g' "$input_file" > "$output_file"

    echo "Processed: $(basename "$input_file") -> $(basename "$output_file")"
    count=$((count + 1))
done 3< "$SCRIPT_INPUT_FILE_LIST_0" 4< "$SCRIPT_OUTPUT_FILE_LIST_0"

echo "Processed $count headers"
