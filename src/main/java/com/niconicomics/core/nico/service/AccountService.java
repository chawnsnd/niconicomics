package com.niconicomics.core.nico.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.nico.vo.OpenBankingRealName;
import com.niconicomics.core.util.ImageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AccountService {

	@Autowired
	private AccountDao accountDao;
	
	@Autowired
	private JandiService jandiService;
	@Autowired
	private OpenBankingService openBankingService;
	
	public Account getAccount(int authorId) {
		Account account = accountDao.selectAccountByAuthorId(authorId);
		return account;
	}
	
	public boolean enrollAccount(Account account, MultipartFile idCardImg, MultipartFile copyOfBankbookImg) throws NotImageException{
		String idCard = "";
		String copyOfBankbook = "";
		idCard = ImageService.saveImage(idCardImg, "/account/"+Integer.toString(account.getAuthorId()), "id_card");
		copyOfBankbook = ImageService.saveImage(copyOfBankbookImg, "/account/"+Integer.toString(account.getAuthorId()), "copy_of_bankbook");
		account.setAuthorId(account.getAuthorId());
		account.setIdCard(idCard);
		account.setCopyOfBankbook(copyOfBankbook);
		if(accountDao.insertAccount(account)) {
			OpenBankingRealName realName = openBankingService.inquiryRealName(account.getBankName(), account.getAccountNumber(), account.getRegistrationNumber().substring(0, 6));
			log.debug(realName.toString());
			if(realName.getAccount_holder_name().equals(account.getAccountHolderName())) {
				account.setInquiryName("TRUE");
				accountDao.updateAccount(account);
			}
			jandiService.accountMessage(account);
			return true;
		}
		return false;
	}
	
}
