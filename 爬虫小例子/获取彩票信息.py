import requests
from lxml import etree

url = 'https://datachart.500.com/ssq/'
headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
}

resp = requests.get(url, headers=headers)
resp.encoding ='gbk'

e = etree.HTML(resp.text)
numbers = e.xpath('//*[@id="tdata"]/tr/td[1]/text()')
print(numbers)
print(len(numbers))
reds = [tr.xpath('./td[@class="chartBall01"]/text()') for tr in e.xpath('//*[@id="tdata"]/tr[not(contains(@class, "tdbck"))]')]
print(reds)
print(len(reds))
blues = e.xpath('//*[@id="tdata"]/tr[not(contains(@class, "tdbck"))]/td[@class="chartBall02"]/text()')
print(blues)
print(len(blues))

for n,r,b in zip(numbers, reds, blues):
    print(f'期号{n}红球{r}篮球[{b}]')