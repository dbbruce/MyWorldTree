import re

def decompress_string(comp:str):
    comp_list = re.findall('[a-zA-Z]|\d+', comp)
    comp_list = [int(i) if i.isdigit() else i for i in comp_list]
    result = ""
    for i in range(0, len(comp_list),2):
        result = result + ''.join([comp_list[i] for _ in range(comp_list[i+1])])
    return result

def main():
    while True:
        ins = input("请输入需要解压的字符串(q退出):")
        if ins == 'q':
            print('程序停止运行')
            break
        elif not re.findall('.*[0-9]$', ins):
            print("解压字符串必须数字结尾")
        elif "".join(re.findall('[a-zA-Z]\d+', ins)) !=ins:
            print("字符和数字不成对")
        else:
            result = decompress_string(ins)
            print('解压结果：', result)

if __name__ == '__main__':
    main()
