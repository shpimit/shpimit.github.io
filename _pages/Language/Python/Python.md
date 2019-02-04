---
layout: page
title: Python 배우기
permalink: /Lecture/Python
---

---

<!-- $theme: gaia -->
<!-- *template: gaia -->
<!-- page_number: false -->

# Introducing Python !!
##### (Easy Python)

<!-- *template: invert -->
<!-- page_number: true -->

* **Table of Learning**

|No|Title|Educational Institution|Term|
|--:|:-:|:-:|:--:|
|1|[텐서플로우 딥러닝 인공지능 개발](/Lecture/TensorFlow)|IT이젠아카데미|18.8.4~9.1|
|2|[파이썬 프로그램밍과 과학 계산](/Lecture/MachineLearning)|서울대학교 도시연구소|18.8.20~8.24|
|3|[빅데이터 분석기초를 위한 Python](/Lecture/Python)|서울대학교 도시연구소|18.9.3~9.7|
|4|[기계학습의이해](/Lecture/MachineLearning)|서울대학교 도시연구소|18.9.10~9.14|

---

<!-- $theme: gaia -->
<!-- page_number: true -->

## Overview

> 파이썬(Python)은 1990년 암스테르담의 귀도 반 로섬(Guido Van Rossum)이 개발한 인터프리터 언어이다. 
> 딥러닝 비전문가라도 각자 분야에서 손쉽게 딥러닝 모델을 개발하고 활용할 수 있도록 케라스는 직관적인 API를 제공하고 있습니다.    
> <small>-- *귀도는 파이썬이라는 이름을 자신이 좋아하는 코미디 쇼인 "몬티 파이썬의 날아다니는 서커스(Monty Python’s Flying Circus)"에서 따왔다고 한다. 파이썬의 사전적인 의미는 고대 신화에 나오는 파르나소스 산의 동굴에 살던 큰 뱀을 뜻하며, 아폴로 신이 델파이에서 파이썬을 퇴치했다는 이야기가 전해지고 있다. * </small>

---

<!-- *template: invert -->  

## Contents

<a name="contents"/>

### Table of Contents

|No|Title|Remarks|
|--:|:-:|:--|
|0|[환경설정](#install)|환경설정|
|2|[Reference Site](#reference)|참조사이트|
|1|[Facebook Crawling](#1)|페이스 북 크롤링|
|2|[Gensim](#2)|유사도|
|3|[Basian](#3)|베이지안 정리|
|4|[Wikipedia](#4)|위키피디아 데이터 분석하기|
|5|[XML](#5)|XML 데이터 분석하기|

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="install"/>

## Get Started(`Python`)

<span style="font-size:16pt">

* Installing Pydev
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

* Installing [Anaconda](https://www.anaconda.com/)**

---

<!-- *template: invert -->

## Data & Source

### Table of Data & Source

|No|Title|Educational Institution|Source|Remarks|
|--:|:-:|:-:|:-:|:--|
|1|<small>텐서플로우 딥러닝 인공지능 개발</small>|<small>IT이젠아카데미</small>|[WebCrawling.ipynb](https://github.com/shpimit/shpimit.github.io/tree/master/blog/Python/src/WebCrawling.ipynb)|웹크롤링|
|2|<small>텐서플로우 딥러닝 인공지능 개발</small>|<small>IT이젠아카데미</small>|[Konlpy.ipynb](https://github.com/shpimit/shpimit.github.io/tree/master/blog/Python/src/KonlpySamply.ipynb)|자연어처리|
|3|<small>텐서플로우 딥러닝 인공지능 개발</small>|<small>IT이젠아카데미</small>|[matplotlib.ipynb](https://github.com/shpimit/shpimit.github.io/tree/master/blog/Python/src/matplotlib.ipynb)|그래프라이브러리|
|4|<small>텐서플로우 딥러닝 인공지능 개발</small>|<small>IT이젠아카데미</small>|[WordCloud.ipynb](https://github.com/shpimit/shpimit.github.io/tree/master/blog/Python/src/WordCloud.ipynb)|워드클라우드|
|5|<small>텐서플로우 딥러닝 인공지능 개발</small>|<small>IT이젠아카데미</small>|[Pandas.ipynb](https://github.com/shpimit/shpimit.github.io/tree/master/blog/Python/src/Pandas.ipynb)|Pandas예제|
|6|<small>텐서플로우 딥러닝 인공지능 개발</small>|<small>IT이젠아카데미</small>|[Series.ipynb](https://github.com/shpimit/shpimit.github.io/tree/master/blog/Python/src/Series.ipynb)|Series예제|

---

<!-- *template: gaia -->
<!-- page_number: false -->

## Introduce Facebook Crawling !!

### 페이스 북 크롤링

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="1"/>

#### 1. Facebook Crawling

###### 1.1 페이스북 crawling 해서 분석하기

<span style="font-size:16pt">

```python
from matplotlib import font_manager, rc
import matplotlib.pyplot as plt

import pytagcloud # 워드 클라우드를 만들어 주는 패키지
import webbrowser

# 그래프 그려주는 함수
def showGraph(wordInfo):
    font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
    font_name = font_manager.FontProperties(fname=font_location).get_name()
    
    plt.rc('font',family=font_name)
    
    plt.xlabel('주요 단어')
    plt.ylabel('빈도 수')
    plt.grid(True)
    
    Sorted_Dict_Values = sorted(wordInfo.values(), reverse=True)
    print(Sorted_Dict_Values)
    plt.bar(range(len(wordInfo)), Sorted_Dict_Values, align='center')
    
    Sorted_Dict_Keys = sorted(wordInfo, key=wordInfo.get, reverse=True)
    print(Sorted_Dict_Keys)
    plt.xticks(range(len(wordInfo)), list(Sorted_Dict_Keys), rotation='70')
    
    plt.show()
```
---

<!-- *template: invert -->
<!-- page_number: true -->

###### 1.2 페이스북 crawling 해서 분석하기 2

```python
# 워드 클라우드 그려주는 함수
def saveWordCloud(wordInfo, filename):
    taglist = pytagcloud.make_tags(dict(wordInfo).items(), maxsize=80)
    print(type(taglist)) #<class 'list'>
    pytagcloud.create_tag_image(taglist, filename, size=(640,480), fontname='korean', rectangular=False)
    webbrowser.open(filename)

import json
import re

from konlpy.tag import Twitter
from collections import Counter
```

---

<!-- *template: invert -->
<!-- page_number: true -->

###### 1.3 페이스북 crawling 해서 분석하기 3

<span style="font-size:12pt">

```python
# 메인 함수
def main():
    openFileName = 'jtbcnews_facebook_2016-10-01_2017-03-12.json'
    cloudImagePath = openFileName + '.jpg'
    
    rfile = open(openFileName, mode='r', encoding='utf-8-sig')
    rfile = rfile.read()  # 메모리상에 바이트로 만들어 주는 함수

    jsonData = json.loads(rfile)
    
#     print(jsonData)
    
    message = ''
    for item in jsonData :
        message = message + re.sub(r'[^\w]','', item['message'])


#     print(message)
    nlp = Twitter()
    nouns = nlp.nouns(message)
    
    count = Counter(nouns)
    print('count 개수:', count)
    
    wordInfo= dict()
    
    for key, value in count.most_common(20):
        if(len(str(key)) > 1):
            wordInfo[key] = value
            print(key, '/', value)
            
    showGraph(wordInfo)
    saveWordCloud(wordInfo, cloudImagePath)       
            
'''
외부에서 이파일을 실행하면  이값은 false
 스스로 실행하면 true 가 됨
'''
if __name__ == '__main__':
    main()
```

###### <U>[Go to Contents](#contents)</U>

---

<!-- *template: gaia -->
<!-- page_number: false -->

## Introduce Gensim !!  
# 유사도

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="2"/>

###### 2. Gensim 라이브러리

[Gensim](https://radimrehurek.com/gensim/models/word2vec.html)
[Skip-Gram 모델 참조문서](http://mccormickml.com/2016/04/19/word2vec-tutorial-the-skip-gram-model/)

`토지 파일 분석 word2vec=toji`  

<span style="font-size:6pt">

```python
import warnings
warnings.filterwarnings(action='ignore', category=UserWarning, module='gensim')

import codecs

from bs4 import BeautifulSoup
from konlpy.tag import Twitter
from gensim.models import word2vec

fp = codecs.open(filename='BEXX0003.txt', mode='r', encoding='utf-8')
soup = BeautifulSoup(fp, 'html.parser')
body = soup.select_one('body > text')
text = body.getText()
print(text)

twitter = Twitter()
results = []

lines = text.split('\r\n')

for line in lines:
    malist = twitter.pos(line, norm=True, stem=True)
    r = []
    for word in malist:
        if not word[1] in ['Josa', 'Eomi', 'Punctuation']:
            r.append(word[0])
            
    r1 = (" ".join(r)).strip()
    results.append(r1)
    
# 파일로 출력하기
output_file = 'toji.out'

with open(output_file, 'w', encoding='utf-8') as fp:
    fp.write('\n'.join(results))
    
# Word2Vec 모델 만들기
data = word2vec.LineSentence(output_file)
model = word2vec.Word2Vec(data, size=200, window=10, hs=1, min_count=2, sg=1)

saved_model_name = 'toji.model'

model.save(saved_model_name)

print('파일', saved_model_name, ' fininshed')   
```

---

<!-- *template: invert -->
<!-- page_number: true -->

`모델 불러오기 toji_model_test`

<span style="font-size:6pt">

```python
import matplotlib.pyplot as plt

from matplotlib import font_manager, rc
from gensim.models import word2vec

def showGraph(somedata): # 유사도 그래프
    su = len(somedata)   # 전체 데이터 수
    # 축에 보여질 항목 이름들
    item = list(item[0] for item in somedata)   # 항목이름
    count = list(item[1] for item in somedata)  # 확률
    
    font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
    font_name = font_manager.FontProperties(fname=font_location).get_name()
    plt.rc('font',family=font_name)    
    
    plt.barh(range(su), count, align='center')  # 수평막대 그래프
    plt.yticks(range(su), item, rotation='10')
    plt.xlim(0.8, 0.86) # x축의 하한 값과 상한값을 작게 설정하여 차트의 효과를 극대화 시켰다.
    plt.grid(True)
    plt.show()

filename = 'toji.model'

model = word2vec.Word2Vec.load(filename)

somedata = model.most_similar(positive=['땅'])
print(somedata)

showGraph(somedata)

print('-' * 50)
somedata = model.most_similar(positive=['집'], topn=5)
print(somedata)
```

###### <U>[Go to Contents](#contents)</U>

---

* [마크다운](http://www.kwangsiklee.com/ko/tag/마크다운/)
* https://www.slideshare.net/JackLee27/markdown-ppt-102809485
* [Gitbook](https://tinydew4.gitbooks.io/gitbook/ko/pages.html)

---

<!-- *template: gaia -->
<!-- page_number: false -->

## Introduce Basian !!  
# 베이지안 정리

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="3"/>

###### 3. 베이지안 정리

<span style="font-size:6pt">

```python
'''
bayes_test.py
'''
from konlpy.tag import Twitter
import math, sys

class BayesianFilter():
    def __init__(self):
        self.category_dict = {}
        self.word_dict = {}
        self.words = set()
        print('생성자 호출됨')
        
    def bayes_split(self, text):
        results = []
        twitter = Twitter()
        
        # 단어의 기본형 사용
        textlist = twitter.pos(text, norm=True, stem=True)
        
        for word in textlist:
            # 조사, 어미, 구둣점은 제외하고...
            if not word[1] in ['Josa','Eomi', 'Punctuation']:
                results.append(word[0])
                
        return results
    
    # 단어와 카테고릐의 출현 횟수 세기
    def increase_word(self, word, category): # 예시 : word('세일'), category('광고')
        # 단어를 카테고리에 추가하기
        if not category in self.word_dict:
            self.word_dict[category] = {}
        if not word in self.word_dict[category]:
            self.word_dict[category][word] = 0
        self.word_dict[category][word] += 1
        self.words.add(word)                 # 단어들 모음집에 추가
    
    def increase_category(self, category):
        # 카테고리 계산하기    
        if not category in self.category_dict:
            self.category_dict[category] = 0
        self.category_dict[category] += 1
        
    def fit(self, text, category):
        # word_list : 단어들을 저장하고 있는 리스트
        word_list = self.bayes_split(text)
        print(word_list)
        
        for word in word_list:
            self.increase_word(word, category)
        self.increase_category(category)
        
#         print('\n fit 함수 실행 결과')
#         print('\n [categoryp_dict 사전 내용]')
#         print('=' * 200)
#         print(self.category_dict)
#         print('\n [word 집한 내용]')
#         print('=' * 200)
#         print(self.words)
#         print('\n [word_dict 사전 values]')
#         print('=' * 200)
#         print(self.word_dict)

    # 단어 리스트에 점수 매기기        
    def score(self, words, category):   # 예시: words(['무료','배송']), categroy('광고')
        score = math.log(self.get_category_probablity(category))
        
        for word in words:
            score += math.log(self.get_word_probablity(word, category))
            
        return score    
    
    # 카테고리 계산
    def get_category_probablity(self, category):
        sum_categories = sum(self.category_dict.values())
        category_v = self.category_dict[category]
        
        print('모든 카데고리들의 빈도수 총합')
        print(sum_categories)
        print('해당 카테고리의 빈도 수')
        print(category_v)
        
        return category_v / sum_categories
    

    # 카테고리 내부의 단어 출현 횟수 구하기
    def get_word_count(self, word, category):
        if word in self.word_dict[category]:
            return self.word_dict[category][word]
        else:
            return 0
        
    # 카테고리 내부의 단어 출현 비율 계산
    def get_word_probablity(self, word, category):
        # 없는 다어이면 n=0인테 이렇게 되면 확률이 0이 되므로 1을 의도적으로 +1 시킨다.    
        # 0이면  확률이  0가 나오니까......+1 은  엄첨나게 많은 데이터에.. 무시해도 될 수준.
        n = self.get_word_count(word, category) + 1
        # 같은 확률이라고 해도 가중치를  주기 위해서
        # 1/2  ==   100/200 -> 1/(2+2)   100/(200+200)  그래서 +len(self.words)
        d = sum(self.word_dict[category].values()) + len(self.words)
        
        return n / d 

    def predict(self, text):
        best_category = None
        max_score = -sys.maxsize # 시스템이  가질 수 있는 가장 큰 정수(2**63-1)
        words = self.bayes_split(text)
        score_list = []
        
        # 사전에 들어 있는 카테고리 수만큼 반복 ...
        for category in self.category_dict.keys():
            score = self.score(words, category) # 이 단어들과 카테고리에 대하여...
            score_list.append((category, score))
            print('스코어')
            print(score)
            print(max_score)
            
            if score > max_score: # 시스템이 가질수 있는 최대 정수값
                max_score = score
                best_category = category
                
        print('베스트 카테고리')
        print(best_category)
        
        return best_category, score_list
        

bf = BayesianFilter()

# 보통 엑셀의 5000줄을  읽어서.. fit 5000번 호출
bf.fit('세일 무료 배송 할인', '광고')
bf.fit('일정 확인','중요')
bf.fit('백화점 세일', '광고')
bf.fit('파격 세일 하일', '광고')
bf.fit('프로젝트 진행 상황', '중요')
bf.fit('쿠폰 선물 & 무료 배송', '광고')
bf.fit('봄과 함께 찾아온 따뜻한 신제품 소식', '광고')
bf.fit('인기 제품 기간 한정 세일', '광고')
bf.fit('계약 잘 부탁드립니다.', '중요')
bf.fit('회의 일정이 등록되었습니다.', '중요')
bf.fit('오늘 일정이 없습니다.', '중요')

print('-' * 50)
pre, scorelist = bf.predict('무료 배송')
print('결과: ', pre)
print(scorelist)
 
print('-' * 50)
pre, scorelist = bf.predict('일정 확인')
print('결과: ', pre)
print(scorelist)
```

###### <U>[Go to Contents](#contents)</U>

---

<!-- *template: gaia -->
<!-- page_number: false -->

## Introduce Wikypedia !!  
# 위키피디아

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="4"/>

###### 4. 위키피디아 데이터 분석하기  

<span style="font-size:6pt">

```python
from gensim.models import word2vec

filename = 'wiki.model'

model = word2vec.Word2Vec.load(filename)

result = model.most_similar(positive=['Python','파이썬'])
print('-' * 50)
print(result)
result = model.most_similar(positive=['아빠','여성'], negative=['남성'])[0]
print('-' * 50)
print(result)
result = model.most_similar(positive=['왕자','여성'], negative=['남성'])[0:5]
print('-' * 50)
print(result)
result = model.most_similar(positive=['서울','일본'], negative=['한국'])[0:5]
print('-' * 50)
print(result)
result = model.most_similar(positive=['서울','중국'], negative=['한국'])
print('-' * 50)
print(result)
result = model.most_similar(positive=['오른쪽','남자'], negative=['왼쪽'])[0]
print('-' * 50)
print(result)
result = model.most_similar(positive=['서울','맛집'])[0:5]
print('-' * 50)
print(result)
result = model['고양이']
print('-' * 50)
print(result)
result = model['강아지']
print('-' * 50)
print(result)
```

###### <U>[Go to Contents](#contents)</U>

---

<!-- *template: gaia -->
<!-- page_number: false -->

## Introduce XML 데이터 분석 !!  
# XML 데이터

---

<!-- *template: invert -->
<!-- page_number: true -->
<a name="5"/>

###### 5.XML 데이터 분석하기

<span style="font-size:6pt">

```python
from xml.etree.ElementTree import Element, SubElement, ElementTree

# Element('앨리먼트 이름')
blog = Element('blog')

# 엘리먼트객체.attrib['속성이름'] = '속성에 들어갈 값'
blog.attrib['date'] = '20180714'

# SubElement(상위엘리먼트 객체, '태그이름').text = '들어갈 글자 내용'
SubElement(blog, 'subject').text = '파이썬 잼있어'
SubElement(blog, 'author').text = '홍길동'
SubElement(blog, 'content').text = '파이썬으로 xml 다루기'

def indent(elem, level=0):
    mytab = '\t'
    i = '\n' + level * mytab
    
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + mytab

        if not elem.tail or not elem.tail.strip():
            elem.tail= i
            
        for elem in elem:
            indent(elem, level +1)
            
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else :
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i        
            
indent(blog)

xmlFile = 'xmlEx01.xml'

# 파일 저장
ElementTree(blog).write(xmlFile, encoding='utf-8')

print('작업완료')
```

###### <U>[Go to Contents](#contents)</U>

---

<span style="font-size:6pt">

```python
from xml.etree.ElementTree import Element, SubElement, ElementTree

# 다음 사전을 이용하여 xml 파일을 만드세요
mydict = {'kim':('김철수',30,'남자','마표공덕동'), 'park':('박영희','40','여자','용산 도원동')}
print('사전 내역: ', mydict)

# Element('앨리먼트 이름')
members = Element('members')

# 엘리먼트객체.attrib['속성이름'] = '속성에 들어갈 값'
members.attrib['date'] = '20180714'

# SubElement(상위엘리먼트 객체, '태그이름').text = '들어갈 글자 내용'
for key, mytuple in mydict.items():
    mem = SubElement(members, 'member')
    mem.attrib['id'] = key # 속성 부여하기
    
    # 하위 엘리먼트
    SubElement(mem, 'name').text = mytuple[0]
    SubElement(mem, 'age').text =str( mytuple[1])
    SubElement(mem, 'gender').text = mytuple[2]
    SubElement(mem, 'address').text = mytuple[3]

def indent(elem, level=0):
    mytab = '\t'
    i = '\n' + level * mytab
     
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + mytab
 
        if not elem.tail or not elem.tail.strip():
            elem.tail= i
             
        for elem in elem:
            indent(elem, level +1)
             
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else :
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i        
             
indent(members)

xmlFile = 'xmlEx02.xml'

# ElementTree(엘리먼트객체).write(저장할 xml 파일 이름)
ElementTree(members).write(xmlFile, encoding='utf-8')

print('작업완료')
 
```

---

<span style="font-size:6pt">

```xml
<?xml version="1.0" encoding="UTF-8"?>
<가족들 설명="호호호" 코멘트="여러 가족들">
	<가족>
		<아부지>
			<이름>김말똥</이름>
			<나이>60</나이>
		</아부지>
		<어머니>
			<이름 정보="순악질">이순자</이름>
			<나이>55</나이>
			<blood>A형</blood>
		</어머니>
		<나 이름="김철식" 나이 ="30"/>
	</가족>
	<가족>
		<아부지>
			<이름>심형래</이름>
			<나이>38</나이>
		</아부지>
		<어머니>
			<이름 정보="abcd">김미화</이름>
			<나이>35</나이>
			<blood>A형</blood>
		</어머니>
		<나 이름="심수봉" 나이 ="3"/>
	</가족>
</가족들>
```

---

<span style="font-size:6pt">

```python
from xml.etree.ElementTree import parse

tree = parse('xmlEx03.xml')
myroot = tree.getroot()

print(type(myroot))

# 속성 읽어 오기
print('속성 읽기 1: ', end=' ')
print(myroot.keys())
print('속성 읽기 2: ', end=' ')
print(myroot.items())
print('속성 읽기 3: ', end=' ')
print(myroot.get('설명'))
print('속성 읽기 4: ', end=' ')
print(myroot.get('foo','미존재시기본값'))
print()

family1 = myroot.findall('가족')
print('finaall는 일치하는 모든 태그를 리스트로 반환한다.')
print(family1)
print('findtext는 일치하는 1번재 태그의 택스트 값을 반환한다.')
family2 = myroot.findtext('가족')
print(family2)

print('find는 일치하는 1번재 태그를 리턴한다.')
family = myroot.find('가족')
print(family)
print()

# childs = family.getiterator()
childs = family.getiterator()
print(childs)

# childs : 아부지, 어머니, 나
for onesaram in childs:
    print('엘리먼트 정보:', end=' ')
    print(onesaram)
    elem = onesaram.getchildren()
    
    for item in elem:
        print('하위 엘리먼트 정보:', end=' ')
        print(item, end=' ')
        print(item.text, end=' ')
        if item.text == '이순자':
            print(item.attrib['정보'])
        else:
            print()
    print()
print()    
```

###### <U>[Go to Contents](#contents)</U>

