---
layout: page
title: Python Crawling 배우기
subtitle: Python BeautifulSoup Crawling
categories: Language
tags: Python
---

# Introducing Web Crawling !!

##### (BeautifulSoup)

---

## Overview

> 텍스트 분석  
> 텍스트 데이터를 통해 의사결정에 도움이 되는 정보 추출하기  
> <small> TF_IDF, Word2Vec, 감성분석, Topic Model등 다양한 분석방법 존재 </small>

---

## Contents

### Table of Contents

|No|Title|Remarks|
|-:|:--:|:--|
|1|[For문과 축약 기법](#1)|반복문|
|2|[문자열 서식설정(String Formatting)](#2)|String Formatting|
|3|[lambda 함수](#3)|lambda|

---

## 1. for문과 축약 기법

> [표현식 for 객체 in 순회형 [if 불린-표현식]]  
> 일반적으로 표현식은 객체이거나 객체를 생성하는 식

### 일반식

```python
int_str1 = []

for i in range(1, 10):
    int_str1.append(str(i))
```

### 리스트 축약

```python
int_str2 = [str(i) for i in range(1,10)]
```

---

## 2. 문자열 서식설정(String Formatting)

> 필드명(Field Name), 형변환(Conversion), 서식명세(Format Specification)
> { ! : }
> {필드명!형변환:서식명세}

```python
s = '파이썬을 배우면서 파이썬을 즐기자!!!'
'{:25}'.format(s)
```

> '파이썬을 배우면서 파이썬을 즐기자!!!    '

```python
'{:=^25}'.format(s)
```

> '==파이썬을 배우면서 파이썬을 즐기자!!!=='

```python
'{:>25}'.format(s)
```

> '    파이썬을 배우면서 파이썬을 즐기자!!!'

```python
'{:~<25}'.format(s)
```

> '파이썬을 배우면서 파이썬을 즐기자!!!~~~~'

```python
'{:~<25}'.format(s)
```

> '파이썬을 배우면서 파이썬을 '

## 3. lambda 함수 사용법
* lambda 는 함수를 생성할때 사용하는 예약어
* def와 동일한 역할

```python
def square(x):
    return x ** 2

square(5)

square = lambda x: x ** 2

square(5)

```
