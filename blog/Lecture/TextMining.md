---
layout: page
title: R
permalink: /Lecture/TextMining
---
# TextMining

## 1. 설치하기

### [이클립스](https://www.eclipse.org)
- pydev 플러그인 설치(메뉴 help - eclipse marketplace)
- pydev 입력후 검색
- sysdm.cpl 명령어로 들어가기
- 고급 탭 - 환경변수 버튼 클리
- 시스템 변수의 path의 가장 앞 단에 다음 항목 추가 하기
- 이클립스와 python 연동
- 메뉴 window - preferences에서 
- pydev - interpreters - python interpreter

- 인코딩 설정
  General -> Workspace -> Textfile encoding -> Other 에서 utf-8로 설정
  
- 프로젝트 생성
   메뉴  file - new - pydev project  

### [아나콘다](https://www.anaconda.com/)

## 2. WebCrawling(네이버 영화제목 뽑기)

- Beautifulsoup
- 네이버 영화제목 뽑기
```python
import urllib.request   # import 모듈이름
from bs4 import BeautifulSoup

url = 'https://movie.naver.com/movie/sdb/rank/rmovie.nhn'

html = urllib.request.urlopen(url)

soup = BeautifulSoup(html, 'html.parser')
tags = soup.findAll('div', attrs={'class':'tit3'})

print(len(tags))
```

- 앵커의 href 속성값 뽑아오기
```python
url_header = 'https://movie.naver.com'    
for tag in tags : 
    # []을 이용한 형식은 자바 스크립트 문법을 이용한 기법이다.
    print(url_header + tag.a['href'])
```    
    
## 3. 텍스트 마이닝

- jpype 설치
[jpype](https://www.lfd.uci.edu/~gohlke/pythonlibs/#jpype)

- 수동설치 JPype1-0.6.3-cp36-cp36m-win_amd64.whl
cmd 창에서 해당 폴더로 이동 후
pip install JPype1-0.6.3-cp36-cp36m-win_amd64.whl 엔터

### KoNLPy의 트위터 형태소 분석기

- [참조사이트](http://konlpy.org/ko/latest/api/konlpy.tag/)
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

### matplotlib 모듈

- [참조사이트](https://matplotlib.org/gallery/index.html)
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

### Word Cloud 

- [참조사이트](https://matplotlib.org/gallery/index.html)
- 설치할 목록
```python
pip install pytagcloud
pip install pygame
pip install simplejson
```
- font.json 수정하기
C:\Windows\Fonts\malgun.ttf외2   -> C:\ProgramData\Anaconda3\Lib\site-packages\pytagcloud\fonts 로 copy한다
```json
	{
		"name": "korean",
		"ttf": "malgun.ttf",
		"web": "http://fonts.googleapis.com/css?family=Nobile"
	},
```
