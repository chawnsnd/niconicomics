package com.niconicomics.core.webtoon.dao;

import com.niconicomics.core.webtoon.vo.Webtoon;

public interface WebtoonMapper {

	public int insertWebtoon(Webtoon webtoon);
	public Webtoon getWebtoon(int webtoonId);
	public int updateWebtoon(Webtoon webtoon);
	public int deleteWebtoon(Webtoon webtoon);
	public void updateHits(int webtoonId);
}
