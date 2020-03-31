package com.niconicomics.core.webtoon.util;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

public class SplitTag {
	
	public static ArrayList<String> splitTag(String tag) {
		String[] splitTag = tag.split("#");
		ArrayList<String> transTagList = new ArrayList<String>();
		for (int i = 0; i < splitTag.length; i++) {
			transTagList.add(splitTag[i]);
		}
		return transTagList;
	}
}
