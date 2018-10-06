---
layout: page
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

* **Table of Learning**

|No|Title|Educational Institution|Term|
|--:|:--:|:-:|:--:|
|1|[블록체인]((Lecture/BlockChain)|서울대학교 도시연구소|18.8.4~9.1|

---

<!-- $theme: gaia -->
<!-- page_number: true -->

## Overview

> 블록체인(영어: block chain, blockchain)은 관리 대상 데이터를 '블록'이라고 하는 소규모 데이터들이 P2P 방식을 기반으로 생성된 체인 형태의 연결고리 기반 분산 데이터 저장환경에 저장되어 누구라도 임의로 수정할 수 없고 누구나 변경의 결과를 열람할 수 있는 분산 컴퓨팅 기술 기반의 데이터 위변조 방지 기술이다
> 딥러닝 비전문가라도 각자 분야에서 손쉽게 딥러닝 모델을 개발하고 활용할 수 있도록 케라스는 직관적인 API를 제공하고 있습니다.    
> <small>-- * 블록체인 기술은 비트코인을 비롯한 대부분의 암호화폐 거래에 사용된다.* </small>

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="contents"/>

* **Table of Contents**   

<span style="font-size:16pt">
  
|No|Title|Explain|YMD|
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

---

* 투표

```solidity
pragma solidity ^0.4.22;

/// @title Voting with delegation.
contract Ballot {
    // This declares a new complex type which will
    // be used for variables later.
    // It will represent a single voter.
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        address delegate; // person delegated to
        uint vote;   // index of the voted proposal
    }

    // This is a type for a single proposal.
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;

    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;

    /// Create a new ballot to choose one of `proposalNames`.
    constructor(bytes32[] proposalNames) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // For each of the provided proposal names,
        // create a new proposal object and add it
        // to the end of the array.
        for (uint i = 0; i < proposalNames.length; i++) {
            // `Proposal({...})` creates a temporary
            // Proposal object and `proposals.push(...)`
            // appends it to the end of `proposals`.
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) public {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    /// Delegate your vote to the voter `to`.
    function delegate(address to) public {
        // assigns reference
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You already voted.");

        require(to != msg.sender, "Self-delegation is disallowed.");

        // Forward the delegation as long as
        // `to` also delegated.
        // In general, such loops are very dangerous,
        // because if they run too long, they might
        // need more gas than is available in a block.
        // In this case, the delegation will not be executed,
        // but in other situations, such loops might
        // cause a contract to get "stuck" completely.
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            // We found a loop in the delegation, not allowed.
            require(to != msg.sender, "Found loop in delegation.");
        }

        // Since `sender` is a reference, this
        // modifies `voters[msg.sender].voted`
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            // If the delegate already voted,
            // directly add to the number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If the delegate did not vote yet,
            // add to her weight.
            delegate_.weight += sender.weight;
        }
    }

    /// Give your vote (including votes delegated to you)
    /// to proposal `proposals[proposal].name`.
    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;

        // If `proposal` is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        proposals[proposal].voteCount += sender.weight;
    }

    /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    // Calls winningProposal() function to get the index
    // of the winner contained in the proposals array and then
    // returns the name of the winner
    function winnerName() public view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}
```


