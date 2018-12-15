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