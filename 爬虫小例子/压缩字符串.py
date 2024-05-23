def compress_string(long_str):
    comp_str = ''
    tmp_c = ''
    tmp_n = 0
    for c in long_str:
        if c == tmp_c:
            tmp_n += 1
        else:
            if tmp_c:
                comp_str = comp_str+"{}{}".format(tmp_c, tmp_n)
            tmp_c = c
            tmp_n = 1
    else:
        comp_str = comp_str + "{}{}".format(tmp_c, tmp_n)
    if len(comp_str) > len(long_str):
        return long_str
    else:
        return comp_str

while True:
    ins = input("请输入长字符串(q退出):")
    if ins == 'q':
        print('程序终止运行~')
        break
    else:
        result = compress_string(ins)
        print(result)
