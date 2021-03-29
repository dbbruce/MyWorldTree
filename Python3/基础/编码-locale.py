# coding:utf-8

# 1、locale 为计算机上提供了国际化和本地化转化的环境。
# 2、在liunx中，可以通过命令locale查看当前系统的语言环境,locale  -a  可以查看系统支持的locale值
# 3、默认的编码方式是平台相关的

# 4、获取系统的默认编码
import locale
locale.getpreferredencoding()
'UTF-8'

# 5、格式转换
import locale
# 获取当前系统语言格式
time_locale = locale.setlocale(locale.LC_TIME)
# 将语言格式转换为en_US
locale.setlocale(locale.LC_TIME, 'en_US')
