package com.niconicomics.core.util;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

public class SplitTag {
	
	public static ArrayList<String> splitTag(String tag) {
		String[] splitTag = tag.split("#");
		ArrayList<String> transTagList = new ArrayList<String>();
		for (int i = 0; i < splitTag.length; i++) {
			transTag.add(splitTag[i]);
		}
		return transTag;
	}
}
