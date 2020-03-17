package com.niconicomics.core.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {

	@GetMapping(value= "/chats/{webtoonId}")
	public String chat(@PathVariable int webtoonId) {
		return "chat";
	}
	
}
