## Genesis Block 생성

```shell
geth --datadir data init Genesis.json
```

### 실행

```shell
geth --networkid 15 --nodiscover --maxpeers 3 --datadir data --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" console
2>> data/geth.log
```

> ABI : Application Binary Interface
> Solidity에서는 배열 return 이 안됨

```shell
txpool
personal.unlockAccount(eth.accounts[0],"1234")
eth.mining
miner.start()

eth.addPeer("enode://8ee31dac020fba80d786151c4aa1d1738cf33e710c9f26f2936a00f960c9d716a99bd9c87ace97d23229dc85cf8c28ccbd488b6ab6c326ca167f64cf70f63bd2@192.168.0.15:30303?discport=0")
### 송금하기
eth.sendTransaction({from :eth.accounts[0], to: "0x57f1bb822658e47826693172537bcc4e66560e03", value:web3.toWei(10,"ether")})


web3.fromWei(eth.getBalance(eth.accounts[0]))

```
