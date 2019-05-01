---
layout: page
title: PyTorch
summary: PyTorch is space to learn Deep Learning with PyTorch
categories: AI
tags: PyTorch
featured-img: ai
comments: 서울대학교 빅데이터 아카데미
---

# Introducing PyTorch !!

#####  PyTorch is space to learn Deep Learning with `PyTorch`.

---

## Overview

> 파이토치(`Pytorch`)는 파이썬(`Python`) 기반의 오픈 소스 머신러닝 라이브러리로, 페이스북 인공지능 연구집단에 의해 개발되었다. 간결하고 구현이 빨리 되며, 텐서플로우보다 사용자가 익히기 훨씬 쉽다는 특징이 있다. 또한 코드를 직접 다른 사람들에게 설명해 주기에도 효과적이다. 텐서플로우와 파이토치의 가장 큰 차이점은 딥러닝을 구현하는 패러다임이 다르다는 것이다. 텐서플로우는 Define-and-Run 프레임워크인 반면에, 파이토치는 Define-by-Run이다. 이 패러다임의 차이로 텐서플로우의 경우 먼저 모델을 만들고 값을 다 따로 넣어주어야 해서 직관적이지 않지만, 파이토치의 경우 간단하고 직관적이다. 게다가 상대적으로 텐서플로우보다 파이토치가 학습을 따라가기가 더 쉽다.  
> <small> 딥러닝을 구현할 수 있는 라이브러리 </small>

---

## Table of Contents

|No|Title|Remarks|
|-:|:-:|:--|
|1|[환경설정](#get-started)|환경설정|
|2|[PyTorch](#pyTorch)|PyTorch 딥러닝 소스|

---

## Get Started

* [PyTorch](https://pytorch.org/)
* PyTorch [개발환경 PyTorch](https://tensorflow.blog/2018/04/25/pytorch-0-4-0-release/)

```shell
# Windows GPU
conda install pytorch cuda91 -c pytorch
pip3 install torchvision
# Windows CPU
conda install pytorch torchvision -c pytorch
```

---

## Data & Source

### Table of Data & Source

|No|Title|Educational Institution|Source|Remarks|
|-:|:-:|:-:|:-:|:--|
|1|Tensor|서울대학교 도시연구소|[Tensor](https://github.com/shpimit/shpimit.github.io/tree/master/_pages/AI/PyTorch/src/01_Tensor.ipynb)|Pytorch기초|
|2|Autograd|서울대학교 도시연구소|[Autograd](https://github.com/shpimit/shpimit.github.io/tree/master/_pages/AI/PyTorch/src/01_Autograd.ipynb)|Autograd|
|3|DataLoader|서울대학교 도시연구소|[DataLoader](https://github.com/shpimit/shpimit.github.io/tree/master/_pages/AI/PyTorch/src/03_Dataset_DataLoader.ipynb)|DataLoader|
|4|Feed-forward|서울대학교 도시연구소|[Feed-forward](https://github.com/shpimit/shpimit.github.io/tree/master/_pages/AI/PyTorch/src/04_Feed-forward_Neural_Networks.ipynb)|Feed-forward|
|5|CNN|서울대학교 도시연구소|[CNN](https://github.com/shpimit/shpimit.github.io/tree/master/_pages/AI/PyTorch/src/05_Convolutional_Neural_Networks.ipynb)|Convolutional_Neural_Networks|
|6|RNN|서울대학교 도시연구소|[RNN](https://github.com/shpimit/shpimit.github.io/tree/master/_pages/AI/PyTorch/src/06_Recurrent_Neural_Networks.ipynb.ipynb)|Recurrent_Neural_Networks|

---

## Reference

* [UDSL실습1 HelloPyTorch](https://github.com/InsuJeon/HelloPyTorch)
* [UDSL실습2 pytorch-tutorial](https://github.com/yunjey/pytorch-tutorial)
