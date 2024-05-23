import xlrd

if __name__ == '__main__':
    excel = xlrd.open_workbook('kaoqin.xlsx')
    sheet = excel.sheets()[0]
    # print(sheet)
    # for i in range(1, 5):
    #     print(sheet.cell_value(i,0))