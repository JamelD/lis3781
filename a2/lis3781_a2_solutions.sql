drop database if exists jed18c;
create database if not exists jed18c;
use jed18c;

-- Company
drop table if exists company;
create table if not exists company
(
    cmp_id INT unsigned not null auto_increment,
    cmp_type enum('C-Corp', 'S-Corp', 'Non-Profit-Corp','LLC','Partnership'),
    cmp_street varchar(30) not null,
    cmp_city varchar(30) not null,
    cmp_state char(2) not null,
    cmp_zip int(9) unsigned zerofill not null comment 'no dashes',
    cmp_phone bigint unsigned not null,
    cmp_ytd_sales decimal(10,2) unsigned not null comment '12,345,678.90',
    cmp_email varchar(100) null,
    cmp_url varchar(100) null,
    cmp_notes varchar(255) null,
    primary key (cmp_id)
) 
engine = InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

SHOW WARNINGS;

Insert into company
values
(null,'C-Corp','1000 W Brevard St','Tallahassee','FL','323040000','8505551234','12345678.00',null,'https://GMTallahasse.com',null),
(null,'S-Corp','600 W College Ave','Tallahassee','FL','323060000','8505554321','20000000.00',null,'https://fsu.edu',null),
(null,'Non-Profit-Corp','505 W Pensacola St','Tallahassee','FL','323010000','8505055005','12378456.00',null,'https://tuckerciviccenter.com',null),
(null,'LLC','1416 W Tennessee St','Tallahassee','FL','323040000','8501112233','32187456.00',null,'https://momos.com',null),
(null,'Partnership','2373 W Tennessee St','Tallahassee','FL','323040000','8504567894','56123478.00',null,'https://proctor.com',null);

SHOW WARNINGS;

-- Customer
drop table if exists customer;
create table if not exists customer
(
    cus_id INT unsigned not null auto_increment,
    cmp_id INT unsigned not null,
    cus_ssn binary(64) not null,
    cus_salt binary(64) not null comment 'demo purposes only, do not use salt name in production',
    cus_type enum('Loyal','Discount','Impulse','Need-Based','Wandering'),
    cus_first varchar(15) not null,
    cus_last varchar(30) not null,
    cus_street varchar(30) null,
    cus_city varchar(30) null,
    cus_state char(2) null,
    cus_zip int(9) unsigned zerofill null comment 'no dashes',
    cus_phone bigint unsigned not null,
    cus_email varchar(100) null,
    cus_balance decimal(7,2) unsigned null,
    cmp_tot_sales decimal(7,2) unsigned null,
    cmp_notes varchar(255) null,
    primary key (cus_id),

    unique index ux_cus_ssn (cus_ssn asc),
    index idx_cmp_id (cmp_id asc),

    constraint fk_customer_company
    foreign key (cmp_id)
    references company (cmp_id)
    on delete no action
    on update cascade
) 
engine = InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

SHOW WARNINGS;

set @salt=RANDOM_BYTES(64);

Insert into customer
values
(null,1,unhex(SHA2(CONCAT(@salt,123456789),512)),@salt,'Discount','John', 'Doe','700 W Park Ave','Tallahassee','FL','323040000','8508508821','j.doe@email.com','1234.00','4321.00',null),
(null,2,unhex(SHA2(CONCAT(@salt,987654321),512)),@salt,'Loyal','Lisa', 'Smith','638 W Georgia St','Tallahassee','FL','323040000','8508501567','lsmith850@email.com','5678.00','5000.00',null),
(null,3,unhex(SHA2(CONCAT(@salt,789561234),512)),@salt,'Impulse','Marvin', 'Par','1411 Arkansas St','Tallahassee','FL','323040000','8508501111','marpar@email.com','9876.00','5000.50',null),
(null,4,unhex(SHA2(CONCAT(@salt,100123456),512)),@salt,'Need-Based','Liz', 'Lee','3204 Dian Rd','Tallahassee','FL','323040000','8508507641','llee@email.com','5432.00','7000.00',null),
(null,5,unhex(SHA2(CONCAT(@salt,404121234),512)),@salt,'Wandering','Joseph', 'West','741 White Dr','Tallahassee','FL','323040000','8508508500','jwest.doe@email.com','1500.00','9000.00',null);

SHOW WARNINGS;