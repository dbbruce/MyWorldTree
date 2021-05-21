1、使用触发器可以定制用户对表的【增，删，改】操作时前后的行为，注意没有【查询】
    所以可以说MySQL创建以下六种触发器：
    BEFORE INSERT - 在将数据插入表格之前激活。
    AFTER INSERT - 将数据插入表格后激活。
    BEFORE UPDATE - 在更新表中的数据之前激活。
    AFTER UPDATE - 更新表中的数据后激活。
    BEFORE DELETE - 在从表中删除数据之前激活。
    AFTER DELETE - 从表中删除数据后激活。

2、要查看当前数据库中的所有触发器
    SHOW TRIGGERS;

3、创建trigger
    DELIMITER $$
    CREATE TRIGGER before_employee_update2
        BEFORE UPDATE ON employees
        FOR EACH ROW
    BEGIN
        INSERT INTO employees_audit
        SET action = 'update',
        employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW();
    END $$
    DELIMITER ;

4、删除触发器
    DROP TRIGGER table_name.trigger_name;

