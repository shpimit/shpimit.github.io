---
layout: page
title: Microservice SpringBoot
summary: Microservice SpringBoot is space to learn with SpringBoot.
categories: Java
tags: Java
featured-img: microservice
comments: 마이크로 서비스 (with SpringBoot)
---

# Introducing Microservice SpringBoot !!

#####  Microservice SpringBoot is space to learn with SpringBoot.

---

## Contents

### Table of Contents

|No|Title|Remarks|
|-:|:--:|:--|
|0|[환경설정](#install)|SpringBoot환경셋팅|
|1|[커리큘럼](#syllabus)|커리큘럼 |
|2|[설계](#design)|실습|

---

## Learning

### Table of Learning

|No|구분|Title|Day|Remarks|
|-:|:-:|:--:|:-:|:--|
|1|온라인|스프링 부트를 이용한 웹 서비스 개발|2019.12.17 ~ 2020.01.16|`STS`|
|2|온라인|Spring Cloud를 활용한 MSA 기초|2019.12.29 ~ 2020.01.28|`Netflix OSS`|
|2|온라인|JPA 프로그래밍 기초|2020.03.09 ~ 2020.04.08|`JPA`|

---

<a name="install"/>

## Get Started(`SpringBoot`)

### 1. Intellij Multi Project 구성하기
* [IntelliJ 자바 멀티 프로젝트(모듈) 생성하기](https://whitepaek.tistory.com/47)

### 2. Tibero JPA 셋팅하기
* [Tibero + JPA](https://evohjo.wordpress.com/2019/10/04/jpa-project-crud-getting-started-with-java-only-in-intellij-ver-maven/)
* [Spring boot + tibero + mybatis 연동하기](https://blog.naver.com/rlqud1125/221465850967)

### 3. Swagger
* [Swagger](https://yookeun.github.io/java/2017/02/26/java-swagger/)

```gradle
compile 'io.springfox:springfox-swagger2:2.6.1'
compile 'io.springfox:springfox-swagger-ui:2.6.1'
```

### 4. Zipkin
```shell
java -jar zipkin-server-2.20.2-exec.jar
```

### 5. GCP
* [UEngine](https://workflowy.com/s/msa/27a0ioMCzlpV04Ib)

---

## Data & Source

### Table of Data & Source

|No|Title|Educational Institution|Source|Remarks|
|--:|:-:|:-:|:-:|:--|
|1|syntax.sol|<small>차세대융합콘텐츠산업협회</small>|[syntax.sol](/_pages/SpringBoot/src/NCIA/syntax.sol)|solidity 문법|

---

## Syllabus

### 1. DDD 설계
* Event 설계

### 2. UI 구축
* 윈도우 환경 기반 구축
* Geth 설치 → 네트워크 구축 가능 (기반 SpringBoot)

### 3. AWS 설치
* WEB 기반 접속
* AWS에서 ubuntu 기반 제작 연동 → aws 가입 → 상용화 관점
  * 사설네트워크용, 서비스용 2개 구축
  * 리눅스 기반 세팅 주제

##### [Go to Contents](#contents)

---

## Design

### 1. Hystrix

#### a. Hystrix로 Timeout 처리하기
* Hystrix를 통해 실행 되는 모든 메소드는 정해진 응답시간 내에 반환 되어야 한다.
* 그렇지 못한 경우, Exception이 발생하며, Fallback이 정의된 경우 수행된다.
* Timeout 시간은 조절할 수 있다. (Circuit 별로 세부 수정 가능하며 뒷 부분에 설명)
* 언제 유용한가 ? → 항상 !!
* 모든 외부 연동은 최대 응답 시간을 가정할 수 있어야 한다.
* 여러 연동을 사용하는 경우 최대 응답시간을 직접 Control하는 것은 불가능하다 (다양한timeout, 다양한 지연등..)

### 2. Ribbon(Client LoadBalancer)
* Client (API Caller) 에 탑재되는 S/W 모듈
* 주어진 서버 목록에 대해서 Load Balancing 을 수행함
* Ribbobn 의 장점 (단점도 있지만… )
  * H/W 가 필요 없이 S/W 로만 가능 (비용 down, 유연성 up)
  * 서버 목록의 동적 변경이 자유로움 (단 Coding 필요)
  * Load Balancing Schema 이 마음대로 구성 가능 (단 Coding 필요)

#### a. 주의
- Retry를 시도하다가도 HystrixTimeout이 발생하면, 즉시 에러 반환 리턴할 것이다.
(Hystrix로 Ribbon을 감싸서 호출한 상태이기 때문에)
- Retry를 끄거나, 재시도 횟수를 0으로 하여도 해당 서버로의 호출이 항상 동일한 비율
로. 실패하지는 않는다. (실패한 서버로의 호출은 특정 시간동안 Skip 되고 그 간격은 조정된
다 - BackOff)
- classpath 에 retry 가 존재해야 한다는 점 주의

#### b. 정리
- Ribbon은 여러 Component에 내장되어있으며, 이를 통해 Client Load Balancing이
수행 가능하다.
- Ribbon에는 매우 다양한 설정이 가능하다 (서버선택, 실패시 Skip 시간, Ping 체크)
- Ribbon에는 Retry기능이 내장 되어있다.
- Eureka와 함께 사용될 때 강력하다 (뒤에 실습)

### 3. Eureka
* Service Registry
  * 서비스 탐색, 등록
  * 클라우드의 전화번호부
  * (단점) 침투적 방식 코드 변경
* DiscoveryClient
  * spring-cloud 에서 서비스 레지스트리 사용 부분을 추상화(Interface)
  * Eureka, Consul, Zookeeper, etcd 등의 구현체가 존재

### 4. Feign
* Eureka + Ribbon + Hystrix

### 5. JPA

```sql
CREATE TABLE CUSTOMERS(
   ID   INT              NOT NULL,
   NAME VARCHAR (20)     NOT NULL,
   AGE  INT              NOT NULL,
   ADDRESS  CHAR (25) ,
   SALARY   DECIMAL (18, 2),       
   PRIMARY KEY (ID)
);
```
* org.hibernate  5.3.7.Final  -> jpa 2.1 사용

#### 5-1. Gradle
* build.gradle

```gradle
dependencies {
    implementation 'com.h2database:h2:1.4.200'
    implementation 'org.hibernate:hibernate-entitymanager:5.4.12.Final'
    compileOnly 'org.projectlombok:lombok:1.18.12'
    annotationProcessor 'org.projectlombok:lombok:1.18.12'

    testCompileOnly 'org.projectlombok:lombok:1.18.12'
    testAnnotationProcessor 'org.projectlombok:lombok:1.18.12'
    testCompile group: 'junit', name: 'junit', version: '4.12'
}

compileJava.options.encoding = "UTF-8"
tasks.withType(JavaCompile) {
    options.encoding = "UTF-8"
}

jar {
    manifest {
        attributes 'Main-Clas':'hellojpa.JpaMain'
    }
}
```

* jpa persistence.xml
  
```xml
    <persistence-unit name="hello">
        <class>hellojpa.entity.Member</class>  # 추가 해야 class 찾음
        <properties>
```

### 6. API 테스트코드
```json
POST http://localhost:8080/holder
Content-Type: application/json
{
  "holderName" : "kevin",
  "tel" : "02-1234-5678",
  "address" : "OO시 OO구"
}
```

```json
POST http://localhost:8080/account
Content-Type: application/json
{
  "holderID" : "계정 생성 후 반환되는 UUID"
}
```

```json
POST http://localhost:8080/deposit
Content-Type: application/json
{
  "accountID" : "계좌 생성 후 반환되는 UUID",
  "holderID" : "계정 생성 후 반환되는 UUID",
  "amount" : 300
}
```

```json
POST http://localhost:8080/withdrawal
Content-Type: application/json
{
  "accountID" : "계좌 생성 후 반환되는 UUID",
  "holderID" : "계정 생성 후 반환되는 UUID",
  "amount" : 10
}
```

### 7. Kafka
* 주키퍼 실행 ./bin/windows/zookeeper-server-start.bat config/zookeeper.properties
* Kafka 실행 ./bin/windows/kafka-server-start.bat config/server.properties
* 주키퍼 Consumer
```shell
./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic coffee --from-beginning
./bin/windows/kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic coffee --from-beginning
```
* 주키퍼 Producer
```shell
./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic coffee
./bin/windows/kafka-console-producer.bat --broker-list localhost:9092 --topic coffee
```
* Topic 생성
```shell
./bin/windows/kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic mytopic
```

## Reference

* gradle 3.0 이 나오면서 compile 은 deprecated 되었고, implementation 또는 api 를 써야 한다.

##### [Go to Contents](#contents)