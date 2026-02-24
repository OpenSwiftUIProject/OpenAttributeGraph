#!/bin/bash

# A `realpath` alternative using the default C implementation.
filepath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

OPENATTRIBUTEGRAPH_ROOT="$(dirname $(dirname $(filepath $0)))"

cd $OPENATTRIBUTEGRAPH_ROOT

swift build -Xswiftc -emit-module-interface -Xswiftc -enable-library-evolution -Xswiftc -no-verify-emitted-module-interface
