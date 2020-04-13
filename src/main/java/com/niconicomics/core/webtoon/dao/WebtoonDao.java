package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.util.PageNavigator;
import com.niconicomics.core.webtoon.vo.Webtoon;
import com.niconicomics.core.webtoon.vo.WebtoonSearchOption;

@Repository
public class WebtoonDao {
	
	@Autowired
	private SqlSession session;
	
	public int insertWebtoon(Webtoon webtoon) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		mapper.insertWebtoon(webtoon);
		return webtoon.getWebtoonId();
	}
	
	public Webtoon selectWebtoonByWebtoonId(int webtoonId) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		Webtoon webtoon = new Webtoon();
		webtoon=mapper.selectWebtoonByWebtoonId(webtoonId);
		return webtoon;
	}

	public boolean updateWebtoon(Webtoon webtoon) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		if(mapper.updateWebtoon(webtoon) == 1) {
			return true;
		}else {			
			return false;
		}
	}
	
	public ArrayList<Webtoon> selectWebtoonList(WebtoonSearchOption option, PageNavigator navi){
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		return mapper.selectWebtoonList(option, rb);
	}

	public int selectCountWebtoonList(WebtoonSearchOption option){
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		return mapper.selectCountWebtoonList(option);
	}
	
	public boolean deleteWebtoonByWebtoonId(int webtoonId) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		if(mapper.deleteWebtoonByWebtoonId(webtoonId) == 1) {
			return true;
		}else {
			return false;
		}
	}
	
}
