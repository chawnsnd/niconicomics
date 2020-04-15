package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class InquiryRealNameReq {

	private String bank_tran_id; //"F123456789U4BC34239Z" Y AN(20) 은행거래고유번호 주 1)
	private String bank_code_std; // "097" Y AN(3) 개설기관.표준코드
	private String account_num; // "1101230000678" Y AN(16) 계좌번호
	private String account_holder_info_type; // “1” Y AN(1) 예금주 실명번호 구분코드 주 2)
	private String account_holder_info; // "880101" N AN(13) 예금주 실명번호 주 2)
	private long tran_dtime; // "20190910101921" Y N(14) 요청일시
	
}
