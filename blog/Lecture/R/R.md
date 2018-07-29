---
layout: page
title: R
permalink: /Lecture/R
---
## R

### 0. 설치

* [R](http://www.r-project.org)
* [RStudio](http://www.rstudio.com/)

---

### 1. 기초

* Ctrl+l       : console지우기
* Ctrl+Enter   : 스크립트 명령어 실행
* Ctrl+Shift+c :  comment toggle

```R
a <- c(1,2,3,4,5,1,2)
summary(a)
m <- matrix(a, nrow=2)
```
### 2. 패키지 설치
```R
install.packages
```
### 3. 핵심 라이브러리
```R
library(ggplot2)  # qplot 라이브러리
library(dplyr)    # 데이터 프레임 rename
```
#### 3.1 문자열 관련 함수(stringr)
```R
install.packages("stringr")
library(stringr)
str <- "java,jsp,linux,2015,2016,2017"
str_length(str)
str_split(str,',')     # 나누는 함수
str_replace(str,'linux','abc')
str_extract(str,"[0-9]{4}") # [1] "2015"
str_extract_all(str,"[0-9]{4}") # [1] "2015" "2016" "2017"
str_locate(str,"linux")  # [1,]    10  14
```
### 4. 데이터 프레임(data.frame)
```R
var1 <- c(70,80,90)
var2 <- c(70,80,80)
df1 <- data.frame(var1, var2)
var3 <- c(50,60,66)
df1 <- cbind(df1, var3)
df1 <- rename(df1, kor=var1)
df1 <- rename(df1, eng=var2)
df1 <- rename(df1, mat=var3)
names(df1)       # 컬럼명 확인
summary(df1$kor) # 데이터 확인
```
### 5. R 제공 샘플데이터
```R
mpg
table(mpg$manufacturer) # 오라클 테이블 아님, 데이터 distinct정보
mpg1 <- mpg      # 데이터 복사
```
### 6. 외부파일
```R
install.packages("readxl")
library(readxl)
df_ex1 <- read_excel("c:/r_temp/excel_exam.xlsx")
nrow(df_ex1) # 마지막 행번호
ncol(df_ex1)
dim(df_ex1)  # 행렬 정보
str(df_ex1)
summary(df_ex1)
df_ex2 <- df_ex1
hap <- df_ex2$math + df_ex2$english + df_ex2$science
df_ex2$hap <- hap
head(df_ex2)
avg <- df_ex2$hap / 3
avg <- round(avg,2)
df_ex2$avg <- avg
df_ex2$math <- as.integer(df_ex2$math)  # 모두 integer 처리 한다(형변환)
write.csv(df_ex2, file="c:/r_temp/df_ex2.csv") # 저장하기
save(df_ex2, file="c:/r_temp/df_rda1.rda") # rdata로 저장 및 불러오기
rm(df_ex2)
load("c:/r_temp/df_rda1.rda")
df_ex2
str(df_ex2)
df_ex3 <- as.data.frame(df_ex2)
str(df_ex3)
df_ex3
df_ex10 <- read_excel("c:/r_temp/excel_exam_novar.xlsx") # 1행의 타이블 없는 데이터
head(df_ex10)
df_ex10 <- read_excel("c:/r_temp/excel_exam_novar.xlsx", col_names = F)
hist(df_ex2$math)
score <- scan()   # 입력받기 Default integer 타입으로 받음.
if(score >= 60) {
  cat("success")
} else {
  cat("fail")
}
score <- scan("", what="")  # 문자입력받기
ifelse(score == 'M',"남자","여자")  # 삼항연산자
switch("name",id="kim",pwd="1234",name="홍길동") # 컬럼 search
name<-c("kim","lee","choi")                  
which(name=="lee")                              # 데이터 search
```
```R
# 반복문
i <- c(1:10)
    cat(n, 'x', 10, '=', n*10, '\n')
}
i=0
while(i<5) {
     i <- i+1
     print(i)
}
```
```R
pythagoras <- function(a,b) {
  c <- a^2 + b^2
  cat(a,b,c)
}
pythagoras(3,4)
```
* 데이터 중 결측지 제거 함수 만들기

```R
na_data <- c(1,2,NA,3,4,NA,5,6,6)
sum(na_data)
fn_na <- function(a) {
  value <-ifelse(!is.na(a),a,0)
  print(value)
}
na_data1 <- fn_na(na_data)
```
* mpg 데이터를 이용한 실습

```R
mpg1 <- mpg
avg_mileage <- (mpg1$cty+ mpg1$hwy) /2 
avg_mileage
length(avg_mileage)
mpg1$avg_mileage <- avg_mileage 
names(mpg1)
summary(mpg1$avg_mileage)
round(mean(mpg1$avg_mileage),3)
table(mpg1$avg_mileage)
hist(mpg1$avg_mileage)
qplot(mpg1$avg_mileage)
hist(mpg1$avg_mileage,xlim=c(0,50), ylim=c(0,100),main="테스트", border=2)
mpg1$test_result <- ifelse(mpg1$avg_mileage >= 20, "pass", "fail")
head(mpg1,10)
mpg1$grade <- ifelse(mpg1$avg_mileage >= 30, "A", ifelse(mpg1$avg_mileage >=20,  "B","C"))
table(mpg1$grade)
```
* midwest 데이터를 이용한 실습

```R
midwest
nrow(midwest)
ncol(midwest)
help(midwest)
names(midwest)
midwest1 <- midwest
midwest1 <- rename(midwest1, total=poptotal)
midwest1 <- rename(midwest1, asian=popasian)
names(midwest1)
midwest1$total
midwest1$asian
a <- (midwest1$asian/midwest1$total) *100
a <- round(a,2)
hist(a)
names(midwest1)
mean(a)
midwest1$ratio <- a
b <- mean(a)
midwest1$group <- ifelse(midwest1$ratio > b, "large", "small")
head(midwest1,2)
table(midwest1$group)
qplot(midwest1$group)

```
* MySQL 설치
https://kldp.net/apmsetup/

```SQL
create table test1 ( kor int, eng int);
insert into test1 values(90,80);
insert into test1 values(100,80);
```

```R
install.packages("DBI")
install.packages("RODBC")
install.packages("RMySQL")
install.packages("rJava")
install.packages("RJDBC")

library(DBI)
library(RODBC)
library(RMySQL)
library(rJava)
library(RJDBC)

# 대소문자 주의
# Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_171')
#drv <- JDBC(driverClass = "com.mysql.jdbc.Driver", classPath="C:\\r_temp\\mysql-connector-java-5.1.46.jar")

# 아래 내용 실행과정에서 오류가 발생시에는 R을 껐다가 다시 킨다.
#conn <- dbConnect(drv,"jdbc:mysql://127.0.0.1:3306/abc","root","apmsetup")

query <- "select * from test1"
test <- dbGetQuery(conn,"select * from test1")
```

* 우편주소 테스트 하기
* MySQL 관리 화면 들어가기 http://127.0.0.1/myadmin/
```SQL
create table post(
    unq     int not null,
    postnum varchar(6),
    sido    varchar(50),
    gugun   varchar(50),
    dong    varchar(50),
    ri      varchar(50),
    bunji   varchar(50),
    others  varchar(100)
);
```
* 관리화면 import에서 file 선택 csv 선택
* CSV using LOAD DATA를 선택    Option에 필드 구분자 , 로 변경
```R
query <- "select * from post"
post <- dbGetQuery(conn,query)
nrow(post)
names(post)
table(post$sido)
t1 <- table(post$sido)
t1
barplot(t1)
```

* dplyr 실습

```R
head(post)
post %>% filter(unq > 100 & unq <=110)   # filter는 오라클 where 조건
head(post %>% filter(unq >= 50000))
head(post %>% filter(sido == "서울특별시"))
post %>% filter(sido == '서울특별시' & gugun == '강남구')
nrow(post %>% filter(sido == '강원도' & dong == '학동'))
nrow(post %>% filter(sido == '강원도' | dong == '학동'))
gangnam <-  post %>% filter(sido == '서울특별시' & gugun == '강남구')
write.csv(gangnam, file='c:/r_temp/gangnam.csv')
post %>% filter(unq %in% c(100,200,300))
head(post %>% select(postnum, sido))
head(post %>% select(postnum, sido,gugun, dong) %>% filter(sido=='서울특별시'))
seoul <- post %>% select(postnum, sido,gugun, dong) %>% filter(sido=='서울특별시')
post %>% select(postnum, sido,gugun, dong) %>% filter(sido=='서울특별시') %>% head(2)

exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class,math)
```

* 조건에 맞는 데이터만 추출하기 

```R
# filter함수
exam <- read.csv("C:\\r_temp\\csv_exam.csv")
dim(exam)
mean(exam$math)
sum(exam$math)
summary(exam)
exam %>% filter(class==1)
exam %>% filter(class != 1) # !는 부정
exam %>% fileter(math>= 50)
exam %>% filter(math >=90 | english >50)
exam %>% filter(class %in% c(1,3,5))
class1_all  <-  exam %>% filter(class==1)
mean(class1_all$math)

# select 함수
exam %>% select(english)                               #python exam['english']
exam %>% select(class, math, english)
exam %>% select(-english)
exam %>% select(class,math) %>% filter(math>=60)
exam %>% select(class,math) %>% filter(math>=60) %>% count()
exam %>% select(english) %>% head(2)

# arrange함수  ---> sort
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class,math)
exam %>% select(class, math) %>% arrange(desc(class))   #python exam.sort_values(by='math', ascending=False)

# 혼합사용
exam %>% select(class, math) %>% filter(math>=60) %>% arrange(desc(math))

# 집단별 함수
exam %>% group_by(class) %>% summarise(수학평균=mean(math))   #python exam.describe()
exam %>% group_by(class) %>% summarise(평균=mean(math),총합=sum(math),중간=median(math))

# Left join 실습하기
jumsu1 <- data.frame(name=c("Kim","Lee"), eng=c(80,90))
jumsu2 <- data.frame(name=c("Kim","Lee"), kor=c(70,90))
left_join(jumsu1, jumsu2, by="name")
```

* 그래프 만들기

```R
# ggplot 실습하기
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_point()
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_col()
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_line()
ggplot(data=mpg,aes(x=displ,y=hwy))+xlim(0,8)+ylim(10,30)

# myschool 정보 이용한 출력
library(readxl)
exam_all <- read_excel("C:\\r_temp\\exam_all.xlsx",col_names=T)
exam_all
aa <- ifelse(exam_all$loc == '1',"강남", 
      ifelse(exam_all$loc == '2',"강북", 
      ifelse(exam_all$loc == '3',"강동","강서")))
exam_all$loc2 <- aa
ggplot(data=exam_all,aes(x=loc2,y=kor))+geom_col()

# economics를 이용한 출력
ggplot(data=economics,aes(x=date,y=unemploy))+geom_line()
ggplot(data=economics,aes(x=date,y=psavert))+geom_line()

# 상자그림
ggplot(data=mpg,aes(x=drv,y=hwy))+geom_boxplot()

table(mpg$drv)
a <- mpg %>% select(drv, hwy) %>% filter(drv==4)
mean(a$hwy)
summary(a$hwy)
quantile(a$hwy)
quantile(a$hwy,1/4)
quantile(a$hwy,1/5)
quantile(a$hwy,1/9)
nrow(mpg %>% select(drv,hwy))

# 4륜구동에대한 정보를 수치로 출력해본다
mpg %>% select(drv,hwy) %>% filter(drv==4)
# hwp에 대한 그룹을 지워 개수를 출력해본다
mpg %>% group_by(hwy) %>% count()

```

* 실제 데이터 분석

```R
# '한국복지패널데이터' 분석
install.packages("foreign")   # spss, sas, stata등 다양한 통계분석 소프트웨어 데이터를 읽을수 있는 라이브러리
library(foreign)

# 데이터 준비
r1 <- read.spss(file="C:\\r_temp\\Koweps_hpc10_2015_beta1.sav",to.data.frame = T)
dim(r1)
class(r1)
names(r1)
head(r1)
r2 <- rename(r1,
             gender = h10_g3,          # 성별
             birth  = h10_g4,          # 생일
             marriage = h10_g10,       # 혼인상태  
             religion = h10_g11,       # 종교
             income = p1002_8aq1,      # 급여
             code_job = h10_eco9,      # 직업     
             code_region = h10_reg7)   # 지역

table(r2$gender)    # 그룹형태의 데이터 갯수 distinct유사
str(r2$gender)      # 저장된 data가 number값임을 알수 있다.

# filter를 이용한 검토(성별에 1 또는 2 이외의 데이터가 있는지 검사 )
r2 %>% filter(gender != '1' & gender != '2') %>% count()

# 성별 데이터 값을 변경(1->M, 2->F)
r2$gender <- ifelse(r2$gender==1,"M","F")
table(r2$gender)
qplot(r2$gender)

# 요약정보
summary(r2$income)
table(is.na(r2$income))
head(r2$income)

# 급여에 들어가 있는 0 또는 9999 값을 NA로 바꾸는 작업을 한다
r2$income <- ifelse(r2$income %in% c(0,9999),NA,r2$income)

# [분석1] 성별로 분류하여 급여분석
# 1. 성별을 기준으로 각각의 평균 출력
r2 %>% group_by(gender) %>% summarise(incodem_avg=mean(income))
r2 %>% filter(!is.na(income)) %>% group_by(gender) %>% summarise(incodem_avg=mean(income))
# 2. 위의 결과를 gender_income에 담는다.
gender_income <- r2 %>% filter(!is.na(income)) %>% group_by(gender) %>% summarise(income_avg=mean(income))
gender_income$income_avg
class(gender_income)
gender_income <- as.data.frame(gender_income)

# [분석2] 나이와 월급의 관계분석
summary(r2$birth)
qplot(r2$birth)
table(is.na(r2$birth))  #결측치 확인
r2$age <- 2015 - r2$birth + 1  # 한국나이 파생변수 생성
summary(r2$age)
#나이가 젤 많은 사람의 생년월일, 성별, 급여를 출력하시오
r2 %>% select(birth, gender, income) %>% filter(!is.na(income)) %>% arrange(birth) %>% head(1)
# 나이에 따른 평균표 만들기
age_income <- r2 %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(income_avg=mean(income))
class(age_income)
age_income <- as.data.frame(age_income)
ggplot(data=age_income, aes(x=age,y=income_avg))+geom_line()

# [분석3] 연령대에 대한 급여 차이 분석
# 연령대를 3분류로 나누어서 급여차이를 분석한다.
# 1. 연령대 컬럼을 추가한다 young/ middle/ old로 분류된 파행 변수 생성
ageg = ifelse(r2$age >= 60,"old", ifelse(r2$age >=30, "middle","young"))
table(ageg)
r2$ageg <- ageg
table(r2$ageg)
qplot(ageg)
# 2. 연령대를 기준으로 평균급여 출력
ageg_income <- r2 %>% filter(!is.na(income)) %>% group_by(ageg) %>% summarise(income_avg=mean(income))
ageg_income <- as.data.frame(ageg_income)
head(ageg_income)
ggplot(data=ageg_income, aes(x=ageg,y=income_avg))+geom_point()
ggplot(data=ageg_income, aes(x=ageg,y=income_avg))+geom_col()

# [분석4] 연령대 및 성별 분석차이
# 1. 연령대 및 성별별 분류
sex_income <- r2 %>% filter(!is.na(income)) %>% group_by(ageg,gender) %>% summarise(mean_ageg_income=mean(income))
sex_income <- as.data.frame(sex_income)
ggplot(data=sex_income, aes(x=ageg,y=mean_ageg_income,fill=gender))+geom_col()+scale_x_discrete(limits=c("young","middle","old"))
ggplot(data=sex_income, aes(x=ageg,y=mean_ageg_income,fill=gender))+geom_col(position="dodge")+scale_x_discrete(limits=c("young","middle","old"))
# 2. 나이대 및 성별 급여 차이
# 나이대별 분류 파행변수 생성
age_band <- ifelse(r2$age>=90, 90,
            ifelse(r2$age>=80, 80,
            ifelse(r2$age>=70, 70,
            ifelse(r2$age>=60, 60,
            ifelse(r2$age>=50, 50,
            ifelse(r2$age>=40, 40,
            ifelse(r2$age>=30, 30,
            ifelse(r2$age>=20, 20,10))))))))
r2$age_band <- age_band
table(r2$age_band)
# 나이대별 성별 분류
ab_income <- r2 %>% filter(!is.na(income)) %>% group_by(age_band,gender) %>% summarise(mean_ab_income=mean(income))
ab_income <- as.data.frame(ab_income
ggplot(data=ab_income, aes(x=age_band,y=mean_ab_income,fill=gender))+geom_col()
ggplot(data=ab_income, aes(x=age_band,y=mean_ab_income,fill=gender))+geom_col(position="dodge")
ggplot(data=ab_income, aes(x=age_band,y=mean_ab_income,fill=gender))+geom_col(position="dodge")+coord_flip()
# 2. 나이 및 성별 급여 차이 - 선그래프
# 각 나이의 그룹에 성별을 분류하여 급여 평균 값을 가진 변수 생성
gender_age <- r2 %>% filter(!is.na(income)) %>% group_by(age,gender) %>% summarise(mean_income=mean(income))
gender_age <- as.data.frame(gender_age)
ggplot(data=gender_age, aes(x=age,y=mean_income,fill=gender))+geom_line()

# 선그래프 심플 예정
head(airquality)
str(airquality)
# 결측값 여부 확인
table(is.na(airquality$Ozone))
table(is.na(airquality$Solar.R))
table(is.na(airquality$Wind))
table(is.na(airquality$Temp))
# [분석1] 주제 : 5월의 온도를 날짜별로 시계열 그래프 출력
air5 <- airquality %>% filter(Month == 5)
ggplot(data=air5, aes(x=Day,y=Temp))+geom_line()+ylim(0,100)
# [분석2] 주제 : 직업별 급여 차이
head(r2$code_job)
table(r2$code_job)
list_job <- read_excel("C:\\r_temp\\Koweps_Codebook.xlsx",col_names = T, sheet=2)
head(list_job)
dim(list_job)
r2 <- left_join(r2, list_job, id="code_job")
head(r2$job)
head(r2 %>% select(code_job, job))
r3 <- r2 %>% filter(!is.na(code_job) & !is.na(income)) %>% group_by(job) %>% summarise(mean_income = round(mean(income),2))
r3 <- as.data.frame(r3)
head(r3)
nrow(r3)
top10 <- r3 %>% arrange(desc(mean_income)) %>% head(10)
ggplot(data=top10, aes(x=job,y=mean_income))+geom_col()+coord_flip()
ggplot(data=top10, aes(x=reorder(job,mean_income),y=mean_income))+geom_col()+coord_flip()
tail10 <- r3 %>% arrange(desc(mean_income)) %>% tail(10)
ggplot(data=tail10, aes(x=reorder(job,mean_income),y=mean_income))+geom_col()+coord_flip()
head20 <- r3 %>% arrange(desc(mean_income)) %>% head(20) %>% tail(10)           #  11~20 번째 직업을 선택함.
ggplot(data=head20, aes(x=reorder(job,mean_income),y=mean_income))+geom_col()+coord_flip()
```

* 구글차트 활용하기

```R
install.packages("googleVis")
library("googleVis")

df = data.frame(country=c("US","GB","BR"),eng=c(70,90,80),kor=c(60,80,70))

# Line Chart
Line <- gvisLineChart(df)
plot(Line)

# Bar Chart
Bar <- gvisBarChart(df)
plot(Bar)

# Column Chart
Column <- gvisColumnChart(df)
plot(Column)

# Area Char
Area <- gvisAreaChart(df)
plot(Area)

# 과일 판매 데이터 정보를 이용한 그래프
# Motion Chart
Fruits
Fruits1 <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(Fruits1)

# 지하철 이용 승객현황 데이터를 이용한 그래프
line <- read.csv("C:\\r_temp\\1-4호선승하차승객수.csv", header=T, sep=",")
names(line)
t1 <- gvisMotionChart(line, idvar="노선번호", timevar="시간", options=list(width=1000,height=500))
options(encoding="UTF-8")
plot(t1)


#import pandas as pd
#import numpy as np
#import matplotlib.pyplot as plt
#
#exam = pd.read_csv("C:\\r_temp\\csv_exam.csv")
#exam.info()
#exam.head(10)
#
#exam.columns
#exam.values
#exam.index
#exam.describe()
#exam.sort_values(by='math', ascending=False)
#
#exam['english']
#
#
#jumsu1 = pd.DataFrame({"name":("Kim","Lee"), "kor":(70,90)})
#jumsu2 = pd.DataFrame({"name":("Kim","Lee"), "eng":(80,90)})
#pd.merge(jumsu1,jumsu2,on="name")
#
#
#### https://blog.naver.com/httyu
#### https://blog.naver.com/townpharm/220974789738
#### http://action.news/watch?v=zkoLrEiU8NA
#### 구글visualization https://github.com/google/google-visualization-python
#### 임영환
#list_job = pd.read_excel('C:\\r_temp\\Koweps_Codebook.xlsx',sheetname='2')

```
[구글차트](https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html)

#### https://www.slideshare.net/dahlmoon/20160623-63318427?next_slideshow=1

## 시험문제
```R
empno <- c(101,102,103,104,105)
bonus <- c(0.1,0.1,0.12,0.15,0)
pay201801 <- data.frame(empno, pay, bonus)

total <- pay201801$pay + (pay201801$pay * pay201801$bonus)
pay201801 <- cbind(pay201801, total)

ggplot(data=pay201801, aes(x=empno, y=pay)) + geom_col()
ggplot(data=pay201801, aes(x=reorder(empno,pay), y=pay)) + geom_col()    # 순서적으로 출력
ggplot(data=pay201801, aes(x=reorder(empno,-pay), y=pay)) + geom_col()   # 역순으로 출력

pay201801 %>% select(empno, total) %>% filter(pay >= 300)

deptno <- c(1,2,1,2,2)

pay201801$deptno <- deptno

pay201801 %>% group_by(deptno) %>% summarise(mean_total=mean(total))

```
## 그래프 정리

### hist

```R
# 히스토그램(도수분포표)
# 특정 수치(숫자) 범위의 밀도 표현
# 문자는 안됨( 예: > b <- c('a',b',c','a') , hist(b))
a <- c(55,60,62,36,92,96)
hist(a)
hist(a,xlim=c(0,100), ylim=c(0,3), breaks = 10, main = "테스트")
players <- read.csv("c:/r_temp/PGA_Players_Converted.csv",stringsAsFactors = FALSE)
hist(players$Ht, main = "PGA Players Heights", ylim=c(0,250), xlab = "cm", ylab = "count", col="#80fd3d")

par(mfrow=c(2,3))  # 화면분할
continent <- unique(players$Continent) # unique 하나만 출력하는 함수

# subset(데이터, 조건) 조건만큼 가져오는 함수
for(i in 1:length(continent)) {
  currPlayers <- subset(players, Continent == continent[1])
  hist(currPlayers$Ht, main = continent[i], breaks=160:200, xlab="cm", border = "#ffffff", col = "#999999", lwd=0.4)
}

par(mfrow=c(1,1))
```

### plot

```R
# x와 y의 2개출을 기준으로 좌표를 찍듯이 그리는 컨셉을 가진 함수
a <- c(55,60,62,36,92,96)
plot(a)

test1 <- read.csv("c:/r_temp/2013_baseball.csv")
plot(test1$code, test1$타율, main ="타율", col="red", xlim=c(100,110))
grid() # grid 표현
```

### qplot

```R
# ggplot2 패키지 함수
# plot 기능처럼 x축과 y축을 이용한 표현 및 hist 기능처럼 양적이 표현도 가능
b <- data.frame(aa=c(10,11,12),bb=c(10,20,30))
qplot(x=b$aa, y=b$bb)

test1 <- c(10,20,30,10)
qplot(test1)

```


### ggplot

```R
# ggplot2 패키지 함수
# plot기능처럼 x축과 y축을 이용한 표현
```

## Text Mining (256p)

### 1. 음악 가사 텍스트 분석

```R
# package 준비
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
install.packages("stringr")
library(stringr)
library(KoNLP)
library(dplyr)

# 데이터 준비
txt <- readLines("c:/r_temp/hiphop.txt")
head(txt)
# Tip : 한글이 깨질 경우 options(encoding="UTF-8")

# 특수문자 제거( "\\W" : 모든 특수문자('," 등)를 제거)
txt <- str_replace_all(txt,"\\W"," ")

# 명사 추출하기
# KoNLP의 extractNoun()를 이용한다.
extractNoun("대한민국의 수도가 서울인가?")
extractNoun("미국의 수도가 워싱턴입니다.")

nouns <- extractNoun(txt)          # list type
class(noun s)                      # [1] "list"
wordcount <- table(unlist(nouns))  # list
head(wordcount)
class(wordcount)                   # [1] "table"
df_word <- as.data.frame(wordcount,stringsAsFactors = F)  # stringsAsFactors = F : 백터(vector)로 가져오지 않고 string 형태로 가져옴
names(df_word)
df_word <- rename(df_word, word=Var1,freq=Freq)  # rename 컬럼명 변경

# 자주 사용되는 단어 빈도표 만들기
# 한개의단어로 구성된 요소 제거
df_word <- filter(df_word, nchar(word) >= 2)
# df_word %>% arrange(desc(freq)) %>% head(20)

# wordcoud만들기
# set.seed(1234) 랜덤하게 출력하게 하기 위하여
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)
pal <- brewer.pal(8, "Dark2")
# set.seed(1234)
# wordcloud(words=df_word$word, freq=df_word$freq)  # 테스트

wordcloud(words        = df_word$word,     # 단어
          freq         = df_word$freq,     # 빈도
          min.freq     = 2,                # 최소단어빈도
          max.words    = 200,              # 표현단어수
          random.order = F,                # 고빈도 단어 중앙배치(고빈도 단어가 주용하지 않으면 T)
          rot.per      = .1,               # 회전 단어 비율
          scale        = c(3,0.2),         # 단어 크기
          colors       = pal               # 색상목록
          )
          
# 상위 10개만 추출하여 막대그래프로 표현하시오
library(ggplot2)
df_word10 <- df_word %>% arrange(desc(freq)) %>% head(10)
ggplot(data=df_word10, aes(x=word,y=freq)) + geom_col()
ggplot(data=df_word10, aes(x=reorder(word,freq),y=freq)) + geom_col()
ggplot(data=df_word10, aes(x=reorder(word,-freq),y=freq)) + geom_col()
ggplot(data=df_word10, aes(x=reorder(word,freq),y=freq)) + geom_col()+coord_flip()   # 가로로 그래프 만들기


```

### 난수에 대한 값을 같게 나오게 하는것

```R
runif(1)
runif(3)

set.seed(3)
runif(3)

set.seed(3)
runif(3)
```

### 2. 국정원 트윗

```R
# 데이터 준비
twitter <- read.csv("c:/r_temp/twitter.csv",header = T, stringsAsFactors = F, fileEncoding = "UTF-8")
names(twitter)                                  # [1] "X"        "번호"     "계정이름" "작성일"   "내용"
twitter %>% select(X) %>% head(10)
names(twitter %>% select(-X))
twitter <- twitter %>% select(-X)               # [1] "번호"     "계정이름" "작성일"   "내용"
twitter <- rename(twitter,no=번호,id=계정이름,date=작성일,content=내용)
names(twitter)
twitter$content

# 전처리
library(stringr)
twitter$content <- str_replace_all(twitter$content,"\\W"," ")
nouns <- extractNoun(twitter$content)

df_word2 <- data.frame(table(unlist(nouns)), stringsAsFactors = F)
tw_top20 <- df_word2 %>% arrange(desc(freq)) %>% head(25)
tw_top20

pal <- brewer.pal(8, "Dark2")
set.seed(1234)
wordcloud(words=df_word2$word,   # 단어
          freq = df_word2$freq, # 빈도
          min.freq =2,        # 최소단어빈도
          max.words=200,       # 표현단어수
          random.order = F,    # 고빈도 단어 중앙배치(고빈도 단어가 주용하지 않으면 T)
          rot.per = 0.1,       # 회전 단어 비율
          scale=c(6,0.2),     # 단어 크기
          colors=pal          # 색상목록
         )
```

### 3. 서울 신라호텔 이용 후기 분석하기

```R
# 데이터 준비
```

### 4. 지도 시각화

```R
install.packages("ggiraphExtra")
library(ggiraphExtra)

install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")   # github 특정폴더에서 데이터 가져오기
library(kormaps2014)

# 시도별 인구 데이터 준비

str(changeCode(korpop1))                   # utf-8로 되어 있는 데이터이므로 changeCode를 사용하여 기본인코딩인 CP949로 변환하여 출력한다.
korpop1 <- rename(korpop1, pop=총인구_명, name=행정구역별_읍면동)
str(changeCode(kormap1))
ggChoropleth(data=korpop1,
             aes(fill=pop, map_id=code, tooltip=name),
             map=kormap1,
             interactive=T)
```


### 5. 인터랙티브 그래프

```R
install.packages("plotly")
library(plotly)
library(ggplot2)
# displ : 구동방식, hwy : 고속도로연비, drv:도시연비
p <- ggplot(data=mpg, aes(x=displ, y=hwy, col=drv))+geom_point()
ggplotly(p)

# diamonds 데이터를 이용한 막대 그래프
p <- ggplot(data=diamonds, aes(x=cut, fill=clarity)) + geom_bar(position="dodge")
ggplotly(p)

# dygraphs
# ggplo2에 내장된 economics(실업자 수, 저축률 등 1967~2015의 미국 월별 경제 지표) 데이터 이용한다.
# dygraphs 패키지를 이용해 시계열 그래프를 만들려면 데이터가 시간 순서 속성을 지니는 ''xts 데이터 타입''(시계열 데이터) 으로 되어 있어야 한다
install.packages("dygraphs")
library(dygraphs)
economics
library(xts)
eco1 <- xts(economics$unemploy, order.by=economics$date)  # xts는  날짜 문자 type을  날짜 데이터 type으로 변경해서 시계열 데이터 생성 가능
head(eco1)
dygraph(eco1)
```

### 6. 유의성 테스트(유의 확률 - p-value)

```R
a <- data.frame(aa=c(1,2,3,4,5,1,2,3,4,5), bb=c(1,1,1,1,1,2,2,2,2,2))
t.test(data=a, aa~bb, var.equal=T)

a <- data.frame(aa=c(1,2,3,4,5,1,2,3,4,6), bb=c(1,1,1,1,1,2,2,2,2,2))
t.test(data=a, aa~bb, var.equal=T)

a <- data.frame(aa=c(1,2,3,4,5,1,2,3,4,1000), bb=c(1,1,1,1,1,2,2,2,2,2))
t.test(data=a, aa~bb, var.equal=T)

a <- data.frame(aa=c(1,7,8,9,10,1,2,3,4,6), bb=c(1,1,1,1,1,2,2,2,2,2))
t.test(data=a, aa~bb, var.equal=T)

a <- data.frame(aa=c(11,7,8,9,10,1,2,3,4,6), bb=c(1,1,1,1,1,2,2,2,2,2))
t.test(data=a, aa~bb, var.equal=T)
```

### 7. 상관분석

```R
# 놀이동산의 만족도 분석 데이터
# -주말이용여부, 동반자녀수, 놀이공원까지의 거리, 놀이기구의 만족도, 대기시간 만족도, 청결상태의 만족도
df1 <-read.csv('c:/r_temp/gData.csv')
str(df1)

# 결측치 확인
colSums(is.na(df1))
# weekend num.child  distance     rides     games      wait     clean overall 
#       0         0         0         0         0         0         0       0 

# 산점도
# 상관계수를 파악하기 전에 우선, 산점도(scatterplot)으로부터 두 변수간에 관련성을 시각적으로 파악함.
head(df1)
head(df1$weekend)
head(weekend)
attach(df1)    # df1을 전역변수화, detach(df1) 전역변수 해제
head(weekend)

plot(y=df1$overall, x=df1$rides, col="red")
plot(df1$overall~df1$rides, col="red")
plot(overall~rides, col="red")
plot(overall~clean, col="red")
plot(overall, rides, col="red",main = "놀이기구와 전체만족도")
plot(overall, rides, col="red",main = "놀이기구와 전체만족도",ylab="전체",xlab="놀이기구")

# 공분산(Covariance) 및 상관계수(Correlation Coefficient)
# 공분산은 2개의 변수의 상관정도를 나타내는 값인데, 만약 2개의 변수 중 하나의 값이 상승하는 경향을 보일때
# 다른 값도 상승하면 공분산의 값은 양수, 반대로 다른값이 하강하는 경향을 보이면 공분산의 값은 음수가 나온다
cov(overall, rides)
# 양수이므로 두 변수간의 상관관계는 상승하는 경향이라 할 수 있겠다.
# 값이 1 또는 -1에 가까울수록 관계가 깊다고 볼수 있음
cor(df1[,4:8])
x <- cor(df1[,4:8])
install.packages("corrplot")
library(corrplot)
corrplot(x)
```

### 8. 회귀분석

```R
# 일정한 패턴을 확인후 무엇인가를 예측하는 분석
lm(overall~rides)

# Call:
# lm(formula = overall ~ rides)

# Coefficients:
# (Intercept)        rides  
#    -94.962        1.703

# overall = -94.962 + 1.703*rides라는 회귀식을 구할 수 있고
# 놀이기구에 대한 만족도(rides)가 1 증가할 대마다 전체만족도(overall)이 1.703 증가한다고 볼수 있다
m1 <- lm(overall~rides)
plot(overall~rides)
abline(m1, col='blue')

```
