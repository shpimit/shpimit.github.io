layout: page
title: AI
summary: AI is space to learn block chain algorithm & theory.
permalink: /Lecture/AI
---

<!-- *template: gaia -->
<!-- page_number: false -->

# Introducing TensorFlow !!
##### (TensorFlow 이해)

<!-- *template: invert -->
<!-- page_number: true -->

**Table of Learning**

|No|Titile|Educational Istitution|Term|
|--:|:--:|:-:|:--:|
|1|[텐서플로우 딥러닝 인공지능 개발](/Lecture/TensorFlow)|IT이젠아카데미|18.8.4~9.1|
|2|[기계학습의이해](/Lecture/MachineLearning)|서울대학교 도시연구소|18.9.10~9.14|
|3|[Deep Learning의 이해](/Lecture/DeepLearning)|서울대학교 도시연구소|18.9.17~9.21|

---

<!-- $theme: gaia -->

## Overview

> 텐서플로(TensorFlow)는 다양한 작업에대해 데이터 흐름 프로그래밍을 위한 오픈소스 소프트웨어 라이브러리이다.   
> <small> *텐서플로는 2015년에 오픈 소스로 공개된 을 수행하게 하는 CUDA 확장기능을 사용 구동될 수 있다.* </small>

---
layout: false 
<!-- *template: invert --> 
<a name="contents"/>

## Contents

* **Table of Contents**   

|No|Titile|Remarks|
|--:|:-:|:--|
|0|[환경설정](#install)|환경설정|
|1|[Tensorflow](#Tensorflow)|Tensorflow 소스|
|2|[Keras](/Lecture/Keras)|Keras 소스|
|3|[Reference Site](#reference)|참조사이트|

---

<a name="install"/>

## Get Started(`TensorFlow`)

* TensorFlow [개발환경 Setting](https://tensorflow.blog/윈도우즈에-아나콘다-텐서플로우-설치하기/)
* [Anaconda3 5.2 설치(Python 3.6 기반)](https://www.anaconda.com/download/#windows)
* [TensorFlow 설치](https://www.tensorflow.org/install/install_windows)

> conda create -n tensorflow pip python=3.6   
> activate tensorflow   
> pip install --ignore-installed --upgrade tensorflow  
 
* Python 필요 패키지설치

> (tensorflow) $ conda install scikit-learn → 파이썬 대표 머신러닝 라이브러리  
> (tensorflow) $ conda install pillow  
> (tensorflow) $ conda install seaborn  
> (tensorflow) $ conda install --channel https://conda.anaconda.org/conda-forge keras  
> (tensorflow) $ conda install h5py  
> (tensorflow) $ conda install cx_Oracle → Oracle 연동 라이브러리  
> (tensorflow) $ conda install pymysql   → MySQL 연동 라이브러리  
> (tensorflow) $ conda install xlrd      → Excel 연동 라이브러리  

* Jupyter Notebook 설치

> (tensorflow) $ conda install jupyter  
> (tensorflow) $ conda install -c conda-forge jupyterlab  

* Theano -> Tensorflow 변경

> ~\Anaconda3\envs\tensorflow\etc\conda\activate.d 내에 있는 Keras Backend가 혹시 theano로 설정되어 있으면 이를 tensorflow로 변경  

* Spyder 환경

> http://rfriend.tistory.com/298  
> Spyder는 Rstudio layout 과 동일한 형태의 layout 도 제공한답니다. (View > Windows layout > Rstudio layout 선택)  
> F9 한줄실행, F5 파일실행  

---

template: inverse
class: middle
* [Windows TensorFlow Install](https://tensorflow.blog/윈도우즈에-아나콘다-텐서플로우-설치하기/)

  * 콘다 업데이트
> conda update -n base conda

  * 파이썬 패키지 업데이트
> conda update --all

  * Tensorflow 설치
> python -m pip install --upgrade pip  
> 아나콘다 배포판에는 텐서플로 최신 버전이 늦게 포함되므로 파이썬 기본 패키지 관리자인 pip로 텐서플로우를 설치합니다.  
> pip install tensorflow  
> 만약 AVX를 지원하지 않는 CPU를 사용하고 있다면 다음과 같이 1.5 버전을 설치합니다.  
> pip install tensorflow==1.5.0  

---

layout: false
<!-- *template: invert -->
<a name="data"/>

## Data & Source 

**Table of Data & Source**   

|No|Source|Remarks|
|--:|:-:|:--|
|0|[Basic](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/TensorFlowBasic.ipynb)|기초,활성화함수|
|1|[XOR](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/XOR_Tensorflow.ipynb)|XOR문제|
|2|[XOR해결](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/XOR-Solution.ipynb)|XOR해결|
|3|[Regression](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/Regression.ipynb)|Regression|

---

**Table of MNIST Best Model Source**  

||[softmax](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/01_mnist_softmax.ipynb)|[Neural Network](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/02_mnist_nn.ipynb)|[NN(w/ Xavier)](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/03_mnist_xavier.ipynb)|[Deep NN](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/04_mnist_deep.ipynb)|[DNN(w/ dropout)](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/05_mnist_dropout.ipynb)|
|--:|:-:|:-:|:-:|:-:|:-:|
|활성화 함수1|W(softmax)|W1(Relu)|W1(Relu)|W1(Relu)|W1(Relu)|
|활성화 함수2|-|W2(Relu)|W2(Relu)|W2(Relu)|W2(Relu)|
|활성화 함수3|-|W3(softmax)|W3(softmax)|W3(Relu)|W3(Relu)|
|활성화 함수4|-|-|-|W4(Relu)|W4(Relu)|
|활성화 함수5|-|-|-|W5(softmax)|W5(softmax))|
|xavier_initializer|미사용|미사용|사용(W최적화)|사용(W최적화)|사용(W최적화)|
|Dropout|미사용|미사용|미사용|미사용|사용(훈련시:0.7,테스트시:1.0)|

---
