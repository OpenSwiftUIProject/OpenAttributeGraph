#!/bin/bash

# A `realpath` alternative using the default C implementation.
filepath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

REPO_ROOT="$(dirname $(dirname $(dirname $(filepath $0))))"
cd $REPO_ROOT

# Install Linux dependencies
apt-get update
apt-get install -y libssl-dev

Scripts/CI/compute_setup.sh