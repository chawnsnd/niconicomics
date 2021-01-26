package com.niconicomics.core.nico.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.nico.vo.InquiryRealNameRes;
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
	
	//계좌 보기
	public Account getAccount(int authorId) {
		return accountDao.selectAccountByAuthorId(authorId);
	}
	
	//계좌 등록
	public boolean enrollAccount(Account account, MultipartFile idCardImg, MultipartFile copyOfBankbookImg) throws NotImageException{
		if(!openBankingService.inquiryRealName(account)) return false;
		String idCard = ImageService.saveImage(idCardImg, "/account/"+Integer.toString(account.getAuthorId()), "id_card");
		String copyOfBankbook = ImageService.saveImage(copyOfBankbookImg, "/account/"+Integer.toString(account.getAuthorId()), "copy_of_bankbook");
		account.setIdCard(idCard);
		account.setCopyOfBankbook(copyOfBankbook);
		account.setInquiryName("TRUE");
		if(accountDao.insertAccount(account)) {
			jandiService.accountMessage(account);
		}
		return true;
	}

	//계좌 수정
	public boolean modifyAccount(Account account, MultipartFile idCardImg, MultipartFile copyOfBankbookImg) throws NotImageException{
		if(!openBankingService.inquiryRealName(account)) return false;
		String idCard = ImageService.saveImage(idCardImg, "/account/"+Integer.toString(account.getAuthorId()), "id_card");
		String copyOfBankbook = ImageService.saveImage(copyOfBankbookImg, "/account/"+Integer.toString(account.getAuthorId()), "copy_of_bankbook");
		account.setIdCard(idCard);
		account.setCopyOfBankbook(copyOfBankbook);
		account.setInquiryName("TRUE");
		if(accountDao.updateAccount(account)) {
			jandiService.accountMessage(account);
		}
		return true;
	}

	//계좌 삭제
	public boolean deleteAccountByAuthorId(int userId) {
		return accountDao.deleteAccountByAuthorId(userId);
	}
	
}
