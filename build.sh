#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

build_type=Release
run_tests=false
tag_only=false
build_requested=false
while getopts ":bt:uT" option; do
    case "$option" in
        b) build_requested=true ;;
        t) build_type="$OPTARG"; build_requested=true ;;
        u) run_tests=true ;;
        T) tag_only=true ;;
        :) echo "Option -$OPTARG requires a value." >&2; exit 2 ;;
        *) echo "Usage: ./build.sh [-b] [-t Release|Debug|RelWithDebInfo] [-u] | ./build.sh -T" >&2; exit 2 ;;
    esac
done
shift "$((OPTIND - 1))"
if (( $# != 0 )); then
    echo "Unexpected arguments: $*" >&2
    exit 2
fi
if [[ "$tag_only" == true ]]; then
    if [[ "$build_requested" == true || "$run_tests" == true ]]; then
        echo "-T must be used alone." >&2
        exit 2
    fi
    exec bash scripts/tag-version.sh
fi
case "$build_type" in
    Release|Debug|RelWithDebInfo) ;;
    *) echo "Unsupported build type: $build_type" >&2; exit 2 ;;
esac

cmake -S . -B build -DCMAKE_BUILD_TYPE="$build_type"
cmake --build build --parallel
if [[ "$run_tests" == true ]]; then
    ctest --test-dir build --output-on-failure --no-tests=error
fi
