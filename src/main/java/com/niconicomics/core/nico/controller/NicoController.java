package com.niconicomics.core.nico.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.nico.service.KakaopayService;
import com.niconicomics.core.nico.service.NicoService;
import com.niconicomics.core.nico.service.OpenBankingService;
import com.niconicomics.core.nico.vo.KakaoPayApprove;
import com.niconicomics.core.nico.vo.KakaoPayReady;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/api/nico")
public class NicoController {

	@Autowired
	private NicoService nicoService;
	@Autowired
	private KakaopayService kakaopayService;
	@Autowired
	private OpenBankingService openBankingService;
	
	@GetMapping(value = "/charge1")
	@ResponseBody
	public String charge1(int userId, String item, HttpSession session) {
		log.debug(Integer.toString(userId));
		log.debug(item);
		User loginUser = (User) session.getAttribute("loginUser"); 
		if(userId != loginUser.getUserId()) {
			return "";
		}
		KakaoPayReady ready = kakaopayService.kakaoPayReady(item);
		log.debug(ready.toString());
		session.setAttribute("chargeUserId", userId);
		return ready.getNext_redirect_pc_url();
	}
	
	@GetMapping(value = "/charge2")
	public String kakaoPayApprove(@RequestParam("pg_token") String pg_token, HttpSession session) {
		int userId = (int) session.getAttribute("chargeUserId"); 
		KakaoPayApprove approve = kakaopayService.kakaoPayApprove(pg_token);
		int nico = Integer.parseInt(approve.getAmount().get("total"));
		log.debug(Integer.toString(nico));
		nicoService.chargeNico(userId, nico);
		return "redirect:/users/me/charge-nico";
	}
	
	@PostMapping(value = "/donate")
	@ResponseBody
	public boolean donate(int authorId, int sponsorId, int webtoonId, int nico, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser"); 
		if(sponsorId == loginUser.getUserId()) {
			return nicoService.donateNico(authorId, sponsorId, webtoonId, nico);			
		}
		return false;
	}
	
	@PostMapping(value = "/exchage")
	@ResponseBody
	public boolean exchage(int userId, int nico, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser"); 
		if(userId == loginUser.getUserId()) {
			return nicoService.exchageNico(userId, nico);
		}
		return false;
	}
}
