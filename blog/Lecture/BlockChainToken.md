
---
layout: page
title: Block Chain Token
summary: Block Chain Token is space to learn block chain algorithm & theory. 
permalink: /Lecture/BlockChainToken
---

---

<!-- $theme: gaia -->
<!-- *template: gaia -->
<!-- page_number: false -->

# Block Chain Token
#####  Block Chain Token is space to learn block chain algorithm & theory. 

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="contents"/>

* **Table of Contents**   

<span style="font-size:16pt">
  
|No|Titile|Explain|YMD|
|--:|:--:|:-:|:--:|
|1|[Reference Site](#site)|Reference|18-07-21|
|2|[Block Chain Token](#block)|블록체인|18-07-24|

---

<!-- *template: invert -->
<a name="site"/>

#### [Reference Site]  
* [jupyter](https://github.com/shpimit/shpimit.github.io/blob/master/_posts/Untitled.ipynb)


---

<!-- *template: invert -->
<a name="block"/>

#### [Block Chain Token]

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
