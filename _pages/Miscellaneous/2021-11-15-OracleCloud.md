---
layout: page
title: OracleCloud 설치
subtitle: OracleCloud 설치
categories: Miscellaneous
tags: Miscellaneous
---

# OracleCloud

## Install

### 1. [Rasbian OS설치](https://www.canakit.com/pi)

* [OracleCloud](https://technfin.tistory.com/entry/오라클-클라우드-무료-가입-오류-및-주의사항?category=867921)
* [OracleCloud무료](https://yangeok.github.io/cloud/2021/08/17/oracle-cloud.html)
* [Nginx1](https://holjjack.tistory.com/114)
* [Nginx](https://hgko1207.github.io/2020/11/16/linux-9/)
* [포트개방](https://pythonblog.co.kr/blog/30/)
* [포트개방1](https://g82net.tistory.com/46)
* [망분리](https://blogger.pe.kr/917)
* [Code-Server](https://tong9433.github.io/blog/002#/)

* nginx default.conf

```sh
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

```

* 메뉴에서 한국어 선택 後 기본설치함 → 약 10분 걸림
* 부팅 완료 後 Language 설정에서는 Korean 선택하지 마세요. 
* 초기에 Wifi연결이 안됨

### 2. [Firmaware Update](https://jamesachambers.com/raspberry-pi-4-ubuntu-server-desktop-18-04-3-image-unofficial/)

* 우분투 비공식 버전 설치를 위한 Firmware Update

```shell
$ sudo apt-get update && sudo apt-get dist-upgrade -y
$ sudo rpi-update
```

### 3. 라즈베리 파이4 USB 웹캠 사용하기

#### ① fswebcam 설치하기

```shell
sudo apt-get install fswebcam
```

#### ② 기본사용법

```shell
fswebcam image.jpg
```

* 결과

```shell
--- Opening /dev/video0...
Trying source module v4l2...
/dev/video0 opened.
No input was specified, using the first.
Adjusting resolution from 384x288 to 320x240.
--- Capturing frame...
Captured frame in 0.00 seconds.
--- Processing captured image...
Writing JPEG image to 'image.jpg'.
```

#### ③ 해상도 지정하기

```shell
fswebcam -r 1280x720 image2.jpg
```

#### ④ 배너 숨기기

```shell
fswebcam -r 1280x720 --no-banner image3.jpg
```

* 기본적으로 python3 프로그램이 설치 되어 있음.. python3로 실행함.

### 4. [라즈베리파이 OpenCV 4.10 설치하기](https://medium.com/@patrick_ryan/building-opencv-4-10-on-raspian-buster-and-raspberry-pi4-64669bd2eb74)

#### ① OpenCV 예제 1. 얼굴 인식예제(https://blog.naver.com/roboholic84/221140338041)

#### ② OpenDV 예제 4. 카메라로 동영상 촬영하기(https://blog.naver.com/roboholic84/221141086412)

#### ③ OpenCV 예제 1.1 동영상 예제와 얼굴인식 예제 합치기(https://m.blog.naver.com/PostView.nhn?blogId=roboholic84&logNo=221141959847&proxyReferer=https%3A%2F%2Fwww.google.com%2F)

### 5. 라즈베리 파이 한글 입력

* [https://westwoodforever.blogspot.com/2019/05/ibus.html](https://westwoodforever.blogspot.com/2019/05/ibus.html)

```shell
sudo apt-get install ibus ibus-hangul
```
