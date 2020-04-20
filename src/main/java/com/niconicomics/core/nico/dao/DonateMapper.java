package com.niconicomics.core.nico.dao;

import java.util.ArrayList;

import com.niconicomics.core.nico.vo.Donate;

public interface DonateMapper {

	public int insertDonate(Donate donate);

	public ArrayList<Donate> selectDonateListByWebtoonId(int webtoonIds);

}
