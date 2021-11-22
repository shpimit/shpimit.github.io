---
layout: post
title: Miscellaneous
subtitle: Miscellaneous
summary: Miscellaneous is my miscellaneous space about IT new technology. 
categories: Miscellaneous
tags: Miscellaneous
featured-img: miscellaneous
mathjax: true
comments: 분류하기 어려운 utility Learning
---

# Introducing `Miscellaneous` !!

##### Miscellaneous is my miscellaneous space about IT new technology.

---

## Contents

### Table of Contents

|No|Title|Remarks|
|-:|:--:|:-:|
|1|[Python](#python) |파이썬|
|2|[Jupyter](#jupyter) |주피터|
|3|[Visual Studio Code](#vsc) |Visual Studio Code|
|4|[Unix](/_pages/Miscellaneous/2018-12-22-StoryTelling)|Unix 꿀 Tip|
|5|[VR](/_pages/Miscellaneous/2018-12-18-KIPFA-VRARMR)|Unity 가상 프로그램|
|6|[Jekyll](/_pages/Miscellaneous/2018-12-13-Jekyll)|Jekyll 프로그램|
|7|[Algorithm](/_pages/Miscellaneous/2018-12-15-Algorithm)|Algorithm 심화|

---

## VSC

##### VSCode-GitHub 연동

1. VSCode를 설치한다.
2. Git-SCM을 설치한다.

* 처음에는 이해 안됬으나.. 결과적으로  일단 먼저 Git-SCM을 깔고나서, Git-Hub 연동해야된다.
* Git-SCM설치 없이,  진행하면 VSCode에서 컴퓨터에서 Git프로그램을 찾을 수 없습니다.. 이런식의 에러 발생.

3. 보기 > 명령 파레트 클릭후 명령창에 git clone이라고 입력해도 똑같은 작업할 수 있음
4. 내용은 “리포지토리 URL(확인하려면 Enter키를 누르고, **취소**하려면 ‘Escape’키를 누름)”
5. GitHub 들어가서 내가 생성해 놓은 프로젝트 URL 복사하여 Ctrl+V.
엔터치면 부모디렉토리를 입력하라고 나옴..
6. ‘GitHub에서 가져온 프로젝트 파일을 어디다가 저장할꺼야?’ 라는 얘기이므로.. 원하는 경로 적어주고 다시 Enter

* [VSCode에 Git 사용하기](http://ccambo.gitlab.io/2017/07/09/VSCODE-VSCode%EC%97%90-Git-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0/)

* [VSCode-GitHub 연동](http://www.ruokit.com/index.php/2017/10/28/vscode-github/)

---

## Python

###### 윈도우10, Anaconda, TensorFlow, PyCharm 환경설정

* [윈도우10에서 Anaconda 기반의 TensorFlow 라이브러리 설치 및 PyCharm을 이용한 개발 환경 구성](http://agiantmind.tistory.com/176)

---

## Jupyter

1. [Jupyter Oracle연동](https://db-blog.web.cern.ch/blog/luca-canali/2016-06-ipythonjupyter-notebooks-oracle)
2. [github](https://github.com/LucaCanali/Miscellaneous/blob/master/Oracle_Jupyter/Oracle_IPython_cx_Oracle_pandas.ipynb)  
3. [Jupyter Home 경로 바꾸기](http://luke77.tistory.com/52)

* .jupyter 폴더 진입
* jupyter_notebook_config.py 열기
* #c.NotebookApp.notebook_dir = '' 열찾기 (179 번째 line 정도)
* '' 란 안에 원하는 폴더의 절대 경로 삽입. 단 \ --> / 로 변경 (c:\temp --> c:/temp)
* #c.NotebookApp.notebook_dir = ''  → 주석 제거
1. [![허민석 Jupyter사용법](http://img.youtube.com/vi/SLPo0o_HArs/0.jpg)](https://youtu.be/SLPo0o_HArs) 
2. [![주피터 노트북의 진화! 주피터랩 살펴보기](http://img.youtube.com/vi/70sRgL42c1w/0.jpg)](https://youtu.be/70sRgL42c1w)

## 영상 촬영

* [촬영기본](https://youtu.be/CD0pRAx0LHc)
* [FPS](https://youtu.be/cBvZJRwLvfI)
* [화각](https://youtu.be/jiqphhL4RlE)
* [화소에 대한 내용](https://youtu.be/NTyfr5iLrTE)
* [구도](https://youtu.be/6PvPFdrk6Cg)

## Lightroom Classic

* 현상에서 작업함
  
> 화이트 밸런스 작업(스포이드) 후 대부분의 색조절
> 그래프에서 S자곡선

## Premiere Pro

> Layer 개념으로 영상/텍스트/효과음을 넣고 진행함
 
* [크로마키 효과](https://www.youtube.com/watch?v=B_fNqhiwCJQ)

https://github.com/fluent/fluentd-kubernetes-daemonset 

출처: https://arisu1000.tistory.com/27852 [아리수]
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/8/$basearch/
gpgcheck=0
enabled=1

firewall-cmd --permanent --zone=public --add-port=8089/tcp
[root@localhost ~]# firewall-cmd --permanent --zone=public --add-port=8089/tcp[root@localhost ~]# firewall-cmd --reload
[root@localhost ~]# firewall-cmd --list-ports 
21/tcp 5000/tcp 5001/tcp 8089/tcp

https://luke-tofu.tistory.com/entry/code-server-구동하기-with-Oracle-Cloud-Infrastructure

server {
    listen       80;
    listen       [::]:80;

    server_name  146.56.154.192; # 도메인 주소

    #charset koi8-r;
    #access_log /var/log/nginx/host.access.log  

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;              
        #proxy_pass       http://127.0.0.1:3100;  # backend url
        #proxy_set_header Host       $http_host;
        #proxy_set_header X-Real-IP  $remote_addr;
    }      

    #root /usr/share/nginx/frontend; # 배포된 프로젝트 경로
    #index index.html index.htm;

    #error_page 404 /404.html;  # redirect server error pages to the static page

    # error_page 500 502 503 504 /50x.html;
    location = /50x.html { 
        root /usr/share/nginx/html; 
    }       

    client_max_body_size 100M;

    # deny access to .htaccess files, if Apache's document root 
    # concurs with nginx's one 
    # 
    #location ~ /\.ht { 
    #   deny all; 
    #}    
}


---

## Data & Source

### Table of Data & Source

|No|Title|Educational Institution|Source|Remarks|
|-:|:--:|:--:|:--:|:-|
|1|Jupyter|허민석 github|[Jupyter](/_pages/Miscellaneous/src/Jupyter.ipynb)|`Jupyter`|

---

### Markdown

* [마크다운 문법](https://eungbean.github.io/2018/06/11/How-to-use-markdown/)
* [마크다운 Table](http://www.tablesgenerator.com/markdown_tables) : 표는 수작업으로 만들기 힘드니까 표를 만들어주는 사이트를 쓰세요.

##### [Go to Contents](#contents)