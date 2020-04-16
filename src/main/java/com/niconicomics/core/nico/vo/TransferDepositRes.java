package com.niconicomics.core.nico.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class TransferDepositRes {

	private String api_tran_id; //"2ffd133a-d17a-431d-a6a5" aNS(40) api_tran_dtm "20190910101921567" N(17) 거래일시(밀리세컨드)
	private String rsp_code; //"A0000" AN(5) 응답코드(API)
	private String rsp_message; //"" AN(300) 응답메시지
	private String wd_bank_code_std; //"097" AN(3) 출금기관.표준코드
	private String wd_bank_code_sub; //"1230001" AN(7) 출금기관.점별코드
	private String wd_bank_name; //"오픈은행" AH(20) 출금기관명
	private String wd_account_num_masked; //"000-1230000-***" NS*(20) 출금계좌번호(출력용)
	private String wd_print_content; //"환불금액" AH(20) 출금계좌인자내역
	private String wd_account_holder_name; //"허균" AH(20) 송금인성명
	private int res_cnt; //"25" N(5) 입금건수
	private ArrayList<TransferDepositResItem> res_list;
	
}
