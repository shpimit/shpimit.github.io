---
layout: page
title: Hyperledger 1.4.1 in NCIA Education
summary: Hyperledger is space to learn Blockchain with GO Language
categories: GO
tags: GO
featured-img: block
comments: NIPA
---

# Introducing Hyperledger Fabric 1.4.1 !!

#####  Hyperledger is space to learn Blockchain with GO Language.

---

## Contents

## Table of Contents

|No|Titile|Remarks|
|--:|:-:|:--|
|0|[환경설정](#install)|Hyperledger 환경셋팅|
|1|[커리큘럼](#Syllabus)|커리큘럼 |
|2|[실습](#Practice)|실습|

---

## Install

### 1. Curl, Docker 설치
```shell
* sudo apt-get install curl     # url에서 copy 해옴
* sudo apt install docker.io
* sudo apt install docker-compose
* sudo apt install software-properties-common
* sudo usermod -aG docker $USER # 현재 접속중인 사용자에게 권한주기
```

### 2. Node.js 설치
```shell
* sudo apt-get update
* sudo apt-get install build-essential libssl-dev
* curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh
* bash install_nvm.sh
* source ~/.profile
* nvm install v8.11.1
```

### 3. Go 언어 설치
```shell
* curl -O https://storage.googleapis.com/golang/go1.11.2.linux-amd64.tar.gz
* tar -xvf go1.11.2.linux-amd64.tar.gz
* sudo mv go /usr/local
* sudo ln -s /usr/local/go/bin/go /usr/local/bin/go
* vi ~/.profile
* export GOPATH=$HOME/go
* export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
* source ~/.profile
```
### 4. Python, Git 설치
```shell
* sudo apt install -y python
* sudo apt install -y git
```

### 5. Fabric Sample 설치, Docker Image 설치
```shell
# curl -sSL http://bit.ly/2ysbOFE | bash -s -- <fabric_version> <fabric-ca_version> <thirdparty_version>
* sudo curl -sSL http://bit.ly/2ysbOFE | bash -s -- 1.4.1 1.4.1 0.4.15  # 1.4.1 을 명시하지 않으면 가장 최신 버전을 가져옴. 안될때 sudo bash -s
* vi ~/.profile
* export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:~/fabric-samples/bin
* source ~/.profile
```

--

## Sample Fabric

### 0. Docker 사용법

```shell
docker ps -a                             # 사용중인 docker
docker rm -f $(docker ps -aq)            # 사용중인 docker 지우기   -q는 id만 가져오겠다.
docker images dev-*                      # 사용중인 docker image
docker rmi -f $(docker images dev-* -q)  # 사용중인 docker image 지우기
docker network ls                        # 사용중인 network 확인하기  3개는 기본으로 떠 있어야 한다.
docker network prune                     # 사용중인 Network 지우기
```

### 1. fabcar

```shell
cd ~/fabric-samples/basic_network
./stop.sh
./teardown.sh

cd ~/fabric-samples/fabcar
./startFabric.sh                                            # Fabcar 구동 script
cd ~/fabric-samples/fabcar/javascript
/fabric-samples/fabcar/javascript/npm install               # Node js 관련 파일 설치 package.json
sudo apt install tree
~/fabric-samples/fabcar/javascript
~/fabric-samples/fabcar/javascript/node enrollAdmin.js      # node 라는 명령어로.. node.js 파일 실행시킴
~/fabric-samples/fabcar/javascript/tree wallet
~/fabric-samples/fabcar/javascript/node registerUser.js
~/fabric-samples/fabcar/javascript/node query.js
```

### 2. Couch DB 조회
```shell
localhost:5984/_utils
```

### 3. 사용중인 것 지우기
```shell
.fabcar/teardown.sh
```


### 4. Dapp Fabcar
```shell
cd fabcar
cd javascript
git clone https://github.com/saarc/fabric-front-end.git
cd fabric-front-end
npm install
cp -R ../wallet ./
node server.js
```
* VirtualBox PortFowarding 작업 필요


### 5. [Commercial paper tutorial](https://hyperledger-fabric.readthedocs.io/en/release-1.4/tutorial/commercial_paper.html)
* Create Network

```shell
$ cd fabric-samples/basic-network
$ ./start.sh
$ docker network inspect net_basic
```

* Working as MagnetoCorp
```shell
(magnetocorp admin)$ cd commercial-paper/organization/magnetocorp/configuration/cli/
(magnetocorp admin)$ ./monitordocker.sh net_basic
```
* 새로운 터미널을 띄워서
```shell
(magnetocorp admin)$ cd commercial-paper/organization/magnetocorp/configuration/cli/
(magnetocorp admin)$ docker-compose -f docker-compose.yml up -d cliMagnetoCorp
```

* Smart contract
```shell
(magnetocorp developer)$ cd commercial-paper/organization/magnetocorp/contract
(magnetocorp developer)$ code .
```

* Install contract
```shell
(magnetocorp admin)$ docker exec cliMagnetoCorp peer chaincode install -n papercontract -v 0 -p /opt/gopath/src/github.com/contract -l node
```
* Instantiate contract
```shell
(magnetocorp admin)$ docker exec cliMagnetoCorp peer chaincode instantiate -n papercontract -v 0 -l node -c '{"Args":["org.papernet.commercialpaper:instantiate"]}' -C mychannel -P "AND ('Org1MSP.member')"
(magnetocorp admin)$ docker ps
```

* Application structure
  -  `addToWallet.js` is the program that Isabella is going to use to load her identity into her wallet.
```shell
(magnetocorp user)$ cd commercial-paper/organization/magnetocorp/application/
(magnetocorp user)$ cd commercial-paper/organization/magnetocorp/application
 npm install
(isabella)$ node addToWallet.js
(isabella)$ tree ../identity/user/isabella/wallet/
```

* Issue application
```shell
node issue.js
```

* Working as DigiBank
```shell
(digibank admin)$ cd commercial-paper/organization/digibank/configuration/cli/
(digibank admin)$ docker-compose -f docker-compose.yml up -d cliDigiBank
```

* Digibank applications
```shell
(balaji)$ cd commercial-paper/organization/digibank/application/
(balaji)$ code buy.js
```

* Run as DigiBank
```shell
(digibank admin)$ cd commercial-paper/organization/digibank/application/
(digibank admin)$ npm install
(balaji)$ node addToWallet.js
```

* Buy application
```shell
(balaji)$ node buy.js
```

```shell
(balaji)$ node redeem.js
```

* mycc
```shell
$ cd fabric-samples/chaincode
$ mkdir mycc
cd mycc
code .  # mycc.go
Ctrl+~
go get -u "github.com/hyperledger/fabric/core/chaincode/shim"
go get -u "github.com/hyperledger/fabric/protos/peer"
go build   # go compile 하는 법
go version
```

* basic-network 가동
```shell
$ cd ../../basic-network/
$ ./start.sh
```

* cli 
```shell
$  docker-compose -f docker-compose.yml up -d cli
$ docker exec -it cli bash
# install
root@2f9f2dd49c99:/opt/gopath/src/github.com/hyperledger/fabric/peer#peer chaincode install -n mycc -v 1 -p github.com/mycc
root@2f9f2dd49c99:/opt/gopath/src/github.com/hyperledger/fabric/peer#peer chaincode list --installed # 등록된 chaincode 확인 
# instantiate
peer chaincode instantiate -n mycc -v 1 -C mychannel -c '{"Args":["a","100"]}' -P 'OR ("Org1MSP.member")'
peer chaincode list --instantiated -C mychannel # 어느 channel에 instantiated 되었는지 확인
# 데이터를 만들어 봄 invoke
peer chaincode invoke -n mycc -C mychannel -c '{"Args":["set","b","200"]}'  # peer chaincode invoke 명령어 Invoke호출
# Data를 조회함
peer chaincode query -n mycc -C mychannel -c '{"Args":["get","a"]}'         # peer chaincode query 명령어 Data 호출
```

* WebServer
```shell
~/fabric-samples/fabcar$ cd javascript
~/fabric-samples/fabcar/javascript$ cp package.json *.js ../application
cd ../application/
node enrollAdmin.js
node registerUser.js
node invoke.js
node query.js
```

# w3schools.com


## Private Data
* Private는 orderer를 사용하지 않고 private를 직접 Peer한테 전송함
```shell
$ ~/fabric-samples/chaincode/marbles02_private/code collections_config.json
```
```json
[
 {
   "name": "collectionMarbles",
   "policy": "OR('Org1MSP.member', 'Org2MSP.member')",
   "requiredPeerCount": 0,
   "maxPeerCount": 3,
   "blockToLive":1000000,  # 0로 나두면 private data를 삭제 하지 않겠다.
   "memberOnlyRead": true
},
 {
   "name": "collectionMarblePrivateDetails",
   "policy": "OR('Org1MSP.member')",
   "requiredPeerCount": 0,
   "maxPeerCount": 3,       # Private는 orderer를 사용하지 않고 private를 직접 Peer한테 전송함
   "blockToLive":3,         # 몇개의 block이 생성된 후 삭제 가능 할수 있다. ex) 네트웍크 timeToLive
   "memberOnlyRead": true   # 멤버만 읽을수 있도록 조치함.
 }
]
```
* First Network 가동
```shell
./byfn.sh up -c mychannel -s couchdb  # -s statedb에 대한 option
```
```shell
docker exec -it cli bash # -it keyboard를 통해서 입력을 받겠다.  환경변수 하면서..... 다른 peer도 선해

# 체인코드 설치   환경변수 하면서..... 다른 peer도 선해
root@260f8b66d769:/opt/gopath/src/github.com/hyperledger/fabric/peer#

export CORE_PEER_LOCALMSPID=Org2MSP

export PEER0_ORG2_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp

export CORE_PEER_ADDRESS=peer0.org2.example.com:9051
```
* chaincode Instantiate
```shell
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C mychannel -n marblesp -v 1.0 -c '{"Args":["init"]}' -P "OR('Org1MSP.member','Org2MSP.member')" --collections-config  $GOPATH/src/github.com/chaincode/marbles02_private/collections_config.json   # --collections-config    collections_config.json파일을 사용옵션
```
* Cli org1로 연결...private data 쓰기 위해
```shell
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

export CORE_PEER_LOCALMSPID=Org1MSP

export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

export PEER0_ORG1_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt



export MARBLE=$(echo -n "{\"name\":\"marble1\",\"color\":\"blue\",\"size\":35,\"owner\":\"tom\",\"price\":99}" | base64 | tr -d \\n)

peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["initMarble"]}'  --transient "{\"marble\":\"$MARBLE\"}"
```
* Read marble
```shell
peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarble","marble1"]}'
```

* Read org1에서만 저장 가능한 데이터 
```shell
peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarblePrivateDetails","marble1"]}'
```

* [couchDB 접근](http://localhost:5984/_utils)   # docker-composer.yaml couchdb id/pw 입력 받께끔 처리 해야 함.
```
Click mychannel_marblesp$$pcollection$marbles
Click mychannel_marblesp$$pcollection$marble$private$details
```
