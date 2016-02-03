-- creating bitemporal tables
CREATE TABLE product_info
(  sku_no      	VARCHAR(14) NOT NULL,
   store_id     VARCHAR(19) NOT NULL,
   amt			INTEGER NOT NULL,
   bus_start    DATE NOT NULL,
   bus_end		DATE NOT NULL,
   sys_start    TIMESTAMP(12) NOT NULL
				  GENERATED ALWAYS AS ROW BEGIN,
   sys_end		TIMESTAMP(12) NOT NULL
				  GENERATED ALWAYS AS ROW BEGIN,
   ts_id		TIMESTAMP(12) NOT NULL
				  GENERATED ALWAYS AS TRANSACTION START ID,
   PERIOD BUSINESS_TIME (bus_start, bus_end),
   PERIOD SYSTEM_TIME	(sys_start, sys_end)
);

-- create the associated history table
CREATE TABLE hist_product_info LIKE product_info

-- link the bitemporal table with its history table
ALTER TABLE product_info ADD VERSIONING USE HISTORY TABLE hist_product_info

-- prevent overlapping business_time periods, create a unique index
CREATE UNIQUE INDEX product_ix ON product_info (sku_no, store_id, BUSINESS_TIME WITHOUT OVERLAPS)

-- insert data into bitemporal tables
INSERT INTO product_info (sku_no, store_id, amt, bus_start, bus_end) VALUES ('CHR_00001', 'NY01', 6.99, '2013-01-01', '2013-07-01');
INSERT INTO product_info (sku_no, store_id, amt, bus_start, bus_end) VALUES ('CHR_00001', 'NY01', 6.99, '2013-07-01', '2014-01-01');
INSERT INTO product_info (sku_no, store_id, amt, bus_start, bus_end) VALUES ('CHR_00019', 'NJ10', 7.99, '2013-01-01', '2014-01-01');
INSERT INTO product_info (sku_no, store_id, amt, bus_start, bus_end) VALUES ('CHR_00005', 'NJ15', 5.99, '2013-01-01', '2014-01-01');

-- updating data in bitemporal tables
UPDATE product_info SET bus_start = '2013-04-01' WHERE sku_no = 'CHR_00005';
UPDATE product_info FOR PORTION OF BUSINESS_TIME FROM '2013-06-01' TO '2013-08-01'
	SET amt = 14.99 WHERE sku_no = 'CHR_00001';
	
-- deleting data from bitemporal tables
DELETE FROM product_info FOR PORTION OF BUSINESS_TIME FROM '2013-06-15' TO '2013-01-05' WHERE sku_no = 'CHR_00001';

-- querying bitemporal tables
SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR BUSINESS_TIME AS OF '2013-07-15' WHERE sku_no = 'CHR_00001';
SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR SYSTEM_TIME FROM '0001-01-01-00.00.00.000000' TO '9999-12-30-00.00.00.000000000000' WHERE sku_no = 'CHR_00001';
SELECT sku_no, amt, bus_start, bus_end 
	FROM product_info 
	FOR BUSINESS_TIME AS OF '2013-07-15' 
	FOR SYSTEM_TIME FROM '0001-01-01-00.00.00.000000' TO '9999-12-30-00.00.00.000000000000' 
	WHERE sku_no = 'CHR_00001';
SELECT sku_no, amt, bus_start, bus_end FROM product_info WHERE sku_no = 'CHR_00001';
