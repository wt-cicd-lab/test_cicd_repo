#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

build_type=Release
run_tests=false
while getopts ":bt:u" option; do
    case "$option" in
        b) ;;
        t) build_type="$OPTARG" ;;
        u) run_tests=true ;;
        :) echo "Option -$OPTARG requires a value." >&2; exit 2 ;;
        *) echo "Usage: ./build.sh [-b] [-t Release|Debug|RelWithDebInfo] [-u]" >&2; exit 2 ;;
    esac
done
shift "$((OPTIND - 1))"
if (( $# != 0 )); then
    echo "Unexpected arguments: $*" >&2
    exit 2
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
