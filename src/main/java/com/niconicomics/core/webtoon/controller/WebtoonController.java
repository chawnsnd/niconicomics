package com.niconicomics.core.webtoon.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;
import com.niconicomics.core.util.ImageService;
import com.niconicomics.core.util.PageNavigator;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.vo.Webtoon;
import com.niconicomics.core.webtoon.vo.WebtoonSearchOption;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/webtoons")
public class WebtoonController {
	
	@Autowired
	private WebtoonDao webtoonDao;

	@GetMapping(value = "")
	public Map<String, Object> getWebtoonList(
			WebtoonSearchOption option,
			@RequestParam(defaultValue = "20") int countPerPage,
			@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "5") int pagePerGroup
		) {
		int webtoonListSize = webtoonDao.selectCountWebtoonList(option);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, webtoonListSize);
		ArrayList<Webtoon> webtoonList = webtoonDao.selectWebtoonList(option, navi);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("webtoonList", webtoonList);
		result.put("navi", navi);
		return result;
	}
	
	@PostMapping(value = "")
	public void insertWebtoon(Webtoon webtoon, MultipartFile thumbnailImage, HttpSession session) throws NotImageException {
		log.debug(webtoon.toString());
		User user = (User) session.getAttribute("loginUser");
		webtoon.setAuthorId(user.getUserId());
		int webtoonId = webtoonDao.insertWebtoon(webtoon);
		String savedFile = ImageService.saveImage(thumbnailImage, "/webtoons/"+Integer.toString(webtoonId), "thumbnail");
		webtoon.setThumbnail(savedFile);
		webtoonDao.updateWebtoon(webtoon);
	}
	
	@GetMapping(value = "/{webtoonId}")
	public Webtoon getWebtoon(@PathVariable(value = "webtoonId") int webtoonId) {
		Webtoon webtoon = webtoonDao.selectWebtoonByWebtoonId(webtoonId);
		return webtoon;
	}

	@PostMapping(value = "/{webtoonId}/put")
	public void updateWebtoon(Webtoon newWebtoon, 
			MultipartFile thumbnailImage,
			@PathVariable(name = "webtoonId") int webtoonId,
			HttpSession session) throws NotImageException {
		User user = (User) session.getAttribute("loginUser");
		Webtoon oldWebtoon = webtoonDao.selectWebtoonByWebtoonId(webtoonId);
		if(oldWebtoon.getAuthorId() != user.getUserId()) return;
		String savedFile;
		if(thumbnailImage.getSize() != 0) {
			ImageService.deleteImage(oldWebtoon.getThumbnail());
			savedFile = ImageService.saveImage(thumbnailImage, "/webtoons/"+Integer.toString(webtoonId), "thumbnail");
			newWebtoon.setThumbnail(savedFile);
		}
		newWebtoon.setWebtoonId(webtoonId);
		webtoonDao.updateWebtoon(newWebtoon);
	}

	@DeleteMapping(value = "/{webtoonId}")
	public void deleteWebtoon(@PathVariable(value = "webtoonId") int webtoonId, HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		Webtoon webtoon = webtoonDao.selectWebtoonByWebtoonId(webtoonId);
		if(webtoon.getAuthorId() != user.getUserId()) return;
		webtoonDao.deleteWebtoonByWebtoonId(webtoonId);
		ImageService.deleteImage(webtoon.getThumbnail());
	}
}
