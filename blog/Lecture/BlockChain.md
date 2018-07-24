---
layout: post
title: Block Chain
summary: Block Chain is space to learn block chain algorithm & theory. 
permalink: /Lecture/BlockChain
---

---

<!-- $theme: gaia -->
<!-- *template: gaia -->
<!-- page_number: false -->

# Block Chain !!
#####  Block Chain is space to learn block chain algorithm & theory. 

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="contents"/>

* **Table of Contents**   

<span style="font-size:16pt">
  
|No|Titile|Explain|YMD|
|--:|:--:|:-:|:--:|
|1|[Reference Site](#site)|Reference|18-07-21|
|2|[Block Chain](#block) |머신러닝|18-06-17|
<!-- |3|[Deep Learning](#deep)|딥러닝|18-06-17|
|4|[R](/Lecture/R)|R|18-06-17|
|5|[TensorFlow](/Lecture/TensorFlow)|텐서플로|18-06-17|
-->
---

<!-- *template: invert -->
<a name="site"/>

#### [Reference Site]  
* [비트코인 블록 탐색기](https://www.blockchain.com/explorer)
* [비트코인 체굴](https://bitnodes.earn.com/nodes/live-map/)
* [WPS](https://www.wps.com/office-free)
* [Radpid Miner](http://www.rapidminer.co.kr/rapidminer-studio)
* [이더스캔](https://etherscan.io/)
* [이더리움 GAS Price](https://ethgasstation.info/)
* [Remix IDE](https://remix.ethereum.org)
-->

---

<!-- *template: invert -->
<a name="block"/>

#### [Block Chain]

> 자바 weka로  iris 동영상 보여주고.. 검증하기
> Confusion Matrix 가능 유무
> Naive Baisan, 유사도 측정 가능 유무
> Solidity 실행

```solidity
pragma solidity ^0.4.18;

contract payment {
    
    //  No initialize  unit = 0
    uint balance;
    uint start;
    address public deposit;
    address public withdrawl;
    
    // Construct
    function payment(address to_address){
        deposit   = msg.sender;
        withdrawl = to_address
        start     = now;
    }
    
    function deposit_to_contract() public payable {
        if(msg.sender == deposit) {
            balance += msg.value;
        }
    }
    
    function withdrawl_from_contract() {
        if(msg.sender == withdrawl){
            withdrawl.transter(this.balance)
        } else if(msg.sender == deposit && now > start + 14 days) {
            selfdestruct(deposit);
        }
    }
}
```

