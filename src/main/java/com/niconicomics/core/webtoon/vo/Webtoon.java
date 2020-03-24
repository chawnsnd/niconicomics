package com.niconicomics.core.webtoon.vo;

import lombok.Data;

@Data
public class Webtoon {

	private int webtoonId;
	private String title;
	private String summary;
	private int authorId;
	private String hashtag;
	private String mgrHashtag;
	private String thumbnail;
	private int hits;
	private String end;
	
}
