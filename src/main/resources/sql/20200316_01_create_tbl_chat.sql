--------------------------------------------------------------------------------------------------------------
-- 일시 : 2020-03-13 --
-- 작성자 : 차준웅 --
-- 내용 : chat 테이블, 시퀀스 생성 -- 
create table tbl_chat (
	chat_id				number 			primary key,
	user_id				number		  	not null,
	constraint chat_fk_user foreign key(user_id)
		references tbl_user(user_id) on delete cascade,
	webtoon_id			number		  	not null,
	constraint chat_fk_webtoon foreign key(webtoon_id)
		references tbl_webtoon(webtoon_id) on delete cascade,
	message				varchar2(1000)
);
