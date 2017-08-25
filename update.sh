#!/bin/bash

ROOT=$(pwd)

pkill Bitradiod

pushd $ROOT/Bitradio/src
git pull
make -f makefile.unix # Headless
sudo cp Bitradiod /usr/local/bin
popd

Bitradiod
