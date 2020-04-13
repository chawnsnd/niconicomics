package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.niconicomics.core.webtoon.vo.Webtoon;
import com.niconicomics.core.webtoon.vo.WebtoonSearchOption;

public interface WebtoonMapper {

	public int insertWebtoon(Webtoon webtoon);
	public Webtoon selectWebtoonByWebtoonId(int webtoonId);
	public int updateWebtoon(Webtoon webtoon);
	public int deleteWebtoonByWebtoonId(int webtoonId);
	public ArrayList<Webtoon> selectWebtoonList(WebtoonSearchOption option, RowBounds rb);
	public int selectCountWebtoonList(WebtoonSearchOption option);
}
