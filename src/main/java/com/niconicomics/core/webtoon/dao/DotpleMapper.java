package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import com.niconicomics.core.webtoon.vo.Dotple;

public interface DotpleMapper {

	public int insertDotple(Dotple dotple);

	public ArrayList<Dotple> selectDotpleListByContentsId(int contentsId);

	public ArrayList<Dotple> selectDotpleListByEpisodeId(int episodeId);

	public int deleteDotpleByDotpleId(int dotpleId);

}
