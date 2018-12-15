# ESCROW

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

# 존재증명계약

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
