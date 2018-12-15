# 블랙리스트

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