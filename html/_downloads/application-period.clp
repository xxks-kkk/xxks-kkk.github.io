-- create application-period temporal tables
CREATE TABLE product_info
( sku_no                VARCHAR(15) NOT NULL,
  store_id 		        VARCHAR(19) NOT NULL,
  amt                   DECIMAL(10,2) NOT NULL,
  bus_start             DATE NOT NULL,
  bus_end               DATE NOT NULL,
  PERIOD BUSINESS_TIME  (bus_start, bus_end)
);

-- prevent overlapping business_time periods
CREATE UNIQUE INDEX ix_product_info ON product_info (sku_no, store_id, BUSINESS_TIME WITHOUT OVERLAPS);

-- change a regular table into an application-period temporal table
ALTER TABLE product_info ADD COLUMN bus_start DATE NOT NULL;
ALTER TABLE product_info ADD COLUMN bus_end DATE NOT NULL;
ALTER TABLE product_info ADD COLUMN PERIOD BUSINESS_TIME(bus_start, bus_end);
ALTER TABLE product_info ADD CONSTRAINT u-index UNIQUE (sku_no, store_id, BUSINESS_TIME WITHOUT OVERLAPS);

-- inserting data into application-period temporal tables
INSERT INTO product_info VALUES('CHR_00001', 'NJ01', 9.99, '2013-01-01', '2013-07-01');
INSERT INTO product_info VALUES('CHR_00001', 'NJ01', 10.99, '2013-07-01', '2014-01-01');
INSERT INTO product_info VALUES('CHR_00001', 'NJ01', 11.99, '2013-06-01', '2013-08-01');
INSERT INTO product_info VALUES('CHR_00005', 'NJ01', 8.99, '2013-01-01', '2014-01-01');
INSERT INTO product_info VALUES('CHR_00007', 'NJ01', 25.99, '2013-01-01', '2014-01-01');
SELECT * FROM product_info;

-- updating data for a specific period of time
UPDATE product_info FOR PORTION OF BUSINESS_TIME FROM '2013-06-01' TO '2013-08-01'
	SET amt = 14.99 WHERE sku_no = 'CHR_00001';
SELECT * FROM product_info;

-- deleting data from application-period temporal tables
DELETE FROM product_info FOR PORTION OF BUSINESS_TIME FROM '2013-06-15' TO '2013-08-15' WHERE sku_no = 'CHR_00001';

-- querying application-period temporal tables
SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR BUSINESS_TIME AS OF '2013-08-15' WHERE sku_no = 'CHR_00001';
SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR BUSINESS_TIME FROM '2013-01-01' TO '2013-06-15' WHERE sku_no = 'CHR_00001';
SELECT sku_no, amt, bus_start, bus_end FROM product_info FOR BUSINESS_TIME BETWEEN '0001-01-01' AND '2013-01-01';
SELECT sku_no, amt, bus_start, bus_end FROM product_info WHERE sku_no = 'CHR_00001';
