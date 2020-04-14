package com.niconicomics.core.nico.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.nico.vo.Transfer;

@Repository
public class TransferDao {

	@Autowired
	private SqlSession session;
	
	public boolean insertTransfer(Transfer transfer) {
		TransferMapper mapper = session.getMapper(TransferMapper.class);
		if(mapper.insertTransfer(transfer) == 1) {
			return true;
		}else {
			return false;
		}
	}

}
