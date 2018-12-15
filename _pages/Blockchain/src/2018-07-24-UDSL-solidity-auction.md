# 경매

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