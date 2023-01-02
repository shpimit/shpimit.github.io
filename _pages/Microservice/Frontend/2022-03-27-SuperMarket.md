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

### 1. Gitlab 연결

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

### 2. React 프로젝트 생성하기

* 특정한 폴더로 이동하여 create-react-app 명령어를 이용하여 spa라는 폴더 생성

```shell
#D:\Project\Java\supermarket> create-react-app spa
npx create-react-app spa
or
yarn create react-app [프로젝트명]
```

### 3. 서버 가동하기(yarn)

* yarn으로 가동 가능, 만약 yarn이 설치 안되어 있으면...
  
```shell
npm install --global yarn
cd spa
yarn start

yarn start = (npm start)
yarn build = (npm run build)
yarn test  = (npm run test)
``` 

### 4. Material-UI 설치

```shell
npm install @material-ui/core
or
yarn add @material-ui/core
```

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

### 5. Mobx Decorator 설치

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

## Reference

* 블로그
  1. [React - Create React App으로 시작하기](https://ndb796.tistory.com/211?category=1030599)
  2. [Redux vs Mobx](https://woowabros.github.io/experience/2019/01/02/kimcj-react-mobx.html) : React에서 Mobx 경험기 (Redux와 비교기)

* youtube
  1. [Create React App으로 리액트 프로젝트 시작하기 [React와 Node.js를 활용한 고객 관리 시스템 개발 강의]](https://youtu.be/_yEH9mczm3g)
  2. [React 기본 강좌 1-1. 리액트를 왜 쓰는가](https://youtu.be/V3QsSrldHqI)