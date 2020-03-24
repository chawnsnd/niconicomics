package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class Account {
	
	private int accountId;
	private int authorId;
	private String name;
	private String phone;
	private String registrationNumber;
	private String bankName;
	private String accountHolderName;
	private String accountNumber;
	private String approved;
	private String idCard;
	private String copyOfBankbook;
	private String inquiry_name;
}