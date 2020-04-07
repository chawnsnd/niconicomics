package com.niconicomics.core.webtoon.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
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
	//웹툰리스트 작가대시보드에서 가장 처음으로 뜨는 페이지
	//api컨트롤러에서 값을 반환함
	@ResponseBody
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ArrayList<Webtoon> myWebtoonList(int authorId) {
		log.debug(Integer.toString(authorId));
		ArrayList<Webtoon> getAllWebtoonList = dao.getAllWebtoon(authorId);
		return getAllWebtoonList;
	}
	//웹툰 하나 가져오기
	
	@ResponseBody
	@RequestMapping(value = "/{webtoonId}", method = RequestMethod.GET)
	public Webtoon getWebtoon(@PathVariable(value = "webtoonId") int webtoonId) {
		log.debug(Integer.toString(webtoonId));
		Webtoon webtoon = dao.selectWebtoonByWebtoonId(webtoonId);
		return webtoon;
	}
	//웹툰인서트 작가대시보드에서 웹툰등록을 누를때 만들어지는 가등록웹툰을 등록
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
		Webtoon lastestWebtoon =dao.selectWebtoonByWebtoonId(max);
		session.setAttribute("newWebtoon", lastestWebtoon);
	}
	//웹툰업데이트 작가대시보드에서 웹툰등록후 상세입력때 사용되는 웹툰업데이트 또는
	//이미등록된 웹툰을 업데이트할때 쓰이는 메서드
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
	//웹툰 삭제시 사용되는 메서드
	@RequestMapping(value = "/{webtoonId}", method = RequestMethod.DELETE)
	public void deleteWebtoon(
			@PathVariable(value = "webtoonId") int webtoonId,
			HttpSession session) {
			User user = (User) session.getAttribute("loginUser");
			int authorId = user.getUserId();
			Webtoon webtoon = new Webtoon();
			webtoon.setWebtoonId(webtoonId);
			webtoon.setAuthorId(authorId);
		int result = dao.deleteWebtoon(webtoon);
	}
	//등록웹툰불러오기
	
	@ResponseBody
	@PostMapping(value="webtoon-delete")
	public void fileDeleteTest(String path) {
		log.debug(path);
		ImageService.deleteImage(path);
	}
	//이미지를 등록할때 쓰이는 이미지 서비스 메서드
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
	//이미지를 등록할때 쓰이는 서버경로를 만들어주는 메서드
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
	@DeleteMapping(value="/{webtoonId}/thumbnail")
	public void deleteThumbnail(
			@RequestBody String path) {
		log.debug(path);
		ImageService.deleteImage(path);
	}
	
	@RequestMapping(value = "/updateHits", method = RequestMethod.GET)
	public String updateHits() {
		int webtoonId = 7;
		//테스트를 위한 강제 입력사항
		dao.updateHits(webtoonId);
		return "home";
	}
}
