package com.niconicomics.core.nico.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.nico.service.NicoService;
import com.niconicomics.core.nico.vo.Transfer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(value = "/api/transfers")
public class TransferController {

	@Autowired
	private NicoService nicoService;
	
	@GetMapping(value = "")
	public ArrayList<Transfer> getTransfers(int authorId){
		return nicoService.getTransferList(authorId);
	}

}
