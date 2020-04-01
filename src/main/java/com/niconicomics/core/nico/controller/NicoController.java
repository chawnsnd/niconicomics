package com.niconicomics.core.nico.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.nico.service.KakaopayService;
import com.niconicomics.core.nico.service.NicoService;
import com.niconicomics.core.nico.vo.KakaoPayApprove;
import com.niconicomics.core.nico.vo.KakaoPayReady;
import com.niconicomics.core.user.vo.User;

@RestController(value = "/nico")
public class NicoController {

	@Autowired
	private NicoService nicoService;
	@Autowired
	private KakaopayService kakaopayService;
	
	@GetMapping(value = "/charge1")
	public String charge1(int userId, String item, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser"); 
		if(userId == loginUser.getUserId()) {
			return "";			
		}
		KakaoPayReady ready = kakaopayService.kakaoPayReady(item);
		session.setAttribute("chargeUserId", userId);
		return ready.getNext_redirect_pc_url();
	}
	
	@GetMapping(value = "/charge2")
	public boolean kakaoPayApprove(@RequestParam("pg_token") String pg_token, HttpSession session) {
		int userId = (int) session.getAttribute("chargeUserId"); 
		KakaoPayApprove approve = kakaopayService.kakaoPayApprove(pg_token);
		int nico = Integer.parseInt(approve.getAmount().get("total"));
		return nicoService.chargeNico(userId, nico);
	}
	
	@PostMapping(value = "/donate")
	public boolean donate(int authorId, int sponsorId, int nico, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser"); 
		if(sponsorId == loginUser.getUserId()) {
			return nicoService.donateNico(authorId, sponsorId, nico);			
		}
		return false;
	}
	
}
