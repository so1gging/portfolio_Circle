package com.mvc.circle.model.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mvc.circle.model.service.GuestService;
import com.mvc.circle.model.vo.GuestbookVO;
import com.mvc.circle.model.vo.Paging;

@RestController
@RequestMapping("/guestbook")
public class GuestbookController {
	Logger logger = LoggerFactory.getLogger(GuestbookController.class);
	
	@Autowired
	GuestService service;
		
	// 모든 게시글 정보 가져오기
	@RequestMapping(value="/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listGuestbook(@PathVariable("page") Integer page) {		
		logger.info("<< MainController : listGuestbook >>");
		Paging paging = service.guestbookPaging(page);
		
		List<GuestbookVO> list = service.listGuestbook(paging);
		Map<String,Object> param = new HashMap<String, Object>();
		
		param.put("list", list);
		
		Boolean next = page * paging.getPageSize() < paging.getTotalArticle() ? true : false;
		param.put("next", next);
		
		return new ResponseEntity(param, HttpStatus.OK);
		
	}
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public ResponseEntity<String> addGuestbook(@RequestBody GuestbookVO guestbook){
		ResponseEntity<String> resEntity = null;
		logger.info("<< MainController : addGuestbook >>");
		logger.info(guestbook.toString());
		Boolean is = service.addGuestbook(guestbook);
		if(is) {
			resEntity = new ResponseEntity("ADD_SUCCEEDED",HttpStatus.OK);			
		}else {
			resEntity = new ResponseEntity("ADD_FAILED",HttpStatus.BAD_REQUEST);						
		}
		
		return resEntity;
	}
	
	@RequestMapping(value="/{guest_no}", method=RequestMethod.PUT)
	public ResponseEntity<String> modifyGuestbook(@RequestBody GuestbookVO guestbook){
		ResponseEntity<String> resEntity = null;
		logger.info("<< MainController : modifyGuestbook >>");
		Boolean is = service.modifyGuestbook(guestbook);
		if(is) {
			resEntity = new ResponseEntity("MOD_SUCCEEDED",HttpStatus.OK);			
		}else {
			resEntity = new ResponseEntity("MOD_FAILED",HttpStatus.BAD_REQUEST);						
		}
		
		return resEntity;
	}
	
	@RequestMapping(value="/{guest_no}", method=RequestMethod.DELETE)
	public ResponseEntity<String> deleteGuestbook(@PathVariable("guest_no") Integer guest_no){
		ResponseEntity<String> resEntity = null;
		logger.info("<< MainController : deleteGuestbook >>");
		
		Boolean is = service.deleteGuestbook(guest_no);
		if(is) {
			resEntity = new ResponseEntity("DEL_SUCCEEDED",HttpStatus.OK);			
		}else {
			resEntity = new ResponseEntity("DEL_FAILED",HttpStatus.BAD_REQUEST);						
		}

		return resEntity;
	}
	
	@RequestMapping(value="/like",method=RequestMethod.POST)
	public ResponseEntity<String> addLike(@RequestBody Map<String,Object> param){
		ResponseEntity<String> resEntity = null;
		logger.info("<< MainController : addLike >>");
		Boolean chk = service.checkLike(param); // 이미 like true, X false
		Boolean is = false;
		
		if(chk) {
			// 이미 like
			logger.info("<< already Heart >>");
			 is = service.removeLike(param);
		}else {
			logger.info("<< new Heart >>");
			is = service.addLike(param);
		}
		
		logger.info("<< "+is+" >>");
		
		if(is) {
			resEntity = new ResponseEntity("LIKE_SUCCEEDED",HttpStatus.OK);			
		}else {
			resEntity = new ResponseEntity("LIKE_FAILED",HttpStatus.BAD_REQUEST);						
		}

		return resEntity;
	}
	
}
