---
layout: page
title: TensorFlow
subtitle: TensorFlow All in One
summary: TensorFlow is space to learn Deep Learning with TensorFlow
categories: TensorFlow
tags: TensorFlow
featured-img: ai
mathjax: true
comments: 텐서플로우 기반의 딥러닝
---

# Introducing TensorFlow !!

#### (TensorFlow 이해)

---

## Overview

> 텐서플로(TensorFlow)는 다양한 작업에대해 데이터 흐름 프로그래밍을 위한 오픈소스 소프트웨어 라이브러리이다.
> <small>-- *텐서플로는 2015년에 오픈 소스로 공개된 을 수행하게 하는 CUDA 확장기능을 사용 구동될 수 있다.* </small>

---

## Contents

### Table of Contents

|No|Title|Remarks|
|-:|:-:|:--|
|0|[환경설정](#get-started)|환경설정|
|1|[Tensorflow](#Tensorflow)|Tensorflow 소스|
|2|[Keras](/Lecture/Keras)|Keras 소스|
|3|[Reference Site](#reference)|참조사이트|

---

## Learning

### Table of Learning

|No|Title|Educational Institution|Lecturer|Term|Remarks|
|-:|:--:|:-:|:--:|:--:|:-|
|1|텐서플로우 딥러닝 인공지능 개발|IT이젠아카데미|[설진욱](https://cafe.naver.com/ugcadman)|Aug 4~ Sep 1 2018|TensorFlow, Keras|
|2|[Deep Learning의 이해](/_pages/AI/TensorFlow/2018-09-17-UDSL-DeepLearning)|서울대학교 도시연구소|오성회교수님|Sep 17~21 2018|`TensorFlow`|
|3|[파이썬 및 텐서플로우 활용한 인공지능 실습](/_pages/AI/TensorFlow/2019-01-14-KIPFA-TensorFlow)|(사)한국인터넷전문가협회|최재규|Jan 14~18 2019|`TensorFlow`|
|4|[텐서플로우 기반의 딥러닝 영상처리(CNN)](/_pages/AI/TensorFlow/2019-04-22-NCIA-CNN)|차세대융합콘텐츠산업협회|김정훈[(파이쿵)](https://pythonkim.tistory.com/)|Apr 22~24 2019|`TensorFlow`|

---

## Get Started

* ~~TensorFlow [개발환경 Setting](https://tensorflow.blog/윈도우즈에-아나콘다-텐서플로우-설치하기/)~~
* ~~[Anaconda3 5.2 설치(Python 3.6 기반)](https://www.anaconda.com/download/#windows)~~ → Python 3.7 기반 설치를 하는것이 맞음

```shell
> conda create -n tensorflow pip python=3.6   
> activate tensorflow   
> pip install --ignore-installed --upgrade tensorflow  
```

* [TensorFlow 공식 홈페이지 설치](https://www.tensorflow.org/install/install_windows)

---

* [Anaconda TensorFlow 설치](https://tensorflow.blog/2018/10/24/pip-install-tensorflow-vs-conda-install-tensorflow/)


* 콘다 업데이트

```shell  
> conda update -n base conda
```

* 파이썬 패키지 업데이트

```shell
> conda update --all
```

* Tensorflow GPU 설치

```shell
> conda install tensorflow-gpu
```

* [CUDA 라이브러리 설치](https://developer.nvidia.com/cuda-toolkit)
* [CUDNN 라이브러리 설치](http://twinstarinfo.blogspot.com/2018/12/tensorflow-gpu-install-nvidia-cuda.htm)

---

* 아래는 필요한경우만 설치 하면 됨
 
* Python 필요 패키지설치

```shell
> (tensorflow) $ conda install scikit-learn → 파이썬 대표 머신러닝 라이브러리  
> (tensorflow) $ conda install pillow  
> (tensorflow) $ conda install seaborn  
> (tensorflow) $ conda install --channel https://conda.anaconda.org/conda-forge keras  
> (tensorflow) $ conda install h5py  
> (tensorflow) $ conda install cx_Oracle → Oracle 연동 라이브러리  
> (tensorflow) $ conda install pymysql   → MySQL 연동 라이브러리  
> (tensorflow) $ conda install xlrd      → Excel 연동 라이브러리  
```

* Jupyter Notebook 설치

```shell
> (tensorflow) $ conda install jupyter  
> (tensorflow) $ conda install -c conda-forge jupyterlab  
```

* Theano -> Tensorflow 변경

> ~\Anaconda3\envs\tensorflow\etc\conda\activate.d 내에 있는 Keras Backend가 혹시 theano로 설정되어 있으면 이를 tensorflow로 변경  

* Spyder 환경

> http://rfriend.tistory.com/298  
> Spyder는 Rstudio layout 과 동일한 형태의 layout 도 제공합니다. (View > Windows layout > Rstudio layout 선택)  
> F9 한줄실행, F5 파일실행  

---


## Data & Source

### Table of Data & Source

|No|Source|Remarks|
|-:|:-:|:--|
|0|[Basic](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/TensorFlowBasic.ipynb)|기초,활성화함수|
|1|[XOR](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/XOR_Tensorflow.ipynb)|XOR문제|
|2|[XOR해결](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/XOR-Solution.ipynb)|XOR해결|
|3|[Regression](https://github.com/shpimit/shpimit.github.io/tree/master/blog/TensorFlow/src/Regression.ipynb)|Regression|

---

* **Table of MNIST Best Model Source**  

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

## Reference

* [강의자료](http://bit.ly/2RoWaQq)
* [텐서플로한글문서](https://tensorflowkorea.gitbooks.io/tensorflow-kr/content/)
* [골빈해커의 3분 딥러닝](https://github.com/golbin/TensorFlow-Tutorials)

##### [Go to Contents](#contents)