-- create database cs336project;
-- use cs336project;

-- create table user (name varchar(100), street_address varchar(300), phone_number varchar(15), email_address varchar(100), password varchar(30), isSeller boolean, isStaff boolean, primary key(email_address));
-- create table end_users(email_address varchar(100), business_name varchar(100), business_address varchar(300), business_type varchar(100), primary key(email_address));
-- create table staff(name varchar(100), street_address varchar(300), phone_number varchar(15), email_address varchar(100), password varchar(30),  isadmin boolean, isrep boolean, primary key(email_address));
-- create table help(staff_email varchar(100), user_email varchar(100), primary key(staff_email, user_email), foreign key(staff_email) references staff(email_address), foreign key(user_email) references end_users(email_address));
-- create table customer_representative(name varchar(100), street_address varchar(300), phone_number varchar(15), email_address varchar(100), password varchar(30), primary key(email_address));
-- create table sales_report(sales_report_ID int, total_earnings float, best_selling_item varchar(100), best_selling_user varchar(100), earning_per_item float, earnings_per_type float, earnings_per_end_user float, primary key (sales_report_ID));
-- #Can't add "not null" to administrative_staff. Pls fix.

-- create table administrative_staff(name varchar(100), street_address varchar(300), phone_number varchar(15), admin_email_address varchar(100), password varchar(30), sales_report_ID int, primary key(admin_email_address), foreign key(sales_report_ID) references sales_report(sales_report_ID));



-- show tables;
-- INSERT INTO user VALUES(
-- 	"admin",
--     "123 a ave. Trenton, NJ",
--     "(123)-456-7891",
--     "admin@gmail.com",
--     "admin123",
-- 	0,
--     1
-- );
-- INSERT INTO administrative_staff VALUES(
-- 	"admin",
--     "123 a ave. Trenton, NJ",
--     "(123)-456-7891",
--     "admin@gmail.com",
--     "admin123",
-- 	NULL
-- );
-- INSERT INTO staff VALUES(
-- 	"admin",
--     "123 a ave. Trenton, NJ",
--     "(123)-456-7891",
--     "admin@gmail.com",
--     "admin123",
--     1,
--     0
-- );


SELECT *
FROM user;

SELECT *
FROM staff;
SELECT *
FROM administrative_staff;

SELECT *
FROM customer_representative;

SELECT * 
FROM user;

SELECT *
FROM end_users;