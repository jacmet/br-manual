#!/bin/sh
# update buildroot manual for nightly.b.o
set -e

DOCKER=buildroot-manual:latest
REPO=https://gitlab.com/buildroot.org/buildroot.git

DIR=${0%/*}
GIT_DIR=$DIR/buildroot
TMP_DIR=$(mktemp -d)

trap "rm -rf $TMP_DIR" EXIT

if ! docker image inspect $DOCKER >/dev/null 2>&1; then
    cd $DIR/docker
    docker build -t $DOCKER .
fi

if [ ! -d $GIT_DIR ]; then
    git clone $REPO $GIT_DIR
fi

cd $GIT_DIR
git pull -q
cd $DIR

docker run --rm -u $(id -u):$(id -g) \
       -v $GIT_DIR:/buildroot:ro \
       -v $TMP_DIR:/output \
       $DOCKER

mkdir -p $DIR/www
mv $TMP_DIR/docs/manual/* $DIR/www/
