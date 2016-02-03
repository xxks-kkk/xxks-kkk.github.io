-- create system-period temporal table
CREATE TABLE product_info
( sku_no    VARCHAR(15) NOT NULL,
  store_id  VARCHAR(19) NOT NULL,
  amt 		INT NOT NULL,
  sys_start TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS ROW BEGIN,
  sys_end   TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS ROW END,
  ts_id     TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS TRANSACTION START ID,
  PERIOD SYSTEM_TIME (sys_start, sys_end)
);

-- create associated history table (method 1)
CREATE TABLE hist_product_info
( sku_no       VARCHAR(15) NOT NULL,
  store_id     VARCHAR(19) NOT NULL,
  amt 		   INT NOT NULL,
  sys_start    TIMESTAMP(12) NOT NULL,
  sys_end	   TIMESTAMP(12) NOT NULL,
  ts_id 	   TIMESTAMP(12) NOT NULL
);

-- create associated history table (method 2)
CREATE TABLE hist_product_info LIKE product_info;


-- link system-period temporal table with its history table
ALTER TABLE product_info ADD VERSIONING USE HISTORY TABLE hist_product_info;

-- inserting data into system-period temporal tables
INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00001', 'NJ001', 5.99);
INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00002', 'NJ011', 7.99);
INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00002', 'NJ019', 9.99);
INSERT INTO product_info (sku_no, store_id, amt) VALUES ('CHR_00005', 'NJ019', 8.99);
SELECT * FROM product_info;
SELECT * FROM hist_product_info;

-- updating data into system-period temporal tables
UPDATE product_info SET amt = 6.99 WHERE sku_no = 'CHR_00001';
SELECT * FROM product_info;
SELECT * FROM hist_product_info;

-- deleting data from system-period temporal tables
DELETE FROM product_info WHERE sku_no = 'CHR_00005';
SELECT * FROM product_info;
SELECT * FROM hist_product_info;

-- querying system-period temporal tables
SELECT sku_no, store_id, amt FROM product_info FOR SYSTEM_TIME AS OF '2015-01-19-11.19.00.000000000000';
SELECT sku_no, store_id, amt FROM product_info FOR SYSTEM_TIME FROM '0001-01-01-00.00.00.000000' TO '9999-12-30-00.00.00.000000' WHERE sku_no = 'CHR_00001';
SELECT * FROM product_info FOR SYSTEM_TIME BETWEEN '2015-01-19-11.00.00.000000' AND '9999-12-30-00.00.000000' WHERE sku_no = 'CHR_00001';
SELECT sku_no, store_id, amt FROM product_info WHERE sku_no = 'CHR_00001';