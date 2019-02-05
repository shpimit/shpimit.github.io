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
|--:|:-:|:--|
|1|[For문과 축약 기법](#반복문)|반복문|

---

## 반복문

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