#!/bin/bash

function bro_dependency() {
	echo "$(tput setaf 1)[INSTALL] BRO Dependency $(tput sgr0)"
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
	echo "$(tput setaf 1)[INSTALL] BRO Dependency Complete! $(tput sgr0)"	
}

function bro_db() {
	echo "$(tput setaf 1)[INSTALL] BRO DB $(tput sgr0)"
	pushd ~/
		BITRADIO_ROOT=$(pwd)

		# Pick some path to install BDB to, here we create a directory within the BITRADIO directory
		BDB_PREFIX="${BITRADIO_ROOT}/db4"
		mkdir -p $BDB_PREFIX

		# Fetch the source and verify that it is not tampered with
		wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
		echo '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef  db-4.8.30.NC.tar.gz' | sha256sum -c
		# -> db-4.8.30.NC.tar.gz: OK
		tar -xzvf db-4.8.30.NC.tar.gz

		# Build the library and install to our prefix
		cd db-4.8.30.NC/build_unix 0ak
		#  Note: Do a static build so that it can be embedded into the executable, instead of having to find a .so at runtime
		../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$BDB_PREFIX
		make install

		# Configure BITRADIO Core to use our own-built instance of BDB
		cd $BITRADIO_ROOT
		./autogen.sh
		./configure LDFLAGS="-L${BDB_PREFIX}/lib/" CPPFLAGS="-I${BDB_PREFIX}/include/" # (other args...)
	popd
	echo "$(tput setaf 1)[INSTALL] BRO DB Complete! $(tput sgr0)"	
}

function bro_install() {
	echo "$(tput setaf 1)[INSTALL] BRO MN $(tput sgr0)"	
	bro_dependency
	pushd ~/
		git clone https://github.com/thebitradio/Bitradio
		bro_db

		pushd ./Bitradio/src
			sudo make -f makefile.unix # Headless
			sudo cp Bitradiod /usr/local/bin
		popd
	popd
	echo "$(tput setaf 1)[INSTALL] BRO Complete! $(tput sgr0)"		
}

function bro_run() {
	echo '[RUN] Run BRO wallet'
	Bitradiod
}

function bro_stop() {
	echo '[STOP] Stop BRO wallet'
	pkill Bitradiod
}

function bro_update() {
	bro_stop
	git pull
	bro_install
	bro_run
}

function bro_conf() {
	echo "$HOME/.Bitradiod/Bitradio.conf"
}

COMMAND=$1

if [ "${COMMAND}" = "install" ]; then 
	bro_install
fi

if [ "${COMMAND}" = "run" ]; then 
	bro_run
fi

if [ "${COMMAND}" = "stop" ]; then 
	bro_stop
fi

if [ "${COMMAND}" = "update" ]; then 
	bro_update
fi
