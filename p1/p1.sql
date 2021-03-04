select 'drop, create, use database, create tables, display data:' as '';
do sleep(5);

Drop schema if exists jed18c;
create schema if not exists jed18c;
show warnings;
use jed18c;

-- -------------------------------------------------------------------
-- Table person
drop table if exists person;
create table if not exists person(
	per_id smallint unsigned not null auto_increment,
    per_ssn binary(64) null,
    per_salt binary(64) null comment 'only for demo purposes, dont use salt name in prod',
    per_fname varchar(15) not null,
    per_lname varchar(30) not null,
    per_street varchar(30) not null,
    per_city varchar(30) not null,
    per_state char(2) not null,
    per_zip int(9) unsigned zerofill not null,
    per_email varchar(100) not null,
    per_dob date not null,
    per_type ENUM('a','c','j'),
    per_notes varchar(255) null,
    primary key (per_id),
    unique index ux_per_ssn (per_ssn ASC)
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table attorney
drop table if exists attorney;
create table if not exists attorney(
	per_id smallint unsigned not null,
    aty_start_date date not null,
    aty_end_date date default null,
    aty_hourly_rate decimal(5,2) not null,
    aty_years_in_practice tinyint not null,
    aty_notes varchar(255) null default null,
    primary key (per_id),
    
    index idx_per_id (per_id asc),
    
    constraint fk_attorney_person
    foreign key (per_id)
    references person (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table client
drop table if exists client;
create table if not exists client(
	per_id smallint unsigned not null,
    cli_notes varchar(255) null default null,
    primary key (per_id),
    
    index idx_per_id (per_id asc),
    
    constraint fk_client_person
    foreign key (per_id)
    references person (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table court
drop table if exists court;
create table if not exists court(
	crt_id tinyint unsigned not null auto_increment,
    crt_name varchar(45) not null,
    crt_street varchar(30) not null,
    crt_city varchar(30) not null,
    crt_state char(2) not null,
    crt_zip int(9) unsigned zerofill not null,
    crt_phone bigint not null,
    crt_email varchar(100) not null,
    crt_url varchar(100) not null,
    crt_notes varchar(255) null,
    primary key (crt_id)
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table judge
drop table if exists judge;
create table if not exists judge(
	per_id smallint unsigned not null,
    crt_id tinyint unsigned null default null,
    jud_salary decimal(8,2) not null,
    jud_years_in_practice tinyint unsigned not null,
    jud_notes varchar(255) null default null,
    primary key (per_id),
    
    index idx_per_id (per_id asc),
    index idx_crt_id (crt_id asc),
    
    constraint fk_judge_person
    foreign key (per_id)
    references person (per_id)
    on delete no action
    on update cascade,
    
    constraint fk_judge_court
    foreign key (crt_id)
    references court (crt_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table judge_hist
drop table if exists judge_hist;
create table if not exists judge_hist(
	jhs_id smallint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    jhs_crt_id tinyint null,
    jhs_date timestamp not null default current_timestamp,
    jhs_type enum('i','u','d') not null default 'i',
    jhs_salary decimal(8,2) not null,
    jhs_notes varchar(255) null default null,
    primary key (jhs_id),
    
    index idx_per_id (per_id asc),
    
    constraint fk_judge_hist_judge
    foreign key (per_id)
    references judge (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table case
drop table if exists `case`;
create table if not exists `case`(
	cse_id smallint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    cse_type varchar(45) not null,
    cse_description text not null,
    cse_start_date date not null,
    cse_end_date date null,
    cse_notes varchar(255) null,
    primary key (cse_id),
    
    index idx_per_id (per_id asc),
    
    constraint fk_court_case_judge
    foreign key (per_id)
    references judge (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table bar
drop table if exists bar;
create table if not exists bar(
	bar_id tinyint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    bar_name varchar(45) not null,    
    bar_notes varchar(255) null,
    primary key (bar_id),
    
    index idx_per_id (per_id asc),
    
    constraint fk_bar_attorney
    foreign key (per_id)
    references attorney (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table specialty
drop table if exists specialty;
create table if not exists specialty(
	spc_id tinyint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    spc_type varchar(45) not null,    
    spc_notes varchar(255) null,
    primary key (spc_id),
    
    index idx_per_id (per_id asc),
    
    constraint fk_specialty_attorney
    foreign key (per_id)
    references attorney (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table assignment
drop table if exists assignment;
create table if not exists assignment(
	asn_id smallint unsigned not null auto_increment,
    per_cid smallint unsigned not null,
    per_aid smallint unsigned not null,
    cse_id smallint unsigned not null,
    asn_notes varchar(255) null,
    primary key (asn_id),
    
    index idx_per_cid (per_cid asc),
    index idx_per_aid (per_aid asc),
    index idx_cse_id (cse_id asc),
    
    constraint fk_assign_case
    foreign key (cse_id)
    references `case` (cse_id)
    on delete no action
    on update cascade,
    
    constraint fk_assignment_client
    foreign key (per_cid)
    references client (per_id)
    on delete no action
    on update cascade,
    
    constraint fk_assignment_attorney
    foreign key (per_aid)
    references attorney (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- -----------------------------------------------------------------------------------
-- table phone
drop table if exists phone;
create table if not exists phone(
	phn_id smallint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    phn_num bigint unsigned not null,
    phn_type enum('h','c','w','f') not null comment 'home, cell, work, fax',
    phn_notes varchar(255) null,
    primary key (phn_id),
    
    index idx_per_id (per_id asc),
    
    constraint fk_phone_person
    foreign key (per_id)
    references person (per_id)
    on delete no action
    on update cascade
)
Engine = InnoDB
default character set=utf8
collate = utf8_unicode_ci;

show warnings;

-- #####################################################################################################################
-- populate tables
-- #################################################################################################################################

-- ------------------------------------------------------------------------------------
-- Person table
Start transaction;

insert into person
(per_id, per_ssn, per_salt, per_fname, per_lname, per_street, per_city, per_state, per_zip, per_email, per_dob, per_type, per_notes)
values
(NULL, NULL, NULL, 'Steve', 'Rogers', '437 Southern Drive', 'Rochester', 'NY', 324402222, 'srogers@comcast.net', '1923-10-03', 'c', NULL), 
(NULL, NULL, NULL, 'Bruce', 'Wayne', '1007 Mountain Drive', 'Gotham', 'NY', 003208440, 'bwayne@knology.net', '1968-03-20', 'c', NULL), 
(NULL, NULL, NULL, 'Peter', 'Parker', '20 Ingram Street', 'New York', 'NY', 102862341, 'pparker@msn.com', '1988-09-12', 'c', NULL), 
(NULL, NULL, NULL, 'Jane', 'Thompson', '13563 Ocean View Drive', 'Seattle', 'WA', 032084409, 'jthompson@gmail.com', '1978-05-08', 'c', NULL), 
(NULL, NULL, NULL, 'Debra', 'Steele', '543 Oak Ln', 'Milwaukee', 'WI', 286234178, 'dsteele@verizon.net', '1994-07-19', 'c', NULL), 
(NULL, NULL, NULL, 'Tony', 'Stark', '332 Palm Avenue', 'Malibu', 'CA', 902638332, 'tstark@yahoo.com', '1972-05-04', 'a', NULL), 
(NULL, NULL, NULL, 'Hank', 'Pymi', '2355 Brown Street', 'Cleveland', 'OH', 022348890, 'hpym@aol.com', '1980-08-28', 'a', NULL), 
(NULL, NULL, NULL, 'Bob', 'Best', '4902 Avendale Avenue', 'Scottsdale', 'AZ', 872638332, 'bbest@yahoo.com', '1992-02-10', 'a', NULL), 
(NULL, NULL, NULL, 'Sandra', 'Dole', '87912 Lawrence Ave', 'Atlanta', 'GA', 002348890, 'sdole@gmail.com', '1990-01-26', 'a', NULL), 
(NULL, NULL, NULL, 'Ben', 'Avery', '6432 Thunderbird Ln', 'Sioux Falls', 'SD', 562638332, 'bavery@hotmail.com', '1983-12-24', 'a', NULL), 
(NULL, NULL, NULL, 'Arthur', 'Curry', '3304 Euclid Avenue', 'Miami', 'FL', 000219932, 'lacurry@gmail.com', '1975-12-15', 'a', NULL), 
(NULL, NULL, NULL, 'Diana', 'Price', '944 Green Street', 'Las Vegas', 'NV', 332048823, 'dprice@symaptico.com', '1980-08-22', 'j', NULL), 
(NULL, NULL, NULL, 'Adam', 'Jurris', '98435 Valencia Dr.', 'Gulf Shores', 'AL', 870219932, 'ajurris@gmx.com', '1995-01-31', 'j', NULL), 
(NULL, NULL, NULL, 'Judy', 'Sleen', '56343 Rover Ct.', 'Billings', 'MT', 672048823, 'jsleen@symaptico.com', '1970-03-22', 'j', NULL), 
(NULL, NULL, NULL, 'Bill', 'Neiderheim', '43567 Netherland Blvd', 'South Bend', 'IN', 320219932, 'bneiderheim@comcast.net', '1982-03-13', 'j', NULL);

commit;

-- ------------------------------------------------------------------------------------
-- phone table
Start transaction;

insert into phone
(phn_id, per_id, phn_num, phn_type, phn_notes)
values
(null, 1, 8032288827, 'c', null),
(null, 2, 2052338293, 'h', null),
(null, 4, 1034325598, 'w', 'has two office numbers'),
(null, 5, 6402238494, 'w', null),
(null, 6, 5508329842, 'f', 'fax number not currently working'),
(null, 7, 8202052203, 'c', 'prefers home calls'),
(null, 8, 4008338294, 'h', null),
(null, 9, 7654328912, 'w', null),
(null, 10, 5463721984, 'f', 'work fax number'),
(null, 11, 4537821902, 'h', 'prefers cell phone calls'),
(null, 12, 7867821902, 'w', 'best number to reach'),
(null, 13, 4537821654, 'w', 'call during lunch'),
(null, 14, 3721821902, 'c', 'prefers cell phone calls'),
(null, 15, 9217821945, 'f', 'use for faxing legal docs');

commit;

-- ------------------------------------------------------------------------------------
-- client table
Start transaction;

insert into client
(per_id, cli_notes)
values
(1, null),
(2, null),
(3, null),
(4, null),
(5, null);

commit;

-- ------------------------------------------------------------------------------------
-- attorney table
Start transaction;

insert into attorney
(per_id, aty_start_date, aty_end_date, aty_hourly_rate, aty_years_in_practice, aty_notes)
values
(6, '2006-06-12', null, 85, 5, null),
(7, '2003-08-20', null, 130, 28,null),
(8, '2009-12-12', null, 70, 17,null),
(9, '2008-06-08', null, 78, 13,null),
(10, '2011-09-12', null, 60, 24,null);

commit;

-- ------------------------------------------------------------------------------------
-- bar table
Start transaction;

insert into bar
(bar_id, per_id, bar_name, bar_notes)
values
(null, 6, 'Florida', null),
(null, 7, 'Alabama', null),
(null, 8, 'Georgia', null),
(null, 9, 'Michigan', null),
(null, 10, 'South Carolina', null),
(null, 6, 'Montana', null),
(null, 7, 'Arizona', null),
(null, 8, 'Nevada', null),
(null, 9, 'New York', null),
(null, 10, 'New York', null),
(null, 6, 'Mississippi', null),
(null, 7, 'California', null),
(null, 8, 'Illinois', null),
(null, 9, 'Indiana', null),
(null, 10, 'Illinois', null),
(null, 6, 'Tallahassee', null),
(null, 7, 'Ocala', null),
(null, 8, 'Bay County', null),
(null, 9, 'Cincinatti', null);

commit;

-- ------------------------------------------------------------------------------------
-- specialty table
Start transaction;

insert into specialty
(spc_id, per_id, spc_type, spc_notes)
values
(null, 6, 'business', null),
(null, 7, 'traffic', null),
(null, 8, 'bankruptcy', null),
(null, 9, 'insurance', null),
(null, 10, 'judicial', null),
(null, 6, 'environmental', null),
(null, 7, 'criminal', null),
(null, 8, 'real estate', null),
(null, 9, 'malpractice', null);

commit;

-- ------------------------------------------------------------------------------------
-- court table
Start transaction;

insert into court
(crt_id, crt_name, crt_street, crt_city, crt_state, crt_zip, crt_phone, crt_email, crt_url, crt_notes)
values
(null, 'leon county circuit court', '301 s monroe st', 'tallahassee', 'fl', 323035292, 8506065504, 'lccc@us.fl.us', 'https://www.leoncountycircuitcourt.gov', null),
(null, 'leon county traffic court', '1921 thomasville rd', 'tallahassee', 'fl', 323035292, 8505774100, 'lctc@us.fl.us', 'https://www.leoncountytrafficcourt.gov', null),
(null, 'florida supreme court', '500 s duval st', 'tallahassee', 'fl', 323035292, 8504880125, 'fsc@us.fl.us', 'https://www.floridasupremecourt.gov', null),
(null, 'orange county courthouse', '424 n orange ave', 'orlando', 'fl', 328012248, 4078362000, 'occ@us.fl.us', 'https://www.ninthcircuit.gov', null),
(null, '5th district court of appeal', '301 s beach st', 'daytona beach', 'fl', 321158763, 3862258600, '5dca@us.fl.us', 'https://www.5dca.org', null);

commit;

-- ------------------------------------------------------------------------------------
-- judge table
Start transaction;

insert into judge
(per_id, crt_id, jud_salary, jud_years_in_practice, jud_notes)
values
(11, 5, 150000, 10, null),
(12, 4, 185000, 3, null),
(13, 4, 135000, 2, null),
(14, 3, 170000, 6, null),
(15, 1, 120000, 1, null);

commit;

-- ------------------------------------------------------------------------------------
-- judge_hist table
Start transaction;

insert into judge_hist
(jhs_id, per_id, jhs_crt_id, jhs_date, jhs_type, jhs_salary, jhs_notes)
values
(null, 11, 3, '2009-01-16', 'i', 130000, null),
(null, 12, 2, '2010-05-27', 'i', 140000, null),
(null, 13, 5, '2000-01-02', 'i', 115000, null),
(null, 13, 4, '2005-07-05', 'i', 135000, null),
(null, 14, 4, '2008-12-09', 'i', 155000, null),
(null, 15, 1, '2011-03-17', 'i', 120000, 'freshman justice'),
(null, 11, 5, '2010-07-05', 'i', 150000, 'assigned to another court'),
(null, 12, 4, '2012-10-08', 'i', 165000, 'became chief justice'),
(null, 14, 3, '2009-04-19', 'i', 170000, 'reassigned to court based upon local area population growth');

commit;

-- ------------------------------------------------------------------------------------
-- `case` table
Start transaction;

insert into `case`
(cse_id, per_id, cse_type, cse_description, cse_start_date, cse_end_date, cse_notes)
values
(null, 13, 'civil', 'Client logo being used without their consent, promoting rival', '2010-09-09', null, 'copyright infringement'),
(null, 12, 'criminal', 'client is charged with assaulting husband during argument', '2009-11-18', '2010-12-23', 'assault'),
(null, 14, 'civil', 'client broke ankle while shopping at grocery store. Floor recently mopped, no sign', '2008-05-06', '2008-07-23', 'slip and fall'),
(null, 11, 'criminal', 'c;ient is charged with stealing several televisions from former place of employment', '2011-05-20', null, 'grand theft'),
(null, 13, 'criminal', 'client is charged with posession of 10 grams of cocaine', '2011-06-05', null, 'posession of narcotics'),
(null, 14, 'civil', 'client claims nespaper printed false information while he ran business', '2007-01-19', '2007-05-20', 'defamation'),
(null, 12, 'criminal', 'client charged with murder of his coworker. no alibi, lovers fued', '2010-03-20', null, 'murder'),
(null, 15, 'civil', 'client delcaring bankruptcy', '2017-01-26', '2013-02-28', 'bankruptcy');

commit;

-- ------------------------------------------------------------------------------------
-- assignment table
Start transaction;

insert into assignment
(asn_id, per_cid, per_aid, cse_id, asn_notes)
values
(null, 1, 6, 7, null),
(null, 2, 6, 6, null),
(null, 3, 7, 2, null),
(null, 4, 8, 2, null),
(null, 5, 9, 5, null),
(null, 1, 10, 1, null),
(null, 2, 6, 3, null),
(null, 3, 7, 8, null),
(null, 4, 8, 8, null),
(null, 5, 9, 8, null),
(null, 4, 10, 4, null);

commit;