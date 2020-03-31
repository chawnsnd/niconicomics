package com.niconicomics.core.webtoon.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.user.vo.User;
import com.niconicomics.core.util.ImageService;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.util.SplitTag;
import com.niconicomics.core.webtoon.vo.Webtoon;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/api/webtoons")
public class WebtoonController {
	
	@Autowired
	private WebtoonDao dao;
	SplitTag tag;
	
	@ResponseBody
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ArrayList<Webtoon> myWebtoonList(int authorId) {
		log.debug(Integer.toString(authorId));
		ArrayList<Webtoon> getAllWebtoonList = dao.getAllWebtoon(authorId);
		return getAllWebtoonList;
	}
	//api컨트롤러에서 값을 반환함
	@ResponseBody
	@RequestMapping(value = "", method = RequestMethod.POST)
	public void webtoonInsert(Webtoon webtoon, HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		webtoon.setAuthorId(user.getUserId()); 
		dao.webtoonInsert(webtoon);
		ArrayList<Webtoon> getAllWebtoonList = dao.getAllWebtoon(user.getUserId());
		int max = getAllWebtoonList.get(0).getWebtoonId();
		for (int i = 0; i < getAllWebtoonList.size(); i++) {
			if (max<getAllWebtoonList.get(i).getWebtoonId()) {
				max = getAllWebtoonList.get(i).getWebtoonId();
			}
		}
		Webtoon lastestWebtoon =dao.webtoonGet(max);
		session.setAttribute("newWebtoon", lastestWebtoon);
	}
	@ResponseBody
	@RequestMapping(value = "/{webtoonId}", method = RequestMethod.PATCH)
	public void updateWebtoon(
			@RequestBody Webtoon webtoon, 
			@PathVariable(name = "webtoonId") int webtoonId) {
		/*
		 * webtoon.setWebtoonId(6); webtoon.setTitle("test");
		 * webtoon.setSummary("testUpdateSummary"); webtoon.setAuthorId(1);
		 * webtoon.setHashtag("#일상#개그"); webtoon.setMgrHashtag("#시간순삭#일단클릭");
		 * webtoon.setThumbnail("testThumbnail"); webtoon.setEnd("end");
		 */
		
		System.out.println(webtoon.toString());
		webtoon.setWebtoonId(webtoonId);
		//테스트를 위한 강제 입력사항
		int result = dao.updateWebtoon(webtoon);
		
	}
	@ResponseBody
	@PostMapping(value="webtoon-upload")
	public String fileUploadTest(@RequestParam(name = "image") String image
		,@RequestParam(name = "webtoonId") int webtoonId
		,@RequestParam(name = "authorId") int authorId
		, HttpServletResponse res) {
		String savedFile;/*
							 * try { savedFile = ImageService.saveImage(image, "/abb", "aaabbb");
							 * 
							 * } catch (NotImageException e) { res.setStatus(406); return ""; }
							 */
		
		return "";
	}
	
	@ResponseBody
	@PostMapping(value="/{webtoonId}/thumbnail")
	public String postThumbnail(
			@PathVariable(name = "webtoonId") int webtoonId, 
			MultipartFile image,
			HttpServletResponse res) {
		/* 보내는 쪽 HTML의 Form에서
		 * <input type="file" name="image"><input type="file" name="image"><input type="file" name="image">
		 * 이런식을 name이 같은 input태그가 여러개일때
		 * ArrayList<MultipartFile> image 로 받는다
		 */
		String savedFile = "";
		log.debug(image.getOriginalFilename());
		try {
			savedFile = ImageService.saveImage(image, "/webtoons/"+Integer.toString(webtoonId), "thumbnail");
		} catch (NotImageException e) {
			e.printStackTrace();
			res.setStatus(406);
		}
		return savedFile;
	}
	@ResponseBody
	@PostMapping(value="webtoon-delete")
	public void fileDeleteTest(String path) {
		log.debug(path);
		ImageService.deleteImage(path);
	}
	
	@RequestMapping(value = "/webtoonGet", method = RequestMethod.GET)
	public String webtoonGet() {
		Webtoon webtoon = dao.webtoonGet(7);
		System.out.println(webtoon.toString());
		//테스트를 위한 강제 입력사항
		//매개변수는 추후 추가예정
		String hashtag = webtoon.getHashtag();
		String mgrHashtag = webtoon.getMgrHashtag();
		//String[] arrayHashtag = hashtag.split("#");
		//String[] arrayMgrHashtag = mgrHashtag.split("#");
		tag.splitTag(hashtag);
		tag.splitTag(mgrHashtag);
		for (int i = 1; i < tag.splitTag(hashtag).size(); i++) {
			System.out.println("#"+tag.splitTag(mgrHashtag).get(i));
		}
		for (int i = 1; i < tag.splitTag(mgrHashtag).size(); i++) {
			System.out.println("#"+tag.splitTag(mgrHashtag).get(i));
		}//해시태그를 빼는 유틸패키지로, 포스트맨
		return "home";
	}
	
	@RequestMapping(value = "/deleteWebtoon", method = RequestMethod.GET)
	public String deleteWebtoon(Webtoon webtoon) {
		webtoon.setAuthorId(1);
		webtoon.setWebtoonId(6);
		//테스트를 위한 강제 입력사항
		int result = dao.deleteWebtoon(webtoon);
		return "home";
	}
	@RequestMapping(value = "/updateHits", method = RequestMethod.GET)
	public String updateHits() {
		int webtoonId = 7;
		//테스트를 위한 강제 입력사항
		dao.updateHits(webtoonId);
		return "home";
	}
}
