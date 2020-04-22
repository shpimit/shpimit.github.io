---
layout: page
title: Spark
summary: Spark. 
categories: HPC
tags: Java
featured-img: HPC
comments: Spark 2.0으로 하는 고속 스마트 빅데이터 분석과 처리
---

# Introducing Java Spark !!

#### With Spark 2.0으로 하는 고속 스마트 빅데이터 분석과 처리

---

## Overview

> 아키텍트는 일반 개발자와 무엇이 다른가?  나는 그 차이가 압도적인 프로젝트 경험 수의 차이라고 본다

---

## Contents

### Table of Contents

|No|Title|Remarks|
|-:|:--:|:-|
|1|[환경설정](#get-started)|환경설정|
|2|[Spark](#spark)|Spark 소스|

---

## Get Started(`Spark`)

### 1. PySpark & Jupyter

* Spark [Windows10 Spark 설치하기](https://guendouz.wordpress.com/2017/07/18/how-to-install-apache-spark-on-windows-10/)

* Spark [Windows10에 Spark 설치하기](https://jjangjjong.tistory.com/24)
  * 참고로 저는 Spark2.4를 설치 했음.
* PySpark [Run PySpark in Jupyter Notebootk on Windows](https://changhsinlee.com/install-pyspark-windows-jupyter/)  

  * findspark를 설치하는것이 핵심

```python
python -m pip install findspark
```

  * 개인적으로는 Anaconda prompt에서 작업

```shell
pip install findspark
```

```python
import findspark
findspark.init()

import pyspark # only run after findspark.init()
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()

df = spark.sql('''select 'spark' as hello ''')
df.show()
```

### 2. Eclipse Scala 환경 Setting

* eclipse plug in (scala IDE)
* Help-Marketplace
* find 검색창에 scala로 검색하고  검색결과중  4.7 scala IDE를 선택한다
* Open perspective -> scala를 선택하면  s가 붙은 아이콘이 생성이 된다.
* Window->prefereces->scala->installations 에 2.11이 선택되어 있는지 확인한다.

### 3. 기본 실행

* SPARK_HOME /usr/local/spark
* Hadoop Echo 실행하는 법
  * start-all.sh
* Hadoop 서비스 확인 하는법
  * console에서 확인 하는법 : jps
  * 브라우저에서 확인 하는법 : http://localhost:50070
* Hive 실행하는법
  * hive --service metastore
* Spark alone으로 띄우고 싶으면 hive config를 주석 처리해야함

```shell
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

### 4. Scala & Jupyter 연결(Jupyter에서 잘 안됨 ?)

```shell
pip install --upgrade toree
jupyter toree install
### jupyter kernel 확인
jupyter kernelspec list
```

https://joonyon.tistory.com/32
https://blog.sicara.com/get-started-pyspark-jupyter-guide-tutorial-ae2fe84f594f

---

## Data & Source

### Table of Data & Source for Scala

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
|19|[ML Decision Tree](#srcMLDT)|ML Decision Tree titanic example|
|20|[ML K-Means](#srcMLKmeans)|ML K-Means example|
|21|[ML ALS](#srcMLALS)|ML ALS 추천 알고리즘 활용 example|

---

## References

* [스파크 2.0으로 하는 고속 스마트 빅데이터 분석과 처리 3/3](https://github.com/PacktPublishing/Fast-Data-Processing-with-Spark-2)

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

#### ML Decision Tree 소스

> scala> :load /home/hadoop_user/scalasrc/ML02v2.scala
> ML02v2.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession
import org.apache.spark.ml.feature.{VectorAssembler,StringIndexer}
import org.apache.spark.ml.classification.DecisionTreeClassifier
import org.apache.spark.sql.types.DoubleType
import org.apache.spark.ml.evaluation.MulticlassClassificationEvaluator

object ML02v2 {
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
      .appName("Chapter 11")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val startTime = System.nanoTime()
		//
		val filePath = "file:///home/hadoop_user/scalasrc/"
		val passengers = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/titanic3_02.csv")
    println("Passengers has "+passengers.count()+" rows")
    passengers.show(5)
    passengers.printSchema()
    // $ 보다는 df() 이런식으로 써야 join같은것 할때 문제가 생기지 않는다.
    val passengers1 = passengers.select(passengers("Pclass"),passengers("Survived").cast(DoubleType).as("Survived"),passengers("Gender"),passengers("Age"),passengers("SibSp"),passengers("Parch"),passengers("Fare"))
    passengers1.show(5)
    //
    // VectorAssembler does not support the StringType type. So convert Gender to numeric
    // Gender는 charater로 되어 있어서 숫자로 변경
    val indexer = new StringIndexer()
    indexer.setInputCol("Gender")
    indexer.setOutputCol("GenderCat")
    val passengers2 = indexer.fit(passengers1).transform(passengers1)
    passengers2.show(5)
    //
    val passengers3 = passengers2.na.drop()
    println("Orig = "+passengers2.count()+" Final = "+ passengers3.count() + " Dropped = "+ (passengers2.count() - passengers3.count()))
    //
    val assembler = new VectorAssembler()
    assembler.setInputCols(Array("Pclass","GenderCat","Age","SibSp","Parch","Fare"))
    assembler.setOutputCol("features")
    val passengers4 = assembler.transform(passengers3)
    passengers4.show(5)
    //
    // split data
    // 9:1로 나누어서 훈련, 테스트 데이터로 나눈다.
    val Array(train, test) = passengers4.randomSplit(Array(0.9, 0.1))
    println("Train = "+train.count()+" Test = "+test.count())
    //
    // Train a DecisionTree model.
    val algTree = new DecisionTreeClassifier()
    algTree.setLabelCol("Survived")
    algTree.setImpurity("gini") // could be "entropy"
    algTree.setMaxBins(32) 
    algTree.setMaxDepth(5)   // 많이 해봤자.... 정밀도가 높아지지 않기 때문에.
    //
    val mdlTree = algTree.fit(train)
    println("The tree has %d nodes.".format(mdlTree.numNodes))
    println(mdlTree.toDebugString)
    println(mdlTree.toString)
    println(mdlTree.featureImportances)
    //
    // predict test set and calculate accuracy
    //
    val predictions = mdlTree.transform(test)
    predictions.show(5)
    //
    val evaluator = new MulticlassClassificationEvaluator()
    evaluator.setLabelCol("Survived")
    // 정확도를 보고 평가 하겠다.
    evaluator.setMetricName("accuracy") // could be f1, "weightedPrecision" or "weightedRecall"
    //
    val accuracy = evaluator.evaluate(predictions)
    println("Test Accuracy = %.2f%%".format(accuracy*100))
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

#### ML KMean 소스

> scala> :load /home/hadoop_user/scalasrc/ML03v2.scala
> ML03v2.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.clustering.KMeans

object ML03v2 {
  //
	def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
	//
  def main(args: Array[String]): Unit = {
    println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 11")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		val startTime = System.nanoTime()
		//
		val filePath = "file:///home/hadoop_user/scalasrc/"

// spark로 읽었으니까..df(데이터 프레임)
		val data = spark.read.option("header","true").
		  option("inferSchema","true").
	    csv(filePath + "data/cluster-points-v2.csv")
    println("Data has "+data.count()+" rows")
    data.show(5)
    data.printSchema()
    //
    val assembler = new VectorAssembler()
    assembler.setInputCols(Array("X","Y"))
    assembler.setOutputCol("features")
    val data1 = assembler.transform(data)
    data1.show(5)
    //
    // Create the Kmeans model
    //
    var algKMeans = new KMeans().setK(2)
    var mdlKMeans = algKMeans.fit(data1)
    // Evaluate clustering by computing Within Set Sum of Squared Errors.
    var WSSSE = mdlKMeans.computeCost(data1)
    println(s"Within Set Sum of Squared Errors (K=2) = %.3f".format(WSSSE))
    // Shows the result.
    println("Cluster Centers (K=2) : " + mdlKMeans.clusterCenters.mkString("<", ",", ">"))
    println("Cluster Sizes (K=2) : " +  mdlKMeans.summary.clusterSizes.mkString("<", ",", ">"))
    //
    var predictions = mdlKMeans.transform(data1)
    predictions.show(3)
    //
    predictions.write.mode("overwrite").option("header","true").csv(filePath + "data/cluster-2K.csv")
    //
    //
    // Now let us try 4 centers
    //
    algKMeans = new KMeans().setK(4)
    mdlKMeans = algKMeans.fit(data1)
    // Evaluate clustering by computing Within Set Sum of Squared Errors.
    WSSSE = mdlKMeans.computeCost(data1)
    println(s"Within Set Sum of Squared Errors (K=4) = %.3f".format(WSSSE))
    // Shows the result.
    println("Cluster Centers (K=4) : " + mdlKMeans.clusterCenters.mkString("<", ",", ">"))
    println("Cluster Sizes (K=4) : " +  mdlKMeans.summary.clusterSizes.mkString("<", ",", ">"))
    //
    predictions = mdlKMeans.transform(data1)
    predictions.show(3)
    //
    predictions.write.mode("overwrite").option("header","true").csv(filePath + "data/cluster-4K.csv")
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

#### ML ALS 추천 알고리즘 활용 소스

> scala> :load /home/hadoop_user/scalasrc/ML04v2.scala
> ML04v2.main(Array("hello","world"))

```scala
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.Row
import org.apache.spark.sql.functions.{split,pow,isnan}
import org.apache.spark.mllib.recommendation.Rating
import org.apache.spark.ml.recommendation.ALS
import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.log4j.{Level, Logger}

object ML04v2 extends Serializable {
  //
	def getCurrentDirectory = new java.io.File( "." ).getCanonicalPath
  //
	def parseRating(row:Row) : Rating = {
	  val aList = row.getList[String](0)
	  Rating(aList.get(0).toInt,aList.get(1).toInt,aList.get(2).toDouble) //.getInt(0), row.getInt(1), row.getDouble(2))
	}
	// df.rdd -> dr[row]  row.getXXXX(2) row.getList   scala의 []는 java의 generic <T>
	def rowSqDiff(row:Row) : Double = {
	  math.pow( (row.getDouble(2) - row.getFloat(3).toDouble),2)
	}
	//
  def main(args: Array[String]): Unit = {
    println(getCurrentDirectory)
		val spark = SparkSession.builder
      .master("local")
      .appName("Chapter 11")
      .config("spark.logConf","true")
      .config("spark.logLevel","ERROR")
      .getOrCreate()
		println(s"Running Spark Version ${spark.version}")
		//
		// To turn off INFO messages
		//
    val rootLogger = Logger.getRootLogger()
    rootLogger.setLevel(Level.ERROR)		// INFO, TRACE,...
		val startTime = System.nanoTime()
		//
		val filePath = "file:///home/hadoop_user/scalasrc/"
		val movies = spark.read.text(filePath + "data/medium/movies.dat")
		movies.show(5,truncate=false)
    movies.printSchema()
		val ratings = spark.read.text(filePath + "data/medium/ratings.dat")
		ratings.show(5,truncate=false)
		val users = spark.read.text(filePath + "data/medium/users.dat")
		users.show(5,truncate=false)
		//
    println("Got %d ratings from %d users on %d movies.".format(ratings.count(), users.count(), movies.count()))
    //
    // Transformation
    // This is a kludge. Let me know if there is a better way
    // 1::A::V = Array[1,A,V]
    val ratings1 = ratings.select(split(ratings("value"),"::")).as("values")
    ratings1.show(5)
// Dataset을 rdd로 해서 row

    val ratings2 = ratings1.rdd.map(row => parseRating(row))
    ratings2.take(3).foreach(println)
    //
    val ratings3 = spark.createDataFrame(ratings2)
    ratings3.show(5)
    //
    // split data
    //
    val Array(train, test) = ratings3.randomSplit(Array(0.8, 0.2))
    println("Train = "+train.count()+" Test = "+test.count())
    //
    // create algorithm object
    //
    val algALS = new ALS()
    algALS.setItemCol("product") // Otherwise will get exception "Field "item" does not exist"
    algALS.setRank(12)
    algALS.setRegParam(0.1) // was regularization parameter, was lambda in MLlib
    algALS.setMaxIter(20)
// fit 해서 모델 만든다.
    val mdlReco = algALS.fit(train)
     //
		// Now let us use the model to predict our test set
		//
    val predictions = mdlReco.transform(test)
    predictions.show(5)
    predictions.printSchema()
    //
    // some of the recommendation is NaN. 
    // Running into https://issues.apache.org/jira/browse/SPARK-14489 = cold Start
    // So filter them out before calculating MSE et al
    // Test Code to find the NaN. Not used
    /*
    val nanState = predictions.na.fill(99999.0)
    println(nanState.filter(nanState("prediction") > 99998).count())
    nanState.filter(nanState("prediction") > 99998).show(5)
    * 
    */
    //
    val pred = predictions.na.drop()
    println("Orig = "+predictions.count()+" Final = "+ pred.count() + " Dropped = "+ (predictions.count() - pred.count()))
    // Calculate RMSE & MSE
    val evaluator = new RegressionEvaluator()
		evaluator.setLabelCol("rating")
		var rmse = evaluator.evaluate(pred)
		println("Root Mean Squared Error = "+"%.3f".format(rmse))
		//
		evaluator.setMetricName("mse")
		var mse = evaluator.evaluate(pred)
		println("Mean Squared Error = "+"%.3f".format(mse))
// reduce는 모든 데이터를 1줄 단위로 더하는것.
		mse = pred.rdd.map(r => rowSqDiff(r)).reduce(_+_) / predictions.count().toDouble
		println("Mean Squared Error (Calculated) = "+"%.3f".format(mse))
		//
    //
    val elapsedTime = (System.nanoTime() - startTime) / 1e9
    println("Elapsed time: %.2f seconds".format(elapsedTime))
    //
    println("*** That's All Folks ! ***")
    // MLlib
    // 1.3.0 (2/18/15)
    // *** Model Performance Metrics ***
    // MSE = 0.87495
    // RMSE = 0.93539
    // 1.4.0 RC2 (5/24/15)
    // *** Model Performance Metrics ***
    // MSE = 0.87185
    // RMSE = 0.93373
    // 1.6.2 (6/22/16)
    // MSE = 0.87423
    // RMSE = 0.93500
    // ML
    // 2.0.0 (7/23/16)
    // Root Mean Squared Error = 0.871
    // Mean Squared Error = 0.759
    //
  }
}
```
