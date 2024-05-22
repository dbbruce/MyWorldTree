from lxml import etree
import requests

url = 'https://nba.hupu.com/stats/players'

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
}

resp = requests.get(url, headers=headers)
resp.encoding = 'utf-8'
# print(resp.text)
e = etree.HTML(resp.text)

# 球员
players = e.xpath(f'//table[@class="players_table"]//tr/td[{2}]/a/text()')
# 球队
teams = e.xpath(f'//table[@class="players_table"]//tr/td[{3}]/a/text()')
print(players)
print(teams)

for i in range(12):
    values = e.xpath(f'//table[@class="players_table"]//tr/td[{i+1}]/text()')
    if i == 1:
        values.extend(players)
    if i == 2:
        values.extend(teams)
    print(values)





