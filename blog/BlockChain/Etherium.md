## Genesis Block 생성

```
geth --datadir data init Genesis.json
```

### 실행

```
geth --networkid 15 --nodiscover --maxpeers 3 --datadir data --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" console 
2>> data/geth.log
```
