package com.niconicomics.core.route;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/webtoons")
public class WebtoonController {

	@GetMapping(value = "/{webtoonId}/episodes/{episodeId}")
	public String goContents() {
		return "webtoon/contents";
	}
	
}
