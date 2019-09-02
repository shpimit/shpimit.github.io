# Hyperledger Fabric 1.4.1

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
* sudo curl -sSL http://bit.ly/2ysbOFE | bash -s 1.4.1   # 1.4.1 을 명시하지 않으면 가장 최신 버전을 가져옴. 안될때 sudo bash -s
* vi ~/.profile
* export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:~/fabric-samples/bin
* source ~/.profile
```

## Sample Fabric

### 1. fabcar
```shell
cd ~/fabric-samples/basic_network
./stop.sh
./teardown.sh

cd ~/fabric-samples/fabcar
./startFabric.sh
cd ~/fabric-samples/fabcar/javascript
/fabric-samples/fabcar/javascript/npm install
sudo apt install tree
~/fabric-samples/fabcar/javascript
~/fabric-samples/fabcar/javascript/node enrollAdmin.js
~/fabric-samples/fabcar/javascript/tree wallet
~/fabric-samples/fabcar/javascript/node registerUser.js
~/fabric-samples/fabcar/javascript/node query.js
```
