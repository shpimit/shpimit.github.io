// pragma solidity  >=0.4.22 <0.6.0;
pragma solidity  ^0.5.7;
// pragma experimental ABIEncoderV2;

contract Vote
{
    /*
     - 투표에 필요한 기능 구현
     - 기능
       > 음방 1위후보 등록 → contract 소유자
       > 후보별 이름/점수(득표) 조회
       > 일반 참여자(계좌를 가진자) 투표 가능 (1계좌당 1개)
       > 중복 투표 불가(경고 처리)
    */
    // 상태변수  → 스토리지 저장
    // 매핑(구조체 구성)
    // 매핑, 개별적 관리
    // 후보별 팀(이름)명 및 곡 정보 : 1개문자열
    mapping(uint8=>string) singerList;
    // 후보별 득표수 → 키를 위에 문자열을 이용
    mapping(string=>uint) singerScores;
    // who 투표를 하였는가?
    mapping(address=>bool) votes;
    /*
     후보자 등록시 번호를 자동 증가
     번호를 기억할 변수, 추가되면 자동증가 → 후보자의 고유키
    */
    uint8 numSinger;
    address contractOwner; // Contract 소유자, 구동자, 배포자
    // =============================================================================
    // 생성자
    // =============================================================================
    constructor() public {
        numSinger =0; // 초기화 안해도 0
        // 예) KBS, 선거관리위원회, 주관부서
        contractOwner = msg.sender; 
    }
    // =============================================================================
    // 함수
    // =============================================================================
    /*
     - 후보자 등록 : addSinger
     - 투표 처리    : vote
     - 이미 투표하였는지 체크 : voted
     - 후보자의 수 : getNumSinger
     - 후보자의 득표수 : getScoreSinger
     - 후보자의 이름 : getNameSinger
    */
    // 후보자 등록 : addSinger
    function addSinger(string memory name) public {
        // 리턴이라는 것은 동기식
        // 언제 완료될지 모르니까 대기했다가 완료되면 알려준다(이벤트) → 비동기식 →  트랙잭션
        // 1. 이미 등록을 하였는가? → 동명이인 배제
        bool isDup = false; // 충복이 최초에는 없다.   자료 구조사용 고민 dictionary도 나쁘지 않다
        
        for(uint8 i=0;i<numSinger;i++) {
            // 단순한 문자열 비교도 해쉬함수를 이용하여 변환하여 비교
            // 중복검사
            if(keccak256(bytes(singerList[i])) == keccak256(bytes(name))) {
                isDup = true;
                break;
            }
        }
        // 중복일경우 동기, 비중복일경우 비동기  이럴경우 비동기
        if(isDup) {
            // 이벤트 발생 → 결과를 전송
        } else {
            // add
            // 상태변수가 차지하고 있는 스토로지의 공간의 변화가 발생했다.
            // 트랜젝션의 대사→ 비용의 발생(gas)
            singerList[ numSinger] = name;
            // 득표수 추가 및 0으로 초기화
            singerScores[name] =0;
            // 후보수 증가
            numSinger++;
            // 이벤트 발생 → 결과를 전송

        }
    }
    // 투표 처리    : vote
    function vote(string memory name) public returns(bool) {
        // 투표 성공 여부에 대한 리턴 가능
        if (voted()) {
            // 이미 투표를 했다
            return false;
        } else {
            // 투표전
            votes[ msg.sender ] = true;
            // 득표를 증가
            singerScores[name]++;
            return true;
        }
    }
    // 이미 투표하였는지 체크 : voted
    // 해당 contract를 작동자(msg.sender)의 투표 여부 체크 : msg.sender(전역변수)  cf. 생성자에는 소유자
    function voted() public view returns (bool) {
        return votes[msg.sender];
    } 
    // 후보자의 수 : getNumSinger
    function getNumSinger() public view returns (uint8) {
        return numSinger;
    }
    // 후보자의 득표수 : getScoreSinger
    function getScoreSinger(string memory name) public view returns (uint) {
        return singerScores[name];
    }
    // 후보자의 이름 : getNameSinger
    function getScoreSinger(uint8 id) public view returns(string memory) {
        return singerList[id];
    }      

}