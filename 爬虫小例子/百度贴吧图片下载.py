import requests
from lxml import etree

base_url = "https://tieba.baidu.com/p/8673042628"

response = requests.get(base_url)
selector = etree.HTML(response.text)

image_urls = selector.xpath('//img[@class="BDE_Image"]/@src')

offset = 0

for img_url in image_urls:
    image_content = requests.get(img_url).content
    with open('{}.jpg'.format(offset), 'wb') as f:
        f.write(image_content)
    offset += 1
