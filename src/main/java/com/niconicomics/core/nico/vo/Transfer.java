package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class Transfer {

	private int transferId;
	private int accountId;
	private String transferDate;
	private int amount;
	private int nico;
	
}
