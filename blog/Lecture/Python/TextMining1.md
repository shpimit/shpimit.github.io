---
layout: page
title: R
permalink: /Lecture/TextMining1
---
# TextMining

## 페이스북 crawling 해서 분석하기
```python3
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

## Gensim 라이브러리
[Skip-Gram 모델 참조문서](http://mccormickml.com/2016/04/19/word2vec-tutorial-the-skip-gram-model/)

`토지 파일 분석 word2vec=toji`  
```python3
import warnings
warnings.filterwarnings(action='ignore', category=UserWarning, module='gensim')

import codecs

from bs4 import BeautifulSoup
from konlpy.tag import Twitter
from gensim.models import word2vec

fp = codecs.open(filename='BEXX0003.txt', mode='r', encoding='utf-8')
soup = BeautifulSoup(fp, 'html.parser')
body = soup.select_one('body > text')
text = body.getText()
print(text)

twitter = Twitter()
results = []

lines = text.split('\r\n')

for line in lines:
    malist = twitter.pos(line, norm=True, stem=True)
    r = []
    for word in malist:
        if not word[1] in ['Josa', 'Eomi', 'Punctuation']:
            r.append(word[0])
            
    r1 = (" ".join(r)).strip()
    results.append(r1)
    
# 파일로 출력하기
output_file = 'toji.out'

with open(output_file, 'w', encoding='utf-8') as fp:
    fp.write('\n'.join(results))
    
# Word2Vec 모델 만들기
data = word2vec.LineSentence(output_file)
model = word2vec.Word2Vec(data, size=200, window=10, hs=1, min_count=2, sg=1)

saved_model_name = 'toji.model'

model.save(saved_model_name)

print('파일', saved_model_name, ' fininshed')   
```
`모델 불러오기 toji_model_test`
```python3
import matplotlib.pyplot as plt

from matplotlib import font_manager, rc
from gensim.models import word2vec

def showGraph(somedata): # 유사도 그래프
    su = len(somedata)   # 전체 데이터 수
    # 축에 보여질 항목 이름들
    item = list(item[0] for item in somedata)   # 항목이름
    count = list(item[1] for item in somedata)  # 확률
    
    font_location = 'c:/Windows/fonts/malgun.ttf'  # \는 \\를 사용한다
    font_name = font_manager.FontProperties(fname=font_location).get_name()
    plt.rc('font',family=font_name)    
    
    plt.barh(range(su), count, align='center')  # 수평막대 그래프
    plt.yticks(range(su), item, rotation='10')
    plt.xlim(0.8, 0.86) # x축의 하한 값과 상한값을 작게 설정하여 차트의 효과를 극대화 시켰다.
    plt.grid(True)
    plt.show()

filename = 'toji.model'

model = word2vec.Word2Vec.load(filename)

somedata = model.most_similar(positive=['땅'])
print(somedata)

showGraph(somedata)

print('-' * 50)
somedata = model.most_similar(positive=['집'], topn=5)
print(somedata)
```
