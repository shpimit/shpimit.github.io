---
layout: page
title: TensorFlow
permalink: /Lecture/TensorFlow
---

---

<!-- *template: gaia -->
<!-- page_number: false -->

# Introducing `TensorFlow` !!
##### (TensorFlow 이해)

---

<!-- *template: invert -->  

## Contents

<a name="contents"/>

* **Table of Contents**   

|No|Titile|Remarks|
|--:|:-:|:--|
|0|[환경설정](#install)|환경설정|
|1|[Tensorflow](#Tensorflow)|Tensorflow 소스|
|2|[Reference Site](#reference)|참조사이트|

---

<a name="install"/>

## TensorFlow

### 1. [개발환경 Setting](https://tensorflow.blog/윈도우즈에-아나콘다-텐서플로우-설치하기/)
 
#### 1.1 [Anaconda3 5.2 설치(Python 3.6 기반)](https://www.anaconda.com/download/#windows)

#### 1.2 [TensorFlow 설치](https://www.tensorflow.org/install/install_windows)
* conda create -n tensorflow pip python=3.6
* activate tensorflow
* pip install --ignore-installed --upgrade tensorflow
 
#### 1.3 Python 필요 패키지설치
* (tensorflow) $ conda install scikit-learn → 파이썬 대표 머신러닝 라이브러리
* (tensorflow) $ conda install pillow
* (tensorflow) $ conda install seaborn
* (tensorflow) $ conda install --channel https://conda.anaconda.org/conda-forge keras
* (tensorflow) $ conda install h5py
* (tensorflow) $ conda install cx_Oracle → Oracle 연동 라이브러리
* (tensorflow) $ conda install pymysql   → MySQL 연동 라이브러리
* (tensorflow) $ conda install xlrd      → Excel 연동 라이브러리

#### 1.4 Jupyter Notebook 설치
* (tensorflow) $ conda install jupyter
* (tensorflow) $ conda install -c conda-forge jupyterlab

#### 1.5 Theano -> Tensorflow 변경
* ~\Anaconda3\envs\tensorflow\etc\conda\activate.d 내에 있는 Keras Backend가 혹시
theano로 설정되어 있으면 이를 tensorflow로 변경

#### 1.6 Spyder 환경
* http://rfriend.tistory.com/298
* Spyder는 Rstudio layout 과 동일한 형태의 layout 도 제공한답니다. (View > Windows layout > Rstudio layout 선택)
* F9 한줄실행, F5 파일실행

---

### 2. [TensorFlow Install](https://tensorflow.blog/윈도우즈에-아나콘다-텐서플로우-설치하기/)

#### 2.1 콘다 업데이트

> conda update -n base conda

#### 2.2 파이썬 패키지 업데이트

> conda update --all

#### 2.3 Tensorflow 설치

> python -m pip install --upgrade pip
> 아나콘다 배포판에는 텐서플로 최신 버전이 늦게 포함되므로 파이썬 기본 패키지 관리자인 pip로 텐서플로우를 설치합니다.
> pip install tensorflow
> 만약 AVX를 지원하지 않는 CPU를 사용하고 있다면 다음과 같이 1.5 버전을 설치합니다.
> pip install tensorflow==1.5.0

#### 2.4 [Anaconda 환경에서 R 설치하기](http://yahwang.tk/posts/27)

> conda install r-irkernel
> jupyter 커널 참조 : https://github.com/jupyter/jupyter/wiki/Jupyter-kernels

#### 2.5. [주피터 설치가능 커널](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)

---

<!-- *template: invert -->

## Data & Source 

<a name="data"/>

* **Table of Data & Source**   

|No|Source|Remarks|
|--:|:-:|:--|
|0|[Basic](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/TensorFlowBasic.ipynb)|기초,활성화함수|
|1|[XOR](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/XOR_Tensorflow.ipynb)|XOR문제|
|2|[XOR해결](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/XOR-Solution.ipynb)|XOR해결|
|3|[Regression](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/Regression.ipynb)|Regression|
|4|[Regression](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/05_Convolutional_Neural_Networks_answer.ipynb)|CNN|
|5|[Recurrent_Neural_Networks](https://github.com/shpimit/shpimit.github.io/tree/master/blog/DeepLearning/src/06_Recurrent_Neural_Networks.ipynb)|RNN|

---


### 2. 기초
```python
import tensorflow as tf

matrix1 = tf.constant([[1.,2.],[3.,4.]])
matrix2 = tf.constant([[1.],[2.]])
print("Matrix 1 shape", matrix1.shape)
print("Matrix 2 shape", matrix2.shape)

sess = tf.Session()
result = sess.run(tf.matmul(matrix1, matrix2))
print(result)
```

```python
import numpy as np

a = [1,2,3,4,5,1,2,6]
print(a)
a = np.array(a)   
a.reshape(2,4)
print(a)
```
* 엑셀 읽기

```python
import numpy as np
import pandas as pd

data = pd.read_excel("c:/r_temp/excel_exam.xlsx")
data.head(5)

import xlrd

list_job = pd.read_excel('C:\\r_temp\\Koweps_Codebook.xlsx')
```

* MySQL 연결하기

```python
# python3
conda install pymysql
conda install sqlalchemy

import pandas as pd
from sqlalchemy import create_engine

#engine = create_engine('mysql://root:apmsetup@localhost/abc', convert_unicode=True)
# 우리가 설치한 mysql 모듈을 써주어야 정상 작동합니다.
engine = create_engine('mysql+pymysql://root:apmsetup@localhost/abc', convert_unicode=True)

conn = engine.connect()

data = pd.read_sql_table('test1', conn)
data.head()
```

* 데이터 프레임 합치기

```python
jumsu1 = pd.DataFrame({"name":("Kim","Lee"), "kor":(70,90)})
jumsu2 = pd.DataFrame({"name":("Kim","Lee"), "eng":(80,90)})
pd.merge(jumsu1,jumsu2,on="name")
```
