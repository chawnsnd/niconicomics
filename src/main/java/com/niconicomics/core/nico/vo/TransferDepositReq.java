package com.niconicomics.core.nico.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class TransferDepositReq {

	private String cntr_account_type; //"N" Y A(1) 약정 계좌/계정구분 주 1)N:계좌, C:계정
	private String cntr_account_num; //"1101230000678" Y AN(16) 약정 계좌/계정 번호 주 1)
	private String wd_pass_phrase; //"790d56ed........821a69" Y aN(128) 입금이체용 암호문구 *
	private String wd_print_content; //"출금계좌인자내역" Y AH(20) 출금계좌인자내역
	private String name_check_option; //"on" or "off" Y aN(3) 
//	private String sub_frnc_name; //“하위가맹점” N AH(40) 하위가맹점명 주 2)
//	private String sub_frnc_num; //“123456789012” N AN(20) 하위가맹점번호 주 2)
//	private int sub_frnc_business_num; //“1234567890” N N(10) 하위가맹점 사업자등록번호 주 2)
	private long tran_dtime; //"20190910101921" Y N(14) 요청일시
	private int req_cnt; //"25" Y N(5) 입금요청건수 **
	private ArrayList<TransferDepositReqItem> req_list; //Y 입금요청목록
	
}
