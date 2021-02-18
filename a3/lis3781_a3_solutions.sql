SET DEFINE OFF

Drop sequence seq_cus_id;
create sequence seq_cus_id
start with 1
increment by 1
minvalue 1
maxvalue 10000;

drop table customer cascade constraints purge;
create table customer
(
    cus_id number(3,0) not null,
    cus_fname varchar2(15),
    cus_lname varchar2(30),
    cus_street varchar2(30),
    cus_city varchar2(30),
    cus_state char(2),
    cus_zip number(9) not null,
    cus_phone number(10) not null,
    cus_email varchar2(100),
    cus_balance number(7,2),
    cus_notes varchar2(255),
    constraint pk_customer primary key(cus_id)
);

Drop sequence seq_com_id;
create sequence seq_com_id
start with 1
increment by 1
minvalue 1
maxvalue 10000;

drop table commodity cascade constraints purge;
create table commodity
(
    com_id number not null,
    com_name varchar2(20),
    com_price number(8,2) not null,
    com_notes varchar2(255),
    constraint pk_commodity primary key(com_id),
    constraint uq_com_name unique(com_name)
);

-- Image A3d

-- Image A3d

drop sequence seq_ord_id;
create sequence seq_ord_id
start with 1
increment by 1
minvalue 1
maxvalue 10000;

drop table "order" cascade constraints purge;
create table "order"
(
    ord_id number(4,0) not null,
    cus_id number,
    com_id number,
    ord_num_units number(5,0),
    ord_total_costs number(8,2),
    ord_notes varchar2(255),
    constraint pk_order primary key(ord_id),
    constraint fk_order_customer
    foreign key (cus_id)
    references customer(cus_id),
    constraint fk_order_commodity
    foreign key (com_id)
    references commodity(com_id),
    constraint check_unit check(ord_num_units > 0),
    constraint check_total check(ord_total_costs > 0)
);

insert into customer values (seq_cus_id.nextval, 'Beverly', 'Davis', '123 Main St.', 'Detroit', 'MI', 48252, 3135551212, 'bdavis@aol.com', 11500.99, 'recently moved');
insert into customer values (seq_cus_id.nextval, 'Stephen', 'Taylor', '456 Elm St.', 'St. Louis', 'MO', 57252, 4185551212, 'staylor@comcast.net', 25.01, NULL);
insert into customer values (seq_cus_id.nextval, 'Donna', 'Carter', '789 Peach Ave.', 'Los Angeles', 'CA', 48252, 3135551212, 'dcarter@wow.com', 300.99, 'returning customer');
insert into customer values (seq_cus_id.nextval, 'Robert', 'Silverman', '857 Wilbur Rd.', 'Phoenix', 'AZ', 25278, 4805551212, 'rsilverman@aol.com', NULL, NULL);
insert into customer values (seq_cus_id.nextval, 'Sally', 'Victors', '534 Holler Way', 'Charleston', 'WV', 78345, 9045551212, 'svictors@wow.com', 500.76, 'new customer');
commit;

insert into commodity values (seq_com_id.nextval, 'DVD & Player', 109.00, NULL);
insert into commodity values (seq_com_id.nextval, 'Cereal', 3.00, 'sugar free');
insert into commodity values (seq_com_id.nextval, 'Scrabble', 29.00, 'original');
insert into commodity values (seq_com_id.nextval, 'Licorice', 1.89, NULL);
insert into commodity values (seq_com_id.nextval, 'Tums', 2.45, 'antacid');
commit;

insert into "order" values (seq_ord_id.nextval, 1, 2, 50, 200, null);
insert into "order" values (seq_ord_id.nextval, 2, 3, 30, 100, null);
insert into "order" values (seq_ord_id.nextval, 3, 1, 6, 645, null);
insert into "order" values (seq_ord_id.nextval, 5, 4, 24, 972, null);
insert into "order" values (seq_ord_id.nextval, 3, 5, 7, 300, null);
insert into "order" values (seq_ord_id.nextval, 1, 2, 5, 15, null);
insert into "order" values (seq_ord_id.nextval, 2, 3, 40, 57, null);
insert into "order" values (seq_ord_id.nextval, 3, 1, 4, 300, null);
insert into "order" values (seq_ord_id.nextval, 5, 4, 14, 770, null);
insert into "order" values (seq_ord_id.nextval, 3, 5, 15, 883, null);
commit;

select * from customer;
select * from commodity;
select * from "order";