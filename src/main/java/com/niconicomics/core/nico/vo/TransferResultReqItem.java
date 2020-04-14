package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class TransferResultReqItem {
	
	private int tran_no; //"1" Y N(5)
	private String org_bank_tran_id; //"F123456789U123A4239C" Y AN(20) 원거래 거래고유번호(참가은행) 주 2)
	private int org_bank_tran_date; //"20190910" Y N(8) 원거래 거래일자(참가은행) 주 3)
	private int org_tran_amt; //"10000" Y N(12) 원거래 거래금액
	
}
