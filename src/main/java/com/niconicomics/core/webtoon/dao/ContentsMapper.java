package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.niconicomics.core.webtoon.vo.Contents;

public interface ContentsMapper {

	public int insertContents(Contents contents);
	public ArrayList<Contents> selectContentsListByEpisodeId(int episodeId); 
	public Contents selectContentsByEpsodeIdAndIdx(
			@Param("episodeId") int episodeId,
			@Param("idx") int idx);
	public int updateContents(Contents contents);
	public int deleteContentsByContentsId(int contentsId);
}
