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
|4|[Hive](#srchive)|Hive SQL 소스|
|5|[Hive Groupby](#srGroupby)|Hive Groupby 소스|
|6|[Hive Parquet](#srcParquet)|Parquet save examples|
|7|[SparkSession](#srcSession)|SparkSession car examples|
|8|[SparkSession1](#srcSession1)|SparkSession car1 examples|
|9|[SparkSession2](#srcSession2)|SparkSession car2 examples|
|10|[DS1](#srcDS1)|DS1 examples|
|11|[DS2](#srcDS2)|DS2 examples|
|12|[DS3](#srcDS3)|DS3 examples|
|13|[DS4](#srcDS4)|DS4 examples|
|14|[DS5](#srcDS5)|DS5 examples|
|15|[DS6](#srcDS6)|DS6 examples|
|16|[MLlib](#srcMLliv)|MLlib 상품과 날씨 영향 소스example|
|17|[ML](#srcML)|ML 상품과 날씨 영향 소스example|
|18|[ML1](#srcML1)|ML 차 판매량 소스 example|

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

#### Hive 쿼리 소스

> scala shell에서 돌리기
> /usr/local/spark/bin/spark-shell --master local

```scala
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._

  // register case class external to main
  case class Employee(EmployeeID : Int, 
    LastName : String, FirstName : String, Title : String,
    BirthDate : String, HireDate : String,
    City : String, State : String, Zip : String, Country : String,
    ReportsTo : String)
    
    val sqlContext = new org.apache.spark.sql.SQLContext(sc)
    //import sqlContext.createSchemaRDD // to implicitly convert an RDD to a SchemaRDD.
    import sqlContext.implicits._
    //import sqlContext._
    //import sqlContext.createDataFrame
    //import sqlContext.createExternalTable
    //
    val employeeFile = sc.textFile("file:///home/hadoop_user/scalasrc/data/NW-Employees-NoHdr.csv")
    println("Employee File has %d Lines.".format(employeeFile.count()))
    val employees = employeeFile.map(_.split(",")).
      map(e => Employee( e(0).trim.toInt,
        e(1), e(2), e(3), 
        e(4), e(5), 
        e(6), e(7), e(8), e(9), e(10)))
     println(employees.count)
     employees.toDF().registerTempTable("Employees")
     var result = sqlContext.sql("SELECT EmployeeID,LastName from Employees")
     result.show()
     result = sqlContext.sql("SELECT * from Employees WHERE State = 'WA'")
     result.show()
     System.out.println("** Done **")    
```

---

#### Hive 쿼리1 소스

> scala shell에서 돌리기
> /usr/local/spark/bin/spark-shell --master local

```scala
case class Employee(EmployeeID : String, 
   LastName : String, FirstName : String, Title : String,
   BirthDate : String, HireDate : String,
   City : String, State : String, Zip : String,  Country : String,
   ReportsTo : String)
//
case class Order(OrderID : String, CustomerID : String, EmployeeID : String,
  OrderDate : String, ShipCountry : String)
//
case class OrderDetails(OrderID : String, ProductID : String, UnitPrice : Double,
  Qty : Int, Discount : Double)
//
val filePath = "file:///home/hadoop_user/scalasrc/"
println(s"Running Spark Version ${sc.version}")
//
val employees = spark.read.option("header","true").
	csv(filePath + "data/NW-Employees.csv").as[Employee]
println("Employees has "+employees.count()+" rows")
employees.show(5)
employees.head()
//
employees.createOrReplaceTempView("EmployeesTable")

var result = spark.sql("SELECT * from EmployeesTable")
result.show(5)
result.head(3)
//
employees.explain(true)
//
result = spark.sql("SELECT * from EmployeesTable WHERE State = 'WA'")
result.show(5)
result.head(3)
//
result.explain(true)
//
// Handling multiple tables with Spark SQL
//
val orders = spark.read.option("header","true").
	csv(filePath + "data/NW-Orders.csv").as[Order]
println("Orders has "+orders.count()+" rows")
orders.show(5)
orders.head()
orders.dtypes
//
val orders = spark.read.option("header","true").
	option("inferSchema","true").
	csv(filePath + "data/NW-Orders.csv").as[Order]
println("Orders has "+orders.count()+" rows")
orders.show(5)
orders.head()
orders.dtypes // verify column types
//
val orderDetails = spark.read.option("header","true").
	option("inferSchema","true").
	csv(filePath + "data/NW-Order-Details.csv").as[OrderDetails]
println("Order Details has "+orderDetails.count()+" rows")
orderDetails.show(5)
orderDetails.head()
orderDetails.dtypes // verify column types
//
//orders.createTempView("OrdersTable")
orders.createOrReplaceTempView("OrdersTable")
result = spark.sql("SELECT * from OrdersTable")
result.show(10)
result.head(3)
//
orderDetails.createOrReplaceTempView("OrderDetailsTable")
var result = spark.sql("SELECT * from OrderDetailsTable")
result.show(10)
result.head(3)
//
// Now the interesting part
//
result = spark.sql("SELECT OrderDetailsTable.OrderID,ShipCountry,UnitPrice,Qty,Discount FROM OrdersTable INNER JOIN OrderDetailsTable ON OrdersTable.OrderID = OrderDetailsTable.OrderID")
result.show(10)
result.head(3)
//
// Sales By Country
//
result = spark.sql("SELECT ShipCountry, SUM(OrderDetailsTable.UnitPrice * Qty * Discount) AS ProductSales FROM OrdersTable INNER JOIN OrderDetailsTable ON OrdersTable.OrderID = OrderDetailsTable.OrderID GROUP BY ShipCountry")
result.count()
result.show(10)
result.head(3)
result.orderBy($"ProductSales".desc).show(10) // Top 10 by Sales   
```

---

#### Hive parquet 소스

> scala shell에서 돌리기
> /usr/local/spark/bin/spark-shell --master local

```scala
// register case class external to main
case class Order(OrderID : String, CustomerID : String, EmployeeID : String,
	OrderDate : String, ShipCountry : String)
//
case class OrderDetails(OrderID : String, ProductID : String, UnitPrice : Float,
	Qty : Int, Discount : Float)
//
println(s"Running Spark Version ${spark.version}")
//
val filePath = "file:///home/hadoop_user/scalasrc/"
val orders = spark.read.option("header","true").csv(filePath + "data/NW-Orders.csv")
println("Orders has "+orders.count()+" rows")
orders.show(3)
//
val orderDetails = spark.read.option("header","true").
option("inferSchema","true").csv(filePath + "data/NW-Order-Details.csv")
println("Order Details has "+orderDetails.count()+" rows")
orderDetails.show(3)
//
println("Saving in Parquet Format ....")
//
// Parquet Operations
//
orders.write.parquet(filePath + "Orders_Parquet")
//
// Let us read back the file
//
println("Reading back the Parquet Format ....")
val parquetOrders = spark.read.parquet(filePath + "Orders_Parquet")
println("Orders_Parquet has "+parquetOrders.count()+" rows")
parquetOrders.show(3)
//
// Save our Sales By Country Report as parquet
//
// Create views for tables
//
orders.createOrReplaceTempView("OrdersTable")
orderDetails.createOrReplaceTempView("OrderDetailsTable")
val result = spark.sql("SELECT ShipCountry, SUM(OrderDetailsTable.UnitPrice * Qty * Discount) AS ProductSales FROM OrdersTable INNER JOIN OrderDetailsTable ON OrdersTable.OrderID = OrderDetailsTable.OrderID GROUP BY ShipCountry")
result.show(3)
result.write.parquet(filePath + "SalesByCountry_Parquet")
//
println("** Done **");
```
---

#### SparkSession Car 소스

> scala shell에서 돌리기
> /usr/local/spark/bin/spark-shell --master local

```scala
def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
println(getCurrentDirectory)

val startTime = System.nanoTime()
//
		// Read Data
		//
		val filePath = "file:///home/hadoop_user/scalasrc/"
		val cars = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/cars.csv")
    println("Cars has "+cars.count()+" rows")
    cars.show(5)
    cars.printSchema()

// Write data
    // csv format with headers
    cars.write.mode("overwrite").option("header","true").csv(filePath + "data/cars-out-csv.csv")
    // Parquet format
    cars.write.mode("overwrite").partitionBy("year").parquet(filePath + "data/cars-out-pqt")
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
    spark.stop()
```
---

#### SparkSession Car1 소스

> scala shell에서 돌리기
> /usr/local/spark/bin/spark-shell --master local

```scala
val cars = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/car-milage.csv")
    println("Cars has "+cars.count()+" rows")
    cars.show(5)
    cars.printSchema()
    //
    cars.describe("mpg","hp","weight","automatic").show()
    //
    cars.groupBy("automatic").avg("mpg","torque","hp","weight").show()
    //
   cars.groupBy().avg("mpg","torque").show()
   cars.agg( avg(cars("mpg")), mean(cars("torque")) ).show() 
   //
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
    spark.stop()
```
---

#### SparkSession Car2 소스

> scala shell에서 돌리기
> /usr/local/spark/bin/spark-shell --master local

```scala
val cars = spark.read.option("header","true").
	  option("inferSchema","true").
    csv(filePath + "data/car-data/car-milage.csv")
    println("Cars has "+cars.count()+" rows")
    // cars.show(5)
    // cars.printSchema()
    //
    val cor = cars.stat.corr("hp","weight")
    println("hp to weight : Correlation = %.4f".format(cor))
    val cov = cars.stat.cov("hp","weight")
		println("hp to weight : Covariance = %.4f".format(cov))
		//
		cars.stat.crosstab("automatic","NoOfSpeed").show()
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
    spark.stop()
```
---

#### DS1 소스

> scala> :load /home/hadoop_user/scalasrc/DS01.scala
> DS01.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession

object DS01 {
  	//
	def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
	//
	def main(args: Array[String]) {
		println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 9")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val startTime = System.nanoTime()
		//
		// Read Data
		//
		val filePath = "/home/hadoop_user/scalasrc/"
		val cars = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/spark-csv/cars.csv")
    println("Cars has "+cars.count()+" rows")
    cars.show(5)
    cars.printSchema()
    //
    // Write data
    // csv format with headers
    cars.write.mode("overwrite").option("header","true").csv(filePath + "data/cars-out-csv.csv")
    // Parquet format
    cars.write.mode("overwrite").partitionBy("year").parquet(filePath + "data/cars-out-pqt")
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
    spark.stop()
    //
	}
}
```

---

#### DS2 소스

> scala> :load /home/hadoop_user/scalasrc/DS02.scala
> DS02.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.{avg,mean}

object DS02 {
  	//
	def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
	//
	def main(args: Array[String]) {
		println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 9")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val startTime = System.nanoTime()
		//
		// Read Data
		//
		val filePath = "/home/hadoop_user/scalasrc/"
		val cars = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/car-data/car-milage.csv")
    println("Cars has "+cars.count()+" rows")
    cars.show(5)
    cars.printSchema()
    //
    cars.describe("mpg","hp","weight","automatic").show()
    //
    cars.groupBy("automatic").avg("mpg","torque","hp","weight").show()
    //
   cars.groupBy().avg("mpg","torque").show()
   cars.agg( avg(cars("mpg")), mean(cars("torque")) ).show() 
   //
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
    spark.stop()
    //
	}
}
```

---

#### DS3 소스

> scala> :load /home/hadoop_user/scalasrc/DS03.scala
> DS03.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession

object DS03 {
  	//
	def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
	//
	def main(args: Array[String]) {
		println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 9")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val startTime = System.nanoTime()
		//
		// Read Data
		//
		val filePath = "/home/hadoop_user/scalasrc/"
		val cars = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/car-data/car-milage.csv")
    println("Cars has "+cars.count()+" rows")
    // cars.show(5)
    // cars.printSchema()
    //
    val cor = cars.stat.corr("hp","weight")
    println("hp to weight : Correlation = %.4f".format(cor))
    val cov = cars.stat.cov("hp","weight")
		println("hp to weight : Covariance = %.4f".format(cov))
		//
		cars.stat.crosstab("automatic","NoOfSpeed").show()
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
    spark.stop()
    //
	}
}
```

---

#### DS4 소스

> scala> :load /home/hadoop_user/scalasrc/DS04.scala
> DS04.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession

object DS04 {
  //
  def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
  //
  //  0 pclass,1 survived,2 l.name,3.f.name, 4 sex,5 age,6 sibsp,7 parch,8 ticket,9 fare,10 cabin,
  // 11 embarked,12 boat,13 body,14 home.dest
  //
  //
  def main(args: Array[String]): Unit = {
    println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 9")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val startTime = System.nanoTime()
		//
		val filePath = "/home/hadoop_user/scalasrc/"
		val passengers = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/titanic3_02.csv")
    println("Passengers has "+passengers.count()+" rows")
    //passengers.show(5)
    //passengers.printSchema()
    //
    val passengers1 = passengers.select(passengers("Pclass"),passengers("Survived"),passengers("Gender"),passengers("Age"),passengers("SibSp"),passengers("Parch"),passengers("Fare"))
    passengers1.show(5)
    passengers1.printSchema()
    //
    passengers1.groupBy("Gender").count().show()
    passengers1.stat.crosstab("Survived","Gender").show()
    //
    passengers1.stat.crosstab("Survived","SibSp").show()
    //
    // passengers1.stat.crosstab("Survived","Age").show()
    val ageDist =  passengers1.select(passengers1("Survived"), (passengers1("age") - passengers1("age") % 10).cast("int").as("AgeBracket"))
    ageDist.show(3)
    ageDist.stat.crosstab("Survived","AgeBracket").show()    
    //    
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
  }
}
```

---

#### DS5 소스

> scala> :load /home/hadoop_user/scalasrc/DS05.scala
> DS05.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.{log,log10,log1p,sqrt,hypot}


object DS05 {
  //
  def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
  //
  //  0 pclass,1 survived,2 l.name,3.f.name, 4 sex,5 age,6 sibsp,7 parch,8 ticket,9 fare,10 cabin,
  // 11 embarked,12 boat,13 body,14 home.dest
  //
  //
  def main(args: Array[String]): Unit = {
    println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 9")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val startTime = System.nanoTime()
		//
		var aList : List[Int] = List(10,100,1000)
		var aRDD = spark.sparkContext.parallelize(aList)
		val sqlContext = spark.sqlContext
    import sqlContext.implicits._
    var ds = spark.createDataset(aRDD)
    ds.show()
    //
    ds.select( ds("value"), log(ds("value")).as("ln")).show()
    ds.select( ds("value"), log10(ds("value")).as("log10")).show()
    ds.select( ds("value"), sqrt(ds("value")).as("sqrt")).show()
    //
		aList = List(0,10,100,1000)
		aRDD = spark.sparkContext.parallelize(aList)
    ds = spark.createDataset(aRDD)
    ds.select( ds("value"), log(ds("value")).as("ln")).show()
    ds.select( ds("value"), log1p(ds("value")).as("ln1p")).show()
    
		val filePath = "/home/hadoop_user/scalasrc/"
		val data = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/hypot.csv")
    println("Data has "+data.count()+" rows")
    data.show(5)
    data.printSchema()
    //
    data.select( data("X"),data("Y"),hypot(data("X"),data("Y")).as("hypot") ).show()
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
  }
}
```

---

#### DS6 소스

> scala> :load /home/hadoop_user/scalasrc/DS06.scala
> DS06.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession
import org.apache.log4j.{Level, Logger}
import org.apache.spark.sql.functions.{to_date,month,year}

object DS06 {
  //
  def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
  //
  def main(args: Array[String]): Unit = {
    println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 9 - Data Wrangling")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		//
		// To turn off INFO messages
		//
    val rootLogger = Logger.getRootLogger()
    rootLogger.setLevel(Level.ERROR)		// INFO, TRACE,...
		val startTime = System.nanoTime()
		//
		val filePath = "/home/hadoop_user/scalasrc/"
		val orders = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/NW/NW-Orders-01.csv")
    println("Orders has "+orders.count()+" rows")
    orders.show(5)
    orders.printSchema()
    //
		val orderDetails = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/NW/NW-Order-Details.csv")
    println("Order Details has "+orderDetails.count()+" rows")
    orderDetails.show(5)
    orderDetails.printSchema()
    //
    // Questions to Answer
    // 1.	How many orders were placed by each customer? 
    // 2.	How many orders were placed in each country ?
    // 3.	How many orders were placed per month ? per year ?
    // 4.	What is the Total Sales for each customer, by year ?
    // 5.	What is the average order by customer, by year ?
    //  
    // First 2 are easy - let us answer them first
    //
    val orderByCustomer = orders.groupBy("CustomerID").count()
    orderByCustomer.sort(orderByCustomer("count").desc).show(5) // We have out ans #1
    //
    val orderByCountry = orders.groupBy("ShipCountry").count()
    orderByCountry.sort(orderByCountry("count").desc).show(5) // ans #2
    //
    //# For the next set of questions, let us transform the data
    //# 1. Add OrderTotal column to the Orders DataFrame
    //# 1.1. Add Line total to order details
    //# 1.2. Aggregate total by order id
    //# 1.3. Join order details & orders to add the order total
    //# 1.4. Check if there are any null columns
    //# 2. Add a date column
    //# 3. Add month and year
    //
    //# 1.1. Add Line total to order details
    val orderDetails1 = orderDetails.select(orderDetails("OrderID"),
                                       (
                                           (orderDetails("UnitPrice") *
                                           orderDetails("Qty")) - 
                                           (
                                               (orderDetails("UnitPrice") *
                                               orderDetails("Qty")) * orderDetails("Discount")
                                           )
                                        ).as("OrderPrice"))
    orderDetails1.show(5)
    //# 1.2. Aggregate total by order id
    val orderTot = orderDetails1.groupBy("OrderID").sum("OrderPrice").alias("OrderTotal")
    orderTot.sort("OrderID").show(5)
    //# 1.3. Join order details & orders to add the order total
    val orders1 = orders.join(orderTot, orders("OrderID").equalTo(orderTot("OrderID")), "inner")
      .select(orders("OrderID"),
            orders("CustomerID"),
            orders("OrderDate"),
            orders("ShipCountry").alias("ShipCountry"),
            orderTot("sum(OrderPrice)").alias("Total"))
    //
    orders1.sort("CustomerID").show()
    //
    // # 1.4. Check if there are any null columns
    orders1.filter(orders1("Total").isNull).show()
    //
    // # 2. Add a date column
    //
    val orders2 = orders1.withColumn("Date",to_date(orders1("OrderDate")))
    orders2.show(2)
    orders2.printSchema()
    //
    // # 3. Add month and year
    val orders3 = orders2.withColumn("Month",month(orders2("OrderDate"))).withColumn("Year",year(orders2("OrderDate")))
    orders3.show(2)
    //
    // Q 3. How many orders by month/year ?
    val ordersByYM = orders3.groupBy("Year","Month").sum("Total").as("Total")
    ordersByYM.sort(ordersByYM("Year"),ordersByYM("Month")).show()
    //
    // Q 4. Total Sales for each customer by year
    var ordersByCY = orders3.groupBy("CustomerID","Year").sum("Total").as("Total")
    ordersByCY.sort(ordersByCY("CustomerID"),ordersByCY("Year")).show()
    // Q 5. Average order by customer by year
    ordersByCY = orders3.groupBy("CustomerID","Year").avg("Total").as("Total")
    ordersByCY.sort(ordersByCY("CustomerID"),ordersByCY("Year")).show()
    // Q 6. Average order by customer
    val ordersCA = orders3.groupBy("CustomerID").avg("Total").as("Total")
    ordersCA.sort(ordersCA("avg(Total)").desc).show()
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    //
  }
}
```

---

#### MLlib 상품과 날씨 영향 소스

> scala shell에서 돌리기
> cd /usr/local/spark
> /usr/local/spark/bin/spark-shell \
> --master local \
> --driver-memory 4g \
> --packages com.github.fommil.netlib:all:1.1.2

```scala

//278--------------------------
import org.apache.spark.{SparkContext, SparkConf}
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.linalg.{Vectors,Vector}
import org.apache.spark.mllib.feature.StandardScaler
import org.apache.spark.sql.functions.udf
import org.apache.spark.mllib.regression.LinearRegressionWithSGD
import org.apache.spark.mllib.evaluation.RegressionMetrics
import com.github.fommil.netlib._

case class Weather( date: String,
                    day_of_week: String,
                    avg_temp: Double,
                    max_temp: Double,
                    min_temp: Double,
                    rainfall: Double,
                    daylight_hours: Double,
                    max_depth_snowfall: Double,
                    total_snowfall: Double,
                    solar_radiation: Double,
                    mean_wind_speed: Double,
                    max_wind_speed: Double,
                    max_instantaneous_wind_speed: Double,
                    avg_humidity: Double,
                    avg_cloud_cover: Double)



val weatherCSVRDD = sc.textFile("file:///home/hadoop_user/scalasrc/data/weather.csv")
val headerOfWeatherCSVRDD = sc.parallelize(Array(weatherCSVRDD.first))
headerOfWeatherCSVRDD.first()
val weatherCSVwithoutHeaderRDD = weatherCSVRDD.subtract(headerOfWeatherCSVRDD)
val weatherDF = weatherCSVwithoutHeaderRDD.map(_.split(",")).
      map(p => Weather(p(0),
      p(1),
      p(2).trim.toDouble,
      p(3).trim.toDouble,
      p(4).trim.toDouble,
      p(5).trim.toDouble,
      p(6).trim.toDouble,
      p(7).trim.toDouble,
      p(8).trim.toDouble,
      p(9).trim.toDouble,
      p(10).trim.toDouble,
      p(11).trim.toDouble,
      p(12).trim.toDouble,
      p(13).trim.toDouble,
      p(14).trim.toDouble
    )).toDF()

weatherDF.show

case class Sales(date: String, sales: Double)


 val salesCSVRDD = sc.textFile("file:///home/hadoop_user/scalasrc/data/sales.csv")
    val headerOfSalesCSVRDD = sc.parallelize(Array(salesCSVRDD.first))
    val salesCSVwithoutHeaderRDD = salesCSVRDD.subtract(headerOfSalesCSVRDD)
    val salesDF = salesCSVwithoutHeaderRDD.map(_.split(",")).map(p => Sales(p(0), p(1).trim.toDouble)).toDF()
headerOfSalesCSVRDD.toDF().show
salesDF.show

 val salesAndWeatherDF = salesDF.join(weatherDF, "date")
salesAndWeatherDF.show

 val isWeekend = udf((t: String) => if(t.contains("일") || t.contains("토")) 1d else 0d)
    val replacedSalesAndWeatherDF = salesAndWeatherDF.withColumn("weekend", isWeekend(salesAndWeatherDF("day_of_week"))).drop("day_of_week")
    val replacedSalesAndWeatherDF2 = salesAndWeatherDF.withColumn("weekend", isWeekend(salesAndWeatherDF("day_of_week")))
replacedSalesAndWeatherDF.show
replacedSalesAndWeatherDF2.show

//replacedSalesAndWeatherDF dataframe -> select -> selectedDataDF dataframe
    val selectedDataDF = replacedSalesAndWeatherDF.select("sales", "avg_temp", "rainfall", "weekend")
    val labeledPoints = selectedDataDF.map(row => LabeledPoint(row.getDouble(0),
      Vectors.dense(
        row.getDouble(1),
        row.getDouble(2),
        row.getDouble(3)
      )))

labeledPoints.toDF().show

import spark.implicits._
val scaler = new StandardScaler(withMean = true, withStd = true).fit(labeledPoints.rdd.map(x => x.features))
val scaledLabledPoints = labeledPoints.map(x => LabeledPoint(x.label, scaler.transform(x.features))).rdd
//dataset labeledPoints         rdd
//dataset scaledLabledPoints    rdd scaledLabledPoints.rdd
//scaler org.apache.spark.mllib.feature.StandardScalerModel  



val numIterations = 20
scaledLabledPoints.cache   // cache는 값을 바꾸지 않는다는 내용
val linearRegressionModel = LinearRegressionWithSGD.train(scaledLabledPoints, numIterations)
println("weights :" + linearRegressionModel.weights)
```

---

#### ML 상품과 날씨 영향 소스

> scala shell에서 돌리기
> cd /usr/local/spark
> /usr/local/spark/bin/spark-shell \
> --master local \
> --driver-memory 4g 

```scala

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql.functions.udf
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.feature.StandardScaler
import org.apache.spark.ml.regression.LinearRegression
import org.apache.spark.ml.Pipeline
import org.apache.spark.sql.Row
import org.apache.spark.ml.tuning.CrossValidator
import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.spark.ml.tuning.ParamGridBuilder

case class Weather( date: String,
                    day_of_week: String,
                    avg_temp: Double,
                    max_temp: Double,
                    min_temp: Double,
                    rainfall: Double,
                    daylight_hours: Double,
                    max_depth_snowfall: Double,
                    total_snowfall: Double,
                    solar_radiation: Double,
                    mean_wind_speed: Double,
                    max_wind_speed: Double,
                    max_instantaneous_wind_speed: Double,
                    avg_humidity: Double,
                    avg_cloud_cover: Double)



val weatherCSVRDD = sc.textFile("file:///home/hadoop_user/scalasrc/data/weather.csv")
val headerOfWeatherCSVRDD = sc.parallelize(Array(weatherCSVRDD.first))
val weatherCSVwithoutHeaderRDD = weatherCSVRDD.subtract(headerOfWeatherCSVRDD)
val weatherDF = weatherCSVwithoutHeaderRDD.map(_.split(",")).
      map(p => Weather(p(0),
      p(1),
      p(2).trim.toDouble,
      p(3).trim.toDouble,
      p(4).trim.toDouble,
      p(5).trim.toDouble,
      p(6).trim.toDouble,
      p(7).trim.toDouble,
      p(8).trim.toDouble,
      p(9).trim.toDouble,
      p(10).trim.toDouble,
      p(11).trim.toDouble,
      p(12).trim.toDouble,
      p(13).trim.toDouble,
      p(14).trim.toDouble
    )).toDF()

weatherDF.show

case class Sales(date: String, sales: Double)


 val salesCSVRDD = sc.textFile("file:///home/hadoop_user/scalasrc/data/sales.csv")
    val headerOfSalesCSVRDD = sc.parallelize(Array(salesCSVRDD.first))
    val salesCSVwithoutHeaderRDD = salesCSVRDD.subtract(headerOfSalesCSVRDD)
    val salesDF = salesCSVwithoutHeaderRDD.map(_.split(",")).map(p => Sales(p(0), p(1).trim.toDouble)).toDF()
headerOfSalesCSVRDD.toDF().show
salesDF.show

 val salesAndWeatherDF = salesDF.join(weatherDF, "date")
salesAndWeatherDF.show

 val isWeekend = udf((t: String) => if(t.contains("일") || t.contains("토")) 1d else 0d)
    val replacedSalesAndWeatherDF = salesAndWeatherDF.withColumn("weekend", isWeekend(salesAndWeatherDF("day_of_week"))).drop("day_of_week")
    val replacedSalesAndWeatherDF2 = salesAndWeatherDF.withColumn("weekend", isWeekend(salesAndWeatherDF("day_of_week")))
replacedSalesAndWeatherDF.show
replacedSalesAndWeatherDF2.show

    // Assembler : Feature를 자동으로 만들어 줌
val va = new VectorAssembler().setInputCols{Array("avg_temp", "weekend", "rainfall")}.setOutputCol("input_vec")

	// va 의 output input_vec를 받아서 scales_vec으로 만든다.
    val scaler = new StandardScaler().setInputCol(va.getOutputCol).setOutputCol("scaled_vec")

    //Transformerに指定可能なパラメータの確認
    //va.explainParams
    //scaler.explainParams

val lr = new LinearRegression().
setMaxIter(20).
setFeaturesCol(scaler.getOutputCol).
setLabelCol("sales")

// R에서는 sales~
// ML의 특징인 Pipeline 스케일 한 데이터를 집어 넣음
    val pipeline = new Pipeline().setStages(Array(va, scaler, lr))
    val pipelineModel = pipeline.fit(replacedSalesAndWeatherDF)
case class Predict(describe: String,
                   avg_temp: Double,
                   rainfall: Double,
                   weekend: Double,
                   total_snowfall: Double )

    val test = sc.parallelize(Seq(
      Predict("Usual Day",20.0,20,0,0),
      Predict("Weekend",20.0,20,1,0),
      Predict("Cold day",3.0,20,0,20),
      Predict("Cold day W",3.0,20,1,20)
    )).toDF

    val predictedDataDF = pipelineModel.transform(test)

    val descAndPred = predictedDataDF.select("describe", "prediction").collect()

    println("####### パラメータチューニング適用前 #######")

    descAndPred.foreach {
      case Row(describe: String, prediction: Double) =>
        println(s"($describe) -> prediction=$prediction")
    }

    // 精度のチューニング
    val crossval = new CrossValidator().setEstimator(pipeline)
    val re = new RegressionEvaluator().setLabelCol("sales")
    crossval.setEvaluator(re)

    val paramGrid = new ParamGridBuilder()

    paramGrid.addGrid(va.inputCols, Array(
      Array("avg_temp","weekend","rainfall"),
      Array("avg_temp","weekend","rainfall","total_snowfall")
    ))
    paramGrid.addGrid(lr.maxIter, Array(5,10))
    paramGrid.addGrid(scaler.withMean, Array(false))

    crossval.setEstimatorParamMaps(paramGrid.build())
    val cvModel = crossval.fit(replacedSalesAndWeatherDF)

    println("####### 交差検定＋グリッドサーチ適用後 #######")
    cvModel.transform(test).select("describe", "prediction").
      collect().
      foreach {
         case Row(describe: String, prediction: Double) =>
           println(s"($describe) -> prediction=$prediction")
      }
```

---

#### ML 차 판매 영향 소스

> scala> :load /home/hadoop_user/scalasrc/ML01v2.scala
> ML01v2.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.corr
import org.apache.spark.ml.regression.LinearRegression
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.linalg.Vectors
import org.apache.spark.ml.evaluation.RegressionEvaluator

object ML01v2 {
	//
	def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
	//
	def main(args: Array[String]) {
		println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 11")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val filePath = "file:///home/hadoop_user/scalasrc/"
		val cars = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/car-data/car-milage.csv")
    println("Cars has "+cars.count()+" rows")
    cars.show(5)
    cars.printSchema()
		//
		// Let us find summary statistics
		//
    cars.describe("mpg","hp","weight","automatic").show()
		//
		// correlations
		//
		var cor = cars.stat.corr("hp","weight")
		println("hp to weight : Correlation = %2.4f".format(cor))
		var cov = cars.stat.cov("hp","weight")
		println("hp to weight : Covariance = %2.4f".format(cov))
		//
	  cor = cars.stat.corr("RARatio","width")
		println("Rear Axle Ratio to width : Correlation = %2.4f".format(cor))
		cov = cars.stat.cov("RARatio","width")
		println("Rear Axle Ratio to width : Covariance = %2.4f".format(cov))
		//
		// Linear Regression
		//
		// Transformation to a labeled data that Linear Regression Can use 
		val cars1 = cars.na.drop() 
		val assembler = new VectorAssembler()
    assembler.setInputCols(Array("displacement","hp","torque","CRatio","RARatio","CarbBarrells","NoOfSpeed","length","width","weight","automatic"))
    assembler.setOutputCol("features")
    val cars2 = assembler.transform(cars1)
    cars2.show(40)
    //
    // Split into training & test
    //
    val train = cars2.filter(cars1("weight") <= 4000)
    val test = cars2.filter(cars1("weight") > 4000)
    test.show()
    println("Train = "+train.count()+" Test = "+test.count())
		val algLR = new LinearRegression()
		algLR.setMaxIter(100)
		algLR.setRegParam(0.3)
		algLR.setElasticNetParam(0.8)
		algLR.setLabelCol("mpg")
		// R로 따지면 mpg~
		val mdlLR = algLR.fit(train)
		//
		println(s"Coefficients: ${mdlLR.coefficients} Intercept: ${mdlLR.intercept}")
		val trSummary = mdlLR.summary
    println(s"numIterations: ${trSummary.totalIterations}")
    println(s"Iteration Summary History: ${trSummary.objectiveHistory.toList}")
    trSummary.residuals.show()
    println(s"RMSE: ${trSummary.rootMeanSquaredError}")
    println(s"r2: ${trSummary.r2}")
    //
		// Now let us use the model to predict our test set
		//
    val predictions = mdlLR.transform(test)
    predictions.show()
    // Calculate RMSE & MSE
    val evaluator = new RegressionEvaluator()
		evaluator.setLabelCol("mpg")
		val rmse = evaluator.evaluate(predictions)
		println("Root Mean Squared Error = "+"%6.3f".format(rmse))
		//
		evaluator.setMetricName("mse")
		val mse = evaluator.evaluate(predictions)
		println("Mean Squared Error = "+"%6.3f".format(mse))
    //
    println("** That's All Folks **");
	}
}
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
