package com.niconicomics.core.webtoon.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ImageService {
	
	public static final String HTTP_ROOT = "http://localhost:8888/images";
	public static final String ROCAL_ROOT = "C:\\niconicomics\\images";
	public static final String[] IMAGE_TYPES = 
		{"image/png", "image/gif", "image/jpeg", "image/bmp", "image/x-icon"};
	
	public static String saveImage(MultipartFile mfile, String uploadPath, String saveName) throws NotImageException {
		if(!Arrays.asList(IMAGE_TYPES).contains(mfile.getContentType())) {
			throw new NotImageException();
		}
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}

		File path = new File(ROCAL_ROOT + uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}

		String originalFilename = mfile.getOriginalFilename();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String savedFilename = saveName+"_"+sdf.format(new Date());

		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		if (lastIndex == -1) {
			ext = "";
		}else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		File serverFile = null;

		while (true) {
			serverFile = new File(ROCAL_ROOT + uploadPath + "/" + savedFilename + ext);
			if (!serverFile.isFile())
				break;
			savedFilename = savedFilename + new Date().getTime();
		}

		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}

		return HTTP_ROOT + uploadPath + "/" + savedFilename + ext;
	}

	public static boolean deleteImage(String path) {
		path = path.substring(HTTP_ROOT.length(), path.length());
		boolean result = false;

		File delFile = new File(ROCAL_ROOT + path);

		if (delFile.isFile()) {
			delFile.delete();
			result = true;
		}

		return result;
	}

	public static void download(String fileName, String fullPath, HttpServletResponse response) {
		try {
			response.setHeader("Content-Disposition", " attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		FileInputStream filein = null;
		ServletOutputStream fileout = null;

		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();

			FileCopyUtils.copy(filein, fileout);

			filein.close();
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
