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
|    2 | 강의  | [쿠버네티스의 시작](https://github.com/chungsju/CloudNative/blob/main/K8S%20설치.md) | 2021.07.17 | * Pod 생성 및 Kubectl 사용법 <br> * Annotation/Namespace <br> * Liveness Porbes    |
|    3 | 강의  | [쿠버네티스로 서비스하기](https://github.com/chungsju/CloudNative/blob/main/K8S%20컨트롤러%20및%20서비스.md) | 2021.07.24 | * Deployment <br> * Service <br> ClusterIP <br> NodePort <br> LoadBalancer <br> Ingress     |
|    4 | 강의  | [쿠버네티스 고급 설정](https://github.com/chungsju/CloudNative/blob/main/K8S%20볼륨.md) | 2021.07.31 | * Readiness Probe <br> * Volume <br> * ConfigMap <br> * Secret    |
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

* Project 만들기 → Kubernetes API 사용하기
* 클러스터 이름 : sunk8s
* 영역 : asia-northeast3-a

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
# gcloud container clusters get-credentials sunk8s --zone asia-east1-a --project eminent-booking-320104
gcloud container clusters get-credentials sunk8s --zone asia-northeast3-a --project sunproject-322214
kubectl get node
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

* Pod  : 컨테이너가 오류가 났을때... 재시작
* 컨트롤러 : Pod 가  오류가 났을때  갯수를  유지하는것
* 서비스 : 네트워크 환경을 제공, 컨트롤러에 access 및 Pod 에 엑세스

* 컨트롤러 : Replication Controller, ReplicaSet  → Pod의 갯수를 조정
* 스케줄러 : 몇번 Node에  여유가 있어,  거기에 생성해
* etcd : 상태 정보를  내부에 저장

* selector : selector는 몇개의 pod가 이이쓴ㄴ지... label은 만드는 조회 조건,

* Replication Controller : label 조건이 and 로만.. 오래된것

```shell
$ kubectl get rc
```
* 특정 Pod 삭제하고 변화 확인하기

```shell
kubectl delete pod goapp-rc-2sdc5
```

* Pod 라벨을 변경해보기

```shell
kubectl label pod goapp-rc-mwflw app=goapp-exit --overwrite
```

```shell
$ kubectl edit rc goapp-rc
```

* 명령어를 통한 스케일링

```shell
kubectl scale rc goapp-rc --replicas=5
```

* Replication Controller 와 POD 모두 삭제
  
```shell
kubectl delete rc goapp-rc
```

* Replication Controller 만 삭제. POD 는 그대로 유지

```shell
kubectl delete rc goapp-rc --cascade=false
```

* ReplicaSet : 연산조건이 in 등 다양하게 가능.  즉 서로 다른 label을 관리

```shell
kubectl get rs --show-labels
```

* 디버깅이 필요할때
  
```shell
k pod rc-nginx-s5pax app=nginx2 --overwrite
```

replica=0으로 바꾸고.. 새로replica=3를 주면 새로운 스펙으로 되지만
다운타임이 발생

* Delpoyment
Deloyment : application을 배포할 목적으로 만들어진 컨트롤러
* 무중단 배포 가능(RollingUpdate)
* rollout  : replicaset 자체를 바꾸어 주는것...
* maxSurge : 몇개씩 rollingupdate를 해야 하는지... 5에 50%라면 반올림3개
* maxUnavailable : 몇개가 최소운영을 되어야 하는지 %

* DemonSet
* Node에서 하나만 돌아야 하는 application : 기본적인 set
* 해당 노드에서 로그에서 발행되는 로그를 다른쪽으로 전달 해야 하는것
* replicas가 의미가 없음으로...무조건 node별로 1개, 1나의 node에 1나만
* brew install watch

```shell
kubectl get pod,rs,deploy
kubectl --record deployment.apps/nginx-deployment set image deployment.v1.apps/nginx-deployment nginx=nginx:1.9.1

kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1 --record

```

* 롤아웃

```shell
kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.10 --record
```

* 롤아웃 히스토리 확인

```shell
kubectl rollout history deployment/nginx-deployment
```

* 롤백

```shell
kubectl rollout undo deployment/nginx-deployment
kubectl rollout undo deployment nginx-deployment --to-revision 3
```

* Deployment ScaleOut

```shell
kubectl edit deploy nginx-deployment
kubectl scale deploy nginx-deployment --replicas=4
# 롤아웃 확인
kubectl rollout status deployment.v1.apps/nginx-deployment
# deployment 상세 확인
kubectl describe deploy nginx-deployment

kubectl label node gke-sunk8s-default-pool-e20fb63d-2rrb disk=ssd


```

```shell
kubectl get jobs/pi
kubectl describe jobs/pi
```

* Job
* 작업이 종료될때 : File 전송,  DB 백업
* 비정상 종료시 다시 실행
* 정상 종료시 종료

* CronJava
* Job 보다는 CornJob 사용 마치 Replicaset 대신 Deployment 사용
* 만약 한번만 작업하게 해야 한다면...concurrencyPoloy: Forbid
* 특정 node에서만 돌게 하려면...nodeselector

```shell
$ k get jobs.batch
$ k describe cronjabs.batch
```

```shell
kubectl api-resources
kubectl explain 오브젝트 = 해당 오브젝트의 상세 메뉴얼
```

* Statefull controller
* pod의 영속성을 가져온다.

* 윈도우도 wsl 설치후 zsh- autocomplete을 사용하면 자동완성을 쓸수있어요!
* metric  :  수치값 좌표값, 뭔가 측정할수 있는 값
*            어떤것을 기준으로 측정 할것인가
*            scale out- 수집을 해서 기준점이 되는것.

* 해당 테스트
* 모든 명령어 --dry-run -o yml

* HPA(Horizontal Pod Autoscaler)
* 자동 동적으로 autoscale 한다.
* 반드시 resource가 있어야 동작한다.
  
```shell
kubectl autoscale deployment 디플로이명 --cpu-percent=59 --min=1 --max=8
kubectl autoscale deployment nginx-deployment --cpu-percent=50 --min=1 --max=8
kubectl get hpa nginx-deployment -o wide
Kubectl describe hpa nginx-deployment
kubectl get hpa nginx-deployment
```

* Pod가 여려개일외 외부에...서스하기
* Service에는 여러개의  ClusterIp,  NodePort, Load Balancer, Headoff

* clusterIP
* 쿠버네티스 클러스터 안에서만 움직이는 대표ip s/w Load Balancer(사설ip)

SVC : selector 정보만 같다면..
v1 v2 : deploy
v2 v2 : deploy

* NodePort : 외부에서 접근할수 있도록
* ClusterIP를 baset로 깔고 간다.
* nodeport : 클러스터의 worker node 포트
* VM ip : 30080  → CuseterIP :포트
* Test용도로만  사용함.
* 일반적으로 클러스터 port 와 target port를 ...동일하게 가져간다.

* LoadBalancer
* 클라우드 벤더에서만 제공해주어야 가능
* Nodeport와 클라우드 벤터 자체 s/w Loadbalancer를 연결해서 사용하는것.

* Headless
* ClusterIP를  None을 셋팅하면....
* StatefulSet과 연결하여  특정 도메인에만 보내야 할때. 고유DNS

```shell
gcloud container clusters list
#ERROR: (gcloud.container.clusters.list) The required property [project] is not currently set.
#It can be set on a per-command basis by re-running your command with the [--project] flag.

#You may set it for your current workspace by running:

gcloud config set project projects/mytestproject
# gcloud container clusters list  구글 cloud shell에서 실행 
gcloud compute disks create --size=10GiB --zone asia-east1-a  mongodb
# 삭제
# gcloud compute disks delete mongodb --zone asia-east1-a

kubectl exec -it mongodb -- mongo
exit
kubectl describe sc standard
gcloud compute disk-types list | grep asia-east1-a
```

```shell
docker build -t shpimit/nodejs:sfs .
docker login
docker push shpimit/nodejs:sfs
curl http://34.81.127.111
curl -X POST -d "hi, my name is shpimit-1" 34.81.127.111
curl -X POST -d "hi, my name is shpimit-2" 34.81.127.111
curl -X POST -d "hi, my name is shpimit-3" 34.81.127.111
curl -X POST -d "hi, my name is shpimit-4" 34.81.127.111
kubectl scale statefulset nodejs-sfs --replicas=1
kubectl get pods #Pod가 삭제된 것을 확인
kubectl get pvc  #pvc 존재 여부 확인 
kubectl get pv
kubectl scale statefulset nodejs-sfs --replicas=2
```

* Ingress

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.46.0/deploy/static/provider/cloud/deploy.yaml
kubectl get pods -n ingress-nginx \
  -l app.kubernetes.io/name=ingress-nginx --watch

curl http://34.81.127.111
```
* Configmap

```shell
Docker CMD 는 3가지 형태로 사용 가능 합니다.

CMD [ "실행파일" , "파라메터1" , "파라메터2" ] → 실행파일 형태
CMD [ "파라메터1" , "파라메터2"] → ENTRYPOINT 의 디펄트 파라메터
CMD command 파라메터1 파라매터2 → 쉘 명령어 형태

docker build -t shpimit/fortune:args .
docker push shpimit/fortune:args
docker run -it shpimit/fortune:args
docker run -it shpimit/fortune:args 15

docker build -t shpimit/fortune:env .
docker push shpimit/fortune:env
docker run -it shpimit/fortune:env

kubectl create configmap fortune-config --from-literal=sleep-interval=7
kubectl get cm fortune-config -o yaml
kubectl create -f ./config-fortune-mapenv-pod.yml
kubectl describe cm fortune-config

kubectl create configmap fortune-config --from-file=config-dir
kubectl apply -f ./config-fortune-mapvol-pod.yml
kubectl exec -it nginx-configvol bash

curl -H "Accept-Encoding: gzip" -I 10.0.2.25:8080
# reload 로 변경 사항 컨테이너에 알리기
kubectl  exec nginx-configvol -c web-server -- nginx -s reload
kubectl apply -f ./config-fortune-mapvol-pod2.yml
```

* Secret

```shell
openssl genrsa -out https.key 2048
openssl req -new -x509 -key https.key -out https.cert -days 360 -subj '/CN=*.acron.com'

kubectl create secret generic fortune-https --from-file=https.key --from-file=https.cert
kubectl create cm fortune-config --from-file=./config
kubectl apply -f ./secret-pod.yaml
kubectl port-forward fortune-https 8443:443 &
curl https://localhsot:8443 -k
```

* Namespace
* 똑같은 환경으로 개발/운영 분리된 영역에서 서비스를 진행함.
* Namespace = development/ test/ production
* SaaS 서비스를 똑같은 서비스를  A고객/B고객/C고객에게 서비스
  └ 똑같은 소스를 다른곳 배포로 하여 멀티tenant
* 쿠버네티스 내부적으로 보안적으로 분리

```shell
kubectl get ns
kubectl get pod --namespace kube-system
kubectl get pod -n 
kubectl config set-context $(kubectl config current-context) --namespace <Namespace-Name>
kubectl config set-context $(kubectl config current-context) --namespace kube-system
kubectl config current-context
```

```shell
kubectl apply -f first-namespace.yml
kubectl get ns
kubectl run testpod --image=nginx -n first-namespace
kubectl config set-context $(kubectl config current-context) --namespace first-namespace
kubectl get pods
kubectl config set-context $(kubectl config current-context) --namespace default

```

* Service Account
* 쿠버네티스는 기본적으로 User Account를 사용하지 않는다. Service Account를 지원함
* 쿠버네티스 바깥에서 클러스터 vendor에서 제공하는 IAM에서 인증받고, 인증서를 기반으로 움직임.
* Service Account: 쿠버네티스 API를 호출할때 인증하는  Account → 그냥 계정
* Service Account는 Namespace를 벗어날수 없다.
* 쿠버네티스는 동사와 목적어(Object: pod 등)가 있다.

* RBAC(Role-Based Access Control)
* Role : 동사와 목적어를 조합
* Role Binding :  해당 Service Account 와 Role을 매핑한 Object
* 클러스터 롤바인딩 /  클러스터 롤 / 클러스터 수준 리소스

```shell
kubectl --kubeconfig=./new_config get pods
```

```shell
kubectl create sa apiuser
kubectl get sa
kubectl get sa --all-namespaces
# 서비스 어카운트의 token secret 얻기
kubectl describe sa apiuser
# Tokens:              apiuser-token-4cdtn
kubectl describe secrets apiuser-token-4cdtn
# kubectl get secrets apiuser-token-xmdc2 -o jsonpath='{.data.token}' | base64 -d 명령어를 통해 data.token 부분만 바로 얻어올수도 있습니다.
# GKE server IP는 ~/.kube/kubeconfig 파일 안에서 확인 가능합니다.
curl -k  https://130.211.242.89/api/v1/namespaces/default/pods/  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IlIwUmVuNFd2cUJGMGZ1aWRUWHN2c2EtQnVUWU1rZ2hNSTE1OGthaXl2RkUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImFwaXVzZXItdG9rZW4tNGNkdG4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiYXBpdXNlciIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjdlYWMzMWE0LTRjNmQtNDMwNC05YmM4LWE2Y2I1OTA3MDA1OSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmFwaXVzZXIifQ.Wnlpp6LAKUM3zqi2qV5MSjwFxfD2PyVSJ11iccJrz31NDSjV3tpvljCnunYZO2TNXIdEis9BKEOzX8ONfIrcV6Kh2esrohuR6YAsbYaUE7PQgi9-_JN5WyR-fPqCZT1_H_q0q0woG2UIy7cJ3gwy1xRV9ni4w8qJUMRsl1uYqLgh4q0q7w0UpKxw-9zwcXhGcwPzKSYoTBsSExn9TJ2tdIOkuhAg2NGL1_SnXDIFjb-sQyK9fxvIyGI1Nlcd_BoSQBrUR1waK6fYagH76UWyCfdB6gZ9vwD6cizSEqQAP6Gf3Vrw1I6kQ2MvJIo9iWdusAt7CY48U6m_yTmBMxNW3A"
```

* 서비스어카운트 전용 kubeconfig 파일 배포
* kubeconfig 파일을 위한 certificate-authority-data 얻기

```shell
kubectl apply -f role.yml
kubectl apply -f rolebinding.yml
# -o out파일 포맷을 바꾸어주는것.  특정 구조체만 뽑아내는것
kubectl get secrets apiuser-token-4cdtn  -o jsonpath='{.data.ca\.crt}'

```

* kubeconfig 파일을 위한 token 얻기

```shell
kubectl get secrets apiuser-token-4cdtn  -o jsonpath='{.data.token}' | base64 -d
kubectl --kubeconfig=./new_config get pods
```

```shell
# Skaffold 샘플 소스 다운
git clone https://github.com/chungsju/skaffold-nodejs.git
# kubernetes-manifests/hello.deployment.yaml 파일의 컨테이너 image: chungsju/skaffold-nodejs 이미지 이름을 각자의 Docker hub repository이름으로 변경
# Skaffold dev
```

* Helm 
* 다른 사람들이.. service/secret 등이 구성되어 있는것을 가져다가 쓰겠다.
* 우리 회사에서 쓰고 있는것을  기존에 짜져 있던것을  value값만 바꾸어서 사용한다.
* value_prod.yml, value_dev.yml, value_usera.yml
* heml install <릴리스이름> → 인스터스 명  < 차트이름>

```shell
helm install my-wordpress bitnami/wordpress
helm status my-wordpress
helm create
```

* [Helm Download](https://github.com/helm/helm/releases)

```shell
helm version
# Helm 차트 리포지토리 추가
helm repo add bitnami https://charts.bitnami.com/bitnami
# 리포지토리 업데이트
helm repo update
# mysql helm 검색
helm search repo mysql
# 피키지 메타 정보 보기
helm show chart bitnami/mysql
# mysql helm 차트 설치 및 Deployment
helm install myhelm-test-mysql bitnami/mysql
helm ls
# helm 차트 uninstall
helm list
helm uninstall myhelm-test-mysql
# wordpress의 username과 패스워드를 셋팅한 상태로 helm Chart 구성
helm install helm-wordpress bitnami/wordpress --set wordpressUsername=myuser,wordpressPassword=mypassword
# helm 릴리스에 설정된 값 확인
helm get values helm-wordpress
# 접속 IP 얻기
kubectl get svc --namespace default helm-wordpress --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}"
```

* CI/CD
* skaffold :  yml 파일로 qlco

* GitOps
* Git을 Ops해서 오퍼레이션 하겠다.

* ArgoCD 설치하기

```shell
# helm repository 설정
helm repo add argo https://argoproj.github.io/argo-helm
# install ArgoCD
helm install sun-argo-cd argo/argo-cd --set server.service.type=LoadBalancer
kubectl -n default get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
# 패스워드 알아내는 법 까먹었을때
helm status sun-argo-cd
helm uninstall sun-argo-cd argo/argo-cd --set server.service.type=LoadBalancer
```

* [Base64 문자열 변환](https://www.convertstring.com/ko/EncodeDecode/Base64Decode)
* id/암호 : admin / APBcOvossXZQvZpf   

* ISTIO
* Dedicated infrastructure : Service Discovery / Load Balancing / Failure Recovery / Metrics and Monitoring
* 투명한 언어 독립적
* Envoy Proxy를 사이드카로 제공
* 보안/인증서를 신경쓰지 않아도 된다.
* Pilot : 정책
* Citadel : 인증서
* Mixer :  네트워크 Envoy proxy가  control plane에 보고 

* Istio Gateway : Ingress와 유사한...
* Istio Virtual Service : Routing Service . L7  http 헤더정보를 보고 Routing
* L7, Circuit Breaker, Tracing 관리
  
* Prometheus : 시계열 DB, Istio와 서비스 매쉬 어플리케이션의 메트릭스 저장
* Grafana : Peometheus와 연계된 대쉬보드 제공
* Kiali : Envoy관측에 따른 서비스 매쉬 스트럭처 및 토폴리지 제공
* Jaeger : end to end distribued tracing system

* DetinationRule  :  pod를 찾아가는 subsets
Service를 pod의 label 정보를 이용하여 분배

* -c  :  Concurrent  사용자

* 강사님 Hands-on 1.10.1
* 나는 1.10.3

```shell
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
unable to recognize "samples/bookinfo/networking/bookinfo-gateway.yaml": no matches for kind "Gateway" in version "networking.istio.io/v1alpha3"
unable to recognize "samples/bookinfo/networking/bookinfo-gateway.yaml": no matches for kind "VirtualService" in version "networking.istio.io/v1alpha3"
```

```shell
istioctl install --set profile=demo -y
# uninstall 하고 싶을때  istioctl x uninstall --purge
kubectl label namespace default istio-injection=enabled
kubectl label namespace default istio-injection=disabled --overwrite
kubectl label namespace default istio-injection= --overwrite
# injection이 활성화된 네임스페이스에서 향후 생성되는 Pod에는 Istio Envoy 사이드카가 자동으로 구동됨
kubectl label namespace default istio-injection=enabled --overwrite
# kubectl label namespace default istio-injection=enabled --overwrite
# kubectl label namespace istiosun istio-injection=enabled
# kubectl config set-context $(kubectl config current-context) --namespace istiosun
# kubectl config set-context $(kubectl config current-context) --namespace default
# kubectl get namespace -L istio-injection
# kubectl get pods -n istio-system
kubectl apply -f samples/addons
#위에 문제가 되어 삭제 해야 할때   아래 문제는   kubectl get pods -n istio-system 로 kiali pod가 다 뜨고 나서 하면 사람짐.
# unable to recognize "samples\\addons\\kiali.yaml": no matches for kind "MonitoringDashboard" in version "monitoring.kiali.io/v1alpha1"
# 여러번 하니까  설치 됨
# kubectl delete -f samples/addons --ignore-not-found
```

* 샘플 어플리케이션 설치

```shell
# 서비스와 디플로이먼트 설치
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
# 다른 로드 밸런스가 떠 있으면 잘 안된다.
# Gateway 및 VirtualService 설치
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
# DestinationRule 설치
kubectl apply -f samples/bookinfo/networking/destination-rule-reviews.yaml
# Istio Gateway 외부 주소 확인
kubectl get service istio-ingressgateway -n istio-system

kubectl port-forward service/istio-ingressgateway 8091:80
# kiali 대쉬보드
istioctl dashboard kiali
# Grafana 대쉬보드
istioctl dashboard grafana
# Jaeger 대쉬보드
istioctl dashboard jaeger
# 가중치 기반 라우팅
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
kubectl get virtualservice reviews -o yaml
# 컨텐츠 기반 라우팅
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
kubectl get virtualservice reviews -o yaml
# circuit breaker 테스트
kubectl apply -f samples/httpbin/httpbin.yaml
```

```yml
# Circuit Beaker를 위한 DestinationRule 파일 생성 및 적용
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: httpbin
spec:
  host: httpbin
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 1
      http:
        http1MaxPendingRequests: 1
        maxRequestsPerConnection: 1
    outlierDetection:
      consecutive5xxErrors: 1
      interval: 1s
      baseEjectionTime: 3m
      maxEjectionPercent: 100

```

* DestinationRule 적용 확인

```shell
kubectl get destinationrule httpbin -o yaml
```

```yml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
...
spec:
  host: httpbin
  trafficPolicy:
    connectionPool:
      http:
        http1MaxPendingRequests: 1
        maxRequestsPerConnection: 1
      tcp:
        maxConnections: 1
    outlierDetection:
      baseEjectionTime: 3m
      consecutive5xxErrors: 1
      interval: 1s
      maxEjectionPercent: 100

```


* 샘플 타겟을 호출할 Client Pod 생성

```shell  
kubectl apply -f samples/httpbin/sample-client/fortio-deploy.yaml
```

* Client Pod에서 동시 접속 부하 발생

```shell
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio load -c 2 -qps 0 -n 30 -loglevel Warning http://httpbin:8000/get
```

## Reference

* [CNCF](https://www.cncf.io/)
* [Landscape CNCF](https://landscape.cncf.io/)
* [CNCF Trail Map](https://github.com/cncf/landscape/blob/master/README.md#trail-map)
* [Microservice Architecture](https://microservices.io/)
* [쿠버네티스](https://kubernetes.io/)
* [강사Github](https://github.com/chungsju/CloudNative/blob/main/Docker-HandsOn.md)
* [https://github.com/chungsju/CloudNative/blob/main/K8S 설치.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20%EC%84%A4%EC%B9%98.md)
* 2일차 : [https://github.com/chungsju/CloudNative/blob/main/K8S Pod.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20Pod.md)
* 3일차 : [https://github.com/chungsju/CloudNative/blob/main/K8S 컨트롤러 및 서비스.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20%EC%BB%A8%ED%8A%B8%EB%A1%A4%EB%9F%AC%20%EB%B0%8F%20%EC%84%9C%EB%B9%84%EC%8A%A4.md)
* 4일차 볼륨 : [https://github.com/chungsju/CloudNative/blob/main/K8S 볼륨.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20%EB%B3%BC%EB%A5%A8.md)
* 4일차 인그레스 : [https://github.com/chungsju/CloudNative/blob/main/K8S 인그레스.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20%EC%9D%B8%EA%B7%B8%EB%A0%88%EC%8A%A4.md)
* 4일차 ConfigMap : [https://github.com/chungsju/CloudNative/blob/main/K8S ConfigMap.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20ConfigMap.md))
* 5일차 : kubectl [https://github.com/chungsju/CloudNative/blob/main/K8S%20Namespace%26RBAC.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20Namespace%26RBAC.md)
* 5일차 : Helm [https://github.com/chungsju/CloudNative/blob/main/K8S Helm.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20Helm.md)
* 5일차 : CI/Cd [https://github.com/chungsju/CloudNative/blob/main/K8S ArgoCD.md](https://github.com/chungsju/CloudNative/blob/main/K8S%20ArgoCD.md)


https://github.com/chungsju/CloudNative/blob/main/K8S%20Istio.md


* [https://helm.sh/](https://helm.sh/)
* [헬름차트 검색 사이트](https://artifacthub.io/)  : Bitnami
* [https://skaffold.dev/](https://skaffold.dev/)


##### [Go to Contents](#contents)
