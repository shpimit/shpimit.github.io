---
layout: page
title: Java
permalink: /Lecture/Java
---

## Java

### 1. 개발환경 Setting

### 2. Syllabus
1. 지난 학습 정리
* 코딩을 배워야 하는 이유(동영상)
* 미래의 언어 코딩(동영상)
2. 날짜와 시간 & 형식
3. 컬렉션
4. 지네릭스, 열거형, 어노테이션
* Junit
* 성능비교, 자바성은 튜닝
5. 쓰레드
6. 람다와 스트림
* 음수표현, 메모리 디버깅
7. 입출력 I/O
8. Networking
* Restful API GET 실습
* Neural Network 예측(아라한 문서)
* 링크 소프트웨어 세상(동영상)

### 3. 기초
```Java
```

### 4. [SpringBoot & Gradle 프로젝트 생성하기](http://jojoldu.tistory.com/250)
1. elipse에서 Spring Starter를 선택
2. 빌드툴은 Maven이 아닌 Gradle을 선택
3. Core의 Lombok, Web의 Web, SQL의 JPA, H2 , OPS의 Actuators 를 선택합니다.
4. build.gradle은 아래와 같습니다.

```gradle
buildscript {
	ext {
		springBootVersion = '2.0.2.RELEASE'
	}
	repositories {
		mavenCentral()
	}
	dependencies {
		classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
	}
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'org.springframework.boot'
apply plugin: 'io.spring.dependency-management'

group = 'com.example'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = 1.8

repositories {
	mavenCentral()
}


dependencies {
	compile('org.springframework.boot:spring-boot-starter-actuator')
	compile('org.springframework.boot:spring-boot-starter-data-jpa')
	compile('org.springframework.boot:spring-boot-starter-web')
	runtime('com.h2database:h2')
	compileOnly('org.projectlombok:lombok')
	testCompile('org.springframework.boot:spring-boot-starter-test')
}
```

5. Spring boot 간단한 Java파일은 아래와 같습니다.

```java
package com.example.simpletest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
public class SimpleTestApplication {

	public static void main(String[] args) {
		SpringApplication.run(SimpleTestApplication.class, args);
	}
	
	@Slf4j
	@Controller
	public static class AIController {
		
		@GetMapping("/hello")
		@ResponseBody
		public String helloworld() {
			return "hello world";
		}
	}
}
```
