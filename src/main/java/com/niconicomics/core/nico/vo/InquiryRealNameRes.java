package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class InquiryRealNameRes {

	private String api_tran_id; // "AA12349BHZ1324K82AL3" AN(20) 거래고유번호(API)
	private long api_tran_dtm; // "20160310101921567" N(17) 거래일시(밀리세컨드)
	private String rsp_code;// "A0000" AN(5) 응답코드(API)
	private String rsp_message; // "" AH(100) 응답메시지(API)
	private String bank_tran_id;// "12345678901234567890" AN(20) 거래고유번호(참가기관)
	private int bank_tran_date;// "20160310" N(8) 거래일자(참가기관)
	private String bank_code_tran;// "098" AN(3) 응답코드를 부여한 참가기관.표준코드
	private String bank_rsp_code;// "000" AN(3) 응답코드(참가기관)
	private String bank_rsp_message;// "" AN(100) 응답메시지(참가기관)
	private String bank_code_std;// "098" AN(3) 개설기관.표준코드
	private String bank_code_sub;// "1230001" AN(7) 개설기관.점별코드
	private String bank_name;// "오픈은행" AH(20) 개설기관명
	private String account_num;// "0001230000678" AN(16) 계좌번호
	private int account_holder_info;// "8801012" N(12) 거래금액
	private String account_holder_info_type;// 예금주 실명번호 구분코드
	private String account_holder_name;// "홍길동" AH(20) 예금주 성명
	private String account_type;// 계좌종류

}
