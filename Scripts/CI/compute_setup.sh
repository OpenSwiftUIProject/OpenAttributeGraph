#!/bin/bash

# A `realpath` alternative using the default C implementation.
filepath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

REPO_ROOT="$(dirname $(dirname $(dirname $(filepath $0))))"
cd $REPO_ROOT

clone_checkout_compute() {
  cd $REPO_ROOT
  revision=$(Scripts/CI/get_revision.sh compute)
  cd ..
  if [ ! -d Compute ]; then
    git clone https://github.com/jcmosc/Compute.git
    cd Compute
  else
    echo "Compute already exists, skipping clone."
    cd Compute
    git fetch --all --quiet
    git stash --quiet || true
    git reset --hard --quiet origin/main
  fi
  git checkout --quiet $revision
  git submodule update --init --recursive
}

clone_checkout_compute
