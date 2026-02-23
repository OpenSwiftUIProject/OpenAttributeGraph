#!/bin/zsh

# clone-swift.sh
#
# Adapted from https://github.com/jcmosc/Compute
#
# Copyright (c) 2024 James Moschou
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e

# Default values
CHECKOUT_PATH=".build/checkouts/swift"
SWIFT_VERSION=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
    --path)
        CHECKOUT_PATH="$2"
        shift 2
        ;;
    --swift-version)
        SWIFT_VERSION="$2"
        shift 2
        ;;
    *)
        echo "Unknown option: $1"
        echo "Usage: $0 [--path <path>] [--swift-version <major.minor>]"
        exit 1
        ;;
    esac
done

# Detect Swift version if not provided
if [ -z "$SWIFT_VERSION" ]; then
    SWIFT_VERSION=$(swift --version 2>/dev/null | grep -oE 'Swift version [0-9]+\.[0-9]+' | grep -oE '[0-9]+\.[0-9]+')
    echo "Detected Swift version: $SWIFT_VERSION"
fi

if [ -z "$SWIFT_VERSION" ]; then
    echo "Error: Could not detect Swift version. Please specify with --swift-version"
    exit 1
fi

SWIFT_VERSION_MAJOR=$(echo "$SWIFT_VERSION" | cut -d. -f1)
SWIFT_VERSION_MINOR=$(echo "$SWIFT_VERSION" | cut -d. -f2)

# Skip if checkout already exists with the expected header
if [ -f "$CHECKOUT_PATH/include/swift/Runtime/Metadata.h" ]; then
    echo "Swift headers already exist at $CHECKOUT_PATH, skipping clone."
    exit 0
fi

# Remove existing checkout if present
rm -rf "$CHECKOUT_PATH"
mkdir -p "$CHECKOUT_PATH"

# Clone with sparse checkout
git clone --filter=blob:none --no-checkout --depth 1 \
    --branch "release/$SWIFT_VERSION_MAJOR.$SWIFT_VERSION_MINOR" \
    https://github.com/swiftlang/swift.git "$CHECKOUT_PATH"

cd "$CHECKOUT_PATH"

git sparse-checkout set --no-cone \
    include/swift \
    stdlib/include \
    stdlib/public/SwiftShims \
    stdlib/public/runtime/MetadataAllocatorTags.def

git checkout

# Write CMakeConfig.h file
cat > include/swift/Runtime/CMakeConfig.h << EOF
#ifndef SWIFT_RUNTIME_CMAKECONFIG_H
#define SWIFT_RUNTIME_CMAKECONFIG_H
#define SWIFT_VERSION_MAJOR $SWIFT_VERSION_MAJOR
#define SWIFT_VERSION_MINOR $SWIFT_VERSION_MINOR
#endif
EOF

echo "The Swift repository has been cloned to $CHECKOUT_PATH"
