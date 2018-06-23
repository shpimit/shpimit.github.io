---
layout: page
title: R
permalink: /Lecture/R
---
## R
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
tail10 <- r3 %>% arrange(desc(mean_income)) %>% tail(10)
ggplot(data=tail10, aes(x=reorder(job,mean_income),y=mean_income))+geom_col()+coord_flip()

ggplot(data=top10, aes(x=reorder(job,mean_income),y=mean_income))+geom_col()+coord_flip()







```
