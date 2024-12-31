CREATE SCHEMA Logistics;	

USE Logistics;	

SELECT * FROM Employee_Details;

SELECT * FROM Membership;

SELECT * FROM Customer;

SELECT * FROM Payment_Details;

SELECT * FROM Shipment_Details;

SELECT * FROM  status;

# 1) Find the incorrect dates in the 'STATUS' table from the 'DELIVERY DATE' column, where the month is greater than 12.

SELECT * FROM STATUS
WHERE CAST(SUBSTRING(DELIVERY_DATE, 6, 2) AS UNSIGNED) > 12;

# 2) Search for the records where the month is February but the date is incorrectly entered as 30 and 31.
SELECT * FROM STATUS 
	WHERE CAST(substring_index(DELIVERY_DATE, '/', 1) AS UNSIGNED) = 2 
		AND 
	CAST(substring_index(substring_index(DELIVERY_DATE, '/', 2), '/', -1) AS UNSIGNED)  > 29;
SELECT * FROM STATUS 
	WHERE CAST(substring_index(SENT_DATE, '/', 1) AS UNSIGNED) = 2 
		AND 
	CAST(substring_index(substring_index(SENT_DATE, '/', 2), '/', -1) AS UNSIGNED)  > 29;
SELECT * FROM Payment_Details
	WHERE CAST(substring_index(substring_index(PAYMENT_DATE, '-', 2), '-', -1) AS UNSIGNED) = 2 
		AND 
    CAST(substring_index(PAYMENT_DATE, '-', -1) AS UNSIGNED) > 29;
    

-- -----------------------------------------------------
-- Converting the string in to a date format
-- -----------------------------------------------------
UPDATE Payment_Details
	SET Payment_Date = STR_TO_DATE(Payment_Date,'%Y-%m-%d');    
UPDATE STATUS
	SET Delivery_Date = STR_TO_DATE(Delivery_Date,'%m/%d/%Y'),
    Sent_Date = STR_TO_DATE(Sent_Date,'%m/%d/%Y');
UPDATE MEMBERSHIP
	SET Start_Date = STR_TO_DATE(Start_Date,'%Y-%m-%d'),
    End_Date = STR_TO_DATE(End_Date,'%Y-%m-%d');



-- -----------------------------------------------------
-- Changing the datatype from TEXT to DATE
-- -----------------------------------------------------
ALTER TABLE Payment_Details
	MODIFY COLUMN Payment_Date Date;
ALTER TABLE STATUS
	MODIFY COLUMN Delivery_Date Date, MODIFY COLUMN Sent_Date Date ;
ALTER TABLE MEMBERSHIP
	MODIFY COLUMN Start_Date Date, MODIFY COLUMN End_Date Date ;



-- -----------------------------------------------------
-- Creating a Single Source Of Truth (SSOT)
-- -----------------------------------------------------
CREATE TABLE logistics_Emp AS
SELECT 
	emp.Emp_ID, ship.SD_ID, Cust.Cust_ID, pmt.PAYMENT_ID, memb.M_ID,
    emp.Emp_NAME, emp.Emp_ADDR, emp.Emp_BRANCH, emp.Emp_DESIGNATION, emp.Emp_CONT_NO,
    ship.SD_DOMAIN, ship.SD_CONTENT, ship.SD_ADDR, ship.SD_ADDR, ship.SD_WEIGHT, ship.SD_TYPE, ship.SD_CHARGES,
    cust.Cust_NAME, cust.Cust_TYPE, cust.Cust_ADDR, cust.Cust_CONT_NO, cust.Cust_EMAIL_ID,
    stat.SENT_DATE, stat.DELIVERY_DATE, stat.CURRENT_ST, 
    pmt.AMOUNT, pmt.PAYMENT_STATUS, pmt.PAYMENT_DATE, pmt.PAYMENT_MODE,
    memb.Start_Date, memb.End_Date
    
FROM
    EMPLOYEE_Details AS emp
         INNER JOIN
	employee_manages_shipment AS ems ON emp.Emp_ID = ems.Employee_deatils_Emp_ID
         INNER JOIN
    SHIPMENT_Details AS ship ON ship.SH_ID = ems.Shipment_SH_ID
		 INNER JOIN
	CLIENT AS cust ON Cust.C_ID = ship.Customer_Cust_ID
		 INNER JOIN
	STATUS AS stat ON ship.SH_ID = stat.SH_ID
		 INNER JOIN
	PAYMENT AS pmt ON ship.SH_ID = pmt.Shipment_SH_ID
		 INNER JOIN
	MEMBERSHIP AS memb ON memb.M_ID = cust.Membership_M_ID
; 
select * from logistics_Emp;

# 3) Extract all the employees whose name starts with A and ends with A.
SELECT 
    Emp_name
FROM
    Employee_Deatils
WHERE
    Emp_name LIKE 'A%A';

# 4) Find all the common names from Employee_Details names and Customer names.
SELECT DISTINCT(Emp_name) FROM Employee_Details WHERE Emp_name IN (SELECT Cust_name FROM Customer AS cus);


# 5) Create a view 'PaymentNotDone' of those customers who have not paid the amount.
CREATE VIEW PaymentNotDone AS
SELECT * FROM logistics_Emp
WHERE PAYMENT_STATUS = 'NOT PAID';

-- Selecting all the observations of the newly created view 'PaymentNotDone'
SELECT * FROM PaymentNotDone;

# 6) Find the frequency (in percentage) of each of the class of the payment mode
SET @total_count = 0;
SELECT COUNT(*) INTO @total_count FROM Pyament_Deatils;
SELECT 
    PAYMENT_MODE,
    ROUND((COUNT(PAYMENT_MODE) / @total_count) * 100,2) 
		AS Percentage_Contribution
FROM
    Payment_Details
GROUP BY PAYMENT_MODE;

# 7) Create a new column 'Total_Payable_Charges' using shipping cost and price of the product.
ALTER TABLE logistics_Emp
	ADD COLUMN TOTAL_PAYABLE_CHARGES FLOAT AFTER AMOUNT;

UPDATE logistics_Emp 
	SET TOTAL_PAYABLE_CHARGES = SH_CHARGES + AMOUNT;
SELECT TOTAL_PAYABLE_CHARGES FROM logistics_Emp;

# 8) What is the highest total payable amount ?
SELECT MAX(TOTAL_PAYABLE_CHARGES) FROM logistics_Emp;


# 9) Extract the customer id and the customer name  of the customers who were or will be the member of the branch for more than 10 years
SELECT Cust_ID, Cust_NAME, START_DATE, END_DATE, ROUND(DATEDIFF(END_DATE, START_DATE)/365,0) 
	AS Membership_Years FROM logistics_Emp 
HAVING Membership_Years > 10;


# 10) Who got the product delivered on the next day the product was sent?
SELECT * FROM logistics_Emp 
	HAVING DELIVERY_DATE-SENT_DATE = 1;
SELECT * FROM logistics_Emp 
	HAVING DATEDIFF(DELIVERY_DATE, SENT_DATE)=1;

# 11) Which shipping content had the highest total amount (Top 5).
SELECT 
    SH_CONTENT, SUM(AMOUNT) AS Content_Wise_Amount
FROM
    logistics_Emp
GROUP BY (SH_CONTENT)
ORDER BY Content_Wise_Amount DESC
LIMIT 5;

# 12) Which product categories from shipment content are transferred more?  
SELECT SH_CONTENT, COUNT(SH_CONTENT) 
	AS Content_Wise_Count 
FROM logistics_Emp 
GROUP BY(SH_CONTENT) 
ORDER BY Content_Wise_Count DESC 
LIMIT 5;

# 13) Create a new view 'TXLogistics' where employee branch is Texas.
CREATE VIEW TXLogistics AS
	SELECT * FROM logistics_Emp 
		WHERE E_BRANCH = 'TX';

SELECT * FROM TXLogistics;


# 14) Texas(TX) branch is giving 5% discount on total payable amount. Create a new column 'New_Price' for payable price after applying discount.
ALTER VIEW TXLogistics
   AS SELECT *, AMOUNT - ((AMOUNT * 5)/100) AS New_Price 
   FROM logistics_Emp
   WHERE E_BRANCH = 'TX';
SELECT * FROM TXLogistics;
   
   
# 15) Drop the view TXLogistics
DROP VIEW TXLogistics;


# 16) The employee branch in New York (NY) is shutdown temporarily. Thus, the the branch needs to be replaced to New Jersy (NJ).
SELECT * FROM logistics_Emp WHERE E_BRANCH = 'NY';

UPDATE logistics_Emp
	SET E_BRANCH = 'NJ'
WHERE E_BRANCH = 'NY';

SELECT * FROM logistics_Emp;

# 17) Finding the unique designations of the employees.
SELECT DISTINCT(Emp_DESIGNATION) FROM Employee_Details;

# 18) We will see the frequency of each customer type (in percentage).
SET @total_count = 0;
SELECT COUNT(*) INTO @total_count FROM logistics_Emp;
SELECT Cust_TYPE, (COUNT(Cust_TYPE)/@total_count)*100 
	AS Contribution FROM logistics_Emp 
GROUP BY Cust_TYPE;

# 19) Rename the column SER_TYPE to SERVICE_TYPE.
ALTER TABLE logistics_Emp
CHANGE SER_TYPE SERVICE_TYPE VARCHAR (15);

# 20) Which service type is preferred more?
SELECT SERVICE_TYPE, COUNT(SERVICE_TYPE) 
	AS Frequency 
FROM logistics_Emp 
GROUP BY SERVICE_TYPE 
ORDER BY Frequency DESC;

# 21) Find the shipment id and shipment content where the weight is greater than the average weight.
SELECT SH_ID, SH_CONTENT, SH_WEIGHT FROM Shipment_Details
WHERE SH_WEIGHT > (SELECT AVG(SH_WEIGHT) FROM Shipment_Details);


