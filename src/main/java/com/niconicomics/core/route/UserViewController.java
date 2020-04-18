package com.niconicomics.core.route;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.service.UserService;
import com.niconicomics.core.user.vo.KakaoUser;
import com.niconicomics.core.user.vo.NaverUserRes;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/users")
public class UserViewController {
	
	@Autowired
	private RestTemplate restTemplate;
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserService userService;
	
	
	@GetMapping(value = "/join")
	public String test() {
		return "user/join1";
	}
	
	@GetMapping(value="/join2")
	public String goJoin2() {
		return "user/join2";
	}

	@GetMapping(value = "/login")
	public String goLogin() {
		return "user/login";
	}
	
	@GetMapping(value = "/kakao-login")
	public String kakaoLogin(String code, HttpSession session) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("grant_type", "authorization_code");
        body.add("client_id", "e8d019946e7e473b418a83659e5b38dc");
        body.add("redirect_url", "http://localhost:8888/core/users/kakao-login");
        body.add("code", code);
        HttpEntity<MultiValueMap<String, String>> tokenReq = new HttpEntity<>(body, headers);
        Map<String, String> tokenInfo = restTemplate.postForObject("https://kauth.kakao.com/oauth/token", tokenReq, Map.class);
        String accessToken = (String) tokenInfo.get("access_token");
        headers.set("Authorization", "Bearer "+accessToken);
        HttpEntity userInfoReq = new HttpEntity<>(headers);
        KakaoUser kakaoUser = restTemplate.postForObject("https://kapi.kakao.com/v2/user/me", userInfoReq, KakaoUser.class);
        boolean result = userService.checkEmailValidation(kakaoUser.getKakao_account().getEmail());
        if(result) {
        	User user = new User();
        	user.setEmail(kakaoUser.getKakao_account().getEmail());
        	user.setNickname(kakaoUser.getProperties().getNickname());
        	user.setType("GENERAL");
        	userDao.insertUser(user);
        }
    	User user = userDao.selectUserByEmail(kakaoUser.getKakao_account().getEmail());
    	session.setAttribute("loginUser", user);
    	return "redirect:/";
	}
	
	@GetMapping(value = "/naver-login")
	public String naverLogin(String code, String state, HttpSession session) {
		log.debug(code);
		log.debug(state);
		HttpHeaders headers = new HttpHeaders();
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("grant_type", "authorization_code");
		body.add("client_id", "DAo5utEZEh2u7jRDH9lv");
		body.add("client_secret", "QNGftK_8A9");
		body.add("code", code);
		body.add("state", state);
		HttpEntity<MultiValueMap<String, String>> tokenReq = new HttpEntity<>(body, headers);
		Map<String, String> tokenInfo = restTemplate.postForObject("https://nid.naver.com/oauth2.0/token", tokenReq, Map.class);
		log.debug(tokenInfo.get("access_token"));
		String accessToken = tokenInfo.get("access_token");
		headers.set("Authorization", "Bearer "+accessToken);
		HttpEntity userInfoReq = new HttpEntity<>(headers);
		NaverUserRes naverUserRes = restTemplate.postForObject("https://openapi.naver.com/v1/nid/me", userInfoReq, NaverUserRes.class);
		boolean result = userService.checkEmailValidation(naverUserRes.getResponse().getEmail());
		if(result) {
        	User user = new User();
        	user.setEmail(naverUserRes.getResponse().getEmail());
        	user.setNickname(naverUserRes.getResponse().getNickname());
        	user.setType("GENERAL");
        	userDao.insertUser(user);
        }
    	User user = userDao.selectUserByEmail(naverUserRes.getResponse().getEmail());
    	session.setAttribute("loginUser", user);
		return "redirect:/";
	}
	

	@GetMapping(value = "/mypage/charge-nico")
	public String goChargeNico() {
		return "user/mypage/chargeNico";
	}
	
	@GetMapping(value = "/mypage/profile")
	public String myPage() {
		return "user/mypage/profile";
	}
	
	@GetMapping(value = "/mypage/edit-profile")
	public String goEditProfile() {
		return "user/mypage/editProfile";
	}
	
	@GetMapping(value = "/mypage/edit-password")
	public String goEditPassword() {
		return "user/mypage/editPassword";
	}
	
	@GetMapping(value = "/mypage/change-to-author")
	public String changeType() {
		return "user/mypage/changeType";
	}
	
	@GetMapping(value = "/mypage/setting")
	public String setting() {
		return "user/mypage/setting";
	}
}
