--------------------------------------------------------------------------------------------------------------
-- 일시 : 2020-03-13 --
-- 작성자 : 차준웅 --
-- 내용 : account 테이블에 타입 추가, 칼럼수정 -- 
ALTER TABLE tbl_account ADD(
    inquiry_name varchar2(5) default 'FALSE' not null
        check (inquiry_name in ('TRUE', 'FALSE'))
);

ALTER TABLE tbl_account MODIFY registration_number	varchar2(20);
ALTER TABLE tbl_account MODIFY account_number	varchar2(20);
