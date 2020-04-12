package com.niconicomics.core.webtoon.vo;

import lombok.Data;

@Data
public class WebtoonSearchOption {

	private String author;
	private int authorId;
	private String title;
	private String[] hashtags;
	private int currentPage;
	private int countPerPage;
	
}
