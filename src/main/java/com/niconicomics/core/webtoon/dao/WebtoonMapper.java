package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import com.niconicomics.core.webtoon.vo.Webtoon;

public interface WebtoonMapper {

	public int insertWebtoon(Webtoon webtoon);
	public Webtoon getWebtoon(int webtoonId);
	public int updateWebtoon(Webtoon webtoon);
	public int deleteWebtoon(Webtoon webtoon);
	public ArrayList<Webtoon> getAllWebtoon(int authorId);
	public void updateHits(int webtoonId);
}
