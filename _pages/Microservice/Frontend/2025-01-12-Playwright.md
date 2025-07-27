---
layout: page
title: Microservice Playwright
summary: Microservice Playwright is space to learn with Playwright.
categories: javascript
tags: javascript
featured-img: microservice
comments: 마이크로 서비스 (with Playwright)
---

# Introducing Microservice Playwright !!

#####  Microservice Playwright is space to learn with Playwright.

---

## Contents

### Table of Contents

|   No |         Title         | Remarks         |
| ---: | :-------------------: | :-------------- |
|    0 | [환경설정](#install)  | Playwright환경셋팅 |
|    1 | [커리큘럼](#syllabus) | 커리큘럼        |
|    2 |    [설계](#design)    | 실습            |

---

<a name="install"/>

## Get Started(`Playwright`)

### 1. 기본 환경 bun 설치

* Web 서버 구축을 위한 Node.js 설치
* [Node.js 다운로드](https://nodejs.org/ko/download/)

> `Playwright`로 프로젝트 만들기

* [vscode에서 npm : 이 시스템에서 스크립트를 실행할 수 없으므로](https://velog.io/@ganymede/Windows에서-NVMNPM-node.js-사용하기)
* [Windows에 bun 설치하기](https://velog.io/@kimgh06/Windows-에서-Bun-설치하기)
* [bun에서 workspace 사용](https://helloinyong.tistory.com/353)
* [[CRA 대신에 Vite로 React 프로젝트 시작하기](https://www.daleseo.com/vite-react/)]

```shell
$ powershell -c "irm bun.sh/install.ps1|iex"
$ bun create vite [프로젝트명]
$ cd [프로젝트명]
$ bun install
$ bun dev
# 기타 의존성 추가하기
$ bun add axios
# 기타 의존성 제거하기
$ bun remove axios
# [devDependencies에 추가하려면, 다른 패키지 관리자 툴과 동일하게 --dev 옵션을 사용](https://bluemiv.tistory.com/112).
$ bun add --dev prettier
$ bun create vite
```

### 2. [vitest 설치](https://www.daleseo.com/vite-react/)

```shell
$ bun add -D vitest @testing-library/react @testing-library/user-event @testing-library/jest-dom happy-dom

# playwright 설치
$ bun add playwright@latest  → binary만 설치됨
$ npm init playwright@latest
```
### 3. [Playwright 설치](https://velog.io/@wowba/react-playwright-3분-메뉴얼)

```shell
  npx playwright test
    Runs the end-to-end tests.

  npx playwright test --ui
    Starts the interactive UI mode.

  npx playwright test --project=chromium
    Runs the tests only on Desktop Chrome.

  npx playwright test example
    Runs the tests in a specific file.

  npx playwright test --debug
    Runs the tests in debug mode.

  npx playwright codegen
    Auto generate tests with Codegen.
```


* next auth 설치

```shell
$ yarn add next-auth
```

* [Serverless Architecture](https://futurecreator.github.io/2019/03/14/serverless-architecture/)
* [Supabase 드리프트](https://cpro95.tistory.com/657?category=929244)
* [Supabase](https://www.peterkimzz.com/supasbase-overview/)
* [Firebase](https://velog.io/@jisoolee11/Firebase-serverless-%EC%95%B1-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0)
* [Serverless 배포플랫폼](https://taeny.dev/javascript/nextjs-with-deployment-platform/)
* [Headless CMS Ghost](https://blog.dalso.org/article/headless-cms-ghost)
* [Supabase vs Ghost](https://www.saashub.com/compare-supabase-vs-ghost?ref=compare)
* [Nextjs  Sample](https://bestofreactjs.com/repo/tomimick-tm-nextjs-starter-react-nextjs-boilerplates)
* [Opencvjs](https://facecrop.netlify.app/)
* [Nextjs oauth](https://davidhwang.netlify.app/TIL/(0320)nextjs%EC%97%90%EC%84%9C-next-cookies-%EC%82%AC%EC%9A%A9-%EC%9D%B4%EC%8A%88/)
* [Nextjs typescript sample](https://github.com/nextauthjs/next-auth-typescript-example/blob/main/pages/api/auth/%5B...nextauth%5D.ts)
* [Nextjs 동작방식](https://merrily-code.tistory.com/154)
* [Nextjs 상태관리](https://tech.wired.company/next-js%EC%97%90%EC%84%9C-%EC%95%88%EC%A0%84%ED%95%98%EA%B2%8C-%EC%83%81%ED%83%9C-%EA%B4%80%EB%A6%AC%ED%95%98%EA%B8%B0-3a671c47e1be)
* [Nextjs Atomic Design](https://dev-bolam.tistory.com/entry/NextJS-Atomic-Design-Pattern%EC%9D%98-%EC%A1%B0%ED%95%A9%EC%97%90%EC%84%9C-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EA%B5%AC%EC%A1%B0%EC%97%90-%EB%8C%80%ED%95%9C-%EB%8B%A8%EC%83%81)
* [Lighthouse](https://velog.io/@dell_mond/Lighthouse-%EC%82%AC%EC%9A%A9%EB%B2%95)
* [NextAuth](https://blog.toycrane.xyz/7%EB%B6%84%EB%A7%8C%EC%97%90-next-auth-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0-d4432ff97158)
* [Nextjs 개요](https://gyyeom.tistory.com/58)
* [withAuth](https://dev.to/shubhamverma/implement-protected-routes-in-nextjs-37ml)

## Data & Source

### Table of Data & Source

|   No | Title | Educational Institution |                    Source                     | Remarks   |
| ---: | :---: | :---------------------: | :-------------------------------------------: | :-------- |
|    1 |  mio  | <small>개인개발</small> | [mio](https://github.com/shpimit/jobmp-front) | `Playwright` |

---

## `Playwright`로 프로젝트 만들기

### 1. Playwright App 설치하기

```shell
$ yarn create next-app [프로젝트 명] --typescript
```
### 2. eslint, prettier 라이브러리 설치(vscode extension 설치와 settings.json 설정은 필수)

* 특정한 폴더로 이동하여 create-Playwright-app 명령어를 이용하여 spa라는 폴더를 만들어 보도록 하겠습니다.

```shell
$ npm i -D eslint eslint-config-airbnb eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-react-hooks
$ npm i -D prettier eslint-config-prettier eslint-plugin-prettier
$ npm i -D babel-eslint eslint-plugin-babel
$ npm i -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
# or 
$ yarn add eslint eslint-config-airbnb eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-react-hooks
$ yarn add prettier eslint-config-prettier eslint-plugin-prettier
$ yarn add babel-eslint eslint-plugin-babel
$ yarn add @typescript-eslint/eslint-plugin @typescript-eslint/parser
$ yarn add --dev @next/eslint-plugin-next
```

### 3. 서버 가동하기

* yarn으로 가동 가능, 만약 yarn이 설치 안되어 있으면...

```shell
$ yarn dev
$ yarn build
$ yarn start
```

### 4. Material UI

```shell
$ yarn add @material-ui/core
```

### 5. Semantic UI

```shell
$ yarn add semantic-ui-react semantic-ui-css
```

### 6. axios

```shell
$ yarn add axios
```

## Reference

* 블로그
  1. [Playwright - 반응형 web](https://chana.tistory.com/m/entry/Nextjs-mobile-responsive-react-responsive)
  2. [Redux vs Mobx](https://woowabros.github.io/experience/2019/01/02/kimcj-Playwright-mobx.html) : Playwright에서 Mobx 경험기 (Redux와 비교기)
  3. [Playwright 프로젝트에 TypeScript를 적용](https://dev-yakuza.posstree.com/ko/react/nextjs/typescript/)

* [Playwright](https://mingeesuh.tistory.com/entry/Nextjs-Image-%EC%BB%B4%ED%8F%AC%EB%84%8C%ED%8A%B8%EB%A1%9C-%EB%B0%B0%EA%B2%BD-%EC%B2%98%EB%A6%AC%ED%95%98%EA%B8%B0?category=1045904)
* [store api분리](https://techblog.woowahan.com/6339/)
* [동적라우팅](https://velog.io/@landvibe-nextjs/API-Routes)
* [동적라우팅1](https://velog.io/@kimu/useRouter)
* [https://colinch4.github.io/2021-06-07/mobx/](https://colinch4.github.io/2021-06-07/mobx/)
* [https://velog.io/@seunghwa17/Playwright-Typescript-%EC%97%90-Styled-component-%EC%A0%81%EC%9A%A9](https://velog.io/@seunghwa17/Playwright-Typescript-%EC%97%90-Styled-component-%EC%A0%81%EC%9A%A9)
* [https://www.w3schools.io/learn/nextjs-custom-404-error/](https://www.w3schools.io/learn/nextjs-custom-404-error/)
* [https://www.howdy-mj.me/boilerplate/next-ts-mobx-sc-sb/](https://www.howdy-mj.me/boilerplate/next-ts-mobx-sc-sb/)
* [안경잡이개발자](https://ndb796.tistory.com/211?category=1030599)