package com.niconicomics.core.webtoon.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.user.vo.User;
import com.niconicomics.core.util.ImageService;
import com.niconicomics.core.util.PageNavigator;
import com.niconicomics.core.webtoon.dao.ContentsDao;
import com.niconicomics.core.webtoon.dao.EpisodeDao;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.vo.Contents;
import com.niconicomics.core.webtoon.vo.Episode;
import com.niconicomics.core.webtoon.vo.Webtoon;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/webtoons")
public class EpisodeController {

	@Autowired
	private EpisodeDao episodeDao;

	@Autowired
	private WebtoonDao webtoonDao;

	@Autowired
	private ContentsDao contentsDao;

	@GetMapping(value = "/{webtoonId}/episodes")
	public ArrayList<Episode> getEpisodeList(
			@PathVariable(value = "webtoonId") int webtoonId,
			@RequestParam(defaultValue = "20") int countPerPage,
			@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "5") int pagePerGroup) {
//		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, 100);
		ArrayList<Episode> episodeList = episodeDao.selectEpisodeListByWebtoonId(webtoonId);
		return episodeList;
	}
	
	@GetMapping(value = "/{webtoonId}/episodes/{episodeNo}")
	public Map<String, Object> getEpisode(
			@PathVariable(name = "webtoonId") int webtoonId,
			@PathVariable(name = "episodeNo") int episodeNo) {
		Episode episode = episodeDao.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo);
		ArrayList<Contents> contentsList = contentsDao.selectContentsListByEpisodeId(episode.getEpisodeId());
		Map<String, Object> result = new HashMap<>();
		result.put("episode", episode);
		result.put("contentsList", contentsList);
		return result;
	}

	@PostMapping(value = "/{webtoonId}/episodes/{episodeNo}")
	public void insertEpisode(
			Episode episode, 
			MultipartFile thumbnailImage, 
//			ArrayList<MultipartFile> contentsImage,
			MultipartHttpServletRequest multipartRequest,
			@PathVariable(name = "webtoonId") int webtoonId,
			@PathVariable(name = "episodeNo") int episodeNo,
			HttpSession session) throws NotImageException {
		
		//사용자 인증
		Webtoon webtoon = webtoonDao.selectWebtoonByWebtoonId(webtoonId);
		User user = (User) session.getAttribute("loginUser");
		if(webtoon.getAuthorId() != user.getUserId()) return;
		
		//에피소드 등록
		episode.setWebtoonId(webtoonId);
		episode.setNo(episodeNo);
		String savedThumbnail = ImageService.saveImage(thumbnailImage, "/webtoons/" + Integer.toString(webtoonId) +"/episodes/"
				+ Integer.toString(episodeNo), "thumbnail");
		episode.setThumbnail(savedThumbnail);
		int episodeId = episodeDao.insertEpisode(episode);
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			if(!fileName.equals("thumbnailImage")) {
				String savedContents = ImageService.saveImage(multipartRequest.getFile(fileName), "/webtoons/" + Integer.toString(webtoonId) +"/episodes/"
						+ Integer.toString(episodeNo), "contents");
				Contents contents = new Contents();
				contents.setEpisodeId(episodeId);
				contents.setIdx(Integer.parseInt(fileName));
				contents.setImage(savedContents);
				contentsDao.insertContents(contents);
			}
		}
	}
	
	@PostMapping(value = "/{webtoonId}/episodes/{episodeNo}/put")
	public void updateEpisode(
			Episode newEpisode, 
			MultipartFile thumbnailImage, 
			MultipartHttpServletRequest multipartRequest,
			@PathVariable(name = "webtoonId") int webtoonId,
			@PathVariable(name = "episodeNo") int episodeNo,
			HttpSession session) throws NotImageException {
		
		//사용자 인증
		Webtoon webtoon = webtoonDao.selectWebtoonByWebtoonId(webtoonId);
		User user = (User) session.getAttribute("loginUser");
		if(webtoon.getAuthorId() != user.getUserId()) return;
		
		//전반적인 에피소드 수정
		Episode oldEpisode = episodeDao.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo);
		newEpisode.setWebtoonId(webtoonId);
		newEpisode.setNo(episodeNo);
		newEpisode.setEpisodeId(oldEpisode.getEpisodeId());
		if(thumbnailImage.getSize() != 0) {
			ImageService.deleteImage(oldEpisode.getThumbnail());
			String savedThumbnail = ImageService.saveImage(thumbnailImage, "/webtoons/" + Integer.toString(webtoonId) +"/episodes/"
					+ Integer.toString(episodeNo), "thumbnail");
			newEpisode.setThumbnail(savedThumbnail);
		}
		episodeDao.updateEpisode(newEpisode);
		
		//컨텐츠수정
		Iterator<String> fileNames = multipartRequest.getFileNames();
		ArrayList<Contents> contentsList = contentsDao.selectContentsListByEpisodeId(oldEpisode.getEpisodeId());
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			if(!fileName.equals("thumbnailImage")) {
				Contents newContents;
				String savedContents = ImageService.saveImage(multipartRequest.getFile(fileName), "/webtoons/" + Integer.toString(webtoonId) +"/episodes/"
						+ Integer.toString(episodeNo), "contents");
				for (Contents contents : contentsList) {					
					if(contents.getIdx() == Integer.parseInt(fileName)) {
						ImageService.deleteImage(contents.getImage());
						newContents = contents;
						newContents.setImage(savedContents);
						contentsDao.updateContents(contents);
						break;
					}else {
						newContents = new Contents();
						newContents.setImage(savedContents);
						newContents.setEpisodeId(oldEpisode.getEpisodeId());
						newContents.setIdx(Integer.parseInt(fileName));
						contentsDao.insertContents(newContents);
						break;
					}
				}
			}
		}
	}

	@DeleteMapping(value = "/{webtoonId}/episodes/{episodeNo}")
	public void deleteEpisode(
			@PathVariable(value = "webtoonId") int webtoonId,
			@PathVariable(value = "episodeNo") int episodeNo,
			HttpSession session) {
		Webtoon webtoon = webtoonDao.selectWebtoonByWebtoonId(webtoonId);
		User user = (User) session.getAttribute("loginUser");
		if(webtoon.getAuthorId() != user.getUserId()) return;
		int episodeId = episodeDao.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo).getEpisodeId();
		episodeDao.deleteEpisodeByEpisodeId(episodeId);
	}

}
