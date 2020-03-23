--------------------------------------------------------------------------------------------------------------
-- 일시 : 2020-03-13 --
-- 작성자 : 차준웅 --
-- 내용 : user 테이블 수정 -- 
ALTER TABLE tbl_user ADD(
    show_dotple varchar2(5) default 'HIDE' not null
        check (show_dotple in ('SHOW', 'HIDE')),
    show_chat varchar2(5) default 'HIDE' not null
        check (show_chat in ('SHOW', 'HIDE'))    
);