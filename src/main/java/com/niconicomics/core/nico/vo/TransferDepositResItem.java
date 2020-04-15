package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class TransferDepositResItem {
	
	private int tran_no; //"1" 거래순번
	private String bank_tran_id; //"F123456789U4BC34239Z" 거래고유번호(참가은행) 
	private int bank_tran_date; //"20190910" 거래일자(참가은행)
	private String bank_code_tran; //"097" AN(3) 응답코드를 부여한 참가은행.표준코드
	private String bank_rsp_code; //"000" AN(3) 응답코드(참가은행)
	private String bank_rsp_message; //"" --bank_code_std "097" AN(3) 입금(개설)기관.표준코드
	private String bank_code_sub; //"1230001" AN(7) 입금(개설)기관.점별코드
	private String bank_name; // "오픈은행" AH(20) 입금(개설)기관명
	private String account_num; // "1101230000678" AN(16) 입금계좌번호
	private String account_num_masked; // "000-1230000-***" NS*(20) 입금계좌번호(출력용)
	private String print_content; // "쇼핑몰환불" AH(20) 입금계좌인자내역
	private String account_holder_name; // "홍길동" AH(20) 수취인성명
	
}
