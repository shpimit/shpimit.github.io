---
layout: page
title: R
permalink: /Lecture/TextMining1
---
# TextMining

## 페이스북 crawling 해서 분석하기
```python
from matplotlib import font_manager, rc
import matplotlib.pyplot as plt

import pytagcloud # 워드 클라우드를 만들어 주는 패키지
import webbrowser

# 그래프 그려주는 함수
def showGraph(wordInfo):
    font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
    font_name = font_manager.FontProperties(fname=font_location).get_name()
    
    plt.rc('font',family=font_name)
    
    plt.xlabel('주요 단어')
    plt.ylabel('빈도 수')
    plt.grid(True)
    
    Sorted_Dict_Values = sorted(wordInfo.values(), reverse=True)
    print(Sorted_Dict_Values)
    plt.bar(range(len(wordInfo)), Sorted_Dict_Values, align='center')
    
    Sorted_Dict_Keys = sorted(wordInfo, key=wordInfo.get, reverse=True)
    print(Sorted_Dict_Keys)
    plt.xticks(range(len(wordInfo)), list(Sorted_Dict_Keys), rotation='70')
    
    plt.show()        

# 워드 클라우드 그려주는 함수
def saveWordCloud(wordInfo, filename):
    taglist = pytagcloud.make_tags(dict(wordInfo).items(), maxsize=80)
    print(type(taglist)) #<class 'list'>
    pytagcloud.create_tag_image(taglist, filename, size=(640,480), fontname='korean', rectangular=False)
    webbrowser.open(filename)

import json
import re

from konlpy.tag import Twitter
from collections import Counter

# 메인 함수
def main():
    openFileName = 'jtbcnews_facebook_2016-10-01_2017-03-12.json'
    cloudImagePath = openFileName + '.jpg'
    
    rfile = open(openFileName, mode='r', encoding='utf-8-sig')
    rfile = rfile.read()  # 메모리상에 바이트로 만들어 주는 함수

    jsonData = json.loads(rfile)
    
#     print(jsonData)
    
    message = ''
    for item in jsonData :
        message = message + re.sub(r'[^\w]','', item['message'])


#     print(message)
    nlp = Twitter()
    nouns = nlp.nouns(message)
    
    count = Counter(nouns)
    print('count 개수:', count)
    
    wordInfo= dict()
    
    for key, value in count.most_common(20):
        if(len(str(key)) > 1):
            wordInfo[key] = value
            print(key, '/', value)
            
    showGraph(wordInfo)
    saveWordCloud(wordInfo, cloudImagePath)       
            
'''
외부에서 이파일을 실행하면  이값은 false
 스스로 실행하면 true 가 됨
'''
if __name__ == '__main__':
    main()
```

## ensim 라이브러리
[Skip-Gram 모델 참조문서](http://mccormickml.com/2016/04/19/word2vec-tutorial-the-skip-gram-model/)
