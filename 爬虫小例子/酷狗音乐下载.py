import requests
import json

# 获取播放列表
headers = {
    'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
}
song_url= 'https://complexsearch.kugou.com/v2/search/song?callback=callback123&srcappid=2919&clientver=1000&clienttime=1715506844536&mid=e1e71554345cf8fce29e7e5b8105b8bb&uuid=e1e71554345cf8fce29e7e5b8105b8bb&dfid=1JcQnm4egXwo2l6vV1277c1Q&keyword=%E6%8C%AA%E5%A8%81%E7%9A%84%E6%A3%AE%E6%9E%97&page=1&pagesize=30&bitrate=0&isfuzzy=0&inputtype=0&platform=WebFilter&userid=0&iscorrection=1&privilege_filter=0&filter=10&token=&appid=1014&signature=59c92e1b2ecd4f85073a31e9dd35466f'
list_resp = requests.get(song_url, headers=headers)
song_list = json.loads(list_resp.text[12:-2])['data']['lists']
for i,s in enumerate(song_list):
    print(f"{i+1}----{s.get('SongName')}----{s.get('FileHash')}")

# 获取单个音乐url地址
num = input("输入数字：")
info_url = f'https://wwwapi.kugou.com/yy/index.php?r=play/getdata&hash={song_list[int(num)-1].get("FileHash")}'
mp3_name = song_list[int(num)-1].get("SongName")
headers2 = {
    'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
    'Cookie':'kg_mid=e1e71554345cf8fce29e7e5b8105b8bb; kg_dfid=1JcQnm4egXwo2l6vV1277c1Q; kg_dfid_collect=d41d8cd98f00b204e9800998ecf8427e; Hm_lvt_aedee6983d4cfc62f509129360d6bb3d=1715347539,1715504614; kg_mid_temp=e1e71554345cf8fce29e7e5b8105b8bb; Hm_lpvt_aedee6983d4cfc62f509129360d6bb3d=1715506844'
}
mp3_url = requests.get(info_url, headers=headers2).json()['data']['play_url']

# 下载音乐
mp3_info = requests.get(mp3_url, headers=headers)

with open(f'{mp3_name}.mp3', 'wb') as f:
    f.write(mp3_info.content)


