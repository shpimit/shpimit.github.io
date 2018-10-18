---
layout: page
title: Java
permalink: /Lecture/Java
---

<!-- *template: gaia -->
<!-- page_number: false -->

# Introducing Java !!
##### (Universal Language)

* **Table of Learning**

|No|Title|Educational Institution|Term|
|--:|:--:|:-:|:--:|
|1|[Java 개발자를 위한 Apach Spark2 빅데이터 분서과 처리](/Lecture/TensorFlow)|한국정보기술연구원|18.10.17~10.19|

---

<!-- $theme: gaia -->
<!-- page_number: true -->

## Overview

> 자바(영어: Java, 문화어: 자바)는 썬 마이크로시스템즈의 제임스 고슬링(James Gosling)과 다른 연구원들이 개발한 객체 지향적 프로그래밍 언어이다.
> <small>-- *1991년 그린 프로젝트(Green Project)라는 이름으로 시작해 1995년에 발표했다.* </small>

---

<!-- *template: invert -->  

## Contents

<a name="contents"/>

* **Table of Contents**   

|No|Titile|Remarks|
|--:|:-:|:--|
|0|[환경설정](#install)|환경설정|
|1|[기본실행](#execute)|기본실행|
|2|[Syllabus](#syllabus)|기본학습|

---

### 1. 개발환경 Setting

<a name="install"/>

* [OpenJDK9](http://jdk.java.net/java-se-ri/9)
* [IJava](https://github.com/SpencerPark/IJava)

> Jupyter에 Java Kernel을 설치하는 방법
> IJava는 JDK >= 9 로 되어 있으나 실제 JDK=9에서만 돌아가는 것으로 보인다.
> 설치하는 방법도 python 컴파일 방법으로는 잘 동작하지 않으니 실제 binary파일을 받고 설치하는것이 좋다.
> jupyter kernelspec list

* [IJava release](https://github.com/SpencerPark/IJava/releases)

```python
# Pass the -h option to see the help page
python3 install.py -h

# Otherwise a common install command is
python3 install.py --sys-prefix
```

---

### 2. Scala 환경 Setting

> eclipse plug in (scala IDE)
> Help-Marketplace
> find 검색창에 scala로 검색하고  검색결과중  4.7 scala IDE를 선택한다
> Open perspective -> scala를 선택하면  s가 붙은 아이콘이 생성이 된다.
> Window->prefereces->scala->installations 에 2.11이 선택되어 있는지 확인한다.

---


<a name="syllabus"/>

### 기본 실행

* SPARK_HOME /usr/local/spark
* Hadoop Echo 실행하는 법
  * start-all.sh
* Hadoop 서비스 확인 하는법
 * console에서 확인 하는법 : jps
 * 브라우저에서 확인 하는법 : http://localhost:50070
* Hive 실행하는법
 * hive --service metastore
* Spark alone으로 띄우고 싶으면 hive config를 주석 처리해야함
```
cd /usr/local/spark
ls
cd conf
hive-site.xml
gedit hive-site.xml
comment -> standalone spark
<!-- <property>
  <name>hive.metastore.uris</name>
  <value>thrift://localhost:9083</value>
  </property>
-->
```


---

<!-- *template: invert -->

## Data & Source 

<a name="data"/>

* **Table of Data & Source** 

|No|Title|Remarks|
|--:|:-:|:--|
|0|[jsoup.ipynb](https://github.com/shpimit/shpimit.github.io/tree/master/blog/Java/src/jsoup.ipynb)|WebCrawling|

---

* **Table of Data & Source for Scala** 

|No|Title|Remarks|
|--:|:-:|:--|
|0|[Date](#srcdate)|주어진 데이터에는 일요일 갯수 확인|
|1|[WC](#srcwordcount)|주어진 파일의 단어 갯수 계산|
|2|[Top3](#srcwctop3)|주어진 파일의 Top3단어 추출|
|3|[Join](#srcjoin)|RDD join 소스|

---

### 2. Syllabus

<a name="syllabus"/>

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

---

<a name="srcdate"/>

### 3. Scala 소스

#### Date 소스

> scala shell에서 돌리기
> ./bin/spark-shell --master local --packages joda-time:joda-time:2.8.2

```scala
import org.joda.time.{DateTime, DateTimeConstants}
import org.joda.time.format.DateTimeFormat
import org.apache.spark.{SparkConf, SparkContext}

val filePath = "file:///home/hadoop_user/scalasrc/data/date.txt"

val textRDD = sc.textFile(filePath)

val dateTimeRDD = textRDD.map { dateStr =>
val pattern =
  DateTimeFormat.forPattern("yyyyMMdd")
  DateTime.parse(dateStr, pattern)
}
dateTimeRDD.foreach(println)

val sundayRDD = dateTimeRDD.filter { dateTime =>
dateTime.getDayOfWeek == DateTimeConstants.SUNDAY
}

val numOfSunday = sundayRDD.count
println(s"주어진 데이터에는 일요일이 ${numOfSunday}개 들어 있습니다.")
```

---

#### WordCount 소스

> scala shell에서 돌리기
> ./bin/spark-shell --master local

```scala
val filePath="file:///home/hadoop_user/scalasrc/data/README.md"

// _는 case랑 같은거고, filter는 if, p{Alnum}은 특수문자 제거
val wordAndCountRDD = sc.textFile(filePath).
              flatMap(_.split("[ ,.]")).
              filter(_.matches("""\p{Alnum}+""")).
              map((_, 1)).
              reduceByKey(_ + _)


// 모든 단어의 등장횟수를 출력한다
wordAndCountRDD.collect.foreach(println)

val filePath="file:///home/hadoop_user/hanbit/README.md"
val wordAndCountRDD = sc.textFile(filePath).
              flatMap(_.split("[ ,.]")).
              filter(_.matches("""[A-Za-z]+""")).
              map((_, 1)).
              reduceByKey(_ + _)


// 모든 단어의 등장횟수를 출력한다
wordAndCountRDD.collect.foreach(println)

//conf [A-Za-z0-9]+===\p{Alnum}+  +1개이상
//filter(_.matches("""[A-Za-z0-9]+""")).
```

---

#### WordCount Top3 단어 추출 소스

> scala shell에서 돌리기
> ./bin/spark-shell --master local

```scala
import org.apache.spark.{SparkConf, SparkContext}

val filePath="file:///home/hadoop_user/scalasrc/data/README.md"
val wordAndCountRDD = sc.textFile(filePath).
                      flatMap(_.split("[ ,.]")).
                      filter(_.matches("""\p{Alnum}+""")).
                      map((_, 1)).
                      reduceByKey(_ + _)
      
// 등장횟수가 가장 많은 단어 세개를 찾는다
val top3Words = wordAndCountRDD.map {
case (word, count) => (count, word)
}.sortByKey(false).map {
case (count, word) => (word, count)
}.take(3)

// 등장횟수가 가장 많은 단어 톱쓰리를 표준출력으로 표시한다
top3Words.foreach(println)
```

---


#### RDD join 소스

> scala shell에서 돌리기
> ./bin/spark-shell --master local

```scala

import scala.collection.mutable.{HashMap, Map}
import java.io.{BufferedReader, InputStreamReader, Reader}
import org.apache.hadoop.conf.Configuration
import org.apache.hadoop.fs.{FileSystem, Path}
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.broadcast.Broadcast
import org.apache.spark.rdd.RDD

// UML type : type이 뒤에 나옵니다.
// record는 한줄씩 읽어드립니다.
// (productId, numOfSold) 튜플 형식으로 바꾸어라
def createSalesRDD(csvFile: String) = {
    val logRDD = sc.textFile(csvFile)
    logRDD.map { record =>
      val splitRecord = record.split(",")
      val productId = splitRecord(2)
      val numOfSold = splitRecord(3).toInt
      (productId, numOfSold)
    }
  }

val salesOctRDD=createSalesRDD("file:///home/hadoop_user/scalasrc/data/sales-october.csv")
salesOctRDD.foreach(println)
salesOctRDD.count
val salesNovRDD=createSalesRDD("file:///home/hadoop_user/scalasrc/data/sales-november.csv")
salesNovRDD.foreach(println)

def createOver50SoldRDD(rdd: RDD[(String, Int)]) = {
    rdd.reduceByKey(_ + _).filter(_._2 >= 50)
  }

val octOver50SoldRDD=createOver50SoldRDD(salesOctRDD)
octOver50SoldRDD.foreach(println)
val novOver50SoldRDD=createOver50SoldRDD(salesNovRDD)
novOver50SoldRDD.foreach(println)



val bothOver50SoldRDD=octOver50SoldRDD.join(novOver50SoldRDD)
bothOver50SoldRDD.foreach(println)


val over50SoldAndAmountRDD = bothOver50SoldRDD.map {
        case (productId, (amount1, amount2)) =>
          (productId, amount1 + amount2)
      }
over50SoldAndAmountRDD.foreach(println)

def createProductRDD(csvFile: String) = {
    val logRDD = sc.textFile(csvFile)
    logRDD.map { record =>
      val splitRecord = record.split(",")
      val productId = splitRecord(0)
      val productName = splitRecord(1)
      val unitPrice = splitRecord(2).toInt
      (productId, (productName,unitPrice))
    }
  }

val productRDD2=createProductRDD("file:///home/hadoop_user/scalasrc/data/products.csv")
productRDD2.foreach(println)

//(20,(인절미(4개),10000))

over50SoldAndAmountRDD.foreach(println)
//(8,140)
//(15,131)

val saleAndProdRDD=over50SoldAndAmountRDD.join(productRDD2)
saleAndProdRDD.foreach(println)

//(8,(140,(강정(10개),15000)))
//(15,(131,(생과자(10개),17000)))

val saprdd=saleAndProdRDD.map { case (productId,(numOfSold,(productName,unitPrice))) =>
      (productName, numOfSold, numOfSold * unitPrice)
    }
saprdd.foreach(println)


// 결과를 계산해 파일시스템이 출력한다
saprdd.saveAsTextFile("file:///home/hadoop_user/scalasrc/data/results3")

```

---

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

---

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
