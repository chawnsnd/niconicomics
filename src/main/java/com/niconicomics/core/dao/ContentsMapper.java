package com.niconicomics.core.dao;

import java.util.ArrayList;

import com.niconicomics.core.vo.Contents;

public interface ContentsMapper {

	public int insertContents(Contents contents);
	public ArrayList<Contents> getContents(int episodeId); 
	public int updateContents(Contents contents);
}
