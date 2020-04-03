package com.niconicomics.core.route;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/webtoons")
public class WebtoonRouteController {

	@GetMapping(value = "")
	public String goWebtoonList() {
		return "webtoon/webtoonList";
	}

	@GetMapping(value = "/{webtoonId}")
	public String goWebtoon(
			@PathVariable(name = "webtoonId") int webtoonId,
			Model model
			) {
		model.addAttribute("webtoonId", webtoonId);
		return "webtoon/webtoon";
	}
	
	@GetMapping(value = "/{webtoonId}/episodes/{episodeNo}")
	public String goContents(
			@PathVariable(name = "webtoonId") int webtoonId,
			@PathVariable(name = "episodeNo") int episodeNo,
			Model model
			) {
		model.addAttribute("webtoonId", webtoonId);
		model.addAttribute("episodeNo", episodeNo);
		return "webtoon/contents";
	}
	
}
