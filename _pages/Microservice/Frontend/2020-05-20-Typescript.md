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

|   No |        Title         | Remarks       |
| ---: | :------------------: | :------------ |
|    0 | [환경설정](#install) | React환경셋팅 |

---

## Learning

### Table of Learning

|   No |  구분  |                                Title                                |     Day     | Remarks |
| ---: | :----: | :-----------------------------------------------------------------: | :---------: | :------ |
|    1 | 블로그 |                  React와 Node.js로 만드는 고객관리                  | Mar 18 2019 |         |
|    2 | 블로그 | [SuperMarket](/_pages/Microservice/Frontend/2022-03-27-SuperMarket) | Mar 27 2022 |         |

---

<a name="install"/>

## Get Started(`React`)

### 1. Node.js 설치

* Web 서버 구축을 위한 Node.js 설치
* [Node.js 다운로드](https://nodejs.org/ko/download/)

---

## Data & Source

### Table of Data & Source

|   No |    Title    | Educational Institution |                          Source                          | Remarks                                           |
| ---: | :---------: | :---------------------: | :------------------------------------------------------: | :------------------------------------------------ |
|    1 |    jobmp    | <small>개인개발</small> |  [jobmp-front](https://github.com/shpimit/jobmp-front)   | `React`                                           |
|    2 | supermarket | <small>개인개발</small> | [supermarket](https://gitlab.com/prugio/supermarket.git) | [Gitlab](/_pages/Miscellaneous/2022-03-17-Gitlab) |

---

## `React`로 프로젝트 만들기

### 1. Yarn으로 typescript react 프로젝트 설치하기

```shell
$ yarn create react-app [프로젝트명] --template typescript
# or
$ yarn create react-app [프로젝트명] 
$ yarn add typescript @types/node @types/react @types/react-dom @types/jest
```

### 2. Mobx 설치하기

```shell
$ yarn add mobx mobx-react
```

* package.json 수정

```json
 "scripts": {
    "start": "react-app-rewired start",
    "build": "react-app-rewired build",
    "test": "react-app-rewired test",
    "eject": "react-scripts eject"
  },
```

### 3. [Material UI](https://material-ui.com/getting-started/installation/)를 적용

```shell
$ yarn add @material-ui/core
$ yarn add @material-ui/icons
$ yarn add @material-ui/pickers
$ yarn add @date-io/date-fns
#$ yarn add date-fns
#$ yarn add moment
$ yarn add @date-io/date-fns@1.x date-fns
$ yarn add @date-io/moment@1.x moment
# $ yarn add @date-io/luxon@1.x luxon
# $ yarn add @date-io/dayjs@1.x dayjs
```

### 4. Typescript 셋팅

* tsconfig.json
  
```json
{
  "compilerOptions": {
    "experimentalDecorators": true,
  }
}
```

### 5. prittier 셋팅

```shell
$ npx prettier --write **/*.tsx
```

### 6. styled-component 

```shell
$ yarn add styled-components
$ yarn add @types/styled-components
```

