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
|0|[환경설정](#Install)|Hyperledger 환경셋팅|
|1|[교육과정](#Curriculum)|수업게시판|
|2|[실습](#Practice)|실습|

---

## Install

### 1. Curl, Docker 설치

> * apt : Ubuntu를 포함한 Debian 계열의 **리눅스에서 쓰이는 패키지 관리 명령어 도구**, APT(Advanced Packaging Tool) 
>```shell
>sudo apt-get install <패키지 이름>
>```
> * apt-get은 인덱스를 가지고 있는데 이 인덱스는 /etc/apt/sources.list 에 있으며 이곳에서 패키지의 저장소 정보를 얻게 된다. 
> * curl 은 command line 용 data transfer tool 이다. download/upload 모두 가능하며 HTTP/HTTPS/FTP/LDAP/SCP/TELNET/SMTP/POP3 등 주요한 프로토콜을 지원하며 Linux/Unix 계열 및 Windows 등 주요한 OS 에서 구동

```shell
* sudo apt-get install curl     # url에서 copy 해옴
* sudo apt install docker.io
* sudo apt install docker-compose
* sudo apt install software-properties-common
* sudo usermod -aG docker $USER # 현재 접속중인 사용자에게 권한주기
```

### 2. Node.js 설치
> * sudo apt-get upgrade : 설치되어 있는 패키지를 모두 새버전으로 업그레이드
>```shell
>sudo apt-get upgrade
>```
> * curl -o : curl 은 remote 에서 받아온 데이타를 기본적으로는 콘솔에 출력한다. -o 옵션 뒤에 FILE 을 적어주면 해당 FILE 로 저장한다. 
> * curl -s : --silent 진행 내역이나 메시지등을 출력하지 않는다. -o 옵션으로 remote data 도 /dev/null 로 보내면 결과물도 출력되지 않는다
> * curl -L : --location 서버에서 HTTP 301 이나 HTTP 302 응답이 왔을 경우 redirection URL 로 따라간다.
> * nvm : NVM은 여러 버전의 Node.js를 설치하고 관리하고 사용할 수 있게 해주는 **bash 스크립트 프로그램**, NVM (Node version manager) 

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

> * tree : 폴더의 하위 구조를 계층적으로 표시해 주는 유틸리티
```shell
* sudo apt install -y python
* sudo apt install -y git
* sudo apt install tree # tree 는 폴더의 하위 구조를 계층적으로 표시해 주는 유틸리티
```

### 5. Fabric Sample 설치, Docker Image 설치
```shell
# curl -sSL http://bit.ly/2ysbOFE | bash -s -- <fabric_version> <fabric-ca_version> <thirdparty_version>
* sudo curl -sSL http://bit.ly/2ysbOFE | bash -s -- 1.4.1 1.4.1 0.4.15  # 1.4.1 을 명시하지 않으면 가장 최신 버전을 가져옴. 안될때 sudo bash -s
* vi ~/.profile
* export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:~/fabric-samples/bin
* source ~/.profile
```

---

## Curriculum

### Table of Curriculum

|No|Title|Educational Institution|Lecturer|Day|Remarks|
|-:|:--:|:-:|:--:|:--:|:-|
|1|하이퍼레저 개론|NIPA|김기형교수님|Sep 2 2019|`fabcar`|
|2|하이퍼레저 개론 및 패브릭의 이해|NIPA|[김재훈교수](jaikim@ajou.ac.kr)|Sep 3 2019|`first network`|
|3|[DApp개발](ftp://202.30.3.201/hyper)|NIPA|[최광훈박사](https://github.com/saarc/class_material)|Sep 4 2019|`basic network`|
|4|프라이빗블록체인 활용|NIPA|[김재훈교수](jaikim@ajou.ac.kr)|Sep 5 2019|`commpercial paper`|
|5|프라이빗 데이터의 활용과 블록체인의 미래|NIPA|신운섭박사|Sep 6 2019|`Private Data`|

---

## Practice

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

#### 1.1 Basic Network 가동

* fabcar를 위한 basic_network 가동

```shell
$ cd ~/fabric-samples/basic_network
$ ./start.sh
$ ./stop.sh
```

##### 1.1.1 Application을 통해서 fabcar 체인코드를 접근

* basic network에 peer를 구성하고
* 1. Create the channel     -c mychannel
* 2. Join peer0.org1.example.com to the channel

```shell
$ cd ~/fabric-samples/fabcar
$ ./startFabric.sh  
```

#### 1.1.2 Node JS를 통해서 fabcar 접근

```shell
$ cd ~/fabric-samples/fabcar/javascript
```

> * `package.json`은 프로젝트에 대한 명세라고 할 수 있다. 해당 프로젝트의 이름, 버전, 사용되는 모듈 등의 스펙이 정해져 있으며, 이 package.json을 통해 모듈 의존성 모듈 관리도 진행할 수 있다. 
> * 만약 어떤 오픈 소스를 다운 받을 때 이 package.json만 있다면 해당 오픈 소스가 의존하고 있는 모듈이 어떤 것인지. 그리고 그 모듈들을 `npm install`로 한 번에 설치할 수 있다.

```json
# package.json 일부내용
    "dependencies": {
        "fabric-ca-client": "~1.4.0",
        "fabric-network": "~1.4.0"
    },
```
```shell
$ ~/fabric-samples/fabcar/javascript/npm install              # Node js 관련 파일 설치 package.json
$ ~/fabric-samples/fabcar/javascript/tree wallet
$ ~/fabric-samples/fabcar/javascript/node enrollAdmin.js      # node 라는 명령어로.. node.js 파일 실행시킴
$ ~/fabric-samples/fabcar/javascript/tree wallet
$ ~/fabric-samples/fabcar/javascript/node registerUser.js
$ ~/fabric-samples/fabcar/javascript/tree wallet
$ ~/fabric-samples/fabcar/javascript/node query.js            # 블록체인에서 쿼리로 조회해옴
```

#### 1.2. Couch DB 조회

* fabcar를 위한 Couch DB조회
> * VirtualBox에서 사용시에는 PortFowarding 작업 필요

```shell
localhost:5984/_utils
```

#### 1.3. 사용중인 것 지우기

```shell
$ cd ~/fabric-samples/basic_network
$ ./teardown.sh                          # docker 까지 모두 stop
```

#### 1.4. DApp Fabcar

> * npm의 경우는 Node Package Manager이기 때문에 node.js를 설치하면 같이 설치된다.
> * git clone [url] : Git 저장소를 복사하고 싶을 때 git clone 명령을 사용합니다

```shell
cd fabcar
cd javascript
git clone https://github.com/saarc/fabric-front-end.git
cd fabric-front-end
npm install
cp -R ../wallet ./    # Key 복사 필요  
node server.js   
```

### 2. [Commercial paper tutorial](https://hyperledger-fabric.readthedocs.io/en/release-1.4/tutorial/commercial_paper.html)
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

### 3. Basic Network + Node.js + Express + Ejs

#### 3.1  내 첫 chaincode 만들기( 프리랜서 IT 인력 마켓플레이스 )

```shell
$ cd fabric-samples/chaincode
$ cp -R sacc jobMP
$ cd jobMP
$ code .         # visudaul studio에서 mycc.go를 연다. Oracle Virtual Machine에서 가능
```

* Visual Studio Code
> Ctrl+~         # visual studio에서 터미널 여는 법

* Go Third Party Package
> go get 패키지명 명령 : 서드 파티 패키지를 내려 받고 설치할수 있다.
> go get -u 패키지명과 같이 -u 옵션을 주면 최신 버전 패키지를 내려받아서 다시 설치한다.

```shell
$fabric-samples/chaincode/jobMP/go get -u "github.com/hyperledger/fabric/core/chaincode/shim"
$fabric-samples/chaincode/jobMP/go get -u "github.com/hyperledger/fabric/protos/peer"
$fabric-samples/chaincode/jobMP/go build       # go compile 하는 법
$fabric-samples/chaincode/jobMP/go version
```

* basic-network 가동
```shell
$ cd ../../basic-network/
$ ./start.sh
```

* CLI 실행

> Docker compose : Docker 어플리케이션을 정의하고 멀티 컨테이너 어플리케이션을 실행시키기 위한 도구
> 여러개의 컨테이너를 1번의 명령으로 실행 시킬 수 있다. 
> docker exec : 외부에서 컨테이너에 특정 명령을 줄수 있습니다.
> ` docker exec [OPTIONS] CONTAINER COMMAND [ARG...] `

```shell
$ docker-compose -f docker-compose.yml up -d cli
$ docker exec -it cli bash
```

* Chaincode Install → Instantiate 

```shell
# install
root@2f9f2dd49c99:/opt/gopath/src/github.com/hyperledger/fabric/peer#peer chaincode install -n jobMP -v 1 -p github.com/jobMP
root@2f9f2dd49c99:/opt/gopath/src/github.com/hyperledger/fabric/peer#peer chaincode list --installed # 등록된 chaincode 확인 
# instantiate
peer chaincode instantiate -n jobMP -v 1 -C mychannel -c '{"Args":["a","100"]}' -P 'OR ("Org1MSP.member")'
peer chaincode list --instantiated -C mychannel # 어느 channel에 instantiated 되었는지 확인
# 데이터를 만들어 봄 invoke
peer chaincode invoke -n jobMP -C mychannel -c '{"Args":["set","b","200"]}'  # peer chaincode invoke 명령어 Invoke호출
# Data를 조회함
peer chaincode query -n jobMP -C mychannel -c '{"Args":["get","a"]}'         # peer chaincode query 명령어 Data 호출
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

```shell
cd fabcar
cd javascript
git clone https://github.com/saarc/fabric-front-end.git
cd fabric-front-end
npm install
cp -R ../wallet ./    # Key 복사 필요  
node server.js   
```

ubuntu@ip-172-31-28-94:~/fabric-samples$ mkdir jobMP
~/fabric-samples/fabcar$ cd javascript
cp package.json *.js ../../jobMP
cp -R ../../fabcar/javascript/wallet ./


# w3schools.com


## 3. Private Data
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

* [couchDB 접근](http://localhost:5984/_utils)   # docker-composer.yaml couchdb id/pw 입력 받께끔 처리 해야 함. fist-network는 이름이 다름
```
Click mychannel_marblesp$$pcollection$marbles
Click mychannel_marblesp$$pcollection$marble$private$details
```

* Private 권한확인
```shell
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

export CORE_PEER_LOCALMSPID=Org1MSP

export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

export PEER0_ORG1_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarble","marble1"]}'
peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarblePrivateDetails","marble1"]}'


# org2에서..가져올때
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051

export CORE_PEER_LOCALMSPID=Org2MSP

export PEER0_ORG2_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp



peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarble","marble1"]}'

peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarblePrivateDetails","marble1"]}'
```
* 자동삭제 기능
```shell
# org1으로 새로운 block을 생성하기위해
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

export CORE_PEER_LOCALMSPID=Org1MSP

export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

export PEER0_ORG1_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

```

* docker를 이용해서 로그 확인
```shell
bstudent@saarc-VirtualBox$ docker logs peer0.org1.example.com 2>&1 | grep -i -a -E 'private|pvt|privdata'
```

* marble 추가 생성
```shell
export MARBLE=$(echo -n "{\"name\":\"marble2\",\"color\":\"blue\",\"size\":35,\"owner\":\"tom\",\"price\":99}" | base64 | tr -d \\n)



peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["initMarble"]}' --transient "{\"marble\":\"$MARBLE\"}" 


```

* owner 정보 변경(block 생성, 3번)
```shell
export MARBLE_OWNER=$(echo -n "{\"name\":\"marble2\",\"owner\":\"tom\"}" | base64 | tr -d \\n)

peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["transferMarble"]}' --transient "{\"marble_owner\":\"$MARBLE_OWNER\"}"

export MARBLE_OWNER=$(echo -n "{\"name\":\"marble2\",\"owner\":\"joe\"}" | base64 | tr -d \\n)

peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["transferMarble"]}' --transient "{\"marble_owner\":\"$MARBLE_OWNER\"}"

export MARBLE_OWNER=$(echo -n "{\"name\":\"marble2\",\"owner\":\"jerry\"}" | base64 | tr -d \\n)

peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["transferMarble"]}' --transient "{\"marble_owner\":\"$MARBLE_OWNER\"}"


```

* 확인 Private Data 삭제
```shell
$ peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarblePrivateDetails","marble1"]}'
결과 : Error: endorsement failure during query. response: status:500 message:"{\"Error\":\"Marble private details does not exist: marble1\"}"
couchdb에서 삭제 가능
```
