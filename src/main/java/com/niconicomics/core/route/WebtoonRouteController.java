package com.niconicomics.core.route;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/webtoons")
public class WebtoonRouteController {

	@GetMapping(value = "/{webtoonId}/episodes/{episodeId}")
	public String goContents(
			@PathVariable(name = "webtoonId") int webtoonId,
			@PathVariable(name = "episodeId") int episodeId,
			Model model
			) {
		model.addAttribute("webtoonId", webtoonId);
		model.addAttribute("episodeId", episodeId);
		return "webtoon/contents";
	}
	
}
