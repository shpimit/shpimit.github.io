* 설치하기

[이클립스](https://www.eclipse.org)
- pydev 플러그인 설치(메뉴 help - eclipse marketplace)
- pydev 입력후 검색
- sysdm.cpl 명령어로 들어가기
- 고급 탭 - 환경변수 버튼 클리
- 시스템 변수의 path의 가장 앞 단에 다음 항목 추가 하기
[아나콘다](https://www.anaconda.com/)

* 이클립스와 python 연동
  메뉴 window - preferences에서 
  pydev - interpreters - python interpreter
  
* 인코딩 설정
  General -> Workspace -> Textfile encoding -> Other 에서 utf-8로 설정

* 프로젝트 생성
   메뉴  file - new - pydev project

* jpype 설치
[jpype](https://www.lfd.uci.edu/~gohlke/pythonlibs/#jpype)
수동설치 JPype1-0.6.3-cp36-cp36m-win_amd64.whl

cmd 창에서 해당 폴더로 이동 후
pip install JPype1-0.6.3-cp36-cp36m-win_amd64.whl 엔터