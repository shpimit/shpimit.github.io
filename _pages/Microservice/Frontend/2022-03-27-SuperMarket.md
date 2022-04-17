---
layout: page
title: Microservice React
summary: Microservice React is space to learn with React.
categories: javascript
tags: javascript
featured-img: microservice
comments: 마이크로 서비스 (with React)
---

# Introducing Microservice React !!

#####  Microservice React is space to learn with React.

---

## Contents

### Table of Contents

|   No |         Title         | Remarks       |
| ---: | :-------------------: | :------------ |
|    0 | [환경설정](#install)  | React환경셋팅 |
|    1 | [커리큘럼](#syllabus) | 커리큘럼      |
|    2 |    [설계](#design)    | 실습          |

---

## Learning

### Table of Learning

|   No | 구분  |       Title       |     Day     | Remarks |
| ---: | :---: | :---------------: | :---------: | :------ |
|    1 | 정규  | 사설네트워크 구축 | Mar 18 2019 | 참석    |

---

<a name="install"/>

## Get Started(`React`)

### 1. Node.js 설치

* Web 서버 구축을 위한 Node.js 설치
* [Node.js 다운로드](https://nodejs.org/ko/download/)

### 2. Gitlab 연결

* MINGW64에서 해야 정상 처리 됨

```shell
# .gitconfig 파일 무조건 확인  gitlab 연결 부분 있는지
$ git remote -v
# 원격 끊기
$ git remote remove origin
# 최초 등록, 원격 gitlab에 repository를 만들지 않아야 정상적으로 된다
$ git remote add origin https://gitlab.com/prugio/supermarket.git
$ git branch -M main
$ git push -uf origin main
```

### 3. React 프로젝트 생성하기

* 특정한 폴더로 이동하여 create-react-app 명령어를 이용하여 spa라는 폴더 생성

```shell
#D:\Project\Java\supermarket> create-react-app spa
npx create-react-app spa
```

### 4. 서버 가동하기(yarn)

* yarn으로 가동 가능, 만약 yarn이 설치 안되어 있으면...
  
```shell
npm install --global yarn
cd spa
yarn start

yarn start = (npm start)
yarn build = (npm run build)
yarn test  = (npm run test)
``` 

### 5. Context Path 변경

* pakage.json에 아래 추가

```pakage.json
  "homepage": "http://localhost:3000/sm/",
  "proxy": "http://localhost:8100/sm/",
```

* application.yml에 아래 추가

```yml
server:
  port : 8100
  servlet:
    context-path: /sm
```

### 6. Mobx Decorator 설치

* Mobx Decorator : @observable, @observer처럼 ‘@’를 사용한 문법의 형태

```shell
# 우리 프로젝트의 모든 설정과 스크립트를 customize해주는 방법이다. 주의할 점은, eject이후에는 eject이전으로 프로젝트를 되돌릴 수 없다는 점이다
$ yarn run eject
# cra에서 default된 설정을 유저 임의대로 customize할 수 있게 되었다.

# mobx에서 제공하는 preset인 bable-preset-mobx를 설치
$ yarn add babel-preset-mobx
```

* package.json 수정

```json
"babel": {
  "presets": [
    "react-app",
    "mobx"
  ]
}
```

### 6. Mobx 설치

```shell
$ yarn add mobx mobx-react
```

### 7. React 다국어 설치

* react-i18next는 React와 React Native 에서 사용할 수 있는 국제화 프레임 워크

```shell
$ npm install react-i18next i18next — save
```

* https://velog.io/@zoeyul/MobX
* https://hyeok999.github.io/2020/04/16/mobx-hooks-market/#a1
* [자바스크립트 비구조](https://tocomo.tistory.com/28)
* * https://www.samsungsds.com/kr/insights/TypeScript.html
* https://twojobui.tistory.com/25
* [React 다국어](https://jinminkim-50502.medium.com/react-프로젝트-i18n-다국어-지원하기-a92bd5539e1d)
* [React Mobx](https://medium.com/@jsh901220/mobx-처음-시작해보기-a768f4aaa73e)

---

## Data & Source

### Table of Data & Source

|   No |    Title    | Educational Institution |                        Source                         | Remarks |
| ---: | :---------: | :---------------------: | :---------------------------------------------------: | :------ |
|    1 | supermarket | <small>개인개발</small> | [supermarket](https://github.com/shpimit/jobmp-front) | `React` |

---

## Syllabus

### Writing.......

---

## Design

### 1. Atomic Design

> 간략한 특징은 다음과 같이 Atoms(원자), Molecules(분자), Organisms(유기체), Templates, Pages 분류로 React Component의 종류와 규모에 맞게 적절히 분류해서 생성하여 관리합니다.

#### a. Atomic Design 단계 구분

* Atoms(원자), Molecules(분자), Organisms(유기체), Templates, Pages

#### b. Atomic Design 적용한 폴더 구조

* atoms, molecules, organisms

---

## `React`로 프로젝트 만들기

### 1. CRA(Create React App) 설치하기

* NPM 명령어를 이용해서 CRA를 설치할 수 있습니다.
```shell
npm install -g create-react-app
```
### 2. React 프로젝트 생성하기
* 특정한 폴더로 이동하여 create-react-app 명령어를 이용하여 spa라는 폴더를 만들어 보도록 하겠습니다.
```shell
#c:\Data\create-react-app jobmarketplace
#D:\Project\Java\react> create-react-app spa
npx create-react-app spa
```

### 3. 서버 가동하기

* yarn으로 가동 가능, 만약 yarn이 설치 안되어 있으면...
```shell
npm install --global yarn
yarn start

yarn start = (npm start)
yarn build = (npm run build)
yarn test  = (npm run test)
yarn eject = (npm run eject)
```

* Windows에서 실행 스크립트 오류날때

```shell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
```


* npm으로 가동하기 위해서는 아래와 같이 함.(`npm start`)

### 4. [Material UI](https://material-ui.com/getting-started/installation/)를 적용하여 테이블 만들기

* Material UI를 설치하기 위해서 터미널(Terminal)에서 다음과 같은 명령어를 입력

```shell
npm install @material-ui/core
```

### 5. withStyles 라이브러리를 이용해서 CSS를 적용

### 6. Node.js 서버 만들기

* client 폴더를 만들고 기존 개발 한것 전부 이관하기
* 루트 폴더에 package.json 만들기
* nodemon 설치
```shell
$ npm install -g nodemon
```

* Express 설치
```shell
$ npm install -g express-generator
$ npm install -g express
```

* 루트 폴더 package.json의 dependencies에 있는 모듈들 설치
```shell
$ npm install
```

* 루트 폴더에 server.js 만들기
* server start :  `node server.js`

### ★ [JSON 검증 서비스](https://jsonlint.com/)

### 7. React의 라이프 사이클(Life Cycle)  이해
* 기본적으로 리액트 라이브러리가 처음 컴포넌트를 실행할 때는 다음의 순서를 따릅니다.

#### 1) constructor()
#### 2) componentWillMount()
#### 3) render()
#### 4) componentDidMount()

### 8. 서버와의 통신목적의 라이브러리 axios를 설치(From React client)
```shell
npm install --save axios
```

### 9. Node.js 서버 파일 업로드 처리 라이브러리 multer를 설치(From Node.js Server)
```shell
npm install --save multer
```

### 10. 안정적인 UI/UX를 위해 AppBar를 적용
* AppBar는 검색 바, 내비게이션 바 등의 목적으로 사용
* client로 이동 icons 라이브러리를 받음
* [Material UI AppBar 예제](https://material-ui.com/demos/app-bar/)
```shell
npm i @material-ui/icons
```

### 11. 페이지 이동을 구현하기 위해 router 구현
```shell
$ npm install react-router-dom —save 
or
$ yarn add react-router-dom
```

### 12. Styled Component  설치

```shell
$ npm install --save styled-components
```

### 13. Social Login

* Google 로그인 [API Key 발급받기](https://console.cloud.google.com/apis/)

```shell
$ yarn add react-google-login
or refer to https://console.cloud.google.com/apis/
$ npm install react-google-login
```

### 14. Kakao Login

* Kakao 로그인 [API Key 발급받기](https://developers.kakao.com)

```shell
$ npm i -S react react-dom react-kakao-login
$ yarn add react-kakao-login
or refer to https://www.npmjs.com/package/react-kakao-login
$ npm install react-kakao-login
```

## Reference

* 블로그
  1. [React - Create React App으로 시작하기](https://ndb796.tistory.com/211?category=1030599)
  2. [Redux vs Mobx](https://woowabros.github.io/experience/2019/01/02/kimcj-react-mobx.html) : React에서 Mobx 경험기 (Redux와 비교기)

* youtube
  1. [Create React App으로 리액트 프로젝트 시작하기 [React와 Node.js를 활용한 고객 관리 시스템 개발 강의]](https://youtu.be/_yEH9mczm3g)
  2. [React 기본 강좌 1-1. 리액트를 왜 쓰는가](https://youtu.be/V3QsSrldHqI)