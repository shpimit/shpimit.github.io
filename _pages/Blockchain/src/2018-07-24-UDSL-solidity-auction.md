---
layout: page
title: Solidity Source
categories: Blockchain
tags: Blockchain
featured-img: block
comments: 서울대학교 빅데이터 아카데미
---

# Solidity 실행

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

* Token 발행

```solidity
pragma solidity ^0.4.8;

contract SNUCOIN {
    
    // 상태 변수 선언
    string public name; // 토큰 이름
    string public symbol; // 토큰 심볼
    uint256 public decimals; // 소수점 이하 자릿수 
    uint256 public totalSupply; // 토큰 총 발행량
    mapping (address => uint256) public balanceOf; // 각 주소의 잔고
    
    // 토큰 생성
    function SNUCOIN(uint256 _supply, string _name, string _symbol, uint256 _decimals) {
        name                  = _name;
        symbol                = _symbol;
        decimals              = _decimals;
        balanceOf[msg.sender] = _supply * 10 ** decimals;
        totalSupply           = _supply * 10 ** decimals;
    }
    
    // 송금
    function transfer(address _to, uint256 _value) {
        // 부정 송금 확인
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        
        // 송금하는 주소와 송금 받는 주소의 잔고 갱신
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }
}  
```

---

* 블랙리스트

```solidity
pragma solidity ^0.4.8;

contract SNUCOIN {
    string public name; 
    string public symbol; 
    uint256 public decimals; 
    uint256 public totalSupply; 
    mapping (address => uint256) public balanceOf; 
    mapping (address => int8) public blackList; 
    address public owner; 
    modifier onlyOwner() { if (msg.sender != owner) throw; _; } 
    
    function SNUCOIN(uint256 _supply, string _name, string _symbol, uint256 _decimals) {
        name                  = _name;
        symbol                = _symbol;
        decimals              = _decimals;
        balanceOf[msg.sender] = _supply * 10 ** decimals;
        totalSupply           = _supply * 10 ** decimals;
        owner                 = msg.sender; 
    }
    function blacklisting(address _addr) onlyOwner {
        blackList[_addr] = 1; 
    }
    function deleteFromBlacklist(address _addr) onlyOwner {
        blackList[_addr] = -1;
    } 
    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        
        if (blackList[msg.sender] > 0) throw; 
        else if (blackList[_to] > 0) throw;
        else {
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }
}
```

---

* 캐쉬백

```solidity
pragma solidity ^0.4.8;

contract SNUCOIN {
    
    string public name; 
    string public symbol; 
    uint256 public decimals; 
    uint256 public totalSupply; 
    mapping (address => uint256) public balanceOf; 
    mapping (address => int8) public blackList; 
    mapping (address => int8) public cashbackRate;  
    address public owner;  
 
    
    modifier onlyOwner() { if (msg.sender != owner) throw; _; }
    

    function SNUCOIN(uint256 _supply, string _name, string _symbol, uint256 _decimals) {
        name                  = _name;
        symbol                = _symbol;
        decimals              = _decimals;
        balanceOf[msg.sender] = _supply *10**decimals;
        totalSupply           = _supply*10**decimals;
        owner                 = msg.sender ; 
    }
    
    function blacklisting(address _addr) onlyOwner {
        blackList[_addr] = 1;
    }
    function deleteFromBlacklist(address _addr) onlyOwner {
        blackList[_addr] = -1;
    }    
    
    function setCashbackRate(int8 _rate) {
        if (_rate < 1) {
           _rate = 0;
        } else if (_rate > 100) {
           _rate = 100;
        }
        cashbackRate[msg.sender] = _rate;

    }        
    
    function transfer(address _to, uint256 _value) {
        // 
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        // 
        if (blackList[msg.sender] >  0) throw;
        else if (blackList[_to] > 0) throw;
        else {
            uint256 cashback = 0;
            if (cashbackRate[_to] > 0) cashback = _value / 100 * uint256(cashbackRate[_to]); 
            balanceOf[msg.sender] -= (_value - cashback); 
            balanceOf[_to] += (_value - cashback);
            
        }
    }
}
```

---

* 회원관리

```solidity
pragma solidity ^0.4.24;

// 소유자 관리용 계약
contract Owned {
    // 상태 변수
    address public owner; // 소유자 주소
    // 소유자 변경 시 이벤트
    event TransferOwnership(address oldaddr, address newaddr);
    // 소유자 한정 메서드용 수식자
    modifier onlyOwner() { if (msg.sender != owner) throw; _; }
    // 생성자
    function Owned() {
        owner = msg.sender; // 처음에 계약을 생성한 주소를 소유자로 한다
    }
    // (1) 소유자 변경
    function transferOwnership(address _new) onlyOwner {
        address oldaddr = owner;
        owner           = _new;
        TransferOwnership(oldaddr, owner);
    }
}
```

---

* Contract 연결

```solidity
pragma solidity ^0.4.8;

// 소유자 관리용 계약
contract Owned {
    // 상태 변수
    address public owner; // 소유자 주소
    
    // 소유자 변경 시 이벤트
    event TransferOwnership(address oldaddr, address newaddr);
    
    // 소유자 한정 메서드용 수식자
    modifier onlyOwner() { if (msg.sender != owner) throw; _; }
    
    // 생성자
    function Owned() {
    owner = msg.sender; // 처음에 계약을 생성한 주소를 소유자로 한다
    }
    // (1) 소유자 변경
    function transferOwnership(address _new) onlyOwner {
        address oldaddr = owner;
        owner = _new;
        TransferOwnership(oldaddr, owner);
    }
}

contract Members is Owned {
    // (3) 상태 변수 선언
    address public coin; // 토큰(가상 화폐) 주소
    MemberStatus[] public status; // 회원 등급 배열
    mapping(address => History) public tradingHistory; // 회원별 거래 이력
    // (4) 회원 등급용 구조체
    struct MemberStatus {
        string name; // 등급명
        uint256 times; // 최저 거래 회수
        uint256 sum; // 최저 거래 금액
        int8 rate; // 캐시백 비율
    }
    // 거래 이력용 구조체
    struct History {
        uint256 times; // 거래 회수
        uint256 sum; // 거래 금액
        uint256 statusIndex; // 등급 인덱스
    }
    // (5) 토큰 한정 메서드용 수식자
    modifier onlyCoin() { if (msg.sender == coin) _; }
    // (6) 토큰 주소 설정 // 특정 contract만 
    function setCoin(address _addr) onlyOwner {
        coin = _addr;
    }
    // (7) 회원 등급 추가
    function pushStatus(string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        status.push(MemberStatus({
            name: _name,
            times: _times,
            sum: _sum,
            rate: _rate
        }));
    }
    // (8) 회원 등급 내용 변경
    function editStatus(uint256 _index, string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        if (_index < status.length) {
            status[_index].name  = _name;
            status[_index].times = _times;
            status[_index].sum   = _sum;
            status[_index].rate  = _rate;
        }
    }
    // (9) 거래 내역 갱신
    function updateHistory(address _member, uint256 _value) onlyCoin {
        tradingHistory[_member].times += 1;
        tradingHistory[_member].sum   += _value;
        
        // 새로운 회원 등급 결정(거래마다 실행)
        uint256 index;
        int8 tmprate;   // status rate가.. 음수로 셋팅되어 있을때
        
        for (uint i = 0; i < status.length; i++) {
            // 최저 거래 횟수, 최저 거래 금액 충족 시 가장 캐시백 비율이 좋은 등급으로 설정
            if (tradingHistory[_member].times >= status[i].times &&
                tradingHistory[_member].sum >= status[i].sum &&
                tmprate < status[i].rate) {
                    index = i;
            }
        }
        tradingHistory[_member].statusIndex = index;
    }
    // (10) 캐시백 비율 획득(회원의 등급에 해당하는 비율 확인)
    function getCashbackRate(address _member) constant returns (int8 rate) {
        rate = status[tradingHistory[_member].statusIndex].rate;
    }
}
```

---

* 상속

```solidity
pragma solidity ^0.4.8;

// 소유자 관리용 계약
contract Owned {
    // 상태 변수
    address public owner; // 소유자 주소
    
    // 소유자 변경 시 이벤트
    event TransferOwnership(address oldaddr, address newaddr);
    
    // 소유자 한정 메서드용 수식자
    modifier onlyOwner() { if (msg.sender != owner) throw; _; }
    
    // 생성자
    function Owned() {
    owner = msg.sender; // 처음에 계약을 생성한 주소를 소유자로 한다
    }
    // (1) 소유자 변경
    function transferOwnership(address _new) onlyOwner {
        address oldaddr = owner;
        owner = _new;
        TransferOwnership(oldaddr, owner);
    }
}


contract Members is Owned {
    // (3) 상태 변수 선언
    address public coin; // 토큰(가상 화폐) 주소
    MemberStatus[] public status; // 회원 등급 배열
    mapping(address => History) public tradingHistory; // 회원별 거래 이력
    // (4) 회원 등급용 구조체
    struct MemberStatus {
        string name; // 등급명
        uint256 times; // 최저 거래 회수
        uint256 sum; // 최저 거래 금액
        int8 rate; // 캐시백 비율
    }
    // 거래 이력용 구조체
    struct History {
        uint256 times; // 거래 회수
        uint256 sum; // 거래 금액
        uint256 statusIndex; // 등급 인덱스
    }
    // (5) 토큰 한정 메서드용 수식자
    modifier onlyCoin() { if (msg.sender == coin) _; }
    // (6) 토큰 주소 설정 // 특정 contract만 
    function setCoin(address _addr) onlyOwner {
        coin = _addr;
    }
    // (7) 회원 등급 추가
    function pushStatus(string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        status.push(MemberStatus({
            name: _name,
            times: _times,
            sum: _sum,
            rate: _rate
        }));
    }
    // (8) 회원 등급 내용 변경
    function editStatus(uint256 _index, string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        if (_index < status.length) {
            status[_index].name  = _name;
            status[_index].times = _times;
            status[_index].sum   = _sum;
            status[_index].rate  = _rate;
        }
    }
    // (9) 거래 내역 갱신
    function updateHistory(address _member, uint256 _value) onlyCoin {
        tradingHistory[_member].times += 1;
        tradingHistory[_member].sum   += _value;
        
        // 새로운 회원 등급 결정(거래마다 실행)
        uint256 index;
        int8 tmprate;   // status rate가.. 음수로 셋팅되어 있을때
        
        for (uint i = 0; i < status.length; i++) {
            // 최저 거래 횟수, 최저 거래 금액 충족 시 가장 캐시백 비율이 좋은 등급으로 설정
            if (tradingHistory[_member].times >= status[i].times &&
                tradingHistory[_member].sum >= status[i].sum &&
                tmprate < status[i].rate) {
                    index = i;
            }
        }
        tradingHistory[_member].statusIndex = index;
    }
    // (10) 캐시백 비율 획득(회원의 등급에 해당하는 비율 확인)
    function getCashbackRate(address _member) constant returns (int8 rate) {
        rate = status[tradingHistory[_member].statusIndex].rate;
    }
}

contract SNUCOIN is Owned{
    // 상태 변수 선언
    string public name; // 토큰 이름
    string public symbol; // 토큰 단위
    uint8 public decimals; // 소수점 이하 자릿수
    uint256 public totalSupply; // 토큰 총량
    mapping (address => uint256) public balanceOf; // 각 주소의 잔고
    mapping (address => int8) public blackList; // 블랙리스트
    mapping (address => Members) public members; // 각 주소의 회원 정보
    // 이벤트 알림
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Blacklisted(address indexed target);
    event DeleteFromBlacklist(address indexed target);
    event RejectedPaymentToBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event RejectedPaymentFromBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event Cashback(address indexed from, address indexed to, uint256 value);
    // 생성자
    function SNUCOIN(uint256 _supply, string _name, string _symbol, uint8 _decimals) {
        balanceOf[msg.sender] = _supply* 10**decimals;
        name        = _name;
        symbol      = _symbol;
        decimals    = _decimals;
        totalSupply = _supply *10**decimals;
        owner       = msg.sender ;
    }
    // 주소를 블랙리스트에 등록
    function blacklisting(address _addr) onlyOwner {
        blackList[_addr] = 1;
        Blacklisted(_addr);
    }
    // 주소를 블랙리스트에서 해제
    function deleteFromBlacklist(address _addr) onlyOwner {
        blackList[_addr] = -1;
        DeleteFromBlacklist(_addr);
    }
    // 회원 관리 계약 설정
    function setMembers(Members _members) {
        members[msg.sender] = Members(_members);
    }
    // 송금
    function transfer(address _to, uint256 _value) {
        // 부정 송금 확인
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        // 블랙리스트에 존재하는 계정은 입출금 불가
        if (blackList[msg.sender] > 0) {
            RejectedPaymentFromBlacklistedAddr(msg.sender, _to, _value);
        } else if (blackList[_to] > 0) {
            RejectedPaymentToBlacklistedAddr(msg.sender, _to, _value);
        } else {
            // (12) 캐시백 금액을 계산(각 대상의 비율을 사용)
            uint256 cashback = 0;
            if(members[_to] > address(0)) {
                cashback = _value / 100 * uint256(members[_to].getCashbackRate(msg.sender));
                members[_to].updateHistory(msg.sender, _value);
            }
            balanceOf[msg.sender] -= (_value - cashback);
            balanceOf[_to] += (_value - cashback);
            Transfer(msg.sender, _to, _value);
            Cashback(_to, msg.sender, cashback);
        }
    }
}
```

---

* ICO(Initial Coin Offering)

```solidity
pragma solidity ^0.4.8;

// 소유자 관리용 계약
contract Owned {
    // 상태 변수
    address public owner; // 소유자 주소

    // 소유자 변경 시 이벤트
    event TransferOwnership(address oldaddr, address newaddr);

    // 소유자 한정 메서드용 수식자
    modifier onlyOwner() { if (msg.sender != owner) throw; _; }

    // 생성자
    function Owned() {
        owner = msg.sender; // 처음에 계약을 생성한 주소를 소유자로 한다
    }
    
    // (1) 소유자 변경
    function transferOwnership(address _new) onlyOwner {
        address oldaddr = owner;
        owner = _new;
        TransferOwnership(oldaddr, owner);
    }
}

// (2) 회원 관리용 계약
contract Members is Owned {
    // (3) 상태 변수 선언
    address public coin; // 토큰(가상 화폐) 주소
    MemberStatus[] public status; // 회원 등급 배열
    mapping(address => History) public tradingHistory; // 회원별 거래 이력
     
    // (4) 회원 등급용 구조체
    struct MemberStatus {
        string name; // 등급명
        uint256 times; // 최저 거래 회수
        uint256 sum; // 최저 거래 금액
        int8 rate; // 캐시백 비율
    }
    // 거래 이력용 구조체
    struct History {
        uint256 times; // 거래 회수
        uint256 sum; // 거래 금액
        uint256 statusIndex; // 등급 인덱스
    }
 
    // (5) 토큰 한정 메서드용 수식자
    modifier onlyCoin() { if (msg.sender == coin) _; }
     
    // (6) 토큰 주소 설정
    function setCoin(address _addr) onlyOwner {
        coin = _addr;
    }
     
    // (7) 회원 등급 추가
    function pushStatus(string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        status.push(MemberStatus({
            name: _name,
            times: _times,
            sum: _sum,
            rate: _rate
        }));
    }
    function return_owner() constant returns (address _owner){
        _owner = owner;
    }
    // (8) 회원 등급 내용 변경
    function editStatus(uint256 _index, string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        if (_index < status.length) {
            status[_index].name = _name;
            status[_index].times = _times;
            status[_index].sum = _sum;
            status[_index].rate = _rate;
        }
    }
     
    // (9) 거래 내역 갱신
    function updateHistory(address _member, uint256 _value) onlyCoin {
        tradingHistory[_member].times += 1;
        tradingHistory[_member].sum += _value;
        // 새로운 회원 등급 결정(거래마다 실행)
        uint256 index;
        int8 tmprate;
        for (uint i = 0; i < status.length; i++) {
            // 최저 거래 횟수, 최저 거래 금액 충족 시 가장 캐시백 비율이 좋은 등급으로 설정
            if (tradingHistory[_member].times >= status[i].times &&
                tradingHistory[_member].sum >= status[i].sum &&
                tmprate < status[i].rate) {
                index = i;
            }
        }
        tradingHistory[_member].statusIndex = index;
    }

    // (10) 캐시백 비율 획득(회원의 등급에 해당하는 비율 확인)
    function getCashbackRate(address _member) constant returns (int8 rate) {
        rate = status[tradingHistory[_member].statusIndex].rate;
    }
}
     

contract SNUCOIN is Owned{
    // 상태 변수 선언
    string public name; // 토큰 이름
    string public symbol; // 토큰 단위
    uint8 public decimals; // 소수점 이하 자릿수
    uint256 public totalSupply; // 토큰 총량
    mapping (address => uint256) public balanceOf; // 각 주소의 잔고
    mapping (address => int8) public blackList; // 블랙리스트
    mapping (address => Members) public members; // 각 주소의 회원 정보
     
    // 이벤트 알림
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Blacklisted(address indexed target);
    event DeleteFromBlacklist(address indexed target);
    event RejectedPaymentToBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event RejectedPaymentFromBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event Cashback(address indexed from, address indexed to, uint256 value);
     
    // 생성자
    function SNUCOIN(uint256 _supply, string _name, string _symbol, uint8 _decimals) {
        balanceOf[msg.sender] = _supply * 10 ** _decimals;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply * 10 ** _decimals;
        owner = msg.sender;
    }
     // 주소를 블랙리스트에 등록
    function blacklisting(address _addr) onlyOwner {
        blackList[_addr] = 1;
        Blacklisted(_addr);
    }
     // 주소를 블랙리스트에서 해제
    function deleteFromBlacklist(address _addr) onlyOwner {
        blackList[_addr] = 0;
        DeleteFromBlacklist(_addr);
    }
     // 회원 관리 계약 설정
    function setMembers(Members _members) {
        if (Members(_members).return_owner() == msg.sender) members[msg.sender] = Members(_members);
        else throw;
    }
     // 송금
    function transfer(address _to, uint256 _value) {
        // 부정 송금 확인
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        // 블랙리스트에 존재하는 계정은 입출금 불가
        if (blackList[msg.sender] > 0) {
            RejectedPaymentFromBlacklistedAddr(msg.sender, _to, _value);
        } else if (blackList[_to] > 0) {
            RejectedPaymentToBlacklistedAddr(msg.sender, _to, _value);
        } else {
            // (12) 캐시백 금액을 계산(각 대상의 비율을 사용)
            uint256 cashback = 0;
            if(members[_to] > address(0)) {
                cashback = _value / 100 * uint256(members[_to].getCashbackRate(msg.sender)) ;
                members[_to].updateHistory(msg.sender, _value);
            }
             balanceOf[msg.sender] -= (_value - cashback);
            balanceOf[_to] += (_value - cashback);
             Transfer(msg.sender, _to, _value);
            Cashback(_to, msg.sender, cashback);
        }
    }
}

// (1) 크라우드 세일
contract Crowdsale is Owned {
    // (2) 상태 변수
    uint256 public fundingGoal; // 목표 금액
    uint256 public deadline; // 기한
    uint256 public price; // 토큰 기본 가격
    uint256 public transferableToken; // 전송 가능 토큰
    uint256 public soldToken; // 판매된 토큰
    uint256 public startTime; // 개시 시간
    SNUCOIN public tokenReward; // 지불에 사용할 토큰
    bool public fundingGoalReached; // 목표 도달 플래그
    bool public isOpened; // 크라우드 세일 개시 플래그
    mapping (address => Property) public fundersProperty; // 자금 제공자의 자산 정보
     // (3) 자산정보 구조체
    struct Property {
        uint256 paymentEther; // 지불한 Ether
        uint256 reservedToken; // 받은 토큰
        bool withdrawed; // 인출 플래그
    }
     // (4) 이벤트 알림
    event CrowdsaleStart(uint fundingGoal, uint deadline, uint transferableToken, address beneficiary);
    event ReservedToken(address backer, uint amount, uint token);
    event CheckGoalReached(address beneficiary, uint fundingGoal, uint amountRaised, bool reached, uint raisedToken);
    event WithdrawalToken(address addr, uint amount, bool result);
    event WithdrawalEther(address addr, uint amount, bool result);
     // (5) 수식자(Q1.크라우드 세일 종료 후 실행 가능한 메서드 선언을 위함)
    modifier afterDeadline() { if (now >= deadline) _; }
     // (6) 생성자
    function Crowdsale (
        uint _fundingGoalInEthers,
        uint _transferableToken,
        uint _amountOfTokenPerEther,
        SNUCOIN _addressOfTokenUsedAsReward
    ) {
        fundingGoal = _fundingGoalInEthers * 1 ether;
        price = 1 ether / _amountOfTokenPerEther;
        transferableToken = _transferableToken;
        tokenReward = SNUCOIN(_addressOfTokenUsedAsReward);
    }
     // (7) 이름 없는 함수(Ether 받기)
    function () payable {
        // (Q2.개시 전 또는 기간이 지난 경우 예외 처리)
        if (!isOpened || now >= deadline) throw;
         // 받은 Ether와 판매 예정 토큰
        uint amount = msg.value;
        uint token = amount / price * (100 + currentSwapRate()) / 100;
        // 판매 예정 토큰의 확인(예정 수를 초과하는 경우는 예외 처리)
        if (token == 0 || soldToken + token > transferableToken) throw;
        // (Q3.자산 제공자)의 자산 정보 변경
        fundersProperty[msg.sender].paymentEther += amount;
        fundersProperty[msg.sender].reservedToken += token;
        soldToken += token;
        ReservedToken(msg.sender, amount, token);
    }
     // (8) 개시(토큰이 예정한 수 이상 있다면 개시)
    function start(uint _durationInMinutes) onlyOwner {
        if (fundingGoal == 0 || price == 0 || transferableToken == 0 ||
            tokenReward == address(0) || _durationInMinutes == 0 || startTime != 0)
        {
            throw;
        }
        if (tokenReward.balanceOf(this) >= transferableToken) {
          //(Q4. 시간 형태의 데이터타입이 없는 browser-solidity 에서 시간 경과는 어떻게 측정?)
            startTime = now;
            deadline = now + _durationInMinutes * 1 minutes;
            isOpened = true;
            CrowdsaleStart(fundingGoal, deadline, transferableToken, owner);
        }
    }
     // (9) 교환 비율(개시 시작부터 시간이 적게 경과할수록 더 많은 보상)
    function currentSwapRate() constant returns(uint) {
        // (Q5.시간 경과가 작을수록 많은 보상을 얻는 if구문)
        if (startTime + 1 minutes > now) {
            return 100;
        } else if (startTime + 2 minutes > now) {
            return 50;
        } else if (startTime + 3 minutes > now) {
            return 20;
        } else {
            return 0;
        }
    }
     // (10) (Q6. 남은 시간(분 단위))과 목표와의 차이(eth 단위), 토큰 확인용 메서드
    function getRemainingTimeEthToken() constant returns(uint min, uint shortage, uint remainToken) {
        if (now < deadline) {
            min = (deadline - now) / (1 minutes);
        }
        shortage = (fundingGoal - this.balance) / (1 ether);
        remainToken = transferableToken - soldToken;
    }
     // (11) 목표 도달 확인(기한 후 실시 가능)
    function checkGoalReached() afterDeadline {
        if (isOpened) {
            // (Q7.모인 Ether와 목표 Ether 비교)
            if (fundingGoal > this.balance) {
                fundingGoalReached = true;
            }
            isOpened = false;
            CheckGoalReached(owner, fundingGoal, this.balance, fundingGoalReached, soldToken);
        }
    }
     // (12) 소유자용 인출 메서드(판매 종료 후 실시 가능)
    function withdrawalOwner() onlyOwner {
        if (isOpened) throw;
        // 목표 달성: Ether와 남은 토큰. 목표 미달: 토큰
        if (fundingGoalReached) {
        // Ether
            uint amount = this.balance;
            if (amount > 0) {
                bool ok = msg.sender.call.value(amount)();
                WithdrawalEther(msg.sender, amount, ok);
            }
            // 남은 토큰
            uint val = transferableToken - soldToken;
            if (val > 0) {
                tokenReward.transfer(msg.sender, transferableToken - soldToken);
                WithdrawalToken(msg.sender, val, true);
            }
        } else {
            // 토큰
            uint val2 = tokenReward.balanceOf(this);
            tokenReward.transfer(msg.sender, val2);
            WithdrawalToken(msg.sender, val2, true);
        }
    }
     // (13) 자금 제공자용 인출 메서드(세일 종료 후 실시 가능)
    function withdrawal() {
        if (isOpened) return;
        // 이미 인출된 경우 예외 처리
        if (fundersProperty[msg.sender].withdrawed) throw;
        // 목표 달성: 토큰, 목표 미달 : Ether
        if (fundingGoalReached) {
            if (fundersProperty[msg.sender].reservedToken > 0) {
                tokenReward.transfer(msg.sender, fundersProperty[msg.sender].reservedToken);
                fundersProperty[msg.sender].withdrawed = true;
                WithdrawalToken(
                    msg.sender,
                    fundersProperty[msg.sender].reservedToken,
                    fundersProperty[msg.sender].withdrawed
                );
            }
        } else {
            if (fundersProperty[msg.sender].paymentEther > 0) {
                if (msg.sender.call.value(fundersProperty[msg.sender].paymentEther)()) {
                    fundersProperty[msg.sender].withdrawed = true;
                }
                WithdrawalEther(
                    msg.sender,
                    fundersProperty[msg.sender].paymentEther,
                    fundersProperty[msg.sender].withdrawed
                );
            }
        }
    }
} 
```

---

* ESCROW

```solidity
pragma solidity ^0.4.8;


contract Owned {
  
    address public owner; 

  
    event TransferOwnership(address oldaddr, address newaddr);

  
    modifier onlyOwner() { if (msg.sender != owner) throw; _; }

   
    function Owned() {
        owner = msg.sender; 
    }

    function transferOwnership(address _new) onlyOwner {
        address oldaddr = owner;
        owner = _new;
        TransferOwnership(oldaddr, owner);
    }
}


contract Members is Owned {

    address public coin; 
    MemberStatus[] public status; 
    mapping(address => History) public tradingHistory; 
     
  
    struct MemberStatus {
        string name;         
        uint256 times; 
        uint256 sum; 
        int8 rate; 
    }

    struct History {
        uint256 times; 
        uint256 sum; 
        uint256 statusIndex;  
        }
 

    modifier onlyCoin() { if (msg.sender == coin)  _; }
     

    function setCoin(address _addr) onlyOwner {
        coin = _addr;
    }
     

    function pushStatus(string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        status.push(MemberStatus({
            name: _name,
            times: _times,
            sum: _sum,
            rate: _rate
        }));
    }
 

    function editStatus(uint256 _index, string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner {
        if (_index < status.length) {
            status[_index].name = _name;
            status[_index].times = _times;
            status[_index].sum = _sum;
            status[_index].rate = _rate;
        }
    }
     

    function updateHistory(address _member, uint256 _value) onlyCoin {
        tradingHistory[_member].times += 1;
        tradingHistory[_member].sum += _value;

        uint256 index;
        int8 tmprate;
        for (uint i = 0; i < status.length; i++) {

            if (tradingHistory[_member].times >= status[i].times &&
                tradingHistory[_member].sum >= status[i].sum &&
                tmprate < status[i].rate) {
                index = i;
            }
        }
        tradingHistory[_member].statusIndex = index;
    }


    function getCashbackRate(address _member) constant returns (int8 rate) {
        rate = status[tradingHistory[_member].statusIndex].rate;
    }
}

contract SNUCOIN is Owned{

    string public name; 
    string public symbol; 
    uint8 public decimals;  
    uint256 public totalSupply; 
    mapping (address => uint256) public balanceOf; 
    mapping (address => int8) public blackList; 
    mapping (address => Members) public members; 
     

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Blacklisted(address indexed target);
    event DeleteFromBlacklist(address indexed target);
    event RejectedPaymentToBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event RejectedPaymentFromBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event Cashback(address indexed from, address indexed to, uint256 value);
     

    function SNUCOIN(uint256 _supply, string _name, string _symbol, uint8 _decimals) {
        balanceOf[msg.sender] = _supply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply;
    }
 

    function blacklisting(address _addr) onlyOwner {
        blackList[_addr] = 1;
        Blacklisted(_addr);
    }
 

    function deleteFromBlacklist(address _addr) onlyOwner {
        blackList[_addr] = -1;
        DeleteFromBlacklist(_addr);
    }
 

    function setMembers(Members _members) {
        members[msg.sender] = Members(_members);
    }
 

    function transfer(address _to, uint256 _value) {

        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;


        if (blackList[msg.sender] > 0) {
            RejectedPaymentFromBlacklistedAddr(msg.sender, _to, _value);
        } else if (blackList[_to] > 0) {
            RejectedPaymentToBlacklistedAddr(msg.sender, _to, _value);
        } else {

            uint256 cashback = 0;
            if(members[_to] > address(0)) {
                cashback = _value / 100 * uint256(members[_to].getCashbackRate(msg.sender));
                members[_to].updateHistory(msg.sender, _value);
            }
 
            balanceOf[msg.sender] -= (_value - cashback);
            balanceOf[_to] += (_value - cashback);
 
            Transfer(msg.sender, _to, _value);
            Cashback(_to, msg.sender, cashback);
        }
    }
}


contract Escrow is Owned {

    SNUCOIN public token;
    uint256 public salesVolume; 
    uint256 public sellingPrice;  
    uint256 public deadline;
    bool public isOpened; 

    event EscrowStart(uint salesVolume, uint sellingPrice, uint deadline, address beneficiary);
    event ConfirmedPayment(address addr, uint amount);
     

    function Escrow (SNUCOIN _token, uint256 _salesVolume, uint256 _priceInEther) {
        token = SNUCOIN(_token);
        salesVolume = _salesVolume;
        sellingPrice = _priceInEther * 1 ether;
    }
     
    // 직접 돈을 받는것이 아니라서.. 블록체인이 익명의 함수를 통해서.. 송금
    function () payable {

        if (!isOpened || now >= deadline) throw; //Q1. 개시 전 또는 기한이 끝난 경우에는 예외처리

         
        uint amount = msg.value;
        if (amount < sellingPrice) throw; //Q2. 판매 가격 미만인 경우 예외 처리         
         

        token.transfer(msg.sender, salesVolume);
        isOpened = false;
        ConfirmedPayment(msg.sender, amount);
    }
     

    // 개시(토큰이 예정수 이상이라면 개시, address(0)는 비어있는 주소를 지칭하는 변수)
    function start(uint256 _durationInMinutes) onlyOwner {
        if (token == address(0) || salesVolume == 0 || sellingPrice == 0 || deadline != 0) throw;
        if (token.balanceOf(this) >= salesVolume){  //Q3. 에스크로의 토큰 보유량이 판매량보다 많은 경우에만 개시      
            deadline = now + _durationInMinutes * 1 minutes;
            isOpened = true;
            EscrowStart(salesVolume, sellingPrice, deadline, owner);
        }
    }
     

    function getRemainingTime() constant returns(uint min) {
        if(now < deadline) {
            min = (deadline - now) / (1 minutes);
        }
    }
     

    // 이더리움의  this는 Contract의 주소
    function close() onlyOwner {

        token.transfer(owner, token.balanceOf(this));

        selfdestruct(owner);
    }
}


```

---

* 존재증명계약

```solidity
pragma solidity ^0.4.8;

contract RandomNumber {
    address owner;
    uint numberMax;

    struct draw {
        uint blockNumber;
    }

    struct draws {
        uint numDraws;
        mapping (uint => draw) draws;
    }

    mapping (address => draws) requests;

    event ReturnNextIndex(uint _index);

    function RandomNumber(uint _max) {
        owner = msg.sender;
        numberMax = _max;
    }

    function request() returns (uint) {
        uint _nextIndex = requests[msg.sender].numDraws;
        requests[msg.sender].draws[_nextIndex].blockNumber = block.number;
        requests[msg.sender].numDraws = _nextIndex + 1;
        ReturnNextIndex(_nextIndex);
        return _nextIndex;
    }

    // (1) 디버깅용으로 blockhash와 seed 값을 반환하도록 변경
    function get(uint _index) constant returns (int status, bytes32 blockhash, bytes32 seed, uint drawnNumber){
        if(_index >= requests[msg.sender].numDraws){
            return (-2, 0, 0, 0);
        }else{
            uint _nextBlockNumber = requests[msg.sender].draws[_index]. blockNumber + 1;
            if (_nextBlockNumber >= block.number) {
                return (-1, 0, 0, 0);
            }else{
                bytes32 _blockhash = block.blockhash(_nextBlockNumber);
// (2) 블록 해시 값, 사용자 주소, 예약 번호를 바탕으로 seed 값 계산
                bytes32 _seed = sha256(_blockhash, msg.sender, _index); // seed를 계산하는 함수
		// (3) seed 값을 바탕으로 난수 계산
                uint _drawnNumber = uint(_seed) % numberMax + 1;
		// (4) 상태, 블록 해시 값, 난수 계산의 기반이 되는 seed 값, 계산된 난수를 반환
                return (0, _blockhash, _seed, _drawnNumber);
            }
        }
    }
}
```
