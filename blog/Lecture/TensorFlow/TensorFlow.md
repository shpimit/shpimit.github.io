---
layout: page
title: TensorFlow
permalink: /Lecture/TensorFlow
---

## TensorFlow
### 1. 개발환경 Setting
#### 1.1 Anaconda3 5.2 설치(Python 3.6 기반)
* https://repo.continuum.io/archive/
#### 1.2 TensorFlow 설치
* https://www.tensorflow.org/install/install_windows
* conda create -n tensorflow pip python=3.6
* pip install --ignore-installed --upgrade tensorflow 
#### 1.3 Python 필요 패키지설치
* activate tensorflow
* (tensorflow) $ conda install scikit-learn → 파이썬 대표 머신러닝 라이브러리
* (tensorflow) $ conda install pillow
* (tensorflow) $ conda install seaborn
* (tensorflow) $ conda install --channel https://conda.anaconda.org/conda-forge keras
* (tensorflow) $ conda install h5py
* (tensorflow) $ conda install cx_Oracle → Oracle 연동 라이브러리
#### 1.4 Jupyter Notebook 설치
* (tensorflow) $ conda install jupyter
* (tensorflow) $ conda install -c conda-forge jypyterlab

#### 1.5 Theano -> Tensorflow 변경
* ~\Anaconda3\envs\tensorflow\etc\conda\activate.d 내에 있는 Keras Backend가 혹시
theano로 설정되어 있으면 이를 tensorflow로 변경
#### 1.6 Spyder 환경
* http://rfriend.tistory.com/298
* Spyder는 Rstudio layout 과 동일한 형태의 layout 도 제공한답니다. (View > Windows layout > Rstudio layout 선택)
* F9 한줄실행, F5 파일실행

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
```

* MySQL 연결하기

```python
# python3
conda install pymysql
conda install sqlalchemy

import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('mysql://root:apmsetup@localhost/abc', convert_unicode=True)
conn = engine.connect()

data = pd.read_sql_table('test1', conn)
data.head()
```
