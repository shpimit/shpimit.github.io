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
