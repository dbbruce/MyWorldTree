# 回文的核心就是遍历和正序倒序相等
import random
from time import sleep


def random_str():
    keys = 'abc'
    result_list = random.choices(keys, k=random.randint(5, 8))
    result_str = "".join(result_list)
    return result_str


def check_max_long_huiwen_str(long_str):
    num = len(long_str)
    number = 0
    results = list()
    for i in range(0, num + 1):
        for j in range(i, num + 1):
            temp_str = long_str[i:j]
            if temp_str == temp_str[::-1]:
                temp_num = len(temp_str)
                if temp_num > number:
                    number = temp_num
                    results = [temp_str]
                elif temp_num == number:
                    results.append(temp_str)
                else:
                    pass  # 非回文
            else:
                pass  # 非回文
    return results


while True:
    ins = input("请输入要生成字符串的个数(q退出):")
    if ins == 'q':
        print('程序终止运行~')
        break
    elif ins.isdigit():
        ins_int = int(ins)
        for _ in range(ins_int):
            result = random_str()
            print(result)
            huiwen_str = check_max_long_huiwen_str(result)
            print(huiwen_str)
            sleep(0.8)
    else:
        print("输入仅限数字")
