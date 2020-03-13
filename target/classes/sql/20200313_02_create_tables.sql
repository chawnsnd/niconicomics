--------------------------------------------------------------------------------------------------------------
-- 일시 : 2020-03-13 --
-- 작성자 : 차준웅 --
-- 내용 : account, transfer, change, doate, dotple 테이블, 시퀀스 생성 -- 
create table tbl_account (
	account_id			number 			primary key,
	author_id			number		 	unique not null,
	constraint account_fk_author foreign key(author_id)
		references tbl_user(user_id) on delete cascade,
	name				varchar2(20)	not null,
	phone				varchar2(50),
	registration_number	number	unique	not null,
	bank_name			varchar2(20)	not null,
	account_holder_name	varchar2(20)	not null,
	account_number		number	unique	not null,
	approved			varchar2(5)		default 'FALSE'	not null
		check (approved in ('FALSE', 'TRUE')),
	id_card				varchar2(100)	unique	not null,
	copy_of_bankbook	varchar2(100)	unique	not null
);
create sequence seq_account;

create table tbl_transfer (
	transfer_id			number 			primary key,
	account_id			number		 	not null,
	constraint transfer_fk_account foreign key(account_id)
		references tbl_account(account_id) on delete cascade,
	transfer_date		date			default sysdate	not null,
	amount				number			not null
);
create sequence seq_transfer;

create table tbl_charge (
	charge_id			number 			primary key,
	user_id				number		 	not null,
	constraint charge_fk_user foreign key(user_id)
		references tbl_user(user_id) on delete cascade,
	charge_date			date			default sysdate	not null,
	amount				number			not null,
	nico				number			not null
);
create sequence seq_charge;

create table tbl_dotple (
	dotple_id			number 			primary key,
	user_id				number		 	not null,
	constraint dotple_fk_user foreign key(user_id)
		references tbl_user(user_id) on delete cascade,
	contents_id			number		 	not null,
	constraint dotple_fk_contents foreign key(contents_id)
		references tbl_contents(contents_id) on delete cascade,
	x_axis				number			not null,
	y_axis				number			not null
);
create sequence seq_dotple;

create table tbl_donate (
	donate_id			number 			primary key,
	donate_date			date			default sysdate	not null,
	nico				number			not null,
	dotple_id			number			unique,
	constraint donate_fk_dotple foreign key(dotple_id)
		references tbl_dotple(dotple_id) on delete cascade,
);
create sequence seq_donate;

