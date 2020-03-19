package com.niconicomics.core.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.vo.Webtoon;

@Repository
public class WebtoonDao {
	@Autowired
	private SqlSession session;
	
	public int webtoonInsert(Webtoon webtoon) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		int result = mapper.insertWebtoon(webtoon);
		return result;
	}
	public Webtoon webtoonGet(int webtoonId) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		Webtoon webtoon = new Webtoon();
		webtoon=mapper.getWebtoon(webtoonId);
		return webtoon;
	}
	public int updateWebtoon(Webtoon webtoon) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		int result = mapper.updateWebtoon(webtoon);
		return result;
	}
	public int deleteWebtoon(Webtoon webtoon) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		int result = mapper.deleteWebtoon(webtoon);
		return result;
	}
	public void updateHits(int webtoonId) {
		WebtoonMapper mapper = session.getMapper(WebtoonMapper.class);
		mapper.updateHits(webtoonId);
	}
}
