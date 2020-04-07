package com.niconicomics.core.route;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/users/me")
public class MypageController {

	@GetMapping(value = "/charge-nico")
	public String goChargeNico() {
		return "user/me/chargeNico";
	}
	
}
