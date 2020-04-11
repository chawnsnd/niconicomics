package com.niconicomics.core.webtoon.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.util.ImageService;
import com.niconicomics.core.webtoon.dao.EpisodeDao;
import com.niconicomics.core.webtoon.vo.Episode;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/webtoons")
public class EpisodeController {

	@Autowired
	private EpisodeDao dao;

	@ResponseBody
	@RequestMapping(value = "/{webtoonId}/episodes", method = RequestMethod.GET)
	public ArrayList<Episode> myEpisodeList(@PathVariable(value = "webtoonId") int webtoonId) {
		log.debug(Integer.toString(webtoonId));
		ArrayList<Episode> getEpisodeList = dao.episodeSelectList(webtoonId);
		return getEpisodeList;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/{webtoonId}/episodes/{lastNo}/insert", method = RequestMethod.POST)
	public void EpisodeInsert(Episode episode, HttpSession session,@PathVariable(value ="lastNo") int no) {
		System.out.println(no);
		//dao.insertEpisode(episode);
		ArrayList<Episode> getAllEpiosdeList = dao.episodeAllList();
		int max = getAllEpiosdeList.get(0).getEpisodeId();
		System.out.println(max);
		for (int i = 0; i < getAllEpiosdeList.size(); i++) {
			if (max < getAllEpiosdeList.get(i).getEpisodeId()) {
				max = getAllEpiosdeList.get(i).getEpisodeId();
			}
		}
		Episode lastestEpisode = dao.selectEpisodeByEpisodeId(max);
		lastestEpisode.setNo(no);
		System.out.println(lastestEpisode);
		session.setAttribute("newEpisode", lastestEpisode);
	}

	
	@ResponseBody
	@PatchMapping(value = "/{webtoonId}/episodes/{no}")
	public String updateEpisode(
			@PathVariable(value = "webtoonId") int webtoonId,
			@PathVariable(value = "no") int no,
			@RequestBody Episode episode) {
		episode.setWebtoonId(webtoonId);
		int result = dao.updateEpisode(episode);
		return "home";
	}

	@RequestMapping(value = "/{webtoonId}/episodes/{no}", method = RequestMethod.DELETE)
	public void deleteEpisode(@PathVariable(value = "no") int no) {
		System.out.println(no);
		//int result = dao.deleteEpisode(episode)
	}

	// 이미지를 등록할때 쓰이는 서버경로를 만들어주는 메서드
	@ResponseBody
	@PostMapping(value = "/{webtoonId}/episodes/{no}/thumbnail")
	public String postThumbnail(@PathVariable(value = "webtoonId") int webtoonId, MultipartFile image,
			HttpServletResponse res, @PathVariable(value = "no") int no) {
		/*
		 * 보내는 쪽 HTML의 Form에서 <input type="file" name="image"><input type="file"
		 * name="image"><input type="file" name="image"> 이런식을 name이 같은 input태그가 여러개일때
		 * ArrayList<MultipartFile> image 로 받는다
		 */
		String savedFile = "";
		log.debug(image.getOriginalFilename());
		try {
			savedFile = ImageService.saveImage(image, "/webtoons/" + Integer.toString(webtoonId) +"/episodes/"
					+ Integer.toString(no), "thumbnail");
		} catch (NotImageException e) {
			e.printStackTrace();
			res.setStatus(406);
		}
		return savedFile;
	}
	
	@DeleteMapping(value="/{webtoonId}/episodes/{no}/thumbnail")
	public void deleteThumbnail(
			@PathVariable(name = "webtoonId") int webtoonId, @RequestBody String path, HttpServletResponse res
			, @PathVariable(value = "no") int no) {
		ImageService.deleteImage(path);
	}
}
