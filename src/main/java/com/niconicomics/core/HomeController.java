package com.niconicomics.core;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.util.ImageService;
import com.niconicomics.core.webtoon.dao.ContentsDao;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private RestTemplate restTemplate;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value= "/test", method = RequestMethod.GET)
	public String test(String str) {
		return str;
	}
	
	@GetMapping(value="jandi-test")
	public void jandiTest() {
		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/vnd.tosslab.jandi-v2+json");
        
        JSONObject body = new JSONObject();
        body.put("body", "새로운");
//        MultiValueMap<String, Object> body = new LinkedMultiValueMap<String, Object>();
//        body.add("body", "'새로운 계좌등록 신청이 있습니다.'");
        HttpEntity<JSONObject> entity = new HttpEntity<>(body, headers);
        log.debug(entity.toString());
        String result = restTemplate.postForObject("https://wh.jandi.com/connect-api/webhook/20858837/8eb8abe45489dd7a33a92259d9d4927e", entity, String.class);
        log.debug(result);
	}
}
