-- @AUTHOR YEMANE HADIS  
-- @ABOUT https://yemanehadis.github.io/portfolio/
-- @LINKEDIN  https://www.linkedin.com/in/yemanehadis/
-- ASUME WE HAVE THE FOLLOWING DATABASE  
	-- SQL_STORE
		-- CUSTOMERS
        -- ORDER_ITEM_NOTES
        -- ORDER_ITEM
        -- ORDERS
        -- ORDER_STATUSES
        -- PRODUCTS
        -- SHIPPERS
	--  SQL_HR
		-- EMPLOYEES
        -- OFFICES
        
USE sql_store;
-- IN AND NOT IN OPRATOR 
select * FROM Customers where state NOT IN ('VA', 'FL', 'GA');
-- all custmer they have b  in the last name it may before or after 
select * FROM Customers where last_name LIKE '%b%';


-- IS NULL and IS NOT NULL
select * FROM customers WHERE phone IS NOT NULL;


-- ORDER BY

select * FROM customers order by state,first_name ;


-- Join Deafault inner join 

select order_id, orders.customer_id first_name, last_name From orders  Join customers ON orders.customer_id = customers.customer_id;


-- Aliace

select order_id, o.customer_id first_name, last_name From orders as o  Join customers as c ON o.customer_id = c.customer_id;

-- Self Join 
select e.employee_id,  e.first_name as Employee,m.first_name As manager From employees e JOIN employees m
	ON e.reports_to = m.employee_id;


-- Join accross database
select * FROM order_items oi Join sql_inventory.products p 
	ON oi.product_id = p.product_id;
    

-- Join more than two table 

SELECT *
 FROM orders o 
 JOIN customers c 
	on o.customer_id = c.customer_id 
 JOIN order_statuses os 
	ON o.status = os.order_status_id;

-- JOIN USING COMPOUND JOIN CONDTION
-- MOSTLY USED WITH COMPOSITE KEY
	-- EXAMPLE
	-- ORDER_ITEM MAY BE IDENTIFIED USING PRODUCT_ID AND ORDER_ID COMBINED
SELECT * 
FROM order_item oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;

-- OUTER JOIN 
	-- LEFT JOIN
		-- ALL THE RECORD FROM LEFT TABLE RETURN IRRESPECTIVE OF JOIN CONDTION 
    -- RIGHT JOIN 
		-- ALL THE RECORD FROM RIGHT TABLE RETURN IRRESPECTIVE OF JOIN CONDTION

-- USING  
	-- HELP US TO REMOVE THE JOIN CONDTION
    -- IF THE KEY REPRESENETED USING THE SAME NAME
    -- IN TWO OF THE TABLES
SELECT 
	o.order_id,
    c.frist_name
FROM orders o
JOIN customers c
	USING (customer_id)
JOIN shippers sh 
	USING(shipper_id);

-- USE OF USING FOR MULTIPLE KEY (COMPOSITE KEY)
SELECT * 
FROM order_items oi
JOIN order_item_notes oin

USING (order_id,product_id);


-- NATUTAL JOIN 
	-- WE DONOT SPECIFY THE JOIN KEY 
    -- SO, THE DATABASE ENGINE WILL LOOK AT TABLE
    -- JOIN THEM BASED COMMON COLUM 
SELECT 
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c;


-- UNION OPRATOR 
	-- WE USE IT TO COMBINE MULTIPLE QUERIES 
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
 union
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';


-- DML
-- INSERT
-- DEFAULT MAKE THE CUSTOMER TABLE 
-- TO GENERATE KEY  

INSERT INTO customers VALUES (DEFAULT,'FRISTNAME','LASTNAME');


-- CREATING A COPY OF A TABLE  
-- SELECT STATMENT IN THE BELOW TABLE CALLED SUB-QUERIES
-- WE CAN ALSO USE IT TO INSERT TO TABLE 
-- AS WE CAN SEE FROM THE SECOND QUERIES

-- FIRST EXAMPLE
CREATE TABLE orders_archive AS 
	SELECT * FROM orders;
-- SECOND EXAMPLE
INSERT INTO  orders_archive ()
	SELECT * FROM orders;
    
-- UPDATE 
-- Example1 - ONLY UPDATE ONE ROW
UPDATE invoices 
set payment_total = 10
where invoice_id = 1;

-- Example2 - UPDATE MULTIPLE ROW
-- 10000 ROW AFFECTED ):
-- BUT WHEN YOU WORK WITH MYSQL WORK BENCH IT HAS SAFE UPDATE 
-- ON BY DEFAULT SO IT CAN SAVE US FROM UPDATING ALL THE DATA
UPDATE invoices 
set payment_total = 10




-- GRANT 
-- SQL GRANT USED TO PROVIDE PRIVILEGE TO DATABASE OBJECTS FOR A USER
-- SYNTAX
grant privilege_name on object_name
to {user_name | public | role_name} 
-- EXAMPLE 
grant insert, 
select on accounts to Ram

-- REVOKE 
-- WITHDRAW USER PRIVILEGES ON DATABASE OBJECT IF ANY GRANTED.
--SYNTAX
revoke privilege_name on object_name
from {user_name | public | role_name}
-- EXAMPLE 
grant insert, 
select on accounts to Ram


-- TCL - TRANSACTION CONTROL LANGUAGES 
	-- USED FOR MANAGING AND CONTROLLING THE TRANSACTIONS IN A DATABASE TO MAINTAIN 
	-- CONSISTENCY  

	-- COMMIT
		-- HELPS USER TO SAVE A GIVEN TRANSACTION INTO THE DB PERMANENTLY

	-- ROLLBACK 
		-- IF, DUE TO SOME RESON COMMITED DATA IS INCORRECT WE CAN USE ROLL BACK TO
		-- REVERSE CHANGE 

	-- SAVEPOINT 
		-- COMMAND HELPS IN SAVING A TRANSACTION TEMPORARILY SO THE USER CAN ROLLBACK



    


 


	

