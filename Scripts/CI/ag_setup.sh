#!/bin/bash

# A `realpath` alternative using the default C implementation.
filepath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

REPO_ROOT="$(dirname $(dirname $(dirname $(filepath $0))))"
DARWINPRIVATEFRAMEWORKS_FALLBACK_REVISION="b7e6ba165f3763dd477f55cc55b4a63f51385571"

clone_checkout_ag() {
  cd $REPO_ROOT
  if ! revision=$(Scripts/CI/get_revision.sh darwinprivateframeworks 2>/dev/null); then
    revision="$DARWINPRIVATEFRAMEWORKS_FALLBACK_REVISION"
    echo "No pinned revision for DarwinPrivateFrameworks, using fallback revision: $revision"
  fi
  cd ..
  if [ ! -d DarwinPrivateFrameworks ]; then
    gh repo clone OpenSwiftUIProject/DarwinPrivateFrameworks
    cd DarwinPrivateFrameworks
  else
    echo "DarwinPrivateFrameworks already exists, skipping clone."
    cd DarwinPrivateFrameworks
    git fetch --all --quiet
    git stash --quiet || true
    git reset --hard --quiet origin/main
  fi
  if [ -n "$revision" ]; then
    git checkout --quiet "$revision"
  fi
}

clone_checkout_ag
