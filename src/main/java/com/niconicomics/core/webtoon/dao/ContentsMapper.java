package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import com.niconicomics.core.webtoon.vo.Contents;

public interface ContentsMapper {

	public int insertContents(Contents contents);
	public ArrayList<Contents> getContents(int episodeId); 
	public int updateContents(Contents contents);
}
