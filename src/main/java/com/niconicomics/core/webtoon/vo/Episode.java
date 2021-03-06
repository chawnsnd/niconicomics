package com.niconicomics.core.webtoon.vo;

import lombok.Data;

@Data
public class Episode {

	private int episodeId;
	private int no;
	private String title;
	private String regdate;
	private int webtoonId;
	private String thumbnail;
	private int hits;
}
