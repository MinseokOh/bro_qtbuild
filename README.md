## Bitrad.io Install&Build Shell

![alt text](https://chainz.cryptoid.info/logo/bro.png)

You can find Bitrad.io documents from [Bitrad.io Github](https://github.com/thebitradio/Bitradio/tree/master/doc)

System Requirements

 * Ubuntu 16.04 x64
 * Minimum Storage 10GB
 * Minimum Memory 2GB

## Commands

```sh
#install wallet

git clone https://github.com/MinseokOh/bro_qtbuild.git
cd bro_qtbuild
bash bro.sh install

#run wallet 

cd bro_qtbuild
bash bro.sh run

#stop wallet

cd bro_qtbuild
bash bro.sh stop

$update wallet

cd bro_qtbuild
bash bro.sh update
```

## Edit conf

Open conf file 
```sh
vi ./.Bitradio/Bitradio.conf
```

Paste conf
```sh
rpcuser=[rpcusername]
rpcpassword=[rpcpassword]
rpcallowip=127.0.0.1
daemon=1
server=1
listen=1
masternode=1
masternodeprivkey=[masternodegenkey]
externalip=[serverip]
```

that's all! enjoy masternode 
