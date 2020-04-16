package com.niconicomics.core.nico.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class TransferResultReq {

	private String check_type; //"1" Y AN(1) 1:출금이체, 2:입금이체
	private long tran_dtime; //"20190910101921" Y N(14) 요청일시
	private int req_cnt; //"25" Y N(5) 요청건수 주 1)
	private ArrayList<TransferResultReqItem> req_list;
	
}
