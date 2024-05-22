# 数据分析
import requests
from lxml import etree

url = 'https://www.qb5.ch/top/allvisit/'

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
}

resp = requests.get(url, headers=headers)
resp.encoding = 'gbk'
e = etree.HTML(resp.text)
types = e.xpath('//*[@id="articlelist"]/ul[2]//span[@class="l1"]/text()')
names = e.xpath('//*[@id="articlelist"]/ul[2]//span[@class="l2"]/a/text()')
authors = e.xpath('//*[@id="articlelist"]/ul[2]//span[@class="l3"]/text()')
counts = e.xpath('//*[@id="articlelist"]/ul[2]//span[@class="l5"]/text()')
nums = e.xpath('//*[@id="articlelist"]/ul[2]//span[@class="l6"]/text()')

datas = list()
for ty, na, au, co, nu in zip(types, names, authors, counts, nums):
    datas.append([ty, na, au, co[:-1], nu])
# %%
import pandas as pd

df = pd.DataFrame(datas, columns=['类别', '书名', '作者', '总字数', '总推荐'])
print(df)

# %%
df.describe()

# %%
df.groupby('类别').count()

# %%
df.类别.hist()

# %%
import matplotlib
import matplotlib.font_manager as mfm

a = sorted([f.name for f in mfm.fontManager.ttflist])
a
# %%
df[df.类别 == '玄幻小说'].sort_values(by='总推荐')
df['总推荐'] = df['总推荐'].astype('int')
