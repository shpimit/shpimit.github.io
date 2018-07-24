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
|2|[Block Chain](#block)|블록체인|18-07-24|

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

---

<!-- *template: invert -->
<a name="block"/>

#### [Block Chain]

> 자바 weka로  iris 동영상 보여주고.. 검증하기
> Confusion Matrix 가능 유무
> Naive Baisan, 유사도 측정 가능 유무
> Solidity 실행

* 송금
* 함수를 실행하는것이 tranaction 단위

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

---

* 경매

```solidity
pragma solidity ^0.4.24;

contract SimpleAuction {
    
    address public beneficiary;    // 경매 출품자 주소
    uint public auctionEnd;        // 경매 종료 시점
    
    address public highestBidder;  // 최고액 입찰자
    uint public highestBid;        // 최고액 입찰가
    
    mapping(address => uint) pendingReturns;   // 경매에 소요된 유보금(입찰자 주소 입력시 예치금을 반환하는 매핑)
    bool ended;                    // 경매 종료 플래그
    
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);    // 거래 내역 로그 기록용 event 변수(optional)
    
    // Constructor
    function SimpleAuction(uint _biddingTime, address _beneficiary) public {
        beneficiary = _beneficiary;                // 출품자 주소
        auctionEnd  = now + _biddingTime;          // 종료시점 설정(계약 생성 시점 + 제한시간(초단위))
    }
    
    function bid() public payable {                // 입찰
        require(now <= auctionEnd);
        require(msg.value > highestBid);           // 함수 호출시 필요조건(종료시점 이내, 최고 입찰가보다 높은 금액)
        
        if(highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;  // 기존에 입찰한 최고 입찰자의 예치금을 유보금으로 처리
        }
        highestBidder = msg.sender;
        highestBid    = msg.value;                 // 최고 입찰자, 최고 입찰가 갱신
        
        emit HighestBidIncreased(msg.sender, msg.value);   // 거래 내역 로그 기록용 event 변수 업데이트(optional)
    }
    
    function withdraw() public returns(bool) {
        uint amount = pendingReturns[msg.sender];
        
        if(amount > 0) {
            pendingReturns[msg.sender] = 0;
            if(!msg.sender.send(amount)) {
                pendingReturns[msg.sender] = amount;
                
                return false;
            }
        }
        
        return true;
    }
    
    // 블록체인에서는 시간이 지난다고 자동으로 경매가 종료 되지 않음
    // 타 프로그램에서 아래의 함수를 호출해서, 또는 remix에서 아래 함수를 실행해서 경매 물건이
    // 최종 낙찰자에게 전달 해야 함.
    function auctionEnd() public {
        require(now >= auctionEnd);
        require(!ended);
        ended = true;
        
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }
}
```


