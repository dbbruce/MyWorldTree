# coding:utf-8

# 1、unittest case的运行流程：
# 写好一个完整的TestCase
# 多个TestCase 由TestLoder被加载到TestSuite里面, TestSuite也可以嵌套TestSuite
# 由TextTestRunner来执行TestSuite，测试的结果保存在TextTestResult中
# TestFixture指的是环境准备和恢复

# 2、unittest中最核心的部分是：TestFixture、TestCase、TestSuite、TestRunner

# 3、Test Fixture
# 用于测试环境的准备和恢复还原, 一般用到下面几个函数。
# setUp()：准备环境，执行每个测试用例的前置条件
# tearDown()：环境还原，执行每个测试用例的后置条件
# setUpClass()：必须使用@classmethod装饰器，所有case执行的前置条件，只运行一次
# tearDownClass()：必须使用@classmethod装饰器，所有case运行完后只运行一次

# 4、Test Case
# 参数verbosity可以控制错误报告的详细程度：默认为1。0，表示不输出每一个用例的执行结果；2表示详细的执行报告结果。
# Verbosity=1情况下成功是 .，失败是 F，出错是 E，跳过是 S
# 测试的执行跟方法的顺序没有关系, 默认按字母顺序
# 每个测试方法均以 test 开头
# Verbosity=2情况下会打印测试的注释

# 5、Test Suite
# 一般通过addTest()或者addTests()向suite中添加。case的执行顺序与添加到Suite中的顺序是一致的
# @unittest.skip()装饰器跳过某个case

# （1）skip():无条件跳过
#      @unittest.skip("i don't want to run this case. ")

# （2）skipIf(condition,reason):如果condition为true，则 skip
#      @unittest.skipIf(condition,reason)

# （3）skipUnless(condition,reason):如果condition为False,则skip
#      @unittest.skipUnless(condition,reason)

# 6、Test Loder
# TestLoadder用来加载TestCase到TestSuite中。
# loadTestsFrom*()方法从各个地方寻找testcase，创建实例，然后addTestSuite，再返回一个TestSuite实例
# defaultTestLoader() 与 TestLoader()功能差不多，复用原有实例
# unittest.TestLoader().loadTestsFromTestCase(testCaseClass)
# unittest.TestLoader().loadTestsFromModule(module)
# unittest.TestLoader().loadTestsFromName(name,module=None)
# unittest.TestLoader().loadTestsFromNames(names,module=None)
# unittest.TestLoader().discover()

# 7、Testing Report
# pip install HTMLReport
# 终端报告： 如上terminal 分支
# TXT报告： 如上txt 分支，当前目录会生成ut_log.txt文件
# HTML 报告：如上html 分支，终端上打印运行信息同时会在当前目录生成report文件夹， 文件夹下有test.html和test.log文件 更多见Python 单元测试 - HTML report

import HTMLReport
import unittest

def add(a, b):
    return a + b


def minus(a, b):
    return a - b


class TestDemo(unittest.TestCase):
    """Test mathfuc.py"""

    @classmethod
    def setUpClass(cls):
        print("this setupclass() method only called once.\n")

    @classmethod
    def tearDownClass(cls):
        print("this teardownclass() method only called once too.\n")

    def setUp(self):
        print("do something before test : prepare environment.\n")

    def tearDown(self):
        print("do something after test : clean up.\n")

    def test_add(self):
        """Test method add(a, b)"""
        self.assertEqual(3, add(1, 2))
        self.assertNotEqual(3, add(2, 2))

    def test_minus(self):
        """Test method minus(a, b)"""
        self.assertEqual(1, minus(3, 2))
        self.assertNotEqual(1, minus(3, 2))

    @unittest.skip("do't run as not ready")
    def test_minus_with_skip(self):
        """Test method minus(a, b)"""
        self.assertEqual(1, minus(3, 2))
        self.assertNotEqual(1, minus(3, 2))


if __name__ == '__main__':
    # verbosity=*：默认是1；设为0，则不输出每一个用例的执行结果；2-输出详细的执行结果
    # unittest.main(verbosity=1)
    # 测试套件
    suite = unittest.TestSuite()
    # 测试用例加载器
    loader = unittest.TestLoader()
    # 把测试用例加载到测试套件中
    suite.addTests(loader.loadTestsFromTestCase(TestDemo))
    # 测试用例执行器
    runner = HTMLReport.TestRunner(report_file_name='test',  # 报告文件名，如果未赋值，将采用“test+时间戳”
                                   output_path='report',  # 保存文件夹名，默认“report”
                                   title='测试报告',  # 报告标题，默认“测试报告”
                                   description='无测试描述',  # 报告描述，默认“测试描述”
                                   thread_count=1,  # 并发线程数量（无序执行测试），默认数量 1
                                   thread_start_wait=3,  # 各线程启动延迟，默认 0 s
                                   sequential_execution=False,  # 是否按照套件添加(addTests)顺序执行，
                                   # 会等待一个addTests执行完成，再执行下一个，默认 False
                                   # 如果用例中存在 tearDownClass ，建议设置为True，
                                   # 否则 tearDownClass 将会在所有用例线程执行完后才会执行。
                                   # lang='en'
                                   lang='cn'  # 支持中文与英文，默认中文
                                   )
    # 执行测试用例套件
    runner.run(suite)
