import requests
from lxml import etree

url = 'https://www.ip138.com/mobile.asp?mobile=135528777777&action=mobile'

headers = {
    'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
}

resp = requests.get(url=url, headers=headers)
resp.encoding='utf-8'
html = etree.HTML(resp.text)
phone_num = html.xpath('//tbody/tr[1]/td[2]/a/text()')
user_info = html.xpath('//tbody/tr/td/span/text()')
user_info.insert(0, phone_num[0])
print(user_info)
