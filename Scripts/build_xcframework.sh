#!/bin/bash
  
# Script modified from https://docs.emergetools.com/docs/analyzing-a-spm-framework-ios

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

PROJECT_BUILD_DIR="${PROJECT_BUILD_DIR:-"${PROJECT_ROOT}/build"}"
XCODEBUILD_BUILD_DIR="$PROJECT_BUILD_DIR/xcodebuild"
XCODEBUILD_DERIVED_DATA_PATH="$XCODEBUILD_BUILD_DIR/DerivedData"

# Copy and modify modulemap
mkdir -p "$PROJECT_BUILD_DIR"
cat > "$PROJECT_BUILD_DIR/module.modulemap" << 'EOF'
framework module OpenAttributeGraph {
  umbrella header "OpenAttributeGraph-umbrella.h"
  export *
  module * { export * }
}
EOF

# Parse arguments
DEBUG_INFO=false
PACKAGE_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --debug-info)
            DEBUG_INFO=true
            shift
            ;;
        *)
            if [ -z "$PACKAGE_NAME" ]; then
                PACKAGE_NAME="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$PACKAGE_NAME" ]; then
    echo "No package name provided. Using the first scheme found in the Package.swift."
    PACKAGE_NAME=$(xcodebuild -list | awk 'schemes && NF>0 { print $1; exit } /Schemes:$/ { schemes = 1 }')
    echo "Using: $PACKAGE_NAME"
fi

echo "Building xcframework for package: $PACKAGE_NAME contains debug info: $DEBUG_INFO"

build_framework() {
    local sdk="$1"
    local destination="$2"
    local scheme="$3"

    local XCODEBUILD_ARCHIVE_PATH="./build/$scheme-$sdk.xcarchive"

    rm -rf "$XCODEBUILD_ARCHIVE_PATH"

    xcodebuild archive \
        -scheme $scheme \
        -archivePath $XCODEBUILD_ARCHIVE_PATH \
        -derivedDataPath "$XCODEBUILD_DERIVED_DATA_PATH" \
        -sdk "$sdk" \
        -destination "$destination" \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        INSTALL_PATH='Library/Frameworks' \
        OTHER_SWIFT_FLAGS=-no-verify-emitted-module-interface

    if [ "$sdk" = "macosx" ]; then
        FRAMEWORK_MODULES_PATH="$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Versions/Current/Modules"
        FRAMEWORK_HEADERS_PATH="$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Versions/Current/Headers"
        mkdir -p "$FRAMEWORK_MODULES_PATH"
        mkdir -p "$FRAMEWORK_HEADERS_PATH"
        cp -r \
        "$XCODEBUILD_DERIVED_DATA_PATH/Build/Intermediates.noindex/ArchiveIntermediates/$scheme/BuildProductsPath/Release/$scheme.swiftmodule" \
        "$FRAMEWORK_MODULES_PATH/$scheme.swiftmodule"
        # Replace OpenAttributeGraphCxx with OpenAttributeGraph in swiftinterface files
        find "$FRAMEWORK_MODULES_PATH/$scheme.swiftmodule" -name "*.swiftinterface" -exec sed -i '' 's/OpenAttributeGraphCxx/OpenAttributeGraph/g' {} \;
        cp -r \
        "$PROJECT_ROOT/Sources/OpenAttributeGraphCxx/include/OpenAttributeGraph"/* \
        "$FRAMEWORK_HEADERS_PATH/" 2>/dev/null || true
        cp "$PROJECT_BUILD_DIR/module.modulemap" \
        "$FRAMEWORK_MODULES_PATH/module.modulemap" 2>/dev/null || true
        rm -rf "$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Modules"
        rm -rf "$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Headers"
        ln -s Versions/Current/Modules "$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Modules"
        ln -s Versions/Current/Headers "$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Headers"
    else
        FRAMEWORK_MODULES_PATH="$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Modules"
        FRAMEWORK_HEADERS_PATH="$XCODEBUILD_ARCHIVE_PATH/Products/Library/Frameworks/$scheme.framework/Headers"
        mkdir -p "$FRAMEWORK_MODULES_PATH"
        mkdir -p "$FRAMEWORK_HEADERS_PATH"
        cp -r \
        "$XCODEBUILD_DERIVED_DATA_PATH/Build/Intermediates.noindex/ArchiveIntermediates/$scheme/BuildProductsPath/Release-$sdk/$scheme.swiftmodule" \
        "$FRAMEWORK_MODULES_PATH/$scheme.swiftmodule"
        # Replace OpenAttributeGraphCxx with OpenAttributeGraph in swiftinterface files
        find "$FRAMEWORK_MODULES_PATH/$scheme.swiftmodule" -name "*.swiftinterface" -exec sed -i '' 's/OpenAttributeGraphCxx/OpenAttributeGraph/g' {} \;
        cp -r \
        "$PROJECT_ROOT/Sources/OpenAttributeGraphCxx/include/OpenAttributeGraph"/* \
        "$FRAMEWORK_HEADERS_PATH/" 2>/dev/null || true
        cp "$PROJECT_BUILD_DIR/module.modulemap" \
        "$FRAMEWORK_MODULES_PATH/module.modulemap" 2>/dev/null || true
    fi
    
    # Delete private and package swiftinterface
    rm -f "$FRAMEWORK_MODULES_PATH/$scheme.swiftmodule/*.package.swiftinterface"
    rm -f "$FRAMEWORK_MODULES_PATH/$scheme.swiftmodule/*.private.swiftinterface"
}

build_framework "iphonesimulator" "generic/platform=iOS Simulator" "$PACKAGE_NAME"
build_framework "iphoneos" "generic/platform=iOS" "$PACKAGE_NAME"
build_framework "macosx" "generic/platform=macOS" "$PACKAGE_NAME"

echo "Builds completed successfully."

cd $PROJECT_BUILD_DIR

rm -rf "$PACKAGE_NAME.xcframework"

if [ "$DEBUG_INFO" = true ]; then
    echo "Creating xcframework with debug symbols..."
    xcodebuild -create-xcframework  \
        -framework $PACKAGE_NAME-iphonesimulator.xcarchive/Products/Library/Frameworks/$PACKAGE_NAME.framework \
        -debug-symbols "$(realpath $PACKAGE_NAME-iphonesimulator.xcarchive/dSYMs/$PACKAGE_NAME.framework.dSYM)" \
        -framework $PACKAGE_NAME-iphoneos.xcarchive/Products/Library/Frameworks/$PACKAGE_NAME.framework \
        -debug-symbols "$(realpath $PACKAGE_NAME-iphoneos.xcarchive/dSYMs/$PACKAGE_NAME.framework.dSYM)" \
        -framework $PACKAGE_NAME-macosx.xcarchive/Products/Library/Frameworks/$PACKAGE_NAME.framework \
        -debug-symbols "$(realpath $PACKAGE_NAME-macosx.xcarchive/dSYMs/$PACKAGE_NAME.framework.dSYM)" \
        -output $PACKAGE_NAME.xcframework
else
    xcodebuild -create-xcframework  \
        -framework $PACKAGE_NAME-iphonesimulator.xcarchive/Products/Library/Frameworks/$PACKAGE_NAME.framework \
        -framework $PACKAGE_NAME-iphoneos.xcarchive/Products/Library/Frameworks/$PACKAGE_NAME.framework \
        -framework $PACKAGE_NAME-macosx.xcarchive/Products/Library/Frameworks/$PACKAGE_NAME.framework \
        -output $PACKAGE_NAME.xcframework
fi