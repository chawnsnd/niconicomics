package com.niconicomics.core.nico.dao;

import java.util.ArrayList;

import com.niconicomics.core.nico.vo.Transfer;

public interface TransferMapper {

	public int insertTransfer(Transfer transfer);

	public ArrayList<Transfer> selectTransferListByAccountId(int accountId);

}
