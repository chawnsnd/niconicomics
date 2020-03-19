package com.niconicomics.core.dao;

import com.niconicomics.core.vo.Webtoon;

public interface WebtoonMapper {

	public int insertWebtoon(Webtoon webtoon);
	public Webtoon getWebtoon(int webtoonId);
	public int updateWebtoon(Webtoon webtoon);
	public int deleteWebtoon(Webtoon webtoon);
	public void updateHits(int webtoonId);
}
