#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential libtool automake autotools-dev autoconf pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils -y
sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler -y
sudo apt-get install libboost-all-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo apt-get install libqrencode-dev -y
sudo apt-get install make -y
sudo apt-get install make-guile -y

./install_db.sh

git clone https://github.com/thebitradio/Bitradio

cd Bitradio/src

sudo make -f makefile.unix # Headless
sudo cp Bitradiod /usr/local/bin

