---
layout: page
title: Java Performance Computing
summary: Java performance computing. 
categories: HPC
tags: Java
featured-img: HPC
comments: 자바 성능 튜닝 이야기
---
name: inverse
class: center, middle, inverse
layout: true
title: AI 고속처리 시스템

---

# Introducing Java Performance !!

#### From. 자바 성능 튜닝 이야기

---

## Overview

> 아키텍트는 일반 개발자와 무엇이 다른가?  나는 그 차이가 압도적인 프로젝트 경험 수의 차이라고 본다

---

layout: false

## Contents

### 1. web서버 access.log

### 2. 시스템 리소스 모니터링

* ganglia

### 3. 부하생성

* nGrinder

### 4. 성능측정

* Response Time
* TPS

### 5. 애플리케이션 서버

* 1차 모니터 링 : 스레드의 수와 큐의길이, 유휴(Idle Thread)가 0이 되면 요청메시지가 앞단의 큐에 저장(JMX - Java Management Extension)

### 6. DB서버

* [slow query](http://dev.mysql.com/doc/refman/5.6/end/slow-query-log.html)
* [튜닝](http://dev.mysql.com/doc/refman/5.6/en/using-explain.html)

### 7. 인프라

* CPU, 메모리, Disk IO : iostat, sar         * 로깅은 메시지큐를 사용하여 해결

### 8. 성능 측정

* 프로파일링 : xhprof --php
* ptrace : System Call     테스트 장비 안됨
* pmap : 메모리 snap shot     ex) pmap -ooffset,rsz,name 19754

### 9. JVM 튜닝

* Xverbosegc   Perm, Eden, Old  모든 영역에 대한 GC정보 보는법