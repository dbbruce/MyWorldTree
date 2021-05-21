1、查看存储过程
    select name from mysql.proc;
    select name from mysql.proc where db='mysqldemo';

2、创建存储过程
    DELIMITER //
        create procedure GetAllProducts()
        BEGIN
        SELECT productCode, productName FROM products;
        END //
    DELIMITER ;

3、调用存储过程
    CALL stored_procedure_name();

4、声明变量
    declare x, y INT DEFAULT 0;

5、变量赋值
    declare total_count int default 0;
    set total_count = 10;

6、实例
    declare total_products int default 0;
    select
       count(*) into total_products
    from
       products;

7、MySQL存储过程参数示例
    DELIMITER //
        create procedure GetOfficeByCountry(IN countryName VARCHAR(255))
         BEGIN
         SELECT officeCode,city,phone
         FROM offices
         WHERE country = countryName;
         END //
    DELIMITER ;

    CALL GetOfficeByCountry('USA');

8、IN参数示例
    DELIMITER //
        create procedure GetOfficeByCountry(IN countryName VARCHAR(255))
         BEGIN
         SELECT officeCode,city,phone
         FROM offices
         WHERE country = countryName;
         END //
    DELIMITER ;
    CALL GetOfficeByCountry('USA');

9、OUT参数示例
    DELIMITER $$
        create procedure CountOrderByStatus(
         IN orderStatus VARCHAR(25),
         OUT total INT)
        BEGIN
         SELECT count(orderNumber)
         INTO total
         FROM orders
         WHERE status = orderStatus;
        END$$
    DELIMITER ;
    CALL CountOrderByStatus('Shipped',@total);
    SELECT @total;

10、INOUT参数示例
    DELIMITER $$
        create procedure set_counter(INOUT count INT(4),IN inc INT(4))
        BEGIN
         SET count = count + inc;
        END$$
    DELIMITER ;
    SET @counter = 1;
    CALL set_counter(@counter,1); -- 2
    CALL set_counter(@counter,1); -- 3
    CALL set_counter(@counter,5); -- 8
    SELECT @counter; -- 8

11、MySQL存储过程返回多个值的实例
    DELIMITER $$
    create procedure get_order_by_cust(
     IN cust_no INT,
     OUT shipped INT,
     OUT canceled INT,
     OUT resolved INT,
     OUT disputed INT)
    BEGIN
     -- shipped
     SELECT
                count(*) INTO shipped
            FROM
                orders
            WHERE
                customerNumber = cust_no
                    AND status = 'Shipped';
     -- canceled
     SELECT
                count(*) INTO canceled
            FROM
                orders
            WHERE
                customerNumber = cust_no
                    AND status = 'Canceled';
     -- resolved
     SELECT
                count(*) INTO resolved
            FROM
                orders
            WHERE
                customerNumber = cust_no
                    AND status = 'Resolved';
     -- disputed
     SELECT
                count(*) INTO disputed
            FROM
                orders
            WHERE
                customerNumber = cust_no
                    AND status = 'Disputed';
    END $$
    DELIMITER ;

    CALL get_order_by_cust(141,@shipped,@canceled,@resolved,@disputed);
    select @shipped,@canceled,@resolved,@disputed;

