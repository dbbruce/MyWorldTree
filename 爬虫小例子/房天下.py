import requests
from lxml import etree
import pandas as pd

url = 'https://newhouse.fang.com/house/s/b91/'
headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
}


resp = requests.get(url, headers=headers)
resp.encoding = 'utf-8'
# print(resp.text)
e = etree.HTML(resp.text)

names = [n.strip() for n in e.xpath('//div[@class="nlcd_name"]/a/text()')]
address = e.xpath('//div[@class="address"]/a/@title')
prices = [d.xpath('string(.)').strip() for d in e.xpath('//div[@class="nhouse_price"]')]
data = []
for n,a,p in zip(names, address, prices):
    # print(f'名称:{n}            地址:{a}              价格:{p}')
    data.append([n,a,p])

pd.set_option('display.max_colwidth', 40)

df = pd.DataFrame(data, columns=['名称','地址','价格'])
print(df)
