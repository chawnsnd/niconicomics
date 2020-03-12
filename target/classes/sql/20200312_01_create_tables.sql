--------------------------------------------------------------------------------------------------------------
-- 일시 : 2020-03-12 --
-- 작성자 : 차준웅 --
-- 내용 : user, webtoon, episode, contents 테이블, 시퀀스 생성 -- 
create table tbl_user (
	user_id		number 			primary key,
	email 		varchar2(50) 	unique not null,
	password 	varchar2(100),
	nickname 	varchar2(25)	not null,
	birthdate 	date,
	gender		varchar2(10),
	type		varchar2(10)	default 'GENERAL'	not null
		check (type in ('GENERAL', 'ADMIN', 'AUTHOR')),
	authority	varchar2(10)	default 'GENERAL'	not null,
	salt		varchar2(2)		not null,
	regdate		date			default sysdate		not null,
	nico		number			default 0			not null
);
create sequence seq_user;

create table tbl_webtoon (
	webtoon_id	number			primary key,
	title		varchar2(100)	not null,
	summary		varchar2(1000)	not null,
	author_id	number			not null,
	constraint webtoon_fk_author foreign key(author_id)
		references tbl_user(user_id) on delete cascade,
	hashtag		varchar2(1000)	not null,
	mgr_hashtag	varchar2(1000),
	thumbnail	varchar2(100)	not null,
	hits    	number			default 0		not null,
	end 		varchar2(5)		default 'FALSE'	not null
		check (end in('FALSE', 'TRUE'))
);
create sequence seq_webtoon;

create table tbl_episode (
	episode_id	number			primary key,
	no			number			not null,
	title		varchar2(100)	not null,
	regdate		date			default sysdate	not null,
	webtoon_id	number			not null,
	constraint episode_fk_webtoon foreign key(webtoon_id)
		references tbl_webtoon(webtoon_id) on delete cascade,
	thumbnail	varchar2(100)	not null
);
create sequence seq_episode;

create table tbl_contents (
	contents_id	number			primary key,
	episode_id	number			not null,
	constraint contents_fk_episode foreign key(episode_id)
		references tbl_episode(episode_id) on delete cascade,
	idx			number			unique		not null,
	image		varchar2(100)	not null
);
create sequence seq_contents;














