#!/usr/bin/env bash

TUIST_REPOSITORY_ROOT="$(
    cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1
    pwd -P
)"

tuist_ci_setup() (
    set -e

    cd "$TUIST_REPOSITORY_ROOT"
    mise trust mise.toml
    mise install
    mise exec -- tuist auth login
)

tuist_xcodebuild() (
    set -e

    if [[ $# -lt 2 ]]; then
        echo "Usage: tuist_xcodebuild <result-bundle.xcresult> <action> [arguments ...]" >&2
        return 64
    fi

    local result_bundle_path="$1"
    local action="$2"
    shift 2

    if [[ -z "$result_bundle_path" || "$result_bundle_path" != *.xcresult ]]; then
        echo "Tuist result bundle path must end in .xcresult: $result_bundle_path" >&2
        return 64
    fi

    if [[ "$result_bundle_path" != /* ]]; then
        result_bundle_path="$PWD/$result_bundle_path"
    fi

    rm -rf "$result_bundle_path"
    # Keep local compilation artifacts outside temporary CI build directories.
    mise exec -- tuist xcodebuild "$action" \
        -resultBundlePath "$result_bundle_path" \
        "$@" \
        COMPILATION_CACHE_ENABLE_CACHING=YES \
        COMPILATION_CACHE_CAS_PATH="$HOME/Library/Developer/Xcode/DerivedData/CompilationCache.noindex" \
        COMPILATION_CACHE_KEEP_CAS_DIRECTORY=YES \
        COMPILATION_CACHE_REMOTE_SERVICE_PATH= \
        COMPILATION_CACHE_ENABLE_PLUGIN=NO
)
