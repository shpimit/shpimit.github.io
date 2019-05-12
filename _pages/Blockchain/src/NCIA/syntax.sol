// 1.컴파일 버전에 대한 명시
// 0.4.22을 기반으로 작성되었고, 0.6.0까지 정상 작동함을 보장한다.
// pragma solidity  >=0.4.22 <0.6.0;
pragma solidity  ^0.5.7;


// 2.import

// 3. contract section
// 3-1. type
contract BasicType {
    function numTest() public pure returns(int, int8, uint, bool) {
        // 기본문장의 끝에는 ;를 반들시 붙인다
        int a = 10;
        // 수치형 확인
        // bool : true, false
        // int, uint : 부호가 있는 정수, 부호가 없는 정수
        // int8~ : 8bit 
        // int → int256으로 간략하게 사용 가능
        int8 b=10;
        uint c =1;
        bool d = true;
        
        
        return (a,b,c,d);
    }  
    
    // enum
    enum Level {
        Gold,
        Silver,
        Normal
    }
    function enumTest () public pure returns (Level, Level, Level) {
        Level a = Level.Gold;
        Level b = Level.Silver;
        Level c = Level.Normal;
        
        return (a, b,c);
    }
    // address : 주소형
    function addrTest() public view returns (address, address, address) {
        /*
         - 20 byte 크기의 자료형
         - contract의 주소, 계좌의 주소등을 담는 변수
         - 함수를 가지고 있고, 송금행위등 지원
           transfer(10), send(), ..
        */        
        // 주소값은 address(해쉬값)
        address payable x = address(0x124);
        //  this 현 contract의 주소:자기자신
        address myAddr     = address(this);
        
        //  msg.sender → 현 contract를 구동한자의 주소
        return (x, myAddr, msg.sender);
    }
    // tuple
    function tupleTest() public pure returns (int, int) {
        /*
         tuple
         - 여러 데이터를 묶는다
         - 타입이 달라도 ok
         - 여러 데이터를 한덩어리 묶어서 처리할때 → return
        */
        return (1, 2);
    }
    function tupleTest2() public pure returns (int, int, int) {
        (int x, int y) = tupleTest();
        // 그룹별 사용
        (x, y)         = (y, x);
        int c          = x;
        
        
        return (x, y, c);
    }
}

// contract
// 솔리디티 관점에서 컨트랙트는 많은함수(코드)와
// 데이터(상태)가 이더리움 블록체인 네트워크상에
// 특정 주소로 존재하는것 
contract ContractIs
{
    // 변수의 저장 위치
    // 1. storage : 상태변수, 함수내 지역변수
    // 2. memory: 함수의 매개변수, 함수의 리턴값
    // 3. callback : memory와 유사하나 external을 사용 매개변수쪽에 사용
    // 스토리지 공간인데 memory를 써서 명시적으로 저장 공간을 바꿀수 있다.
    // 상태변수
    int a = 10;
    // 함수
    function main() public view returns (int, int)
    {
        // 지역변수
        int b = a;
        return (b, a);
    }
    // 생성자
    constructor (int _a) public {
        a = _a;
    }
}

// getter, setter
contract GetSetIs {
    uint private data;
    
    // getter, setter 사용
    function setData( uint a) public {data =a;}
    // 상태변수를 함수 내부에서 읽겠다면 view 키워드 추가
    function getData() public view returns(uint) { return data; }
}

contract GetSetIsTest {
    function main() public returns (uint) {
        // contract create
        GetSetIs gs = new GetSetIs();
        gs.setData(3);
        return gs.getData();
    }
}

// function
contract FuncIs
{
    /*
     - 구조
       function 함수명 [] [] returns ()  {}
    
       function
       함수명
       [
          (가시성: visablity)
          external : contract상에서 명시된것만 외부에 공개
          public   : 모든 contract의 내부, 외부에 공개
          internal :  해당 contract와 상속된 contract에만 공개
          private  :  오직 해당 contract 계정에만 공개
       ]
       [
          (옵션:option)
          (구버전 contant →  view, pure → gas 발생이 안된다)
          view     : 열거하는 내용이 해당 함수에는 없어야 한다.
                       - 상태변수 값 변경
                       - 이벤트 발생
                       - 다른 contract 생성
                       - ether 전송
                       - view난 pure로 선언되지 않은 함수를 호출
                       - 인라인 어셈블 사용 
          pure     : 열거하는 내용이 해당 함수에는 없어야 한다.
                       - 상태변수 읽기
                       - xx.balance 접근 시도
                       - contract 기본 멤버 변수 (msg, tx, block, ...) 접근 행위
                       - pure로 정의되어 있지 않는 함수 호출
                       - 인라인 어셈블 사용
          payable : contract가 자신의 함수를 통해 다름 지갑, 다른 contract에 ether를 송금받는 행위등등
                      →   함수자체가 지불 가능한 상태로 제작하는 경우
       ]
       returns
       (
          타입
          or
          타입 변수명
        )
       {
          statement;
          // 리턴값이 존재하면
          return 값; or return (값, 값);
       }
    */
    int age  = 1;
    // 해당 함수의 가시성은 생략하면 public에 대한 가시시성
    // 부분에 불명확해짐으로 표시
    // 코드 자체를 살펴보니 상태변수를 읽기만 할뿐
    // 뭔가 값을 변경하거나 하는 행위가 없어서
    // 비용이 발생될만한 소지가 없으니 view를 넣어서
    // 처리를 해라
    function t() public view returns (int) {
        
        return age;
    }
    
    function t2() public view returns (int) {
        // age++;  //상태변수 변경시도
        
        return age;
    }
    
    // remove view
    function t3() public returns (int) {
        age++;
        
        return age;
    }    
    
    function t4() public pure returns (int) {
        // return age; //상태변수를 읽으려고 했다.
        return 10;
    }
    
    //  return =========================================
    // 리턴되는 값이 타입을 명시
    function add(uint x, uint y) public pure returns (uint) {
        uint results = x + y;
        
        return results;
    }
    
    // 리턴되는 값의 타입과 변수명 명시
    function add2(uint x, uint y) public pure returns (uint results) {
        // 해당 변수는 이미 타입이 정해져 있으르로  사용시 타입을 명시 하지 않는다.
        results = x + y;
        
        return results;
    }
    
    function a() external pure {
        
    }
    
    function b() private pure {
        
    }
    /*
    함수 구현은
    - 기능을 먼저 구현하고
    - 다루는 데이터(조건)에 따라 옵션조건 부여
    - 비용적인 측면, 사용되는 가시성 측면 고려
    - 함수의 정의를 계속 수정
    */
}

// 생성자 테스트
contract ContractShape
{
    uint cnt;
    address from;
    address to;
    // 생성자 
    constructor (uint _cnt, address _from, address _to) public {
        cnt  = _cnt;
        from =  _from;
        to   = _to;
    }
    function checkCnt() public view returns (uint) {
        return cnt;
    }
}

contract ContractShapeTest
{
    // contract 생성을 상태변수 진행 : ok
    ContractShape cs = new ContractShape(10, address(0xFF), address(0xAB));
    
    function log() public view returns (uint) {
        return cs.checkCnt();
    }
}

// 조건문, 반복문, 제어문
contract CondiLoopTest
{
    /*
     - 조건문, 반복문, 제어문
     - 기존언어 자바계열과 크게 다르지 않다
     - if, for, while, do~wihile, break, continue
     - 삼항 연산자
    */
    function getCoffePriceCheck(uint price) public pure returns(int8) {
        if (price > 1500)         return 1;
        else if (price < 1500)    return -1;
        else                      return 0;
    }
    
    // 삼항 연산자
    // 조건 ? 참이면코드 : 거짓이면 코드
    function threeCheck(uint x) public pure returns (uint result) {
        
        // 리턴 형식에 변수명을 사용하면  return 생략 가능
        result = x > 10 ? (x > 2 ? 11 : 1004):0;
    }
    // for
    // forCheck(uint value), → 누적합 :  forCheck(5) → 0+1+2+3+4+5
    function forCheck(uint value) public pure returns (uint result) {
        
        result = 0;
        
        for(uint i=value; i > 0; i--) 
            result += i;
    }
    
    function forCheck2(uint value) public pure returns (uint sum, uint mul) {
        
        sum = 0;
        mul = 1;
        
        for(uint i=value; i > 0; i--) {
            sum += i;
            if(i>0)
                mul *= i;
        }

    }
    
    // while : 0~무한대(언제끌날지 모르겠다), do~while : 1~무한대(언제끝날지 모르겠다)
    function whileCheck(uint param) public pure returns(uint, uint){
        
        (uint n, uint n2, uint i) = (0, 0, 0);
        
        while(i< param) {
            n += i;
            if(i> 10) 
                break;
            i++;
            
        }
        i=0;
        
        do {
            i++;
            if(i%2 == 0) {
                continue;
            }
            if (i > 10) {
                break;
            }
            n2 += i;
            
        } while(i <param);
        
        return (n, n2);
    }
}
// 타입의 형변환
contract AsTypeTest
{
    /*
     - 암묵적 형변환
       > 작은타입 → 큰타입
     - 명시적 형변환
       > 큰타입 → 작은타입
    */
    function asType() public pure returns (uint256, int8) {
        uint8 a    = 1;
        uint256 b  = 1;
        // 암묵적 형변환
        uint256 c  = a;
        // 명시적 형변환
        int8    d   = int8(b);
        return (c, d);
    }
}

// Array
contract ArrayTest
{
    // 상태변수 → stroage
    // 배열선언
    uint8[2] myArr1;
    // 배열선언 + 초기화
    uint8[2] myArr2 = [1,2];
    uint[]   myArr3 = [1,2];
    uint[]   myArr4 = new uint[](2);
    
    // 복합 타입을 리턴할 경우 memory, 키워드를 같이 표방
    // → 리턴하는 변수가 storage이면 리턴 불가
    // → 변수가 선언될때 변수명 앞에 사용한 키워드 그대로 사용(가시성 제거)
    function arrTest1() public view returns (uint256, uint256[] memory) {
        // 지역변수 → storage
        // define
        uint8[2] memory arr4;
        // 지역변수에서 배열생성시 사이즈를 부여하여 값넣고 초기화
        uint8[3] memory arr1 = [1,2,3];
        // new를 통해서 사이즈 넣고 생성
        uint8[] memory arr2 = new uint8[](arr1.length);

        // error
        // uint8[] memory arr3 = [1,2,3];
        // 포인터가 대입되었다
        // storage → memory에 대입하는 케이스
        uint256[] memory arr5 = myArr3;
        
        return (arr5[0], arr5);
    }
    
    // 바이트 배열(고정, 동적)
    // byte, bytes(1~32) <-> byte <->string
    function byteTest() public pure
    returns(byte and_v, byte or_v, byte xor_v, byte neg_v) {
        // byte → 1 byte
        byte a = 0x00;
        byte b = 0xFF;
        // bit 연산
        
        and_v = a & b;
        or_v = a | b;
        xor_v = a ^ b;
        neg_v = ~a;
        
    }
    
    // bytes : 정적 바이트 배열
    function bytesTest() public pure
    returns (bytes2 staticBytesArr) {
        // bytes : 이미 선언시 고정 크기를 가진다
        // error
        // staticBytesArr = "ABC";
        staticBytesArr = "AB";
        // 바이트배열을 동적으로 만들어서 제공하면 값이 사이즈를 넘는다  → 유동적 조절→ gas 발생→ 고정크기 추천
        // bytes는 이미 배열이라서 [] 기호 안써도 됩니다.
        bytes memory dyBytestArr = new bytes(2);
        dyBytestArr = "AB";
        // 유동적 크기변화가 발생
        dyBytestArr = "ABC";
    }
    // 정적 바이트 배열 생성 → 값부여 → 바이트 배열 카피 → 리턴
    function bytesToByteArrayTest() public pure returns(byte[] memory){
        // bytes  → byte[]
        bytes memory tmp = new bytes(5);
        tmp = "ABCDE";
        
        byte[] memory result = new byte[](tmp.length);
        // copy with for
        
        for(uint8 i = 0; i < tmp.length; i++) {
            result[i] = tmp[i];
        }
        
        return result;
    }
    // bytes <-> string
    function bytesToString() public pure returns (string memory) {
        bytes memory tmp = new bytes(5);
        tmp = "ABCD가나다123!@#";
        
        string memory s = string(tmp);
        return s;
    }
}
//  byte <-> bytes(1~32) <-> string
//  string : 라이브러리
contract StringTest
{
    // 문자열 사용간 필요한 라이브러리 정의
    // 1. byteArrayToString()
    // 2. 입력 : byteArray
    // 출력 : string
    function byteArrayToString(byte[] memory str) public pure returns(string memory) {
        bytes memory strbytes = new bytes(str.length);
        
        for(uint i = 0; i < str.length; i++) {
            strbytes[i] = str[i];
        }
        
        // string memory s = string(strbytes);
        
        // return s;
        return  string(strbytes);
    }
    
    // stringToByteArray
    // string →  bytes → byte[]
    // bytes(string) byte(bytes)
    function stringToByteArray(string memory str) public pure returns(byte[] memory) {
        // string → bytes
        bytes memory buffer = bytes(str);
        // bytes → byte[]
        byte[] memory buff = new byte[](buffer.length);       
        
        for(uint i=0; i < buffer.length; i++ ){
            buff[i] = byte(buffer[i]);
        }

        return buff;

    }
    
    function testBATS(string memory src) public pure returns(string memory) {
        return byteArrayToString(stringToByteArray(src));
    }
    
    // 1. 문자열 더하기 addString(string, string)    →  string
    function addString(string memory str1, string memory str2) public pure returns(string memory) {
        // string → bytes
        bytes memory tmp1 = bytes(str1);
        bytes memory tmp2 = bytes(str2);
        
        // bytes buffer
        bytes memory tmp3 = new bytes(tmp1.length + tmp2.length);
        
        for(uint i=0 ;i < tmp1.length; i++) {
            tmp3[i] = tmp1[i];
        }
        for(uint i=0 ;i < tmp2.length; i++) {
            tmp3[tmp1.length+i] = tmp2[i];
        }        

        return string(tmp3);
    }
    // 2. 문자열 자르기 subString(string, sIdx, size) → string
    // 한글처리는 일단배제
    // 직접적용해보니 3byte로 처리가 되었다
    // 인코딩(utf8 or euc-kr등 한글처리에 대한 고민)
    function subString(string memory str1, uint sIdx, uint size) public pure returns(string memory) {
        // string → bytes
        bytes memory tmp1 = bytes(str1);
        
        // checking sIdx + size > bytes.length → error, 원본리턴
        if(sIdx + size > tmp1.length) {
            return str1;
        }

        // buffer create
        bytes memory tmp2 = new bytes(size);
        
        for(uint i=0 ;i < size; i++) {
            tmp2[i] = tmp1[sIdx+i];
        }
        
        return string(tmp2);
    }
}

// mapping → dictionary
/*
 매핑
 - dictionary 구조 →  key, value 쌍으로 구성
 - mapping ( address => uint) public balance;
   키 : 모든 자료형이 가능
   public getter 자동생성
*/
contract MappingMod
{
    mapping(address =>uint) public balance;
    
    function setBalance(address addr, uint value) public {
        balance[addr] = value;
    }
    // 내가 구동한 contract에서 다른 contract를 생성했을시
    // 다른 contract의 msg.sender는 누구인가?
    // blance[msg.sender] = value 는 동작 하지 않는다.
}
contract MappingTest
{
    MappingMod mm = new MappingMod();
    
    function test(uint value) public returns(uint) {
        // 매핑 변수에 값 설정
        mm.setBalance(msg.sender, value);
        // 매핑 변수에서 데이터 힉득
        // 변수(키)

        return mm.balance(msg.sender);
    }
}

// struct
// 구조체 반환시
pragma experimental ABIEncoderV2;
contract StructTest
{
    /*
     구조체
     - 사용자 정의 타입
     - 어떤 타입도 맴버로 담을 수 있다
     - 매핑의 키로 사용은 불가
     - 구조체는 스토리지에 저장
     - 원본 주의(자기 참조시)
       → depth 제한 : 3 depth
           구조체 3depth
           mapping의 값으로 사용시 2depth
    */
    // define
    struct person {
        uint32 birth;
        bool isMale;
    }
    
    struct player {
        person p;
        uint8 team;
        uint8[2] points;
    }
    mapping (address=>player) players;
    
    // create
    player p1 = player( person(990919, true), 10, [90, 80]);
    
    constructor() public {
        // 매핑에 데이터 추가
        players[ msg.sender ] = p1;
    }
    // getPlayer() => player
    function getPlayer() public view returns(player memory) {
        return players[msg.sender];
    }
    // player's mean
    function getPlayerMean() public view returns(uint) {
        uint sum = players[msg.sender].points[0] + players[msg.sender].points[1];
        uint mean = uint( sum / players[msg.sender].points.length);
        
        return mean;
    }
    // 매핑, 배열구조로 사용이 가능하나 depth 제한
    // B tree : 자기 자신을 자식으로 3번
    struct caseA
    {
        uint a;
        caseA[] b;
    }
    // binary tree :자기자신을 자식으로 2개
    struct caseB
    {
        uint a;
        mapping(bool => caseB) b;
    }

}

// 상속, 추상, 인터페이스
/*
 상속
 - contract 상속
 - 부모의 맴버를 그대로 사용
 - 자식은 재정의, 추가 가능
 - 인터페이스, 추상
*/
contract A
{
    function f() public pure returns (uint) {
        return 10;
    }
}
contract B
{
    function f() public pure returns (uint) {
        return 20;
    }
    function f2() public pure returns (uint) {
        return 30;
    }    
}
// 상속
// 부모들이 함수명이 동일하면
// 나중에 상속받은 소속 함수가 최종
contract C is A, B {}
contract D is B, A {}
contract E is B, A {
    // override
    function f() public pure returns(uint) {
        return 1004;
    }
}
/*
 추상 컨트랙트
 - contract 내부가 함수 선언만 but 구현된 함수도 포함 ok
 - 스스로 생성 불가
 - 틀이라는 형태로 많이 사용
*/
contract Form
{
    function eat(string memory food) public pure returns(bool);
    function f() public pure returns (uint) {
        return 11;
    }    
}
contract F
{
    function f() public pure returns (uint) {
        return 50;
    }
}
contract G is F, Form
{
    // 추상화된 함수를 구현
    function eat(string memory food) public pure returns(bool) {
        return true;
    }
}
// 인터페이스
interface Form2
{
    // 함수들은 external로 선언되어야 한다.
    function eat2(string calldata food) external pure returns(bool);
}
contract H is F, Form2
{
    function eat2(string calldata food) external pure returns(bool) {
        return true;
    }
}
// event(contract에서 이벤트를 발생 →   예를 들면 NODE 전달)
/*
 이벤트
 - 함수 실행 중간에 이벤트를 발생시켜
 - 특정 데이터를 외부(web3사용하는)로 전달하는 역할
 - javascript에서는 콜백함수를 통해서 전달
 - 비동기
*/
contract EventTest
{
    event myEvent (
        address _from,
        address _to,
        uint _amt
    );
    // 비동기 상황이 존재했고
    function pay(address _to) public payable {
        // 예를 들어 송금하는 행위는 비동기식이여서 리턴을 잡아주면 블럭이 발생
        // 이벤트를 발생 → 이벤트가 전달되면 그때 따음 스텝 처리
        emit myEvent(msg.sender, _to, msg.value);
    }
}

// library
/*
 라이브러리
 - 특정 주소에 한번 배포되면, 다양한 contract들이 재사용 가능
 - 라이브러리 함수가 호출되면 호출한 contract에서 실행
 - contract는 라이브러리의 저장소(스토리지)접근 가능
 - 라이브러리는 상태변수를 가질수 없고, 상속 미지원, 이더도 받을 수 없다.
*/
library math {
    function addInt(int a, int b) public pure returns (int c) {
        return a + b;
    }
}
library math2 {
    // 라이브러리는 상태변수를 가질수 없고 → 우회적으로 해결
    struct m1Struct { int a; }
    struct m2Struct { int a; }
    function addInt (m1Struct storage s, int value) public view returns(int c) {
        return s.a + value;
    } 
    function mulInt (m2Struct storage s, int value) public view returns(int c) {
        return s.a * value;
    }    
}
contract LibTest
{
    using math2 for *;
    math2.m1Struct m1;
    math2.m2Struct m2;
    
    function test() public returns (int, int, int) {
        m1 = math2.m1Struct(10);
        m2 = math2.m2Struct(5);
        
        return (math.addInt(1,2), m1.addInt(10),  m2.mulInt(2));
    }
}