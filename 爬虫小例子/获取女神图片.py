import requests
from lxml import etree

url = 'https://pic.netbian.com/4kmeinv/'

header = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
}

resp = requests.get(url, headers=header)

resp.encoding = 'gbk'

html = resp.text
# print(html)
xp = etree.HTML(html)
srcs = xp.xpath('//div[@class="slist"]/ul/li/a/img/@src')
names = xp.xpath('//div[@class="slist"]/ul/li/a/b/text()')
for i in zip(srcs, names):
    print(i[0], i[1])
    img_resp = requests.get(f'https://pic.netbian.com{i[0]}', headers=header)
    with open(f'./女神/{i[1]}.jpg', 'wb') as f:
        f.write(img_resp.content)
