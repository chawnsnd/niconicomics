package com.niconicomics.core.nico.dao;

import java.util.ArrayList;

import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.nico.vo.DonateSearchOption;

public interface DonateMapper {

	public int insertDonate(Donate donate);

	public ArrayList<Donate> selectDonateListBySearchOption(DonateSearchOption option);

}
