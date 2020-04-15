package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class TransferDepositReqItem {

	private int tran_no; //"1" Y N(5) --bank_tran_id "F123456789U4BC34239Z" Y AN(20) 은행거래고유번호 주 3)
	private String bank_code_std; //"097" Y AN(3) 입금은행.표준코드
	private String account_num; //"1101230000678" Y AN(16) 계좌번호
	private String account_holder_name; //"홍길동" Y AH(20) 입금계좌예금주명 ***
	private String print_content; //"입금계좌인자내역" Y AH(20) 입금계좌인자내역
	private int tran_amt; //"10000" Y N(12) --req_client_name “홍길동” Y AH(20) 요청고객성명 주 4)
	private String req_client_name; 
	private String req_client_bank_code; //"097" N AN(3) 요청고객계좌 개설기관.표준코드 주 4)
	private String req_client_account_num; //"1101230000678" N AN(16) 요청고객계좌번호 주 4)
	private String req_client_fintech_use_num; //"123456789012345678901234" N AN(24) 요청고객핀테크이용번호 주 4)
	private String req_client_num; //“HONGGILDONG1234” Y AN(20) 요청고객회원번호 주 4)
	private String transfer_purpose; //“TR” Y AN(2) 이체용도 주 5)TR:송금, ST:결제, AU:인증
	private String recv_bank_tran_id; //"F123456789U4BCT4112Z" N AN(20) 수취조회 은행거래고유번호 주 6)
	private String bank_tran_id;
	private String cms_num; //“93848103221” N AN(32) CMS 번호 주 7)
	
}
