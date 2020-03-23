package com.niconicomics.core;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.util.ImageService;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value= "/test", method = RequestMethod.GET)
	public String test(String str) {
		return str;
	}
	
	@GetMapping(value="file-upload-test")
	public String goFileUploadTest() {
		return "fileUploadTest";
	}
	
	@ResponseBody
	@PostMapping(value="file-upload-test")
	public String fileUploadTest(@RequestParam(name = "image") MultipartFile image, HttpServletResponse res) {
		String savedFile;
		try {
			savedFile = ImageService.saveImage(image, "/test", "aaabbb");
		} catch (NotImageException e) {
			res.setStatus(406);
			return "";
		}
		return savedFile;
	}

	@ResponseBody
	@PostMapping(value="file-delete-test")
	public void fileDeleteTest(String path) {
		log.debug(path);
		ImageService.deleteImage(path);
	}
	
}
