---
layout: page
title: R
permalink: /Lecture/NLP
---

---

<!-- *template: gaia -->

# Introducing `NLP` !!
##### (Natural Language Processing)
###### Created by [푸르지오 (@shpimit)](https://github.com/shpimit)

---

<!-- $theme: gaia -->

# Overview

> 자연어 처리는 **KoNLpy**등의 처리를 통해서 형태소를 구별하여 단어/문장등에서 의미를 발견하는 작업이다. 
>
> <small>-- *[Gaia (mythology) - Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Gaia_%28mythology%29)*</small>

---

<!-- *template: invert -->

# Contents

<a name="contents"/>

* **Table of Contents**   

|No|Titile|Explain|
|--:|:-:|:--|
|0|[Install](#install)|환경설정|
|1|[WebCrawling](#WebCrawling)|웹 크롤링|
|2|[Text Mining](#text)|텍스트 마이닝|
|3|[Graph & Chart](#matplotlib)|그래프 & 차트|
|4|[Word Cloud](#wordcloud)|워드 클라우드|

---

<!-- *template: gaia -->

## Introduce Install !!  
# 환경 설정

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="install"/>

### Install

##### **1. Pydev**

<span style="font-size:16pt">  

* [eclipse 설치](https://www.eclipse.org)  
* pydev 플러그인 설치(메뉴 help - eclipse marketplace)  
* pydev 입력후 검색  
* sysdm.cpl 명령어로 들어가기  
* 고급 탭 - 환경변수 버튼 클리  
* 시스템 변수의 path의 가장 앞 단에 다음 항목 추가 하기  
* 이클립스와 python 연동  
* 메뉴 window - preferences에서   
   pydev - interpreters - python interpreter  
* 인코딩 설정  
  General -> Workspace -> Textfile encoding -> Other 에서 utf-8로 설정      
* 프로젝트 생성  
   메뉴  file - new - pydev project  

##### **[2. Anaconda](https://www.anaconda.com/)**

---

<!-- *template: gaia -->

## Introduce **WebCrawling** ll !!  
# WebCrawling

---

<!-- *template: invert -->
<!-- page_number: true -->

<a name="WebCrawling"/>

### WebCrawling

<span style="font-size:18pt">  

* 네이버 영화제목 뽑기  
```python
import urllib.request   # import 모듈이름
from bs4 import BeautifulSoup

url = 'https://movie.naver.com/movie/sdb/rank/rmovie.nhn'

html = urllib.request.urlopen(url)

soup = BeautifulSoup(html, 'html.parser')
tags = soup.findAll('div', attrs={'class':'tit3'})

print(len(tags))
```

* 앵커의 href 속성값 뽑아오기  
```python
url_header = 'https://movie.naver.com'    
for tag in tags : 
    # []을 이용한 형식은 자바 스크립트 문법을 이용한 기법이다.
    print(url_header + tag.a['href'])
```    
###### [go to main](#contents)

---

<!-- *template: gaia -->

## Introduce Text Mining !!  

# Text Mining

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="text"/>

### Text Mining 

* jpype 설치
[jpype](https://www.lfd.uci.edu/~gohlke/pythonlibs/#jpype)

* 수동설치 JPype1-0.6.3-cp36-cp36m-win_amd64.whl
cmd 창에서 해당 폴더로 이동 후
pip install JPype1-0.6.3-cp36-cp36m-win_amd64.whl 엔터

---

<!-- *template: invert -->
<!-- page_number: true -->

### Text Mining

##### KoNLPy의 트위터 형태소 분석기

<span style="font-size:12pt"> 

* [참조사이트](http://konlpy.org/ko/latest/api/konlpy.tag/)
```python
from konlpy.tag import Twitter

twitter = Twitter()

text = "아름다운그녀가아버지가방에들어가신다."

# stem = True 이면, 형용사/동산의 기본원형으로 바꿔준다.
# 아름다운 -> 아름답다, 들어가신다 -=> 들어간다.
# norm = 정규화로 바꾸어 준다.
malist = twitter.pos(text, norm=True, stem=True)
print('-' * 40)
print(malist)

malist = twitter.pos(text, norm=False, stem=True)
print('-' * 40)
print(malist)

malist = twitter.pos(text, norm=True, stem=False)
print('-' * 40)
print(malist)

malist = twitter.pos(text, norm=False, stem=False)
print('-' * 40)
print(malist)

print(type(malist))   # type을 알기 위해서 하는것

for myitem in malist:
    print("단어:", myitem[0])
    print("픔사:", myitem[1])
```

###### [go to main](#contents)

---

<!-- *template: gaia -->

## Introduce Graph & Chart !!  
# matplotlib

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="matplotlib"/>

### matplotlib 모듈

<span style="font-size:18pt"> 
  
* [참조사이트](https://matplotlib.org/gallery/index.html)  
```python
# font_manager 글꼴 관리자
# rc 함수 : 전역적으로 사용하고 싶을때
# 예을 들어서, Figure의 크기를(10, 10)으로 전역 설정하고 싶다면 다음과 같이 코딩한다.
# plt.rc('figure',figsize=(10,10))

from matplotlib import font_manager, rc
import matplotlib.pyplot as plt

# 더 많은 설정과 옵션의 종류는 matplotlib/mpl-data폴더의 matplotlibrc 파일에 저장되어 있다.
# 예시) 파이썬 설치 경로\Lib\site-packages\matplotlib\mpl-data\matplotlibrc 
font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
font_name = font_manager.FontProperties(fname=font_location).get_name()
plt.rc('font',family=font_name)

xdata = [1, 2, 3, 4]
ydata = [5, 6, 7, 8]

plt.plot(xdata, ydata)  # 백그라운에 그린다.
plt.xlabel('x축 한글 표시')
plt.ylabel('y축 한글 표시')
plt.title('matplotlib 활용')
plt.show()  # 그린것을  보여준다..
```

###### [go to main](#contents)

---

<!-- *template: gaia -->

## Introduce word cloud !!  
# Word Cloud

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="wordcloud"/>

### Word Cloud 

<span style="font-size:18pt"> 

* [참조사이트](https://matplotlib.org/gallery/index.html)
* 설치할 목록  
```python
pip install pytagcloud
pip install pygame
pip install simplejson
```
* font.json 수정하기
C:\Windows\Fonts\malgun.ttf외2   -> C:\ProgramData\Anaconda3\Lib\site-packages\pytagcloud\fonts 로 copy한다
```json
	{
		"name": "korean",
		"ttf": "malgun.ttf",
		"web": "http://fonts.googleapis.com/css?family=Nobile"
	},
```

---

<!-- *template: invert -->
<!-- page_number: true -->

#### 말뭉치 파일 단어 빈도 분석


*  정규 표현식을 실습해본다.
```python
import re  # 정규표현식 regular

# sub : 대체
# [^\w] : ^는 \w를 제외하고 \w : 영소문자, 숫자, 한글
text = '[특종]대한민구 통일됨(후후후)\n\n#조아  #아주 조아 #cheeze'

newtext = re.sub(r'[^\w]','',text)

print(newtext) 
```

---

<!-- *template: invert -->
<!-- page_number: true -->

#### 자료형 이해

<span style="font-size:18pt"> 

```python
word_dic = {}
malist = [('사랑','Noun'),('이','조사'),('사랑','Noun'),('바보','Noun')]

for word in malist:
    if word[1] == "Noun":
        if not(word[0] in word_dic):
            word_dic[word[0]] = 0
        word_dic[word[0]] += 1  # 카운트하기
        
print(word_dic)
print(word_dic.items())     

# 키를 이용한 오름차순 정렬
keys = sorted(word_dic.items(), reverse=False)
print(keys)

# 키를 이용한 내림차순 정렬
keys = sorted(word_dic.items(), reverse=True)
print(keys)

# 값(1번째 인덱스)을 이용한 역순 정렬
keys = sorted(word_dic.items(), key=lambda x : x[1], reverse =True)
print(keys)
```

---

<!-- *template: invert -->
<!-- page_number: true -->

#### 데이터 정렬

```python
mydict = {'a':20,'b':30, 'c':10}

# 값(value) 가장 큰것부터 역순으로 정렬
byValues = sorted(mydict.values(), reverse=True)
print(byValues)

# 키를 기준으로 역순으로 정렬
byKeys = sorted(mydict.keys(), reverse=True)
print(byKeys)

# 키를 기준으로 역순으df로 정렬
keyortByVals = sorted(mydict,key=mydict.get, reverse=True)
print(keyortByVals)
```

---

<!-- *template: invert -->
<!-- page_number: true -->

#### 국립국어원

<span style="font-size:6.5pt">
  
* [참조하기](https://ithub.korean.go.kr/user/main.do)
```python
import codecs # 파일의 인코딩과 디코딩을 위한 모듈
import pytagcloud # 워드 클라우드를 만들어 주는 패키지
import webbrowser
import matplotlib
import matplotlib.pyplot as plt

from matplotlib import font_manager, rc
from bs4 import BeautifulSoup
from konlpy.tag import Twitter

fp = codecs.open("BEXX0003.txt", 'r', encoding='utf-8')
soup = BeautifulSoup(fp, "html.parser")
body = soup.select_one("body > text")
text = body.getText()
# print(text)

twitter  = Twitter()

word_dic = {}

lines = text.split('\n\r')

for line in lines:
    malist = twitter.pos(line)
    for word in malist:              # word는 tuple 자료구조이다. 2번째 요소에 품사 정보가 들어있다.
        if word[1] == "Noun":        # 명사 확인하기
            if not(word[0] in word_dic): # 새롭게 들어온 명사이면
                word_dic[word[0]] = 0    # 사전에 추가하기
            word_dic[word[0]] += 1       # 카운트하기

# 많이 사용된 명사 출력하기        
keys = sorted(word_dic.items(), key=lambda x:x[1], reverse=True)        
 
print(keys)

def saveWordCloud(wordInfo):
    taglist = pytagcloud.make_tags(dict(wordInfo).items(), maxsize=80)
    print(type(taglist)) #<class 'list'>
    filename = 'wordcloun.png'
    pytagcloud.create_tag_image(taglist, filename, size=(640,480), fontname='korean', rectangular=False)
    webbrowser.open(filename)

def showGraph(wordInfo):
    font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
    font_name = font_manager.FontProperties(fname=font_location).get_name()
    plt.rc('font',family=font_name)
    
    plt.xlabel('주요 단어')
    plt.ylabel('빈도 수')
    plt.grid(True)
    
    barcount = 10 # 10개만 그리겠다.
    
    Sorted_Dict_Values = sorted(wordInfo.values(), reverse=True)
    print(Sorted_Dict_Values)
    print('dd')
    plt.bar(range(barcount), Sorted_Dict_Values[0:barcount], align='center')
    
    Sorted_Dict_Values = sorted(wordInfo, key=wordInfo.get, reverse=True)
    plt.xticks(range(barcount), list(Sorted_Dict_Values)[0:barcount], rotation='70')
    
    plt.show()

wordInfo = dict()
for word, count in keys[:500]:              # word: 해당 명사, count: 명사의 빈도 수
#     print("{0}({1})".format(word, count), end="")
    if(count >= 60) and len(word) >= 2:
        wordInfo[word] = count

saveWordCloud(wordInfo)
showGraph(wordInfo)

print(wordInfo) 
```
###### [go to main](#contents)
