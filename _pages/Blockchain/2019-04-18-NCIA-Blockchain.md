---
layout: page
title: Blockchain in NCIA Education
summary: Blockchain is space to learn Smart Contract with solidity
categories: solidity
tags: solidity
featured-img: block
comments: 차세대융합콘텐츠산업협회 블록체인 기반 Smart Contract DAPP 개발
---

# Introducing Blockchain !!

#####  Blockchain is space to learn Smart Contract with solidity.

---

## Contents

## Table of Contents

|No|Title|Remarks|
|--:|:-:|:--|
|0|[환경설정](#install)|이더리움환경셋팅|
|1|[커리큘럼](#Syllabus)|커리큘럼 |
|2|[실습](#Practice)|실습|

---

## Learning

### Table of Learning

|No|구분|Title|Day|Remarks|
|--:|:-:|:--:|:-:|:--|
|1|정규|사설네트워크 구축|Mar 18 2019|참석|
|2|정규|솔리디티 프로그램/언어 이해 및 프로그램 작성|Mar 19 2019|참석|
|3|정규|DApp제작|Mar 20 2019|참석|

---

<a name="install"/>

## Get Started(`Entereum`)

### 1. 이더리움 설치
* [이더리움 다운로드](https://geth.ethereum.org/downloads/)
* 설치 파일 : geth-windows-amd64-1.8.27-4bcc0a37.exe
* 설치 경로 : C:\Geth
* 설치 확인
```shell
$ geth version
```
* 작업 경로 : C:\ncia
* Genesis 파일 copy : C:\ncia

### 2. Node.js 설치
* Web 서버 구축을 위한 Node.js 설치
* [Node.js 다운로드](https://nodejs.org/ko/download/)
* 설치 파일 : node-v10.15.3-x64.msi
* 설치 경로 : C:\Program Files\nodejs
* npm install -g(글로벌 패키지에 추가)
* npm 글로벌 패키지로 express 설치(web 서버 역할)
```shell
$ npm install -g express
$ npm install -g express-generator
```

### 3. Web.js 설치
> Web3는 JavaScript용 API로 DAPP을 만들기 위한 가장 기본이 되는 API라 할 수 있습니다.
* 해당 PC에 git가 설치 되어 있어야 설치 가능
* [github](https://github.com/ethereum/web3.js/)
```shell
# 해당 PC에 git가 설치 되어 있어야 설치 가능
$ npm install --save web3@0.16.0
# package.json 에 web3에 추가 됨을 확인 가능함.
```

### 4. Git 설치
* [Git Download](https://git-scm.com/downloads)
* 설치 파일 : Git-2.21.0-64-bit.exe
* 설치 경로 : C:\Program Files\Git

### 5. nodemon 설치
* 소스를 저장하면 자동 리로드되는 모둘 설치
```shell
$ npm install -g nodemon
```
* package.json에 start 옆에...node → nodemon으로 수정

### 6. jQuery 설치
* Download 버튼 클릭후  google CDN
* jQuery 홈페이지에서 Ctrl+F cdn 에서 구글 cdn 링크 값 긁겅 와서
* ctrl+shift+i  tbody 찾아서 copy →  select    ctrl+f  붙이고 검색

### 7. AWS 서버 셋팅
* EC2 인스턴스 시작 →
* Ubuntu Server 18.04 LTS (HVM), SSD Volume Type → 검토및 시작
* Name 셋팅 : nodeDApp, pri_network
* 원격 접속 허용을 위한 인바운드 처리[pri_network] : ehtereum 기본 포트 8123
  * aws. 서비스 > ec2> 서버 > 보안그룹> launc-wizard-x > 인바운드> 편집> 사용자지정 TCP >8123>  접근 ip는 알아서
* 원격 접속 허용을 위한 인바운드 처리[nodeDApp] : express 기본 포트 3000
  * aws. 서비스 > ec2> 서버 > 보안그룹> launc-wizard-x > 인바운드> 편집> 사용자지정 TCP >3000>  접근 ip는 알아서
* putty 접근, puttygen으로 ppk 패스워드 변경( gemoney.pem → gemoney.ppk)
* Filezilla로 소스 이관
  * 프로토콜 : SFTP - SSH File Transfer Protocol
  * 호스트  : AWS IP
  * 사용자  : ubuntu
  * 키파일  : gemoney.ppk

---

## Data & Source

### Table of Data & Source

|No|Title|Educational Institution|Source|Remarks|
|--:|:-:|:-:|:-:|:--|
|1|syntax.sol|<small>차세대융합콘텐츠산업협회</small>|[syntax.sol](/_pages/Blockchain/src/NCIA/syntax.sol)|solidity 문법|
|2|Vote.sol|<small>차세대융합콘텐츠산업협회</small>|[Vote.sol](/_pages/Blockchain/src/NCIA/Vote.sol)|투표예제|

---

## Syllabus

### 1. 블록체인 디테일
* 특징, 키워드, 네트워크 구성, 노드구성, 블록연결, 작업증명, 분산원장

### 2. 사설네트워크 구축
* 윈도우 환경 기반 구축
* Geth 설치 → 네트워크 구축 가능 (기반 이더리움)
* 명령어 
  * 계좌 개설, 송금, 트렌젝션등등 기본적인 처리과정
* MIST 브라우저 (GUI툴)
  * 위에 작업을 다시 수행
  * DApp을 제작한후 네트워크에 배포 편하게 구성
  * 사설네트워크 ~ 라이브 네트워크 모두 접속 가능하다
* javascript RPC를 이용한 접속
  * JS명령으로 네트워크 상에 명령을 구성

### 3. 블록체인 이해를 위한 전자지갑 구축
* WEB 기반 접속
* 3가지 방식
  * 클라이언트 사이드에서 사설 네트워크를 접속하여 RPC 명령을 작업한다
  * AJAX를 이용하여 통신 서버가 사설 네트워크와  접속하여 RPC로 명령을 처리한다
    Restful 기반 API 서버 → 사설 네트워크를 숨길수가 있어서 상대적 보안 우수
  * Socket을 이용한 실시간 통신을 이용하여 사설 네트워크와 RPC로 명령을 처리한다
    실시간 통신 클라이언트와 서버간에 웹소켓을 이용한 통신 지원
    (websoket(html5 표준)) VS socket.io(써드 파트 모둘)

### 4. 솔리디티 프로그램/언어 이해 및 프로그램 작성(2일차)
* 이더리움 기반 DApp을 제작하는 언어 → 솔리디티
* 계속 발전하는 언어 → 버전중요 → 라이브러리가 충분하지 않아서, 커스텀 라이브러리 제작 중요
* 자료형, 함수, 클래스, 조건/제어/반복문, 배열, 구조체, 매핑, 상속, 이벤트
→  언어의 스타일은 스칼라언어 유사성을 가진다

### 5. DApp제작(3일차)
* 2가지 케이스 제작
  * 서비스 기반 : node.js 활용
  * 투표, 게임(슬롯머신), .. →  블록체인 기반 서비스가 완성되는 과정
* AWS에서 ubuntu 기반 제작 연동 → aws 가입 → 상용화 관점
  * 사설네트워크용, 서비스용 2개 구축
  * 리눅스 기반 세팅 주제

---

## Practice

### 1. 사설네트워크 구축

```shell
$ cd C:\ncia\
$ geth --datadir "./ethereum/data" account new
```
* 9740ef64eb31e8fe632280dc56c61574ad832bb9
* 004b019d54442e7a6ded083f3d227449788f0509

* 계정목록 확인
```shell
geth --datadir "./ethereum/data" account list
```

#### a. 사설네트워크 가동 순서
* 최초 블록생성 : 제네시스 블록
* CustomGenesis.json 생성
* C:\ncia\CustomGenesis.json
* 9740ef64eb31e8fe632280dc56c61574ad832bb9

#### b. 제네시스 블록 파일
* 블록 체인의 첫번째 블록
```shell
{
    "config": {
      "chainId": 33,
      "homesteadBlock": 0,
      "eip155Block": 0,
      "eip158Block": 0
    },
    "nonce": "0x0000000000000033",             
    "timestamp": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "gasLimit": "0x8000000",                
    "difficulty": "0x100",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",               
    "coinbase": "0x3333333333333333333333333333333333333333",
    "alloc": {
        "9740ef64eb31e8fe632280dc56c61574ad832bb9":{
            "balance":"10000000000000000000"   
        }
    }
}
```
* 블록에인 내에서 유일하게 이전 블록의 정보를 가지고 있지 않은 블록
* 네트워크 상의 모든 클라이언트들이 동일한 제네시스 블록을 가지고 있어서 합의 과정에 참여할수 있다.
* 개별 구성 요소
  * config : 기존 이더리움의 버전 문제를 해결하기 위해서 추가된 1.6이상부터 사용
  * nonce  : 현재 블록의 작업 증명을 하기 위해서 계산의 양이 충분했는지 → 난이도 조절용
  * timestamp : 블록이 취득된 시점
  * parentHash : 부모블럭, 이전블록의 해쉬값
  * extraData : 향후 확장을 위한 항목
  * gasLimit : 하나의 블럭이 담을수 있는 임계치, 값이 커지면 거래가 빨라진다. 가스(수수료) 비용을 높게 책정하면 트랜젝션이 빠르게 처리 된다.
  * coinbase : 채굴에 성공하여 기존의 노들들에 연결이 되면 보상을 받게 되는 수수료를 누가 받을것인가 사용자 계정 해쉬값
  * alloc : 계좌해쉬:{balance:보상금}

#### c. 사설네트워크 가동
* 첫번째 블록 생성
```shell
geth --datadir "./ethereum/data" init "./CustomGenesis.json"
```

* 사설 네트워크 가동(rpcapi가 핵심임, 그중에 web3가 핵심중에 핵심)
```shell
geth --datadir "./ethereum/data" --identity "PrivateNetwork" --port "30303" --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcport "8123" --nodiscover --networkid 1900 --nat "any" --rpcapi "db, eth, net, web3, miner, personal" console
# 계정확인
> eth.accounts
["0x9740ef64eb31e8fe632280dc56c61574ad832bb9"]
# 잔고 확인
> eth.getBalance(eth.accounts[0])
```
* 원격에서 제네시스 블록에 붙는지 확인
```shell
geth attach http://localhost:8123
```

```shell
# 채굴시작
miner.start()
# 채굴스탑
miner.stop()
```

* 네트워크에 외부 프로그램이 접근할려고 하면
   * rpc 옵셔 필요로 하고,
   * 지원해 주는 라이브러리를 명시(원격 접속후 사용가능)
   * 웹기반 web3를 포함해 줘야 이 라이브러리를 통해서 제어가 가능

```shell
# 추가 계정 생성
> personal.newAccount('1234')
0x0462fc880ab6348613c0422cbc0bd1bfc7aeb95e
# 계정 목록 확인
> eth.accounts
```

#### d. 트랜젝션 발생
* 화폐단위
1 ether = 1,000, 000, 000, 000, 000, 000 wei(웨이 → 수수료 단위) ether <-> wei 환산
* 송금 → 트랜잭션 → miner.start() 작동해야 처리 → 수수료 발생 → 돈을 빼야 된다 → 계정 락을 푼다
personal.unlockAccount(계정, 비번)

```shell
eth.getBalance(eth.accounts[0])
eth.getBalance(eth.accounts[1])
0
```

* 송금

```shell
# 계좌 락을 푼다
> personal.unlockAccount(eth.accounts[0], "1234")

first argument must be the account to unlock
# 트랜젝션 발생
> eth.sendTransaction({from:eth.accounts[0], to:eth.accounts[1], value:web3.toWei(0.000001, 'ether') })
# 트랜젝션 확인
>  eth.pendingTransactions
# 해당 목록이 조회되면 아직 처리가 않된 상태이다. → miner.start()
[{
    blockHash: null,
    blockNumber: null,
    from: "0x9740ef64eb31e8fe632280dc56c61574ad832bb9",
    gas: 90000,
    gasPrice: 1000000000,
    hash: "0x63b83173b3d2d2f610cba5412c1e0b46228736970008b914b3150dccbedb1687",
    input: "0x",
    nonce: 0,
    r: "0x72bab93642282bb28eff7df0abf3067af76cf30a2e6d601875da23463b699c50",
    s: "0x6e28c27f5813a8f5a8c053e2dd907e9810074e7d2ce59920ddfd0a658c3af53e",
    to: "0x0462fc880ab6348613c0422cbc0bd1bfc7aeb95e",
    transactionIndex: 0,
    v: "0x65",
    value: 1000000000000
}]
```

#### e. MIST 브라우저
* GUI 기반
* 여러 네트워크 연동 가능
* 스마트 컨트랙트(솔리디티로 만든 DApp) 네트워크에 배포하는 기능
* [MIST 다운로드](https://github.com/ethereum/mist/releases)

### 2. 블록체인 이해를 위한 전자지갑 구축

#### a. node 기반 DApp 서비스 베이스 구축
* 배경 : DApp을 웹 베이스로 구축
* 개발 환경 : Node.js + Geth 기반으로 구축한 네트워크
* IDE : VS CODE
* 모듈 : web3 →  npmjs.com에서 검색해서 사용
* 언어 : javascript

##### 가. 구성1(웹 베이스)
* 설치 : nodejs.org
* 필요한 패키지 설치 
```shell
$ npm install -g express
$ npm install -g express-generator
```
* 프로젝트 생성 (프로젝트 만든는 곳 가서 함.)
```shell
$ cd C:\ncia\ethereum\data\block_chain\DApp
$ express -h
$ express -e mini_wallet
$ cd mini_wallet
# package.json 연관 파일들 수정
$ npm install
# node_modules에 설치됨
$ SET DEBUG=mini-wallet:*
# package.json의 start 명령어를 실행
$ npm start
# 브라우저 오픈
http://localhost:3000
```
* 프로젝트 구조
  * bin
    * www                : 노드 프로그램의 시작점, 서버가동
  * node_module
    * ...                : npm install을 통해 설치된 모듈이 위치한곳
  * public
    * js, css, img, ..   : 정적데이터, url 라우트가 필요 없음
  * routes
    * *.js               : URL을 정의하고, 디비연동, 화면 랜더링
  * views
    * *.ejs              : 실제 화면 담당
  * app.js               : 서버 구성에 필요한 환경정보, 라우트(블루프린트), 이벤트
  * package.json         : 프로젝트 메타 데이터
* 구성
  * 클라이언트 사이드에서 사설 네트워클를 접속하여 PRC 명령을 작업한다. → 클라이언트 사이드 web3를 이용한 rpc 연동
  * views> index.ejs에서 작업
  * 필요한 재료  →  web3
```shell
# 해당 PC에 git가 설치 되어 있어야 설치 가능
$ npm install --save web3@0.16.0
# package.json 에 web3에 추가 됨을 확인 가능함.
```
* Ctrl+Shift+j  javascript console로 들어옴
* C:\ncia\ethereum\data\block_chain\DApp\mini_wallet\node_modules\web3\dist\web3-light.min.js
* public > lib > web3-light.min.js
* bignumber.min.js


```javascript
<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    <link rel='stylesheet' href='/stylesheets/style.css' />
    <!-- 사설 네트워크 통신하는 모듈 로드 -->
    <!-- http://localhost:3000/lib/bignumber.min.js -->
    <script src="/lib/bignumber.min.js"></script>
    <script src="/lib/web3-light.min.js"></script>
    <script>
      // 1. 모듈 가져오기
      const Web3_Mod = require('web3')
      const web3     = new Web3_Mod()
      // 2. 사설 네트워크 접속
      const url      = 'http://localhost:8123'
      web3.setProvider( new web3.providers.HttpProvider(url))
      console.log(web3)
    </script>
  </head>
  <body>
    <h1><%= title %></h1>
    <p>Welcome to <%= title %></p>
  </body>
</html>
```

#### b.구성2 

* AJAX를 이용하여 통신 서버가 사설 네트워큭와  접속하여 PRC로 명령을 처리한다
  Restful 기반 API 서버 -> 사설 네트워크를 숢실수가 있어서 상대적 보안 우수
* route >ethRpc.js 생성 서버단에서 web3를 통해 네트워크 접속후 통신
* 클라이언트는 ajax를 통해서 해다 API 서버와 통신하여 구성
* views > rpc.ejs
* ~/rpc/allACccounts, ~/rpc/rpcTest

#### c.구성3
* SOCKET을 이용한 실시간 통신을 이용하여 사설 네트쿼크와 PRC로 명령을 처리한다
  실시간 통신 클라이언튼와 서버간이 웹소켓을 이용한 통신 지원
  (websoket(html5 표준)) VS socket.io(써드 파트 모둘)
```shell
$ npm install --save socket.io
```
* pakage.json > dependencies > 추가됨
* 클랑라이언트 사이드에서 socket.io를 사용할수 있게 라이브러리 추가
   C:\ncia\ethereum\data\block_chain\DApp\mini_wallet\node_modules\socket.io-client\dist\socket.io.js 복사하여
   C:\ncia\ethereum\data\block_chain\DApp\mini_wallet\public\lib 추가하기
* 이유는  서버에서 말고  클라이언트에서eh socket.io를 사용하게끔

### 3. 솔리디티 프로그램/언어 이해 및 프로그램 작성(스마트 컨트랙트)

#### a.개요
* 솔리디티 언어를 이용하여 개발
* 학장자 *.sol
* 개발완료 → 컴파일 → 배포형태의 파일 2개 생성
* 해당 파일을 네트워크에 배포하고, 코드에서는 사용을 하고 → DApp 상에서 컨트렉트를 엑세스 하여 서비스 제공(*.abi, *bin)

#### b.개발툴
* remix 
  * → 웹상 개발, git로 소스를 받아 로컬에서도 가능, 
  * 다양한 컴파일 버전지원(모든), 배포, 구동 다 지원
  * 배포(MIST브라우저, 직접 배포(명령어))
  * 단점 : 한글 주석
  * 컴파일러 버전 확인(0.5.7)
  * 크롬 브라우저에서 소스 확인법(window.localStorage['sol:syntax.sol'])
* vs code extenstion, 인텔리J 플러그인 설치

#### c.기본문법
##### 1) 기본 타입(syntax.sol)
* 블린
* 정수
* 부동소수점
* 문자열
* 주소형
* 열겨형
* 구조체
* 이벤트
* 튜플
##### 2) 컨트랙트 구조 → class로 염두해 두고 문법을 익히면 됩
##### 3) 변수(상태변수, 지역변수), 저장공간
##### 4) 함수(옵션, 가시성 키워드)
##### 5) 조건문, 제어문, 반복문 등등
##### 6) 형변환(암묵적, 명시적)
##### 7) 배열 이해, 바이트 이해, 동적/정적 생성
##### 8) 문자열 → 라이브러리 거의 없다: 자주쓰는 표현 구현
##### 9) 구조체, 이벤트, 매핑
##### 10) 상속, 인터페이스 확인, 추상
##### 11) 라이브러리, 기본제공 전역변수, 전역함수(this, msg.sender,....)

### 3.DApp 서비스 구성
* concept
* contract 제작
  * *.sol 작성
  * test
  * 네트워크에 배포
    * *.sol → compile → *.abi, *.bin 생성 → 명령 → 네트워크배포(aws 리눅스에서 진행) 
    * → 마이너진행 → CONTRACT 배포 완료 
    * → 주소, *.abi를 이용하여 서비스쪽(node등에서 연결하여 사용)
    * node에서는 터틀 모듈로 진행, 기타 언어별로 지원을 다 제공 → solc 컴파일러를 이용
    * GUI → MIST → 간편하게 배포 가능
  * 사용
    * contract 주소, abi 파일을 이용하여 contract 사용
    * → contract 소유자, contract 이용자 → msg.sender
    * tranaction 처리시 → gas 지급에 대한 처리
    * 투표, 슬롯머신(이벤트, 랜덤 등등) 진행
    * 회원(네트워크상에 계좌를 가진 자)
    * 가입(아이디, 비번:(로그인용, 네트워크계좌비번)) + 가입기녕 1eth지급)
    * node 기반 →  서비스를 연결 → 제공

* 미니 투표 
  * 프로젝트 폴더
  * express -e mini_vote
  * *.sol 작성
  * npm install --save web3@0.16.0
  * public/lib/bignumber.min.js, web3-light.min.js 이관
  * vs code 프로젝트 위치로 터미널 오픈
    * cd mini_vote
    * npm install
    * package.json > scripts > start > node → nodemon 교체/저장
    * npm start
      * http://localhost:3000/
      * views/index.ejs에서 네트워크에 연결되기 위한 기본 코드 처리

### 4. AWS상 리눅스에 셋팅 및 운영
#### a. 이더리움 설치
```shell
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum
```

#### b. 네트워크 구축 [pri_network]
```shell
mkdir pri_net
mkdir ./pri_net/ethereum
mkdir ./pri_net/ethereum/data
cd pri_net
geth --datadir "./ethereum/data" account new
# 최초 계좌 해쉬값 카피해두고
#Address: {eadf1a5a2bd73fa652d4c8684c6805248ce3aa84}
nano CustomGenesis.json # 우클릭 하면 복사되고 ctrl-X 해서 저장
```

```shell
geth --datadir "./ethereum/data" init "./CustomGenesis.json"

# 사설 네트워크 가동(rpcapi가 핵심임, 그중에 web3가 핵심중에 핵심)
geth --datadir "./ethereum/data" --identity "PrivateNetwork" --port "30303" --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcport "8123" --nodiscover --networkid 1900 --nat "any" --rpcapi "db, eth, net, web3, miner, personal" console  

```

* eth.accounts
* ["0xeadf1a5a2bd73fa652d4c8684c6805248ce3aa84"]]
* exit

#### c. solc 컴파일러 설치

```shell
sudo apt-get install solc
mkdir dapp && cd dapp
mkdir vote && cd vote
nano Vote.sol # 코드 복사
solc -o . --bin --abi Vote.sol
cat Vote.abi  # 코드 copy
[{"constant":true,"inputs":[{"name":"id","type":"uint8"}],"name":"getScoreSinger","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"voted","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"name","type":"string"}],"name":"getScoreSinger","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getNumSinger","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"name","type":"string"}],"name":"addSinger","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"name","type":"string"}],"name":"vote","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]
cat Vote.bin  # 코드 copy
608060405234801561001057600080fd5b506000600360006101000a81548160ff021916908360ff16021790555033600360016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506108ca8061007d6000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c8063273f1dcc146100675780633500f91e146101115780636ccd05c6146101335780638b2da60914610202578063c115368e14610226578063fc36e15b146102e1575b600080fd5b6100966004803603602081101561007d57600080fd5b81019080803560ff1690602001909291905050506103b4565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100d65780820151818401526020810190506100bb565b50505050905090810190601f1680156101035780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b61011961046e565b604051808215151515815260200191505060405180910390f35b6101ec6004803603602081101561014957600080fd5b810190808035906020019064010000000081111561016657600080fd5b82018360208201111561017857600080fd5b8035906020019184600183028401116401000000008311171561019a57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f8201169050808301925050505050505091929192905050506104c2565b6040518082815260200191505060405180910390f35b61020a610535565b604051808260ff1660ff16815260200191505060405180910390f35b6102df6004803603602081101561023c57600080fd5b810190808035906020019064010000000081111561025957600080fd5b82018360208201111561026b57600080fd5b8035906020019184600183028401116401000000008311171561028d57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f82011690508083019250505050505050919291929050505061054c565b005b61039a600480360360208110156102f757600080fd5b810190808035906020019064010000000081111561031457600080fd5b82018360208201111561032657600080fd5b8035906020019184600183028401116401000000008311171561034857600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f820116905080830192505050505050509192919290505050610706565b604051808215151515815260200191505060405180910390f35b60606000808360ff1660ff1681526020019081526020016000208054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156104625780601f1061043757610100808354040283529160200191610462565b820191906000526020600020905b81548152906001019060200180831161044557829003601f168201915b50505050509050919050565b6000600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff16905090565b60006001826040518082805190602001908083835b602083106104fa57805182526020820191506020810190506020830392506104d7565b6001836020036101000a0380198251168184511680821785525050505050509050019150509081526020016040518091039020549050919050565b6000600360009054906101000a900460ff16905090565b600080905060008090505b600360009054906101000a900460ff1660ff168160ff1610156106185782805190602001206000808360ff1660ff16815260200190815260200160002060405180828054600181600116156101000203166002900480156105ef5780601f106105cd5761010080835404028352918201916105ef565b820191906000526020600020905b8154815290600101906020018083116105db575b50509150506040518091039020141561060b5760019150610618565b8080600101915050610557565b50801561062457610702565b81600080600360009054906101000a900460ff1660ff1660ff168152602001908152602001600020908051906020019061065f9291906107f9565b5060006001836040518082805190602001908083835b602083106106985780518252602082019150602081019050602083039250610675565b6001836020036101000a0380198251168184511680821785525050505050509050019150509081526020016040518091039020819055506003600081819054906101000a900460ff168092919060010191906101000a81548160ff021916908360ff160217905550505b5050565b600061071061046e565b1561071e57600090506107f4565b6001600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff0219169083151502179055506001826040518082805190602001908083835b602083106107ac5780518252602082019150602081019050602083039250610789565b6001836020036101000a038019825116818451168082178552505050505050905001915050908152602001604051809103902060008154809291906001019190505550600190505b919050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061083a57805160ff1916838001178555610868565b82800160010185558215610868579182015b8281111561086757825182559160200191906001019061084c565b5b5090506108759190610879565b5090565b61089b91905b8082111561089757600081600090555060010161087f565b5090565b9056fea165627a7a723058208f030ec0090102330a02faeeac3d5f75285b13d4bab4116eb0887c35c1a0f4440029
cd ../..
# 네트워크 가동
geth --datadir "./ethereum/data" --identity "PrivateNetwork" --port "30303" --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcport "8123" --nodiscover --networkid 1900 --nat "any" --rpcapi "db, eth, net, web3, miner, personal" console 

```

#### d. 네트워크에 배포
* var abi = [{"constant":true,"inputs":[{"name":"id","type":"uint8"}],"name":"getScoreSinger","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"voted","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"name","type":"string"}],"name":"getScoreSinger","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getNumSinger","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"name","type":"string"}],"name":"addSinger","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"name","type":"string"}],"name":"vote","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]
* var bin = "0x608060405234801561001057600080fd5b506000600360006101000a81548160ff021916908360ff16021790555033600360016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506108ca8061007d6000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c8063273f1dcc146100675780633500f91e146101115780636ccd05c6146101335780638b2da60914610202578063c115368e14610226578063fc36e15b146102e1575b600080fd5b6100966004803603602081101561007d57600080fd5b81019080803560ff1690602001909291905050506103b4565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100d65780820151818401526020810190506100bb565b50505050905090810190601f1680156101035780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b61011961046e565b604051808215151515815260200191505060405180910390f35b6101ec6004803603602081101561014957600080fd5b810190808035906020019064010000000081111561016657600080fd5b82018360208201111561017857600080fd5b8035906020019184600183028401116401000000008311171561019a57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f8201169050808301925050505050505091929192905050506104c2565b6040518082815260200191505060405180910390f35b61020a610535565b604051808260ff1660ff16815260200191505060405180910390f35b6102df6004803603602081101561023c57600080fd5b810190808035906020019064010000000081111561025957600080fd5b82018360208201111561026b57600080fd5b8035906020019184600183028401116401000000008311171561028d57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f82011690508083019250505050505050919291929050505061054c565b005b61039a600480360360208110156102f757600080fd5b810190808035906020019064010000000081111561031457600080fd5b82018360208201111561032657600080fd5b8035906020019184600183028401116401000000008311171561034857600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f820116905080830192505050505050509192919290505050610706565b604051808215151515815260200191505060405180910390f35b60606000808360ff1660ff1681526020019081526020016000208054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156104625780601f1061043757610100808354040283529160200191610462565b820191906000526020600020905b81548152906001019060200180831161044557829003601f168201915b50505050509050919050565b6000600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff16905090565b60006001826040518082805190602001908083835b602083106104fa57805182526020820191506020810190506020830392506104d7565b6001836020036101000a0380198251168184511680821785525050505050509050019150509081526020016040518091039020549050919050565b6000600360009054906101000a900460ff16905090565b600080905060008090505b600360009054906101000a900460ff1660ff168160ff1610156106185782805190602001206000808360ff1660ff16815260200190815260200160002060405180828054600181600116156101000203166002900480156105ef5780601f106105cd5761010080835404028352918201916105ef565b820191906000526020600020905b8154815290600101906020018083116105db575b50509150506040518091039020141561060b5760019150610618565b8080600101915050610557565b50801561062457610702565b81600080600360009054906101000a900460ff1660ff1660ff168152602001908152602001600020908051906020019061065f9291906107f9565b5060006001836040518082805190602001908083835b602083106106985780518252602082019150602081019050602083039250610675565b6001836020036101000a0380198251168184511680821785525050505050509050019150509081526020016040518091039020819055506003600081819054906101000a900460ff168092919060010191906101000a81548160ff021916908360ff160217905550505b5050565b600061071061046e565b1561071e57600090506107f4565b6001600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff0219169083151502179055506001826040518082805190602001908083835b602083106107ac5780518252602082019150602081019050602083039250610789565b6001836020036101000a038019825116818451168082178552505050505050905001915050908152602001604051809103902060008154809291906001019190505550600190505b919050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061083a57805160ff1916838001178555610868565b82800160010185558215610868579182015b8281111561086757825182559160200191906001019061084c565b5b5090506108759190610879565b5090565b61089b91905b8082111561089757600081600090555060010161087f565b5090565b9056fea165627a7a723058208f030ec0090102330a02faeeac3d5f75285b13d4bab4116eb0887c35c1a0f4440029"
* contract 생성
* voteContract = eth.contract(abi)
* tranaction 정보(수수료와 지급 정)
* var transfer = {from:eth.accounts[0], data:bin, gas:2000000}
* personal.unlockAccount(eth.accounts[0])
* var con = voteContract.new(transfer) # 확인
* con

---

```shell
{
  abi: ..., 
  address: undefined, # ← 이부분이 채굴을 통해 처리되면 셋팅된다(주소)
  transactionHash: "0x94d0ab111ee1e6e64bbf32df782b7f35b3b4831594c697cc4c0e86c368d70d4c"
}
```
---
* miner.start()
* 원격 접속 허용을 위한 인바운드 처리
  * aws. 서비스 > ec2> 서버 > 보안그룹> launc-wizard-x > 인바운드> 편집> 사용자지정 TCP >8123>  접근 ip는 알아서

#### e. Node.js 서버 구축
* 노드 환경 구축[nodeDapp]
```shell
sudo apt-get update
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install -y nodejs
node -v
```

#### f. express 설치 및 프로젝트 구성
```shell
sudo npm install -g express express-generator
mkdir DApp && cd DApp
express -e mini_vote
cd mini_vote
npm install
```

#### g. Web3 설치
```shell
npm install --save web3@0.16.0
# 일반 가동(터미널을 붙잡고 있다)
npm start
ctrl+c
```

#### h. pm 설치
```shell
# 프로세스 관리자(퇴근가능)
sudo npm install -g pm2
pm2 start ./bin/wwww
pm2 stop 0
pm2 restart 0
```

## Reference

* [GO(구글)](https://geth.ethereum.org/downloads/)
* [npmjs](https://www.npmjs.com/)
* [node](https://nodejs.org/en/) → 일렉트론을 만나면 application으로 변경
* [Git](https://git-scm.com)
* [jQuery](http://jquery.com/download/)
* [pm2](https://expressjs.com/ko/advanced/pm.html) : PM2는 Node.js 애플리케이션용 프로덕션 프로세스 관리자
