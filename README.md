# Logistic Company's Data Analysis - MySQL

  This project involves analyzing the operational data of a logistics company to gain actionable insights. The analysis leverages MySQL for querying and managing the dataset, focusing on key performance indicators such as delivery times, shipping costs, and customer satisfaction rates.

# ABSTRACT: 
 
  Logistics is the support function of an organization and it means having the right object, at the right place, in the right time. Logistics deals with various kinds of methods to control the flow of resources from one place to another. One of the major and the most important factors that is costing is being dealt with utmost attention. The project is being designed keeping in mind the details of the various requirements of logistics such as keeping records of the goods; i.e. their details and the kind of content that is stored in the shipment which is to be delivered. 
  A Relational Database Management System (RDBMS) is similar to DBMS. The difference is that in RDBMS, the entities and values in tables are related to one another. Also the tables are related to each other. Thus, it is called “Relational”. 

# Objectives:

* Identify trends and patterns in logistics operations.

* Evaluate the efficiency of delivery routes and methods.

* Provide data-driven recommendations to improve service quality.

# PROBLEM DESCRIPTION:

  The logistics company provides services in both the international and domestic sectors. The logistics management takes into consideration every facility that has an impact on cost. It plays an important role in making the product confirm to customer requirements. Also, it involves efficient integration of suppliers, manufacturers, Import & export and other activities at many levels; from the strategic level through the tactical to the operational level. 
  Customers can send different types of shipping contents. Payment is to be done at the same time the product is delivered to the client. Delivery boy and centre head can update the status of the shipment. Create a database schema and table relationships that can be used in any technology. 

# SCOPE:
 
  It is of critical importance to the organization how it delivers products & services to the customer, whether the product is tangible or intangible. Effective and efficient physical movement of the tangible product will speak of intangible services associated with the product and the organization which is delivering it. 
  In case of intangible products, the delivery of tangibles at the right place & right time will speak about its quality. On the macro level infrastructure such as various modes of transport, transportation equipment, storage facilities, connectivity and information processing are contributing to a large extent in the physical movement of goods produced in manufacturing, mining and agriculture Sectors.
  This speed and reliability in distribution of products and services contribute to a great extent in the growth of a country’s domestic and international trade. 

# TABLE DEFINITIONS:

1)	**Employee_Details Table**: 
  This table contains the information of the employees. 

 2) **Membership Table**: 
  This table contains the membership details of the customer or client. 
 
 3)	**Customer Table**: 
    This table contains the information of the customers or clients. 
 
 4)	**Payment_Details Table**: 
    This table contains the payment details.
     
 5)	**Shipment_Details Table**: 
    This table contains the shipment details.
     
 6)	**Status table**: 
    This table contains the details about the delivery status. 
     
 7)	**Employee Manages Shipment Table**: 
    This is a relationship table between the employee and the shipment table.

# Approach:

  1.**Data Import**: Load the CSV files into MySQL using the Import Table Wizard.
  
  2.**Data Cleaning**: Ensure no null values are present and correct any inconsistencies.
  
  3.**Column Renaming**: Rename columns for clarity and consistency.
  
  4.**Data Typing**: Convert columns to appropriate data types for analysis.

# Questions Solved in This SQL File:

1) Find the incorrect dates in the 'STATUS' table from the 'DELIVERY DATE' column, where the month is greater than 12 ?

2) Search for the records where the month is February but the date is incorrectly entered as 30 and 31 ?

3) Extract all the employees whose name starts with A and ends with A ?

4) Find all the common names from Employee_Details names and Customer names ?

5) Create a view 'PaymentNotDone' of those customers who have not paid the amount ?

6) Find the frequency (in percentage) of each of the class of the payment mode ?

7) Create a new column 'Total_Payable_Charges' using shipping cost and price of the product ?

8) What is the highest total payable amount ?

9) Extract the customer id and the customer name  of the customers who were or will be the member of the branch for more than 10 years ?

10) Who got the product delivered on the next day the product was sent ?

11) Which shipping content had the highest total amount (Top 5) ?

12) Which product categories from shipment content are transferred more ?

13) Create a new view 'TXLogistics' where employee branch is Texas ?

14) Texas(TX) branch is giving 5% discount on total payable amount. Create a new column 'New_Price' for payable price after applying discount ?

15) Drop the view TXLogistics ?

16) The employee branch in New York (NY) is shutdown temporarily. Thus, the the branch needs to be replaced to New Jersy (NJ) ?

17) Finding the unique designations of the employees ?

18) We will see the frequency of each customer type (in percentage) ?

19) Rename the column SER_TYPE to SERVICE_TYPE ?

20) Which service type is preferred more ?

21) Find the shipment id and shipment content where the weight is greater than the average weight ?

# Key Features:
  
**Comprehensive Data Queries**: Use of advanced SQL queries for data extraction and processing.
  
**Performance Metrics Analysis**: Examination of critical metrics like delivery success rates and average transit times.

**Visualization-Ready Outputs**: Data formatted for easy integration with visualization tools.

# Tools and Technologies:
 
 * MySQL

 * Data cleaning and preprocessing techniques

 * Integration with visualization platforms for reporting

 
 # CONCLUSION :
 
The rise in the demand of transportation of shipment from one place to another and due to development of better transportation facilities all around the globe, logistics has taken a vital position in business processes all around the world. The increase in the amount of transfer of contents has also contributed to the development of logistics this rapidly. 
 
Due to all these factors it became necessary to keep track of all whereabouts of the shipments. Logistics system not only helps us to keep track of them but also provides us with better solutions and helps us to get maximum utilization of the available resources. Keeping track of any shipment and knowing its current status becomes easy. 

# Getting Started: 
  To replicate this analysis or build on it, follow these steps:
  
  1.Clone the repository:
  
      git clone https://github.com/Gtshivanand/Logistic Company's Data Analysis - MySQL.git
  
  2.Import the Dataset into MySQL:
  
  Import the nifty_data.csv file into your MySQL database.
  
  Use the provided nifty_data.
  
  sql script to create the necessary table and load the data.
  
  3.Run SQL Queries:
  
  You can run the SQL queries provided in the queries/ directory or modify them to explore other aspects of the data.
  
  4.Perform Analysis:
  
  Use the queries and results to perform your analysis, explore trends, and test trading strategies.

 # Contact:

For any inquiries or suggestions, feel free to reach out:

- *Email:* [shivanandnashi97@gmail.com](mailto:shivanandnashi97@gmail.com)
- *LinkedIn:* [Shivanand Nashi](https://www.linkedin.com/in/shivanand-s-nashi-79579821a)


