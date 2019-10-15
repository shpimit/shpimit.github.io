---
layout: page
title: RaspberryPi4 설치
subtitle: RaspberryPi4 설치
categories: Miscellaneous
tags: Miscellaneous
---

# RaspberryPi4

## Install

### 1. [Rasbian OS설치](https://www.canakit.com/pi)

* 메뉴에서 한국어 선택 後 기본설치함 → 약 10분 걸림
* 부팅 완료 後 Language 설정에서는 Korean 선택하지 마세요. 
* 초기에 Wifi연결이 안됨

### 2. [Firmaware Update](https://jamesachambers.com/raspberry-pi-4-ubuntu-server-desktop-18-04-3-image-unofficial/)

* 우분투 비공식 버전 설치를 위한 Firmware Update
```shell
$ sudo apt-get update && sudo apt-get dist-upgrade -y
$ sudo rpi-update
```
