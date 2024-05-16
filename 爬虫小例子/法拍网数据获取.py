import requests
from lxml import etree

# 注意cookie会变化，后期加入动态变更
headers = {
    'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
    'Referer':'https://www1.rmfysszc.gov.cn/projects.shtml?dh=3&gpstate=1&wsbm_slt=1',
    'Cookie':'Cookies-01=78968004; ASP.NET_SessionId=yguon4d2r0cfe5c3zftbv21v; __jsluid_s=330954ea166490732c832ad09bca12cf; Hm_lvt_5698cdfa8b95bb873f5ca4ecf94ac150=1715772749; __jsl_clearance_s=1715872834.611|0|d0ygddQ1%2BdNbhm95zJTekg2dttY%3D; Hm_lpvt_5698cdfa8b95bb873f5ca4ecf94ac150=1715872834',
}

data = {
    'type': '0',
    'name': '',
    'area': '',
    'city': '不限',
    'city1': '',
    'city2': '',
    'xmxz': '0',
    'state': '0',
    'money': '',
    'money1': '',
    'number': '0',
    'fid1': '',
    'fid2': '',
    'fid3': '',
    'order': '0',
    'page': '1',
    'include': '0',
}
url = 'https://www1.rmfysszc.gov.cn/ProjectHandle.shtml'

resp = requests.post(url, data=data, headers=headers)

e = etree.HTML(resp.text)
titles = e.xpath('//div[@class="product"]/div[@class="p_img"]/div[@class="p_title"]/a/text()')
left_info1 = e.xpath('//div[@class="product"]/div[2]/p[1]/text()')
left_info2 = e.xpath('//div[@class="product"]/div[2]/p[2]/text()')
left_info3 = e.xpath('//div[@class="product"]/div[2]/p[3]/text()')
left_info4 = e.xpath('//div[@class="product"]/div[2]/p[4]/text()')
right_value1 = e.xpath('//div[@class="product"]/div[2]/p[1]/strong/text()')
right_value2 = e.xpath('//div[@class="product"]/div[2]/p[2]/span/text()')
right_value3 = e.xpath('//div[@class="product"]/div[2]/p[3]/span/text()')
right_value4 = e.xpath('//div[@class="product"]/div[2]/p[4]/span/text()')

for x in zip(titles,left_info1,right_value1,left_info2,right_value2,left_info3,right_value3,left_info4,right_value4):
    print(x)