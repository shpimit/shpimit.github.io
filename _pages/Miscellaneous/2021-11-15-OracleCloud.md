---
layout: page
title: OracleCloud 설치
subtitle: OracleCloud 설치
categories: Miscellaneous
tags: Miscellaneous
---

# OracleCloud

## Install

### 1. OracleCloud 환경 셋팅

* [OracleCloud](https://technfin.tistory.com/entry/오라클-클라우드-무료-가입-오류-및-주의사항?category=867921)
* [OracleCloud무료](https://yangeok.github.io/cloud/2021/08/17/oracle-cloud.html)
* [Nginx1](https://holjjack.tistory.com/114)
* [Nginx](https://hgko1207.github.io/2020/11/16/linux-9/)
* [포트개방](https://pythonblog.co.kr/blog/30/)
* [포트개방1](https://g82net.tistory.com/46)
* [망분리](https://blogger.pe.kr/917)
* [Code-Server](https://tong9433.github.io/blog/002#/)
* [subicura](https://github.com/subicura/workshop-init)

* nginx default.conf

```shell
$ vi /etc/nginx/conf.d/default.conf
```

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

* CentOS Version 확인

```shell
$ cat /etc/os-release
NAME="CentOS Linux"
VERSION="8"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="8"
PLATFORM_ID="platform:el8"
PRETTY_NAME="CentOS Linux 8"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:8"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"
CENTOS_MANTISBT_PROJECT="CentOS-8"
CENTOS_MANTISBT_PROJECT_VERSION="8"
$ hostnamectl
   Static hostname: heaven-web
         Icon name: computer-vm
           Chassis: vm
        Machine ID: e0a85fec865646f7b39fd019fd009195
           Boot ID: 5d248f031a1e499c9312031622cf3dc0
    Virtualization: kvm
  Operating System: CentOS Linux 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-305.19.1.el8_4.x86_64
      Architecture: x86-64
```

* [CentOS jq 설치 확인(commandline JSON processor)](https://github.com/subicura/workshop-init)

```shell
$ jq
bash: jq: command not found
$ yum install jq
```

* [Code-Server 설치](https://github.com/coder/code-server)
* [Code-Server 참조블로그](https://010000.github.io/post/20210307_install_code-server_linux/)

```shell
$ curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run
CentOS Linux 8
Installing v4.1.0 of the amd64 rpm package from GitHub.

+ mkdir -p ~/.cache/code-server
+ curl -#fL -o ~/.cache/code-server/code-server-4.1.0-amd64.rpm.incomplete -C - https://github.com/coder/code-server/releases/download/v4.1.0/code-server-4.1.0-amd64.rpm
+ mv ~/.cache/code-server/code-server-4.1.0-amd64.rpm.incomplete ~/.cache/code-server/code-server-4.1.0-amd64.rpm
+ sudo rpm -i ~/.cache/code-server/code-server-4.1.0-amd64.rpm

rpm package has been installed.

To have systemd start code-server now and restart on boot:
  sudo systemctl enable --now code-server@$USER
Or, if you don't want/need a background service you can run:
  code-server

$ sudo systemctl status --now code-server@$USER
$ sudo systemctl start --now code-server@$USER
$ sudo systemctl stop --now code-server@$USER

# 패스 워드 변경
$ vi /home/opc/.config/code-server/config.yaml
[변경 전]
bind-addr: 127.0.0.1:8080
auth: password
password: a999b6d198687e7064f9c451
cert: false

[변경 후]
bind-addr: 0.0.0.0:8080
auth: password
password: $Set_NewPassword_Here
cert: false
```


* [오라클 클라우드 방화벽 오픈](https://ldne.tistory.com/247)

```shell
# 방화벽 오픈 상태
$ sudo iptables -L
# 오픈 포트
$ sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
$ sudo iptables -I INPUT 1 -p tcp --dport 443 -j ACCEPT
$ sudo iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
# 오픈 포트
$ sudo iptables -I INPUT 1 -p tcp --dport 3306 -j ACCEPT
```

* [CentOS8 포트 추가](https://m.blog.naver.com/islove8587/221948892476)

```shell
# Web 서버
$ sudo firewall-cmd --list-all
$ sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
$ sudo firewall-cmd --reload
# WAS/DB 서버
$ sudo firewall-cmd --list-all
$ sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
$ sudo firewall-cmd --reload
```

* CentOS7 포트 추가

```shell
$ sudo iptables --list
$ sudo iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
$ sudo iptables -I INPUT 1 -p tcp --dport 3306 -j ACCEPT  
# 잘못 추가시 삭제 -D 옵션 1번째 라인
$ sudo iptables -D INPUT 1 
# 아래 명령어 opc 패스워드 물어봄(모름)
service iptables restart
```

* [CentOS8 Docker 설치](https://ldne.tistory.com/174)
  
```shell

$ sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
$ sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

# yum update
$ sudo yum -y update
$ sudo yum install -y yum-utils

# Docker 설치
# https://docs.docker.com/engine/install/centos/ 사이트 자료를 참고하여 설치한다.
yum -y update
yum install -y yum-utils
 
# Docker repository 시스템에 추가
# Failed loading plugin "osmsplugin": No module named 'librepo'
sudo yum install librepo
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-nightly
 
# 최신버전의 Docker 설치(Install Docker Engine)
yum -y install docker-ce docker-ce-cli containerd.io
 
# Docker 데몬 시작 및 부팅 시 Docker 데몬 자동 시작
systemctl start docker
systemctl enable docker
 
# Docker 실행중인지 확인
systemctl status docker
```

* [CentOS8 OpenCV 설치](https://linuxize.com/post/how-to-install-opencv-on-centos-8/)

```shell
# Once the installation is completed, verify that OpenCV library exists by running:
pkg-config --modversion opencv
```

* ① Install the required and optional dependencies:

```shell
# CentOS repository에서 설치가 안됨
sudo dnf install opencv opencv-devel

# OpenCV source에서 설치가 안됨
sudo dnf install epel-release git gcc gcc-c++ cmake3 qt5-qtbase-devel \
    python3 python3-devel python3-pip cmake python3-devel python3-numpy \
    gtk2-devel libpng-devel jasper-devel openexr-devel libwebp-devel \
    libjpeg-turbo-devel libtiff-devel tbb-devel libv4l-devel \
    eigen3-devel freeglut-devel mesa-libGL mesa-libGL-devel \
    boost boost-thread boost-devel gstreamer1-plugins-base

# OpenCV source에서 몇개 문제되는것 빼고 아래 추가 설치
sudo dnf install epel-release git gcc gcc-c++ cmake3 qt5-qtbase-devel \
    python3 python3-devel python3-pip cmake python3-devel python3-numpy \
    gtk2-devel libpng-devel libwebp-devel \
    libjpeg-turbo-devel libtiff-devel tbb-devel \
    freeglut-devel mesa-libGL mesa-libGL-devel \
    boost boost-thread boost-devel gstreamer1-plugins-base  

# sudo dnf install jasper-devel openexr-devel libv4l-devel eigen3-devel
sudo dnf install --skip-broken http://repo.okay.com.mx/centos/8/x86_64/release/jasper-devel-2.0.14-4.el8.x86_64.rpm    
sudo dnf install --skip-broken http://repo.okay.com.mx/centos/8/x86_64/release/OpenEXR-devel-2.2.0-11.el8.x86_64.rpm
sudo dnf install --skip-broken http://mirror.centos.org/centos/7/os/x86_64/Packages/libv4l-devel-0.9.5-4.el7.x86_64.rpm
sudo dnf install https://download-ib01.fedoraproject.org/pub/epel/7/aarch64/Packages/e/eigen3-devel-3.3.4-6.el7.noarch.rpm
```

* Clone both OpenCV’s and OpenCV contrib repositories:
  
```shell
$ sudo mkdir -p ~/opencv_build && cd ~/opencv_build
$ sudo git clone https://github.com/opencv/opencv.git
$ sudo git clone https://github.com/opencv/opencv_contrib.git
```

* Once the download is completed, create a temporary build directory, and switch to it:

```shell
$ cd ~/opencv_build/opencv && sudo mkdir build && cd build
```

* Configure the OpenCV build with the following CMake command:
  
```shell
cmake3 -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
```

https://seonbicode.tistory.com/74?category=879887