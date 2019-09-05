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
docker rm -f $(docker ps -aq)            # 사용중인 docker 지우기
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
* Redeem application
```shell
(balaji)$ node redeem.js
```
