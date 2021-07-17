---
layout: page
title: Docker & Kubernetes
summary: Docker & Kubernetes is space.
categories: Java
tags: Java
featured-img: microservice
comments: Cloud Native를 위한 도커와 쿠버네티스(에이콘 아카데미)
---

# Introducing Docker & Kubernetes !!

#####  Docker & Kubernetes is space .

---

## Contents

### Table of Contents

|   No |          Title           | Remarks       |
| ---: | :----------------------: | :------------ |
|    0 | [환경설정](#get-started) | Docker 환경셋팅 |
|    1 |    [실습](#practice)     | 실습          |

---

## Learning

### Table of Learning

|   No | 구분  |                    Title                    |    Day     | Remarks |
| --: | :---: | :-----------------------------------------: | :--------: | :------ |
|    1 | 강의  | [Docker 기본다지기](https://github.com/chungsju/CloudNative/blob/main/Docker-HandsOn.md) | 2021.07.10 | * 도커기본 다지기 <br> * 쿠버네티스 간단하게 맛보기     |
|    2 | 강의  | [쿠버네티스의 시작](https://github.com/chungsju/CloudNative/blob/main/K8S%20Pod.md) | 2021.07.17 | * Pod 생성 및 Kubectl 사용법 <br> * Annotation/Namespace <br> * Liveness Porbes    |
|    3 | 강의  | [쿠버네티스로 서비스하기](https://github.com/chungsju/CloudNative/blob/main/K8S%20Pod.md) | 2021.07.24 | * Deployment <br> * Service <br> ClusterIP <br> NodePort <br> LoadBalancer <br> Ingress     |
|    4 | 강의  | [쿠버네티스 고급 설정](https://github.com/chungsju/CloudNative/blob/main/K8S%20Pod.md) | 2021.07.31 | * Readiness Probe <br> * Volume <br> * ConfigMap <br> * Secret    |
|    5 | 강의  | [쿠버네티스 가용성 개선 및 보안](https://github.com/chungsju/CloudNative/blob/main/K8S%20Pod.md) | 2021.08.07 | * StatefullSet <br> * 리소스 제어 <br> * 계정/인증 및 보안     |
---

## Get Started

### 1. [Docker 설치](https://docs.docker.com/docker-for-windows/install/)

* 맥은 그냥 설치 하면 되며, 윈도우는 링크 PDF 를 참조 하세요

### 2. 구글 클라우드 무료계정

* [구글 클라우드 가입 방법](https://youtu.be/9W_USK7-v6U)
* [Google Cloud SDK 설치 ](https://cloud.google.com/sdk/docs/install?hl=ko#windows)
* [Visual Studio Cloud Code](https://marketplace.visualstudio.com/items?itemName=GoogleCloudTools.cloudcode&ssr=false#overview)
  * Visual Studio Extension에서 Cloud Code를 설치
  * VS 밑에 Cloud Code가 보여야 함. → Click 시 상단에 New Application
  * 신규.yml 파일 만든 다음 k를 치면 k8s 오브젝트 template로 구성가능함.

---

## Practice

### 1. Docker 기본 다지기(7/10)

#### ① Docker Image 만들기

```shell
# docker ps 실행중인 container 환경 보기
$ docker ps
# docker ps -a 실행된것 까지 다 확인 가능
$ docker ps -a

$ docker run --name datetest centos date
# docker stop  container id or name으로 stop 가능
$ docker stop mysqltest1
```

#### ② docker로 Mysql 띄우기

```shell
$ docker run --name mysqltest1 -e MYSQL_ROOT_PASSWORD=mypass1q -d mysql:5.7.34

# docker logs 컨테이너 로그 메시지 보기
$ docker logs mysqltest1

# docker inspect 컨테이너 정보 보기
$ docker inspect mysqltest1
```

#### ③ docker container를  다른 pc 환경으로 전달할때.
(기술적 가능, 쿠버네티스에서 함)

```shell
# container attach 사용하지 말아아 함.
$ docker attach 컨테이너 이름/id
# container -detatch 로 빠져 나와야 함.

# docker exec 특정 container에 명령어를 전달 하는 기능
$ docker exec -it 233abf0483fe /bin/bash

# 컨테이너 변경사항 커밋 
# docker commit
$ docker commit -a shpimit@nate.com 233abf0483fe datetest2
```

#### ④ Docker Volume

```shell
# Host OS에서 가지고 있는 volume
$ docker volume create -name myvolume
$ docker volume ls
$ docker run --name some-mysql -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag

# 새로 만든 volume은 컨테이너 삭제 해도 사라지지 않는다.
$ docker volume create data_vol
```

#### ⑤ Docker Network

```shell
$ docker network ls
# Port Forwaring
$ docker run --name mysqltest2 -p 3308:3306 -e MYSQL_ROOT_PASSWORD=mypass1q -d mysql:5.7.34
```

##### [Go to Contents](#contents)

### 2. 쿠버네티스의 시작(7/17)

#### ① Docker TAG 이름 변경

```shell
# image id로 tag 이름 변경하기
docker tag f78ebc0dce57 shpimit/date:latest
```

> docker export는 layer를 합쳐서, save는 layer를 그대로..`

#### ② 우분투 14.04를 기반으로 nginx 서버를 설치한 도커 이미지를 생성하는 예제

* Dockerfile 만들기

```Dockerfile
# 어떤 이미지를 기반으로 할지 설정. <이미지 이름>:<태그> 형식
FROM ubuntu:14.04
# 메인테이너 정보                                              
MAINTAINER Foo Bar foo@bar.com
RUN apt-get update
# RUN으로 셸 스크립트 혹은 명령 실행
RUN apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
# 호스트와 공유할 디렉터리 목록
VOLUME ["/data", "/etc/nginx/site-enabled", "/var/log/nginx"]
# 다음 CMD에서 설정한 실행 파일이 실행될 디렉터리
WORKDIR /etc/nginx
# 컨테이너가 시작되었을 때 실행할 실행 파일 또는 스크립트
CMD ["nginx"]
# 노출할 포트 번호
EXPOSE 80
EXPOSE 443
```

* 이미지 빌드
  
> windows오 mac은 build된 파일은 볼수 없음. 오로지 linux에서마 보임<br>
> 그 이유는 windows/mac 은 docker를 vm 위에서 돌림
  
```shell
docker build -t nginx:0.1 .
# docker와 관련된 상세를 보는것 inspect 명령어
docker inspect nginx:0.1
```

* 이미지 실행

```shell
docker run --name shpimit-nginx -d -p 8081:80 -v D:\document:/data nginx:0.1
```

#### ③ Go web 만들기

* main.go 파일 만들기

```go
package main

import (
	"fmt"
	"os"
	"log"
	"net/http"
)
func handler(w http.ResponseWriter, r *http.Request){
	name, err := os.Hostname()
	if err != nil {
		panic(err)
	}

	fmt.Fprintln(w,"hostname:", name)
}
func main() {
  fmt.Fprintln(os.Stdout,"Starting GoApp Server......")
	http.HandleFunc("/",handler)
	log.Fatal(http.ListenAndServe(":8080",nil))
}
```

* Dockerfile 만들기

```Dockerfile
FROM golang:1.11-alpine AS build

WORKDIR /src/
COPY main.go go.* /src/
RUN CGO_ENABLED=0 go build -o /bin/demo

FROM scratch
COPY --from=build /bin/demo /bin/demo
CMD ["/bin/demo"]
```

* Container Image 생성

```shell
docker build -t goapp .
```

* Container Image start

```shell
docker run --name goapp-project -p 8080:8080 -d goapp
```

* 프로세서 상세 정보 출력

```shell
docker inspect goapp-project
```

* Docker 허브 양식에 맞게  tag 수정하기

```shell
docker tag goapp shpimit/goapp
```

* 도커 허브에 이미지 업로드 하기

```shell
docker login
docker push shpimit/goapp
```

* 도커 허브의 이미지로 컨테이너 실행

```shell
docker run --name goapp-shpimit -p 8080:8080 -d shpimit/goapp
```

* Default Dockerfile이 아닌 다른 Docker file 사용할때

```shell
docker build -t shipimit/nginx -f Dockerfile_nginx
```

#### ④ MySql과 WordPress 의 컨테이너 버전을 이용하여 wordpress 블로그 만들기

* Word press

```shell
docker run --name wordpress-sun -p 8080:80 -d wordpress
docker run --name sun-workdpress -p 8082:80 -e WORDPRESS_DB_HOST=192.168.0.10:3307 -e WORDPRESS_DB_USER=wordpressuser -e WORDPRESS_DB_PASSWORD=123 -e WORDPRESS_DB_NAME=wordpressdb -d wordpress
docker run --name wordpress-sun -p 8080:80 -d wordpress
docker run --name sun-workdpress1 --link mysql3:mysql3 -p 8082:80 -e WORDPRESS_DB_HOST=mysql3:3306 -e WORDPRESS_DB_USER=wordpressuser -e WORDPRESS_DB_PASSWORD=123 -e WORDPRESS_DB_NAME=wordpressdb -d wordpress
```

```shell
docker run --name some-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123 -d mysql
docker run --name sun-mysql -p 3307:3306 -e MYSQL_DATABASE=wordpressdb -e MYSQL_USER=wordpressuser -e MYSQL_PASSWORD=123 -e MYSQL_ROOT_PASSWORD=123 -d mysql 
```

* 로그 보기
  
```shell
docker logs d105ee3a9dba
```

#### ⑤ 쿠버네티스 환경

* gcloud init

> 1. 구글 클라우드 ..... 내 컴퓨터 연결<br>
> 2. Log in<br>
> 3. 허용하면 oauth2 연동이 되는것임<br>
> 4. 구글 클라우드 내 프로젝트 선택

```shell
gcloud init
# Create a new configureation 선택
```

* gcloud 연결

> 구글 클라우드 연결에 있는 주소 copy<br>

```shell
gcloud container clusters get-credentials sunk8s --zone asia-east1-a --project eminent-booking-320104
```

* 쿠버네티스 동작 원리

> ETCD → Controller Manager → Scheduler → ETCD →  VM선택<br> 
>  5개       5 != 3 판단   노드가 어디 여유?<br> 
> nodeSelector : 가 있는 부분 ssd: "true" 라고 되어 있는데만 pod을 생성하기도 함.

> kubelet : api 서버와 통신하는것이고 모든것중에 핵심(HOST에 떠 있음.) container start/stop<br>
> kube-proxy : Network 담당, 가 vm당 1개만 올라가는것,  vm 컨테이너끼리 통신하는것 관리
             라우팅 테이블이라고 생각해도 됨.<br>
> CNI : 맨밑단에서 network을 연결해주는것.

```shell
kubectl api-resources
kubectl explain pod
```

* Pod
  
> 쿠버네티스 작은 단위, 컨테이너의 모음짐( 1개의 Pod 안에 1개의 Container 95%). 배포단위<br>
> Pod안에서 container들은 network을 공유

* Pod 설정보기

```shell
kubectl get pod myapp-pod -o yaml
kubectl get po myapp-pod -o json
```

* Pod yml 파일로 만들기

```yml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    name: myapp-pod
spec:
  containers:
  - name: myapp-pod
    image: nginx
    resources:
      limits:
        memory: "128Mi"
        cpu: "500m"
    ports:
      - containerPort: 80
```

* 쿠버네티스에 pod 만들기

```shell
kubectl apply -f Podtest.yml
kubectl get po --show-labels
kubectl get pod -L env
```

* Lable을 이용한 필터링 조회

```shell
kubectl get pod -l env=prod
```

## Reference

* [CNCF](https://www.cncf.io/)
* [Landscape CNCF](https://landscape.cncf.io/)
* [CNCF Trail Map](https://github.com/cncf/landscape/blob/master/README.md#trail-map)
* [Microservice Architecture](https://microservices.io/)
* [강사Github](https://github.com/chungsju/CloudNative/blob/main/Docker-HandsOn.md)

##### [Go to Contents](#contents)
