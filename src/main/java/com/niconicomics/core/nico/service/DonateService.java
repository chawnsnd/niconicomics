package com.niconicomics.core.nico.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.niconicomics.core.nico.dao.DonateDao;
import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.nico.vo.DonateSearchOption;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.vo.Webtoon;

@Service
public class DonateService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private DonateDao donateDao;
	
	@Autowired
	private WebtoonDao webtoonDao;
	
	
	
	@Transactional
	public boolean donate(Donate donate) {
		User author = userDao.selectUserByUserId(donate.getAuthorId());
		User sponsor = userDao.selectUserByUserId(donate.getSponsorId());
		if(donate.getNico() < 0) return false;
		if(sponsor.getNico()-donate.getNico() < 0) return false;
		author.setNico(author.getNico()+donate.getNico());
		sponsor.setNico(sponsor.getNico()-donate.getNico());
		if(userDao.updateUser(author) && userDao.updateUser(sponsor) && donateDao.insertDonate(donate)) {
			return true;
		}else {
			return false;
		}
	}

	public ArrayList<Donate> selectDonateListBySearchOption(DonateSearchOption option) {
		ArrayList<Donate> donateList = donateDao.selectDonateListBySearchOption(option);
		for (Donate donate : donateList) {
			donate.setSponserNickname(userDao.selectUserByUserId(donate.getSponsorId()).getNickname());
			donate.setWebtoonTitle(webtoonDao.selectWebtoonByWebtoonId(donate.getWebtoonId()).getTitle());
		}
		return donateDao.selectDonateListBySearchOption(option);
	}
	
}
