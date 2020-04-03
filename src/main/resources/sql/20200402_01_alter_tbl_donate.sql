--------------------------------------------------------------------------------------------------------------
-- 일시 : 2020-04-02 --
-- 작성자 : 차준웅 --
-- 내용 : donate 테이블에 칼럼 추가 -- 
ALTER TABLE tbl_donate ADD(
	sponsor_id				number,
	constraint donate_fk_sponsor foreign key(sponsor_id)
		references tbl_user(user_id) on delete set null,
	author_id				number,
	constraint donate_fk_author foreign key(author_id)
		references tbl_user(user_id) on delete set null,
	webtoon_id				number,
	constraint donate_fk_webtoon foreign key(webtoon_id)
		references tbl_webtoon(webtoon_id) on delete set null
);