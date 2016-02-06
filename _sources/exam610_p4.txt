.. _exam610-p4.rst:

#################################################
Exam 610 Part 4: Working with DB2 Data using SQL
#################################################

.. note::

        The following content is all about SQL

DB2 Syntax Diagram Conventions
******************************

Diagram captured from *Understanding DB2: Learning Visually with Examples (2nd Edition)*, page 27


Relational Algebra
******************

.. note::

        Content adapted from *Database Management Systems (3rd edition)*


- Creating example tables 




20% of the *DB2 10.1 Fundamentals*

Objectives
**********

- Ability to perform ``INSERT``, ``UPDATE``, and ``DELETE`` operations against a database
- Ability to retrieve and format data using various forms of the ``SELECT`` statement
- Ability to sort and group data retrieved by a ``SELECT`` statement
- Ability to query system-period, application-period, and bitemporal temporal (time travel) tables
- Ability to access Extensible Markup Language (XML) data using XQuery expressions and the built-in SQL/XML functions that are available with DB2
- Ability to create and invoke an SQL stored procedure or and SQL user-defined function (UDF)
- Knowledge of what transactions are, as well as how transactions are initiated and terminated

Structured Query Language
*************************

SQL statements can be categorized according to the function they have been designed to perform. Consequently, SQL statements typically fall under
one of the following categories:

	- **Embedded SQL Application Construct statements:** 
	
			Used for the sole purpose of constructing Embedded SQL applications
			
	- **Data Control Language (DCL) statements:**
	
			Used to grant and revoke authorities and privileges
			
	- **Data Definition Language (DDL) statements:**
	
			Used to create, alter, and delete database objects
			
	- **Data Manipulation Language (DML) statements:**
	
			Used to store data in, manipulate data in, retrieve data from, and remove data from select database objects
	
	- **Transaction Management statements:**
	
			Used to establish and terminate database connections and transactions 

.. note::

	**Embedded SQL Application Construct statements** is not required for exam 610.
	
SQL Data Manipulation Language (DML) Statements
***********************************************

Overview
========

DML statements are used exclusively to store, modify, and delete data, as well as to retrieve data from tables, views, or both.

Four DML statements are avialable:

	- ``INSERT``
	- ``UPDATE``
	- ``DELETE``
	- ``SELECT``
	
The INSERT Statement
====================

Adding data to tables, nicknames, or views

syntax
------

	.. code-block:: sql
	
		INSERT INTO [TableName | ViewName]
			<([ColumnName], ...)>
			VALUES ([value | NULL | DEFAULT], ...)
			
	or
	
	.. code-block:: sql
	
		INSERT INTO [TableName | ViewName]
			<([ColumnName], ...)>
			[SELECTStatement]

Example
-------

	.. _DEPARTMENT-table:
	
	DEPARTMENT table
	
	===========  =========
	Column Name  Data Type
	===========  =========
	DEPTNO       CHAR(3)
	DEPTNAME     CHAR(20)
	MGRID        INTEGER
	===========  =========
	
	*Data Stored in the DEPARTMENT table*
	
	======= ==============   =======
	DEPTNO  DEPTNAME         MGRID
	======= ==============   =======
	A01     ADMINISTRATION   1000
	B01     PLANNING         1001
	C01     DEVELOPMENT      1007
	D01     PERSONNEL        1008
	E01     OPERATIONS       (NULL)
	F01     SUPPORT          (NULL)
	======= ==============   =======
	
	.. code-block:: sql
	
		INSERT INTO department
			(deptno, deptname, mgrid)
			VALUES ('A01', 'ADMINISTRATION', 1000)
			
	.. highlights::
	
		- number of values provided in the VALUES clause must equal the number of column names identified in the column name list
		- the values provided will be assined to the specified columns in the order in which they appear
		- value supplied must be compatible with the data type of the column it is being assigned to
		
	If values are provided (using the VALUES clause) for every column found in the table, the column name list can be omitted.
	
	.. code-block:: sql
	
		INSERT INTO department
			VALUES ('A01', 'ADMINISTRATION', 1000)
			
	
	The INSERT statement with SELECT statement performs a type of cut-and-paste operation in which values are retrieved from one base table or
	view and copied to another.
	
	.. code-block:: sql
	
		INSERT INTO department (deptno, deptname)
			SELECT deptno, deptname FROM organization
			
	.. note::
	
		For such an INSERT statement to execute correctly, all columns in the table the record is being inserted into that *do not* appear
		in the column name list must either accept NULL values or have a defaults constraint associated with them. Otherwise, the INSERT statement
		will fail and an error will be generated.
		
The UPDATE Statement
====================

Updating column values in a table or view. In other words, once a table has been created and populated, you can modify any of the data values stored
in it by executing an UPDATE statement.

syntax
------

.. code-block:: sql

	UPDATE [TableName | ViewName]
		SET [ColumnName] = [[Value | NULL | DEFAULT], ...]
		<WHERE [Condition] | WHERE CURRENT OF [CursorName]>
		
or

.. code-block:: sql

	UPDATE [TableName | ViewName]
		SET ([ColumnName], ...) = ([Value | NULL | DEFAULT], ...)
		<WHERE [Condition] | WHERE CURRENT OF [CursorName]>
		
or

..  code-block:: sql

	UPDATE [TableName | ViewName]
		SET ([ColumnName], ...) = ([SELECTStatement])
		<WHERE [Condition] | WHERE CURRENT OF [CursorName]>

Example
-------

.. _EMPLOYEE-table:
	
	EMPLOYEE table
	
	==============  =========
	Column Name     Data Type
	==============  =========
	EMPNO           INTEGER
	FNAME           CHAR(10)
	LNAME           CHAR(10)
	SEX             CHAR(1)
	HIREDATE        DATE
	TITLE           CHAR(25)
	DEPT            CHAR(3)
	SALARY          DECIMAL(8,2)
	==============  =========
	


	- Salary of every employee who has the title of DATABASE ADMINISTRATOR is increased by 10 percent
	
	.. code-block:: sql
	
		UPDATE employee SET salary = salary * 1.10
			WHERE title = 'DATABASE ADMINISTRATOR'
		
	- Delete the values assigned to the DEPT column of every record found in the EMPLOYEE table
	
	.. code-block:: sql
	
		UPDATE employee SET dept = NULL
		
	- Change the value assigned to the DEPT column of each record found in the EMPLOYEE table
	
	.. code-block:: sql
	
		UPDATE employee SET (dept) =
			(SELECT deptno
			   FROM department
			   WHERE deptname = 'ADMINISTRATOR')
			   
The DELETE Statement
====================

To remove one or more rows of data from a table or updatable view

syntax
------

.. code-block:: sql

	DELETE FROM [TableName | ViewName]
		<WHERE [Condition] | WHERE CURRENT OF [CursorName]>
	
or

.. code-block:: sql

	DELETE FROM [TableName | ViewName]
		<WHERE ([ColumnName], ...) IN ([SELECTStatement])>
		
		
Example
-------

	.. _SALES-table:
	
	SALES table
	
	==============  =========
	Column Name     Data Type
	==============  =========
	ORDERNO         CHAR(10)
	COMPANY         CHAR(20)
	PURCHASEDATE    DATE
	SALESPERSON     INTEGER
	==============  =========
	
	- Remove every record for company ACME,INC from SALES table
	
	.. code-block:: sql
		
		DELETE FROM sales
			WHERE company = 'ACME, INC.'
			
	- Remove every record from SALES table for which no salesperson has been assigned
	
	.. code-block:: sql
	
		DELETE FROM sales
			WHERE salesperson IS NULL
			
	- Delete every record whose company starts with 'J'
	
	.. code-block:: sql
	
		DELETE FROM sales WHERE company LIKE 'J%'
		
	- Delete employees from EMPLOYEE table who happen to be make sales in 1971
	
	.. code-block:: sql
	
		DELETE FROM employee WHERE empno
			IN (SELECT salesperson FROM sales WHERE YEAR(purchasedate) = 1971)
			
	- Remove all rows in SALES table
	
	.. code-block:: sql
	
		DELETE FROM sales
		
The TRUNCATE statement
======================

A better alternative to using the DELETE statement to empty a table of its contents
is to use the TRUNCATE statement instead.

.. note::

	Why TRUNCATE?
	
	- TRUNCATE operations do not generate transaction log records.
	- Give more control over any DELETE triggers that may have been defined. 

syntax
------

.. code-block:: sql

	TRUNCATE <TABLE> [TableName]
		<[DROP | REUSE] STORAGE>
		<IGNORE DELETE TRIGGERS | RESTRICT WHEN DELETE TRIGGERS>
		
.. note::

	- If ``DROP STORAGE`` clause is specified with the truncate statement used, 
	  storage space that has been allocated for the table will be released and 
	  make available to the operating system.
	  
	- If ``REUSE STORAGE`` clause is used instead, storage space for the table is 
	  merely emptied, and the space remains available for the table's future needs.
	  
	- If ``IGNORE DELETE TRIGGERS`` clause is specified, DELETE triggers defined on
	  the table will not fire as the data in the table is being deleted. 
	  
	- If ``RESTRICT WHEN DELETE TRIGGERS`` clause is used, the system catalog will be 
	  examined to determine whether DELETE triggers on the table have been created.
	  And if one or more triggers are found, the truncate operation will end and an 
	  error will be returned. (In this case, the table's storage remains intact and its
	  records are left untouched.)
	  
Example
-------

	- Remove every record from SALES table without firing any DELETE triggers

	.. code-block:: sql
	
		TRUNCATE FROM sales
			IGNORE DELETE TRIGGERS

Working with SQL procedures
===========================

**Example 1**:

- Creating the check_comm procedure

Create a SQL procedure to report the name of staff members, their departments, and their salaries for 
employees who received more than a given commission: (save as check_comm.clp)

::

        CREATE OR REPLACE PROCEDURE check_comm (IN v_comm SMALLINT, OUT v_sqlstatus CHAR(5))
        SPECIFIC check_comm
        DYNAMIC RESULT SETS 1
        LANGUAGE SQL
        BEGIN
                DECLARE SQLSTATE CHAR(5);
                DECLARE chn_cur CURSOR WITH RETURN FOR 
                SELECT name, dept, job, salary FROM staff WHERE comm > v_comm;
                OPEN chn_cur;
                SET v_sqlstatus = SQLSTATE;
        END@

.. topic:: Syntax explanation

        - the ``SPECIFIC`` clause provides a unique name to identify the SQL procedure.
        - the ``DYNAMIC RESULT SETS`` clause indicates ``1`` as the maximum number of result sets.
        - the ``LANGUAGE SQL`` clause indicates that this is an SQL stored procedure.
        - the SQL procedure body is enclosed by the ``BEGIN`` and ``END`` keywords. It contains a declaration of a 
          variable and a cursor, setting of the output parameter, and returning a result set by opening the cursor.

.. note::

        - result set associated with cursor ``chn_cur`` once we ``OPEN chn_cur``
        - the ``v_comm`` input parameter indicates the comission value. The ``v_sqlstatus`` output parameter
          returns the status for the last SQL statement. If the execution of the SQL procedure is successful,
          the value of ``v_sqlstatus`` is 0. Otherwise, it sets to the standardized error code.
	- if you have mutliple inputs, then specify like: ``IN a SMALLINT, IN c char(5), ...``

- Register the SQL procedure to database server:

::

        db2 -td@ -vf check_comm.clp
 
.. note::

        - ``-td`` parameter specifies the \@ character as the end of statement character. Avoid using the ;
          character because it is used as the end of statements in the procedure body.
        - ``-v`` parameter displays the current command in the standard output
        - ``-f`` parameter indicates the input command file
	
- Calling SQL procedure:

::

        db2 "CALL check_comm(1000,?)"

.. note::

        - ``?`` is the place holder for the ``v_sqlstatus`` output parameter that returns the latest ``SQLSTATE`` value.

The return result shows the name and value of the output parameter and the result set from the open cursor with 
a list of staff members that have a commission greater than $1000.00.

::

        C:\Users\IBM_ADMIN\Documents>db2 "CALL CHECK_COMM(1000,?)"

        Value of output parameters
        --------------------------
        Parameter Name  : V_SQLSTATUS
        Parameter Value : 00000


        Result set 1
        --------------

        NAME      DEPT   JOB   SALARY
        --------- ------ ----- ---------
        Rothman       15 Sales  76502.83
        Koonitz       42 Sales  38001.75
        Edwards       84 Sales  67844.00

        3 record(s) selected.

        Return Status = 0        

**Example 2:**

- Creating ``FIND_SALARY`` procedure:

::

        CREATE OR REPLACE PROCEDURE FIND_SALARY
        LANGUAGE SQL
        DYNAMIC RESULT SETS 1
        BEGIN
                DECLARE EOF INT DEFAULT 0;
                DECLARE STMT VARCHAR(200);
                DECLARE R_EMPNO CHAR(6);
                DECLARE R_SALARY DEC(9,2);
                DECLARE C1 CURSOR WITH RETURN FOR
                        SELECT EMPNO, SALARY FROM EMPLOYEE
                        WHERE SALARY <= 50000;
        
                DECLARE CONTINUE HANDLER FOR NOT FOUND
                        SET EOF=1;
        
                SET STMT = 'INSERT INTO T_RESULTS VALUES (?,?)';
                PREPARE S1 FROM STMT;
                OPEN C1;
                WHILE EOF = 0 DO
                        FETCH FROM C1 INTO R_EMPNO, R_SALARY;
                        EXECUTE S1 USING R_EMPNO, R_SALARY;
                END WHILE;
                CLOSE C1;
        END@ 

.. topic:: Synatx Explanation

        - a ``CONTINUE`` handler will continue execution at the statement following the one that raised the exception
        - handler here used to return a value for EOF to indicate that the end of records has been reached.
        - ``PREPARE`` statement is used by application programs to dynamically prepare an SQL statement
   
.. seealso::

        - Exception handling ftp://ftp.software.ibm.com/software/dw/dm/db2/sqlplbook/ch05.pdf

- Register the procedure to database

::

        C:\Users\IBM_ADMIN\Documents>db2 -td@ -vf find_salary.clp
        CREATE OR REPLACE PROCEDURE FIND_SALARY
        LANGUAGE SQL
        DYNAMIC RESULT SETS 1
        BEGIN
                DECLARE EOF INT DEFAULT 0;
                DECLARE STMT VARCHAR(200);
                DECLARE R_EMPNO CHAR(6);
                DECLARE R_SALARY DEC(9,2);
                DECLARE C1 CURSOR WITH RETURN FOR
                        SELECT EMPNO, SALARY FROM EMPLOYEE
                        WHERE SALARY <= 50000;

                DECLARE CONTINUE HANDLER FOR NOT FOUND
                        SET EOF=1;

                SET STMT = 'INSERT INTO T_RESULTS VALUES (?,?)';
                PREPARE S1 FROM STMT;
                OPEN C1;
                WHILE EOF = 0 DO
                        FETCH FROM C1 INTO R_EMPNO, R_SALARY;
                        EXECUTE S1 USING R_EMPNO, R_SALARY;
                END WHILE;
                CLOSE C1;
        END
        DB20000I  The SQL command completed successfully.

- Calling the procedure

::

        C:\Users\IBM_ADMIN\Documents>db2 "call FIND_SALARY"

        Return Status = 0

.. note::

        before executing procedure, need to create T_RESULTS table first
        ::
                
                create table db2admin.t_results (employno char(6), salary dec(9,2))

- Check result

::

        C:\Users\IBM_ADMIN\Documents>db2 "select * from T_RESULTS fetch first 5 rows only"

        EMPLOYNO SALARY
        -------- -----------
        000120      49250.00
        000170      44680.00
        000220      49840.00
        000230      42180.00
        000240      48760.00

        5 record(s) selected.


Working with user-defined functions
===================================

**Example 1: scalar UDF function**

- Create a scalar function that calculates the tangent for a given argument

::

        CREATE OR REPLACE FUNCTION TAN (X DOUBLE)
        RETURNS DOUBLE
        LANGUAGE SQL
        CONTAINS SQL
        NO EXTERNAL ACTION
        DETERMINISTIC
        RETURN SIN(X)/COS(X); 

.. note::

        - You can either run it as db2 commands or save it to a clp file
        - ``NO EXTERNAL ACTION`` clause specifies that the function does not perform an action that
          changes the state of an object that the database manager does not manage.
        - ``DETERMINISTIC`` clause indicates to the database manager to always return the same results for given
          argument values.

- (Optional) Register it to database

::

        C:\Users\IBM_ADMIN\Documents>db2 -tvf tan.clp
        CREATE OR REPLACE FUNCTION TAN (X DOUBLE)
        RETURNS DOUBLE
        LANGUAGE SQL
        CONTAINS SQL
        NO EXTERNAL ACTION
        DETERMINISTIC
        RETURN SIN(X)/COS(X)
        DB20000I  The SQL command completed successfully.

.. note::

        - If you run previous step as db2 command, then this step is no needed.

- Calling user-defined functions

::

       C:\Users\IBM_ADMIN\Documents>db2 "select tan(10) from sysibm.sysdummy1"

        1
        ------------------------
        +6.48360827459087E-001

        1 record(s) selected. 
        

**Example 2: UDF table function**

- Creating a UDF table function

You can use a table function to return EMPNO, LASTNAME, FIRSTNAME, and DEPARTMENT_NAME for all the employees of a 
given department number. 

::

        CREATE OR REPLACE FUNCTION employee_same_dept_name (deptno CHAR(3))
        RETURNS TABLE (empno     CHAR(6),
                       lastname  VARCHAR(15),
                       firstname VARCHAR(12),
                       department_name VARCHAR(30))
        LANGUAGE SQL
        READS SQL DATA
        NO EXTERNAL ACTION
        DETERMINISTIC
        RETURN
                SELECT empno, lastname, firstnme, deptname
                        FROM employee, department
                        WHERE employee.workdept = employee_same_dept_name.deptno
                                AND employee.workdept = department.deptno;

- (Optional) Register it with database

::

        C:\Users\IBM_ADMIN\Documents>db2 -tvf employee.clp
        CREATE OR REPLACE FUNCTION employee_same_dept_name (deptno CHAR(3))
                RETURNS TABLE (empno     CHAR(6),
                               lastname  VARCHAR(15),
                               firstname VARCHAR(12),
                               department_name VARCHAR(30))
        LANGUAGE SQL
        READS SQL DATA
        NO EXTERNAL ACTION
        DETERMINISTIC
        RETURN
                SELECT empno, lastname, firstnme, deptname
                        FROM employee, department
                        WHERE employee.workdept = employee_same_dept_name.deptno
                                AND employee.workdept = department.deptno
        DB20000I  The SQL command completed successfully.

- Execute it

::

       C:\Users\IBM_ADMIN\Documents>db2 "select * from table(employee_same_dept_name('A00')) AS emp_same_dpt"

        EMPNO  LASTNAME        FIRSTNAME    DEPARTMENT_NAME
        ------ --------------- ------------ ------------------------------
        000010 HAAS            CHRISTINE    SPIFFY COMPUTER SERVICE DIV.
        000110 LUCCHESSI       VINCENZO     SPIFFY COMPUTER SERVICE DIV.
        000120 O'CONNELL       SEAN         SPIFFY COMPUTER SERVICE DIV.
        200010 HEMMINGER       DIAN         SPIFFY COMPUTER SERVICE DIV.
        200120 ORLANDO         GREG         SPIFFY COMPUTER SERVICE DIV.

        5 record(s) selected.

Working with temporal tables
============================

System-period temporal tables
-----------------------------
:download:`system-period temporal table sql<system-period.clp>`

- Creating system-period temporal table

To create a product table for a retail store as a system-period temporal table

::

        CREATE TABLE product_info
        ( sku_no      VARCHAR(15) NOT NULL,
          store_id    VARCHAR(19) NOT NULL,
          amt         INT NOT NULL,
          sys_start   TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS ROW BEGIN,
          sys_end     TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS ROW END,
          ts_id       TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS TRANSACTION START ID,
          PERIOD SYSTEM_TIME (sys_start, sys_end)
        );

The ``sku_no`` column stores the product unique number for a particular store and ``amt`` is its cost. The 
``sys_start`` and ``sys_end`` columns indicate when the product information in each row becomes active or inactive.
The ``ts_id`` column indicates the start time of a transaction that affects the row.

- Create associated history table

**Method 1:**

::

        CREATE TABLE hist_product_info
        ( sku_no       VARCHAR(15) NOT NULL,
          store_id     VARCHAR(19) NOT NULL,
          amt          INT NOT NULL,
          sys_start    TIMESTAMP(12) NOT NULL,
          sys_end      TIMESTAMP(12) NOT NULL,
          ts_id        TIMESTAMP(12) NOT NULL
        );

.. note::

        - the history table should have the same columns as the system-period temporal table.
        - the columns to indicate the period and the transaction_id should not have the ``GENERATED ALWAYS`` clause
          in the create statement.
 
**Method 2 (prefer):**

You can also create the ``hist_product_info`` table by using the CREATE TABLE statement with the LIKE clause.

::

       CREATE TABLE hist_product_info LIKE product_info;

- Linking system-period temporal table with its associated history table

::

        ALTER TABLE product_info ADD VERSIONING USE HISTORY TABLE hist_product_info;

- Inserting data into system-period temporal tables

::

        INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00001', 'NJ001', 5.99);
        INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00002', 'NJ011', 7.99);
        INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00002', 'NJ019', 9.99);
        INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00005', 'NJ019', 8.99);


        C:\Users\IBM_ADMIN\Documents>db2 SELECT * FROM product_info

        SKU_NO          STORE_ID            AMT         SYS_START                        SYS_END                          TS_ID
        --------------- ------------------- ----------- -------------------------------- -------------------------------- --------------------------------
        CHR_00001       NJ001                         5 2016-01-19-23.21.20.926357000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.21.20.926357000000
        CHR_00002       NJ011                         7 2016-01-19-23.21.35.013245000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.21.35.013245000000
        CHR_00002       NJ019                         9 2016-01-19-23.21.48.624776000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.21.48.624776000000
        CHR_00005       NJ019                         8 2016-01-19-23.22.00.278829000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.22.00.278829000000

        4 record(s) selected.


        C:\Users\IBM_ADMIN\Documents>db2 SELECT * FROM hist_product_info

        SKU_NO          STORE_ID            AMT         SYS_START                        SYS_END                          TS_ID
        --------------- ------------------- ----------- -------------------------------- -------------------------------- --------------------------------

        0 record(s) selected.

.. note::

        Data is added to the ``hist_product_info`` table only when you *delete* or *update* data into system-period
        temporal tables.

- Updating data into system-period temporal tables

Increase the price of the product with ``sku_no = 'CHR_00001`` from 5.99 to 6.99

::

        UPDATE product_info SET amt = 6.99 WHERE sku_no = 'CHR_00001';

        C:\Users\IBM_ADMIN\Documents>db2 SELECT * FROM hist_product_info

        SKU_NO          STORE_ID            AMT         SYS_START                        SYS_END                          TS_ID
        --------------- ------------------- ----------- -------------------------------- -------------------------------- --------------------------------
        CHR_00001       NJ001                         5 2016-01-19-23.21.20.926357000000 2016-01-19-23.24.04.788596000000 2016-01-19-23.21.20.926357000000

        1 record(s) selected.


        C:\Users\IBM_ADMIN\Documents>db2 SELECT * FROM product_info

        SKU_NO          STORE_ID            AMT         SYS_START                        SYS_END                          TS_ID
        --------------- ------------------- ----------- -------------------------------- -------------------------------- --------------------------------
        CHR_00001       NJ001                         6 2016-01-19-23.24.04.788596000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.24.04.788596000000
        CHR_00002       NJ011                         7 2016-01-19-23.21.35.013245000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.21.35.013245000000
        CHR_00002       NJ019                         9 2016-01-19-23.21.48.624776000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.21.48.624776000000
        CHR_00005       NJ019                         8 2016-01-19-23.22.00.278829000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.22.00.278829000000

        4 record(s) selected.        
 
.. note::

        - When update, data is automatically added to the associated history table
        - This update in the ``product_info`` table inserts a row in the ``hist_product_info`` table to indicate
          the time when the inserted values were active
        - The sys_start column in the ``hist_product_info`` table has the same value as the sys_start column in the 
          ``product_info`` after the insert.
        - The sys_end column of the ``hist_product_info`` table has the same values as the ``sys_start`` column
          in the updated row of the ``product_info`` table.

- Deleting data from system-period temporal tables

::

       DELETE FROM product_info WHERE sku_no = 'CHR_00005'; 

        C:\Users\IBM_ADMIN\Documents>db2 SELECT * FROM product_info

        SKU_NO          STORE_ID            AMT         SYS_START                        SYS_END                          TS_ID
        --------------- ------------------- ----------- -------------------------------- -------------------------------- --------------------------------
        CHR_00001       NJ001                         6 2016-01-19-23.24.04.788596000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.24.04.788596000000
        CHR_00002       NJ011                         7 2016-01-19-23.21.35.013245000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.21.35.013245000000
        CHR_00002       NJ019                         9 2016-01-19-23.21.48.624776000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.21.48.624776000000

        3 record(s) selected.


        C:\Users\IBM_ADMIN\Documents>db2 SELECT * FROM hist_product_info

        SKU_NO          STORE_ID            AMT         SYS_START                        SYS_END                          TS_ID
        --------------- ------------------- ----------- -------------------------------- -------------------------------- --------------------------------
        CHR_00001       NJ001                         5 2016-01-19-23.21.20.926357000000 2016-01-19-23.24.04.788596000000 2016-01-19-23.21.20.926357000000
        CHR_00005       NJ019                         8 2016-01-19-23.22.00.278829000000 2016-01-19-23.27.37.934517000000 2016-01-19-23.22.00.278829000000

        2 record(s) selected.

.. note::

        The DELETE statement leads to insertion of a row in the ``hist_product_info`` table where the sys_start
        column has the same value as the sys_start column in the ``product_info`` table and the ``sys_end``
        column has the time of the delete.   

- Querying system-period temporal tables

        - ``FOR SYSTEM_TIME AS OF`` *value1* to include all the rows with a time period that
          begins before or on *value1* and ends after *value1* from both the system-period temporal and history tables:

          ::

                C:\Users\IBM_ADMIN\Documents>db2 SELECT sku_no, store_id, amt FROM product_info FOR SYSTEM_TIME AS OF '2015-01-19-11.19.00.000000000000'

                SKU_NO          STORE_ID            AMT
                --------------- ------------------- -----------

                0 record(s) selected.      

        - ``FOR SYSTEM_TIME FROM`` *value1* ``TO`` *value2* to include all the rows with a time period that begins
          before or on *value1* and ends before *value2* from both the system-period temporal and history tables:

          ::

                C:\Users\IBM_ADMIN\Documents>db2 SELECT sku_no, store_id, amt FROM product_info FOR SYSTEM_TIME FROM '0001-01-01-00.00.00.000000' TO '9999-12-30-00.00.00.000000' WHERE sku_no = 'CHR_00001'

                SKU_NO          STORE_ID            AMT
                -------- ------- ------------------- -----------
                CHR_00001       NJ001                         5
                CHR_00001       NJ001                         6

                2 record(s) selected. 

        - ``FOR SYSTEM_TIME BETWEEN`` *value1* ``AND`` *value2* to include all the rows with a time period that
          overlaps any point in time between *value1* and *value2* from both the system-period temporal and history
          tables

          ::

                C:\Users\IBM_ADMIN\Documents>db2 SELECT * FROM product_info FOR SYSTEM_TIME BETWEEN '0001-01-01-00.00.00.000000' AND '9999-12-30-00.00.00.000000' WHERE sku_no = 'CHR_00001'

                SKU_NO          STORE_ID            AMT         SYS_START                        SYS_END                          TS_ID
                --------------- ------------------- ----------- -------------------------------- -------------------------------- --------------------------------
                CHR_00001       NJ001                         5 2016-01-19-23.21.20.926357000000 2016-01-19-23.24.04.788596000000 2016-01-19-23.21.20.926357000000
                CHR_00001       NJ001                         6 2016-01-19-23.24.04.788596000000 9999-12-30-00.00.00.000000000000 2016-01-19-23.24.04.788596000000

                2 record(s) selected.

If issuing a query without specifying a time period, it returns only rows in the system-period temporal table

::

        C:\Users\IBM_ADMIN\Documents>db2 SELECT sku_no, store_id, amt FROM product_info WHERE sku_no = 'CHR_00001'

        SKU_NO          STORE_ID            AMT
        --------------- ------------------- -----------
        CHR_00001       NJ001                         6

        1 record(s) selected.


Application-period temporal tables
----------------------------------

:download:`application-period temporal table sql<application-period.clp>`

- Creating application-period temporal tables

**Method 1:**
create a product table for a retail store as an application-period temporarl table:

::

    CREATE TABLE product_info
    ( sku_no                VARCHAR(15) NOT NULL,
      store_id 		    VARCHAR(19) NOT NULL,
      amt                   DECIMAL(10,2) NOT NULL,
      bus_start             DATE NOT NULL,
      bus_end               DATE NOT NULL,
      PERIOD BUSINESS_TIME  (bus_start, bus_end)
    );

To prevent overlapping business_time periods, create a unique index:

::

    CREATE UNIQUE INDEX ix_product_info ON product_info (sku_no, store_id, BUSINESS_TIME WITHOUT OVERLAPS);         

**Method 2:**

Alter existing table:

::

    ALTER TABLE product_info ADD COLUMN bus_start DATE NOT NULL;
    ALTER TABLE product_info ADD COLUMN bus_end DATE NOT NULL;
    ALTER TABLE product_info ADD COLUMN PERIOD BUSINESS_TIME(bus_start, bus_end);
    ALTER TABLE product_info ADD CONSTRAINT u-index UNIQUE (sku_no, store_id, BUSINESS_TIME WITHOUT OVERLAPS);

- Inserting data into application-period temporal tables

::

    INSERT INTO product_info VALUES('CHR_00001', 'NJ01', 9.99, '2013-01-01', '2013-07-01');
    INSERT INTO product_info VALUES('CHR_00001', 'NJ01', 10.99, '2013-07-01', '2014-01-01');
    INSERT INTO product_info VALUES('CHR_00001', 'NJ01', 11.99, '2013-06-01', '2013-08-01');
    INSERT INTO product_info VALUES('CHR_00005', 'NJ01', 8.99, '2013-01-01', '2014-01-01');
    INSERT INTO product_info VALUES('CHR_00007', 'NJ01', 25.99, '2013-01-01', '2014-01-01');
    SELECT * FROM product_info;

    db2 => SELECT * FROM product_info

    SKU_NO          STORE_ID            AMT          BUS_START  BUS_END
    --------------- ------------------- ------------ ---------- ----------
    CHR_00001       NJ01                        9.99 01/01/2013 07/01/2013
    CHR_00001       NJ01                       10.99 07/01/2013 01/01/2014
    CHR_00005       NJ01                        8.99 01/01/2013 01/01/2014
    CHR_00007       NJ01                       25.99 01/01/2013 01/01/2014

    4 record(s) selected.

.. note::

    The 3rd INSERT statement for "CHR_00001" fails because it indicates a period that overlaps with the
    specified period in the 2nd INSERT statement.

- Updating application-period temporal tables

::

    db2 => UPDATE product_info FOR PORTION OF BUSINESS_TIME FROM '2013-06-01' TO '2013-08-01' \
    db2 (cont.) => SET amt = 14.99 WHERE sku_no = 'CHR_00001'
    DB20000I  The SQL command completed successfully.
    db2 => SELECT * FROM product_info

    SKU_NO          STORE_ID            AMT          BUS_START  BUS_END
    --------------- ------------------- ------------ ---------- ----------
    CHR_00001       NJ01                       14.99 06/01/2013 07/01/2013
    CHR_00001       NJ01                       14.99 07/01/2013 08/01/2013
    CHR_00005       NJ01                        8.99 01/01/2013 01/01/2014
    CHR_00007       NJ01                       25.99 01/01/2013 01/01/2014
    CHR_00001       NJ01                        9.99 01/01/2013 06/01/2013
    CHR_00001       NJ01                       10.99 08/01/2013 01/01/2014

    6 record(s) selected.

.. note::

     UPDATE can cause the spliting of rows and inserting of new rows into the table.
     Two existing rows for CHR_00001 are split. These two rows are updated with the new time period and tow new
     rows are inserted for CHR_00001 with the price 14.99

- Deleting data from application-period temporal tables

::

    db2 => DELETE FROM product_info FOR PORTION OF BUSINESS_TIME FROM '2013-06-15' TO '2013-08-15' WHERE sku_no = 'CHR_00001'
    DB20000I  The SQL command completed successfully.
    db2 => SELECT * FROM product_info
    
    SKU_NO          STORE_ID            AMT          BUS_START  BUS_END
    --------------- ------------------- ------------ ---------- ----------
    CHR_00001       NJ01                       14.99 06/01/2013 06/15/2013
    CHR_00001       NJ01                       10.99 08/15/2013 01/01/2014
    CHR_00005       NJ01                        8.99 01/01/2013 01/01/2014
    CHR_00007       NJ01                       25.99 01/01/2013 01/01/2014
    CHR_00001       NJ01                        9.99 01/01/2013 06/01/2013

    5 record(s) selected.  

- Querying the application-period temporal tables

Same as system-period temporal table:

::
 
    db2 => SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR BUSINESS_TIME AS OF '2013-08-15' WHERE sku_no = 'CHR_00001'

    SKU_NO          AMT          BUS_START  BUS_END
    --------------- ------------ ---------- ----------
    CHR_00001              10.99 08/15/2013 01/01/2014

    1 record(s) selected.

    db2 => SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR BUSINESS_TIME FROM '2013-01-01' TO '2013-06-15' WHERE sku_no = 'CHR_00001'

    SKU_NO          AMT          BUS_START  BUS_END
    --------------- ------------ ---------- ----------
    CHR_00001               9.99 01/01/2013 06/01/2013
    CHR_00001              14.99 06/01/2013 06/15/2013

    2 record(s) selected.

    db2 => SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR BUSINESS_TIME BETWEEN '0001-01-01' AND '2013-01-01'

    SKU_NO          AMT          BUS_START  BUS_END
    --------------- ------------ ---------- ----------
    CHR_00005               8.99 01/01/2013 01/01/2014
    CHR_00007              25.99 01/01/2013 01/01/2014
    CHR_00001               9.99 01/01/2013 06/01/2013

    3 record(s) selected.

    db2 => SELECT sku_no, amt, bus_start, bus_end FROM product_info WHERE sku_no = 'CHR_00001'

    SKU_NO          AMT          BUS_START  BUS_END
    --------------- ------------ ---------- ----------
    CHR_00001               9.99 01/01/2013 06/01/2013
    CHR_00001              14.99 06/01/2013 06/15/2013
    CHR_00001              10.99 08/15/2013 01/01/2014

    3 record(s) selected.

Bitemporal tables
-----------------

:download:`Bitemporal tables sql<bitemporal.clp>`


References
**********

- *Roger E. Sanders* DB2 10.1 Fundamentals Certification Study Guide Chapter 5
- `DB2 10.1 fundamentals certification exam 610 prep, Part 4: Working with DB2 Data using SQL <http://www.ibm.com/developerworks/data/tutorials/db2-cert6104/>`_


Comments
********

.. disqus::



