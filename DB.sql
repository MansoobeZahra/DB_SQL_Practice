--create database sesional2
use sesional2
CREATE TABLE CUSTOMER_T (
    CUSTOMER_ID     INTEGER PRIMARY KEY,
    CUSTOMER_NAME   VARCHAR(50) NOT NULL,
    CUSTOMER_ADDRESS VARCHAR(100),
    CUSTOMER_CITY   VARCHAR(30),
    CUSTOMER_STATE  CHAR(2),
    POSTAL_CODE     VARCHAR(10)
);

INSERT INTO CUSTOMER_T VALUES (1, 'Contemporary Casuals', '1444 S Hines Blvd', 'Gainesville', 'FL', '32601-2015');
INSERT INTO CUSTOMER_T VALUES (3, 'Home Furnishings', '1900 Allard Ave', 'Albany', 'NY', '12208-3125');
INSERT INTO CUSTOMER_T VALUES (4, 'Eastern Furniture', '1925 Bettine Rd', 'Carteret', 'NJ', '07008-3188');
INSERT INTO CUSTOMER_T VALUES (5, 'Impressions', '5585 Westcott Ct', 'Sacramento', 'CA', '94206-4056');
INSERT INTO CUSTOMER_T VALUES (6, 'Furniture Gallery', '325 Flatiron Dr', 'Boulder', 'CO', '80514-4432');
INSERT INTO CUSTOMER_T VALUES (7, 'Period Furniture', '394 Rainbow Dr', 'Seattle', 'WA', '97954-3589');
INSERT INTO CUSTOMER_T VALUES (8, 'California Classics', '816 Peach Rd', 'Santa Clara', 'CA', '96915-7754');
INSERT INTO CUSTOMER_T VALUES (9, 'M and H Casual Furniture', '3709 First Street', 'Clearwater', 'FL', '34620-2314');
INSERT INTO CUSTOMER_T VALUES (10, 'Seminole Interiors', '2400 Rocky Point Dr', 'Seminole', 'FL', '34646-4423');
INSERT INTO CUSTOMER_T VALUES (11, 'American Euro Lifestyles', '2424 Missouri Ave N', 'Prospect Park', 'NJ', '07508-5621');
INSERT INTO CUSTOMER_T VALUES (12, 'Battle Creek Furniture', '345 Capitol Ave SW', 'Battle Creek', 'MI', '49015-5601');
INSERT INTO CUSTOMER_T VALUES (13, 'Heritage Furnishings', '66789 College Ave', 'Carlisle', 'PA', '17013-6834');
INSERT INTO CUSTOMER_T VALUES (14, 'Kaneohe Homes', '112 Kiowai St', 'Kaneohe', 'HI', '96744-2537');
INSERT INTO CUSTOMER_T VALUES (15, 'Mountain Scenes', '4132 Main Street', 'Ogden', 'UT', '84401-4432');


CREATE TABLE PRODUCT_T (
    PRODUCT_ID          INTEGER PRIMARY KEY,
    PRODUCT_LINE_ID     INTEGER,
    PRODUCT_DESCRIPTION VARCHAR(50) NOT NULL,
    PRODUCT_FINISH      VARCHAR(20),
    STANDARD_PRICE      NUMERIC(8, 2)
);

INSERT INTO PRODUCT_T VALUES (1, 1, 'End Table', 'Cherry', 175.00);
INSERT INTO PRODUCT_T VALUES (2, 1, 'Coffee Table', 'Natural Ash', 200.00);
INSERT INTO PRODUCT_T VALUES (3, 2, 'Computer Desk', 'Natural Ash', 375.00);
INSERT INTO PRODUCT_T VALUES (4, 3, 'Entertainment Center', 'Natural Maple', 650.00);
INSERT INTO PRODUCT_T VALUES (5, 1, 'Writers Desk', 'Cherry', 325.00);
INSERT INTO PRODUCT_T VALUES (6, 2, '8-Drawer Desk', 'White Ash', 750.00);
INSERT INTO PRODUCT_T VALUES (7, 2, 'Dining Table', 'Natural Ash', 800.00);
INSERT INTO PRODUCT_T VALUES (8, 3, 'Computer Desk', 'Walnut', 250.00);


CREATE TABLE ORDER_T (
    ORDER_ID    INTEGER PRIMARY KEY,
    CUSTOMER_ID INTEGER REFERENCES CUSTOMER_T(CUSTOMER_ID),
    ORDER_DATE  DATE
);

INSERT INTO ORDER_T VALUES (1001, 1, '2008-10-21');
INSERT INTO ORDER_T VALUES (1002, 8, '2008-10-21');
INSERT INTO ORDER_T VALUES (1003, 15, '2008-10-22');
INSERT INTO ORDER_T VALUES (1004, 5, '2008-10-22');
INSERT INTO ORDER_T VALUES (1005, 3, '2008-10-24');
INSERT INTO ORDER_T VALUES (1007, 11, '2008-10-27');
INSERT INTO ORDER_T VALUES (1008, 12, '2008-10-30');
INSERT INTO ORDER_T VALUES (1009, 4, '2008-11-05');
INSERT INTO ORDER_T VALUES (1010, 1, '2008-11-05');

-- This query directly addresses the "Write SQL code to create ORDER_LINE_T?" question.
CREATE TABLE ORDER_LINE_T (
    ORDER_ID        INTEGER REFERENCES ORDER_T(ORDER_ID),
    PRODUCT_ID      INTEGER REFERENCES PRODUCT_T(PRODUCT_ID),
    ORDERED_QUANTITY INTEGER,
    PRIMARY KEY (ORDER_ID, PRODUCT_ID)
);

INSERT INTO ORDER_LINE_T VALUES (1001, 1, 2);
INSERT INTO ORDER_LINE_T VALUES (1001, 2, 2);
INSERT INTO ORDER_LINE_T VALUES (1001, 4, 1);
INSERT INTO ORDER_LINE_T VALUES (1002, 1, 5);
INSERT INTO ORDER_LINE_T VALUES (1003, 3, 3);
INSERT INTO ORDER_LINE_T VALUES (1003, 5, 2);
INSERT INTO ORDER_LINE_T VALUES (1004, 6, 2);
INSERT INTO ORDER_LINE_T VALUES (1004, 8, 1);
INSERT INTO ORDER_LINE_T VALUES (1005, 4, 3);
INSERT INTO ORDER_LINE_T VALUES (1005, 1, 3);
INSERT INTO ORDER_LINE_T VALUES (1007, 2, 2);
INSERT INTO ORDER_LINE_T VALUES (1007, 3, 3);
INSERT INTO ORDER_LINE_T VALUES (1008, 3, 3);
INSERT INTO ORDER_LINE_T VALUES (1008, 8, 2);
INSERT INTO ORDER_LINE_T VALUES (1009, 4, 2);
INSERT INTO ORDER_LINE_T VALUES (1009, 7, 3);
INSERT INTO ORDER_LINE_T VALUES (1010, 8, 10);


select * from CUSTOMER_T
select * from PRODUCT_T
select * from ORDER_LINE_T
select * from ORDER_T
select * from PRODUCT_T

=============================================================================================================================================
                						PRACTICE
=============================================================================================================================================
1. Write an SQL query to display order id , customer id  order date and items ordered for order id 1001. 

SELECT *
FROM ORDER_T O
JOIN ORDER_LINE_T OL ON O.ORDER_ID=OL.ORDER_ID
JOIN PRODUCT_T P ON OL.PRODUCT_ID=P.PRODUCT_ID
WHERE O.ORDER_ID = 1001



SELECT O.ORDER_ID, O.CUSTOMER_ID, O.ORDER_DATE, P.PRODUCT_DESCRIPTION
FROM ORDER_T O
JOIN ORDER_LINE_T OL ON O.ORDER_ID=OL.ORDER_ID
JOIN PRODUCT_T P ON OL.PRODUCT_ID=P.PRODUCT_ID
WHERE O.ORDER_ID = 1001
---------------------------------------------------------------------------------------------------------------------------------------------
2. Write SQL query to find the cost of highest valued order placed by customer having id =1. 

SELECT MAX(TOTAL_COST) AS MAXIMUM_COST FROM
(
 SELECT SUM(PRODUCT_T.STANDARD_PRICE*ORDER_LINE_T.ORDERED_QUANTITY) AS TOTAL_COST 
 FROM ORDER_T
 JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID=ORDER_LINE_T.ORDER_ID
 JOIN PRODUCT_T ON PRODUCT_T.PRODUCT_ID=ORDER_LINE_T.PRODUCT_ID

 WHERE ORDER_T.CUSTOMER_ID=1
 GROUP BY ORDER_LINE_T.ORDER_ID
)

---------------------------------------------------------------------------------------------------------------------------------------------
3. Write SQL query to display the customers who have ordered product with ids 3 and 4. 

SELECT CUSTOMER_NAME FROM CUSTOMER_T
WHERE CUSTOMER_ID IN
(
 SELECT CUSTOMER_ID FROM ORDER_T
 WHERE ORDER_ID IN
 (
  SELECT ORDER_ID FROM ORDER_LINE_T
  WHERE PRODUCT_ID IN (2,3)
 ) 
)

METHOD 2:
SELECT CUSTOMER_T.CUSTOMER_ID, PRODUCT_T.PRODUCT_ID, CUSTOMER_T.CUSTOMER_NAME 
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID = ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_LINE_T.ORDER_ID = ORDER_T.ORDER_ID
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID = PRODUCT_T.PRODUCT_ID

WHERE PRODUCT_T.PRODUCT_ID IN (3,4)


---------------------------------------------------------------------------------------------------------------------------------------------
4. Create a trigger on product table that records the user along with insertion details if the user inserts any product with standard price greater than 850. 


CREATE TABLE HIGHER_PRICE_DETAILS
(
 PRODUCT_ID             NUMBER       NOT NULL,
 PRODUCT_LINE_ID        NUMBER,
 PRODUCT_DESCRIPTION    VARCHAR2(50),
 PRODUCT_FINISH         VARCHAR2(20),
 STANDARD_PRICE         NUMBER,
 INSERT_TIME            TIMESTAMP,

 PRIMARY KEY(PRODUCT_ID,STANDARD_PRICE,INSERT_TIME)
)

CREATE OR REPLACE TRIGGER HIGH_PRICE_TRIG
BEFORE INSERT ON PRODUCT_T
FOR EACH ROW
WHEN (new.STANDARD_PRICE>850)
BEGIN
     INSERT INTO HIGHER_PRICE_DETAILS VALUES(:new.PRODUCT_ID, :new.PRODUCT_LINE_ID, :new.PRODUCT_DESCRIPTION, :new.PRODUCT_FINISH, :new.STANDARD_PRICE, SYSTIMESTAMP);
END;

---------------------------------------------------------------------------------------------------------------------------------------------
5. Create a view having order IDs, product ids, product description having standard price greater than 250

CREATE OR REPLACE VIEW TESTVU1 AS
SELECT ORDER_LINE_T.ORDER_ID, PRODUCT_T.PRODUCT_ID, PRODUCT_T.PRODUCT_DESCRIPTION
FROM ORDER_LINE_T 
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID=PRODUCT_T.PRODUCT_ID
WHERE PRODUCT_T.STANDARD_PRICE > 250

---------------------------------------------------------------------------------------------------------------------------------------------
6. What are the standard price and standard price if increased by 10 percent for every product?

SELECT STANDARD_PRICE, (STANDARD_PRICE+(STANDARD_PRICE*0.1)) AS INCREASED_PRICE
FROM PRODUCT_T

---------------------------------------------------------------------------------------------------------------------------------------------
7. Write SQL query to increase the salary of IT_PROG s by 10 % each?

UPDATE EMPLOYEES
SET SALARY = SALARY + ( 0.1 * SALARY)
WHERE JOB_ID = 'IT_PROG'

---------------------------------------------------------------------------------------------------------------------------------------------
8. Write SQL query to set the standard price of Dining Table equal to 3 times the average price of all products.

UPDATE PRODUCT_T
SET STANDARD_PRICE = 3 * (SELECT AVG(STANDARD_PRICE) FROM PRODUCT_T)
WHERE PRODUCT_DESCRIPTION='Dining Table'

---------------------------------------------------------------------------------------------------------------------------------------------
9. Write SQL query to Show customer names along with their ordered product names who live in 'CA' ?

SELECT CUSTOMER_T.CUSTOMER_NAME, PRODUCT_T.PRODUCT_DESCRIPTION 
FROM CUSTOMER_T 
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID=ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID=ORDER_LINE_T.ORDER_ID
JOIN PRODUCT_T ON PRODUCT_T.PRODUCT_ID=ORDER_LINE_T.PRODUCT_ID

WHERE CUSTOMER_T.CUSTOMER_STATE='CA'

---------------------------------------------------------------------------------------------------------------------------------------------
10. Create a trigger  that records all the entries that are deleted from product_line_T along with timestamp?



---------------------------------------------------------------------------------------------------------------------------------------------
11. Write an sql query to find the names of those customer and product_description for which customers have placed order of any product of quantity greater than 4 at a time.

SELECT CUSTOMER_T.CUSTOMER_NAME, PRODUCT_T.PRODUCT_DESCRIPTION  
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID=ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID=ORDER_LINE_T.ORDER_ID
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID=PRODUCT_T.PRODUCT_ID

WHERE ORDERED_QUANTITY > 4

---------------------------------------------------------------------------------------------------------------------------------------------
Q-Find product price and description of all products having 'White Ash' finish and having price lower than average price of products never ordered.


SELECT PRODUCT_DESCRIPTION, STANDARD_PRICE
FROM PRODUCT_T 
WHERE PRODUCT_FINISH = 'White Ash'
AND STANDARD_PRICE <
(
SELECT AVG(STANDARD_PRICE)
FROM PRODUCT_T 
WHERE PRODUCT_T.PRODUCT_ID NOT IN 
  ( SELECT PRODUCT_T.PRODUCT_ID 
    FROM PRODUCT_T 
    JOIN ORDER_LINE_T ON PRODUCT_T.PRODUCT_ID = ORDER_LINE_T.PRODUCT_ID
  )
)

=============================================================================================================================================
						    		QUIZZES
=============================================================================================================================================

12-Find product price and description of all products having 'white' finish and having price lower than average price of products never ordered.

SELECT STANDARD_PRICE, PRODUCT_DESCRIPTION
FROM PRODUCT_T
WHERE PRODUCT_FINISH LIKE 'White%'
AND STANDARD_PRICE < (SELECT AVG(STANDARD_PRICE) FROM PRODUCT_T)
AND PRODUCT_T.PRODUCT_ID NOT IN (SELECT ORDER_LINE_T.PRODUCT_ID FROM ORDER_LINE_T)


---------------------------------------------------------------------------------------------------------------------------------------------
13-Find total cost of each order.

SELECT SUM(STANDARD_PRICE * ORDERED_QUANTITY) AS TOTAL_ORDER_COST, ORDER_T.ORDER_ID
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID = ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID = ORDER_LINE_T.ORDER_ID
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID = PRODUCT_T.PRODUCT_ID
GROUP BY ORDER_T.ORDER_ID

---------------------------------------------------------------------------------------------------------------------------------------------

14-Find the most expensive order
SELECT * FROM
( 
SELECT SUM(STANDARD_PRICE * ORDERED_QUANTITY) AS TOTAL_ORDER_COST, ORDER_T.ORDER_ID
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID = ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID = ORDER_LINE_T.ORDER_ID
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID = PRODUCT_T.PRODUCT_ID
GROUP BY ORDER_T.ORDER_ID
ORDER BY TOTAL_ORDER_COST DESC
)
WHERE ROWNUM = 1;

---------------------------------------------------------------------------------------------------------------------------------------------
15- Find the customer who has ordered the most expensive product.

SELECT * FROM
( 
SELECT CUSTOMER_T.CUSTOMER_ID, CUSTOMER_T.CUSTOMER_NAME, PRODUCT_T.PRODUCT_DESCRIPTION, PRODUCT_T.PRODUCT_ID, PRODUCT_T.STANDARD_PRICE
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID = ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID = ORDER_LINE_T.ORDER_ID
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID = PRODUCT_T.PRODUCT_ID
ORDER BY STANDARD_PRICE DESC
)
WHERE ROWNUM = 1


---------------------------------------------------------------------------------------------------------------------------------------------
16- Find the city with the customers having the highest buying power.

SELECT * FROM
(SELECT SUM (ORDERED_QUANTITY * STANDARD_PRICE) AS TOTAL_COST, CUSTOMER_STATE
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID = ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID = ORDER_LINE_T.ORDER_ID
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID = PRODUCT_T.PRODUCT_ID
GROUP BY CUSTOMER_STATE
ORDER BY TOTAL_COST DESC
)
WHERE ROWNUM = 1


=============================================================================================================================================
								SESSIONALS
=============================================================================================================================================

1- FIND NAMES OF CUSTOMERS WHO DO NOT LIVE IN FL, NJ, MI AND HAVE NEVER ORDERED ANY PRODUCT

SELECT CUSTOMER_NAME,CUSTOMER_T.CUSTOMER_ID
FROM CUSTOMER_T 
WHERE CUSTOMER_STATE NOT IN ('FL','NJ','MI')
AND CUSTOMER_T.CUSTOMER_ID NOT IN
(SELECT CUSTOMER_T.CUSTOMER_ID
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID = ORDER_T.CUSTOMER_ID
)
---------------------------------------------------------------------------------------------------------------------------------------------
2-Find product price and description of all products having 'Ash' finish and having price lower than average price of products, never ordered.

SELECT STANDARD_PRICE, PRODUCT_DESCRIPTION
FROM PRODUCT_T
WHERE PRODUCT_FINISH LIKE 'Ash%'
AND STANDARD_PRICE < (SELECT AVG(STANDARD_PRICE) FROM PRODUCT_T)
AND PRODUCT_T.PRODUCT_ID NOT IN (SELECT ORDER_LINE_T.PRODUCT_ID FROM ORDER_LINE_T)
---------------------------------------------------------------------------------------------------------------------------------------------
3-FIND THE MOST EXPENSIVE ORDER PLACED BY CUSTOMERS WHO LIVE IN FL.

SELECT * FROM 
(
SELECT SUM(STANDARD_PRICE * ORDERED_QUANTITY) AS TOTAL_ORDER_COST, ORDER_T.ORDER_ID
FROM CUSTOMER_T
JOIN ORDER_T ON CUSTOMER_T.CUSTOMER_ID = ORDER_T.CUSTOMER_ID
JOIN ORDER_LINE_T ON ORDER_T.ORDER_ID = ORDER_LINE_T.ORDER_ID
JOIN PRODUCT_T ON ORDER_LINE_T.PRODUCT_ID = PRODUCT_T.PRODUCT_ID
WHERE CUSTOMER_STATE = 'FL'
GROUP BY ORDER_T.ORDER_ID
ORDER BY TOTAL_ORDER_COST DESC
)
WHERE ROWNUM = 1 ;
---------------------------------------------------------------------------------------------------------------------------------------------


