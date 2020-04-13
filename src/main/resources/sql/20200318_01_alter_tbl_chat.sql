--------------------------------------------------------------------------------------------------------------
-- 일시 : 2020-03-13 --
-- 작성자 : 차준웅 --
-- 내용 : chat 테이블에 타입 추가 -- 
ALTER TABLE tbl_chat ADD(
    type varchar2(10) default 'GENERAL' not null
        check (type in ('GENERAL', 'DOTPLE', 'DONATE'))
);