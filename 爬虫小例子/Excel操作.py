import pandas as pd

data = pd.read_excel('1.xlsx')
data['year'] = data['type'].apply(lambda x:x.split('/')[0].strip())
data['c'] = data['type'].apply(lambda x:x.split('/')[1].strip())
data['t'] = data['type'].apply(lambda x:x.split('/')[2].strip())
print(data)
# 直接在中括号里筛选，只显示c字段为法国的数据
print(data[data['c']=='法国'])
writer = pd.ExcelWriter('temp.xlsx')
data.to_excel(writer, sheet_name='新数据')
writer.close()

# 安装年将数据中的每年生成一个sheet
data = pd.read_excel('1.xlsx')
writer = pd.ExcelWriter('temp.xlsx')

for i in data['year'].unique():
    data[data['year'] == i].to_excel(writer, sheet_name=i)
writer.close()