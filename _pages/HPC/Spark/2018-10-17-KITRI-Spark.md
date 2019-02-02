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

|No|Titile|Remarks|
|--:|:-:|:--|
|1|[환경설정](#installation)|환경설정|
|2|[Spark](#spark)|Spark 소스|

---

## Get Started(`Spark`)

### Installation

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

---

## Data & Source

### Table of Data & Source

|No|Source|Remarks|
|--:|:-:|:--|
|0|[PySpark](https://github.com/shpimit/shpimit.github.io/tree/master/_pages/AI/PyTorch/src/01_Tensor.ipynb)|PySpark Jupyter 동작확인|

---

## Reference

* [스파크 2.0으로 하는 고속 스마트 빅데이터 분석과 처리 3/3](https://github.com/PacktPublishing/Fast-Data-Processing-with-Spark-2)
