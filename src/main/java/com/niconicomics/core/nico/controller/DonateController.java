package com.niconicomics.core.nico.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.nico.service.DonateService;
import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.user.vo.User;

@RestController
@RequestMapping(value = "/api/donates")
public class DonateController {
	
	@Autowired
	private DonateService donateService;
	
	@PostMapping(value = "")
	public boolean donate(Donate donate, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser"); 
		if(donate.getSponsorId() != loginUser.getUserId()) return false;
		return donateService.donate(donate);			
	}
	
	@GetMapping(value = "")
	public ArrayList<Donate> getDonates(int webtoonId) {
		return donateService.selectDonateListByWebtoonId(webtoonId);
	}
	
}
