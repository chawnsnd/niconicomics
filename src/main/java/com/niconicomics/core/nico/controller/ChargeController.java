package com.niconicomics.core.nico.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.niconicomics.core.dao.UserDao;
import com.niconicomics.core.nico.service.KakaopayService;
import com.niconicomics.core.nico.service.NicoService;
import com.niconicomics.core.nico.vo.KakaoPayApprove;
import com.niconicomics.core.nico.vo.KakaoPayReady;
import com.niconicomics.core.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/charge")
public class ChargeController {
	
	@Autowired
	private KakaopayService kakaopayService;
	
	@Autowired
	private NicoService nicoService;
	
	//임시
	private User user;
	public ChargeController() {
		user = new User();
		user.setNico(0);
	}
	
	@GetMapping(value = "")
	public String goCharge() {
		return "charge/charge";
	}
	
	@ResponseBody
	@GetMapping(value = "/userinfo-temp")
	public User userinfoTemp(){
		return user;
	}
	
	@ResponseBody
	@GetMapping(value = "/kakaopay-ready")
	public String kakaoPayReady(String item) {
		KakaoPayReady ready = kakaopayService.kakaoPayReady(item);
		return ready.getNext_redirect_pc_url();
	}
	
	@GetMapping(value = "/kakaopay-approve")
	public String kakaoPayApprove(@RequestParam("pg_token") String pg_token, HttpSession session) {
		KakaoPayApprove approve = kakaopayService.kakaoPayApprove(pg_token);
		int nico = Integer.parseInt(approve.getAmount().get("total"));
//		String loginEmail = (String) session.getAttribute("loginEmail");
//		nicoService.chargeNico(loginEmail, nico);
		user.setNico(user.getNico()+nico);
		return "redirect:/charge";
	}
}
