---
layout: page
title: DB 연동
permalink: /Lecture/DBConnect
---

---

<!-- $theme: gaia -->
<!-- *template: gaia -->
<!-- page_number: false -->

# Introducing DB Connect !!
##### (Oracle DB Connect)

---

<!-- *template: invert -->

## Contents

<a name="contents"/>

* **Table of Contents**   

|No|Titile|Explain|
|--:|:-:|:--|
|1|[Json](#json)|Javasript Object Notations|
|2|[Oracle](#oracle)|오라클|

---

<!-- page_number: false -->

## Introduce Json !!  
# Json 사용

---

<!-- *template: invert -->
<!-- page_number: true -->

<a name="json"/>

#### 1. Json

###### 1.1 Json  사용 해서 분석하기

<span style="font-size:16pt">

```python
import json

data = { 
    'age':30, 
    'name':'홍길동',
    'address':'역삼동',
    'broadcast':{
        'sba':5,
        'mbc':11
        }
    }

print(type(data))              # <class 'dict'>

json_data = json.dumps(data, indent = 4, sort_keys=True)

print(json_data)
print(type(json_data))         # <class 'str'>

json_data2 = json.loads(json_data, encoding='utf-8')
print(json_data2)
print(type(json_data2))       # <class 'dict'>  사전으로 변경됨. Game Over !!!!
```

---

<!-- *template: invert -->

<span style="font-size:16pt">

```json
{
	"member" : {
				"name":"심형래",
				"address":"용산구 도원동",
				"phone":"02-1234-5678"
	},
	"web" : {
				"cafename":"cae.naver.com/asdf1234",
				"id":"badboy"
	}
}
```

```python
import json
import codecs

def load_jsonfile( fname ):
    try:
        with codecs.open(fname, 'rb', encoding='utf-8') as f:
            lines = f.read()
            print(type(lines))
            json_data = json.loads(lines)
            return json_data
    except Exception as e:
        print('error:', e)

mydata = load_jsonfile("some.json")
print(mydata)
print(type(mydata))

d1 = mydata['member']['name']
d2 = mydata['member']['address']
d3 = mydata['member']['phone']

print('이름: '+ d1 + ', 주소: ' + d2 + ', 전화번호: ' + d3 )

d4 = mydata['web']['cafename']
d5 = mydata['web']['id']

print('cafename: '+ d4 + ', id: ' + d5)

```
[Weka](http://myeonguni.tistory.com/1568)
---

<!-- *template: invert -->

###### 1.2 공공기관 api를 사용해서..

[서울시 공공 API](http://openapi.seoul.go.kr:8088/sample/json/SeoulLibraryTime/1/5)
[Json Parser Site](http://json.parser.online.fr/)

###### Web site의 특정 url에서 제공하는 json 파일 내용을 읽어서 정보들을 출력

```python
import json
import requests

def getUrlInfo():
    url = 'http://openapi.seoul.go.kr:8088/sample/json/SeoulLibraryTime/1/5'
    source_code = requests.get(url)
#     print(type(source_code))
    text = source_code.text
    json_data = json.loads(text)
    print(json_data)
    print(type(json_data))
    
    print(json_data['SeoulLibraryTime']['RESULT']['CODE'])
    print('-'*200)
    print(json_data['SeoulLibraryTime']['row'][0]['LBRRY_NAME'])
    pass

if __name__ == '__main__':
    getUrlInfo()
```

---

<!-- *template: invert -->

#####  folium 지도 시각화 라이브러리
###### 숙제 : 지도(위도/경도) 표시
http://ibos.kr/Sunxr9

```python
import json
import requests

def getUrlInfo():
    url = 'http://openapi.seoul.go.kr:8088/sample/json/SeoulLibraryTime/1/5'
    source_code = requests.get(url)
#     print(type(source_code))
    text = source_code.text
    json_data = json.loads(text)
    print(json_data)
    print(type(json_data))
    
    print(json_data['SeoulLibraryTime']['RESULT']['CODE'])
    print('-'*200)
    print(json_data['SeoulLibraryTime']['row'][0]['LBRRY_NAME'])
    
    print('***** 도서관 목록  *****')
    mylength = range(len(json_data['SeoulLibraryTime']['row']))
#     print(mylength)
    
    for i in mylength:
        print(json_data['SeoulLibraryTime']['row'][i]['LBRRY_NAME'])
    
    pass

if __name__ == '__main__':
    getUrlInfo()
```

###### <U>[Go to Contents](#contents)</U>

---

<!-- page_number: false -->

## Introduce Oracle Connecting !!  
# 오라클 연동

---

<a name="oracle"/>

<!-- *template: invert -->

#### 1. Oracle

[오라클](http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html)  
[오라클 instant](http://www.oracle.com/technetwork/database/database-technologies/instant-client/overview/index.html)  
[SQL Developer](https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html)  

<span style="font-size:12pt">
	
```SQL
sqlplus as / sysdba

select name from v$database;  -- 결과 확인 XE

create user oraman identified by oracle account unlock;
alter user oraman default tablespace users;
grant connect, resource to oraman;
grant create view to oraman;
-- 사용자가 제대로 생성되었는 지 확인하기
select username from dba_users order by username;

create table myterror(
    eventid number,
    iyear number,
    imonth number,
    iday number,
    country number,
    country_txt varchar2(255),
    region number,
    region_txt varchar2(255),
    provstate varchar2(255),
    city varchar2(255),
    latitude number,
    longitude number
);

select * from tab;

```

```
load data
infile 'myterror.csv'
insert into table myterror
fields terminated by ','
trailing nullcols(
    eventid char,
    iyear char,
    imonth char,
    iday char,
    country char,
    country_txt char,
    region char,
    region_txt char,
    provstate char,
    city char,
    latitude char,
    longitude char
)
```

```
sqlldr.exe userid=oraman/oracle control=myterror.ctl
```

---

```python
import cx_Oracle
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc

# Series : 동일 타입의 데이터를 담고 있는 1차원 배열과 유사 형태의 자료 구조
from pandas.core.series import Series

conn = cx_Oracle.connect('oraman/oracle@DESKTOP-D3MO1PU:1521/XE')

cur = conn.cursor()

cur.execute('select * from country_summary_top_10')

data = [] # 숫자형 데이터를 저장할 리스트
myindex = [] # 축에 놓일 국가 이름

for result in cur:
    print(result)
    data.append(result[1])
    myindex.append(result[0])
#     print(type(result))   # 튜플 <class 'tuple'> 예 ('Iraq', 12875)

font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
font_name = font_manager.FontProperties(fname=font_location).get_name()
plt.rc('font',family=font_name)    
    
chartData = Series(data=data, index=myindex)  # ctrl+space를 치면 입력할 수 있는 문법 형식이 나온다.
# print(chartData)
chartData.plot(kind='bar', rot=18, grid=True,title='범죄 빈도수 Top 10 국가', alpha=0.7)

plt.show()
    
cur.close()
conn.close()
```

---

<!-- *template: invert -->

<span style="font-size:6pt">
	
```SQL
create or replace view three_country
as
select country_txt, iyear, count(*) as cnt
from myterror
where country_txt in ('Iraq','Pakistan', 'Afghanistan')
group by country_txt, iyear
order by country_txt desc, iyear asc;
```
	
```python
import cx_Oracle
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc

# Series : 동일 타입의 데이터를 담고 있는 1차원 배열과 유사 형태의 자료 구조
from pandas.core.series import Series

conn = cx_Oracle.connect('oraman/oracle@DESKTOP-D3MO1PU:1521/XE')

cur = conn.cursor()

cur.execute('select * from three_country')

data0  = []   # 국가이름
data1  = []   # 테러 발생 년동
data2  = []   # 테러 발생 빈도

for result in cur:
    data0.append(result[0])
    data1.append(result[1])
    data2.append(result[2])


# MultiIndex를 이용하여 시리즈 만들기
myseries = Series(data=data2, index=[data0, data1])

print(myseries)
print(type(myseries))

# 인덱스 중 하나를 컬럼으로 이동시켜 데이터 프레임을 만들어 준다. (Series -> DataFrame)
df = myseries.unstack()
print(df)
print('-'*200)
df = myseries.unstack(0)
print(df)
print('-'*200)
df = myseries.unstack(1)
print(df)
print('-'*200)
print(type(df))
 
font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
font_name = font_manager.FontProperties(fname=font_location).get_name()
plt.rc('font',family=font_name)
 
df.plot(kind='barh', rot=0) # barh의 h는 horizental 의이
plt.title("3개국 테러 발생 현황")

plt.show()
cur.close()
conn.close()
```

---

<!-- *template: invert -->

##### 국가와는 상관없이 분기별로 집계회 놓은 테이블 bungitable을 이용하여 Pie 그래프 그리기

<span style="font-size:6pt">
	
```SQL
create table bungitable
as
select result as bungi, count(*) as myaccount, ordering
from
(
select country_txt,
case  
     when imonth in (1,2,3) then '일사분기'
     when imonth in (4,5,6) then '이사분기'
     when imonth in (7,8,9) then '삼사분기'
     when imonth in (10,11,12) then '사사분기'
end as result, 
case  
     when imonth in (1,2,3) then 1
     when imonth in (4,5,6) then 2
     when imonth in (7,8,9) then 3
     when imonth in (10,11,12) then 4
end as ordering  
from myterror
)
group by result, ordering
order by ordering
```

```python
import cx_Oracle
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc

# Series : 동일 타입의 데이터를 담고 있는 1차원 배열과 유사 형태의 자료 구조
from pandas.core.series import Series

conn = cx_Oracle.connect('oraman/oracle@DESKTOP-D3MO1PU:1521/XE', encoding='utf-8')

cur = conn.cursor()

cur.execute('select bungi, mycount from bungitable order by ordering')

data     = []   # 데이터
myindex  = []   # 사사분기 이름
total    = 0

for result in cur:
    myindex.append(result[0])
    data.append(result[1])
    total += result[1]

print(total)

newindex = []
 
for idx in range(len(myindex)):
    newindex.append(myindex[idx] + '\n(' + str(round(100 * data[idx]/total, 2)) + '%)')

font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
font_name = font_manager.FontProperties(fname=font_location).get_name()
plt.rc('font',family=font_name)
 
chartData = Series(data=data, index=newindex)
chartData.plot(kind='pie', title='분기별 범죄 빈도') 


plt.show()
cur.close()
conn.close()
```

###### <U>[Go to Contents](#contents)</U>

---

<!-- *template: invert -->

###### 지역별 범죄 발생 빈도 확인해보기

<span style="font-size:6pt">

지역별 범죄 발생 빈도에서 상위 5~8위까지의 데이터럴 이용하여 차틀 그리기(수명막대, 파이그래프)
	
```SQL
create table region_summary
as
select region_txt, count(*) as cnt from myterror
group by region_txt
order by cnt desc;

create table region_summary_ranking
as
select region_txt, cnt
from (
    select region_txt, cnt, rank() over(order by cnt desc) as ranking
    from region_summary
)
where ranking between 5 and 8;

select * from region_summary_ranking
```

```python
import cx_Oracle
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc

# Series : 동일 타입의 데이터를 담고 있는 1차원 배열과 유사 형태의 자료 구조
from pandas.core.series import Series

conn = cx_Oracle.connect('oraman/oracle@DESKTOP-D3MO1PU:1521/XE', encoding='utf-8')

cur = conn.cursor()

cur.execute('select * from region_summary_ranking')

data     = []   # 데이터
myindex  = []   # 사사분기 이름
total    = 0

for result in cur:
    myindex.append(result[0])
    data.append(result[1])
    total += result[1]

print(total)

newindex = []
 
for idx in range(len(myindex)):
    newindex.append(myindex[idx] + '\n(' + str(round(100 * data[idx]/total, 2)) + '%)')

font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
font_name = font_manager.FontProperties(fname=font_location).get_name()
plt.rc('font',family=font_name)
 
 
chartData = Series(data=data, index=newindex)
chartData.plot(kind='barh', rot=18, alpha=0.7, title='지역별 범죄 발생 빈도(5~8위)') 
plt.show()

# chartData = Series(data=data, index=newindex)
chartData.plot(kind='pie', title='지역별 범죄 발생 빈도(5~8위)') 
plt.show()

cur.close()
conn.close()
```

###### <U>[Go to Contents](#contents)</U>
