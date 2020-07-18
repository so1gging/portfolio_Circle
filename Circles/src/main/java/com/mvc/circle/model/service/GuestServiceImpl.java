package com.mvc.circle.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.circle.model.dao.GuestDao;
import com.mvc.circle.model.vo.GuestbookVO;
import com.mvc.circle.model.vo.Paging;

@Service
public class GuestServiceImpl implements GuestService{
	
	Logger logger = LoggerFactory.getLogger(GuestServiceImpl.class);
	
	@Autowired
	GuestDao dao;

	@Override
	public List<GuestbookVO> listGuestbook(Paging paging) {
		logger.info("<< GuestServiceImpl : listGuestbook >>");
		return dao.listGuestbook(paging.getStartRow(), paging.getEndRow());
	}

	@Override
	public Paging guestbookPaging(Integer page) {
		logger.info("<< GuestServiceImpl : guestbookPaging >>");
		Paging paging = new Paging();
		
		paging.setPage(page);
		
		int totalGuestbook = dao.totalGuestbook();
		
		paging.setTotalArticle(totalGuestbook);
		paging.setTotalPage(totalGuestbook);
		
		paging.setStartRow();
		paging.setEndRow();
		
		return paging;
	}

	@Override
	public Boolean addGuestbook(GuestbookVO guestbook) {
		logger.info("<< GuestServiceImpl : addGuestbook >>");
		
		return dao.addGuestbook(guestbook);
	}

	@Override
	public Boolean modifyGuestbook(GuestbookVO guestbook) {
		logger.info("<< GuestServiceImpl : modifyGuestbook >>");
		return dao.modifyGuestbook(guestbook);
	}

	@Override
	public Boolean deleteGuestbook(Integer guest_no) {
		logger.info("<< GuestServiceImpl : deleteGuestbook >>");
		return dao.deleteGuestbook(guest_no);
	}

	@Override
	public Boolean addLike(Map<String, Object> param) {
		logger.info("<< GuestServiceImpl : addLike >>");
		Boolean is = false;
		if(dao.addHeart(param)) {
			logger.info("<< addLike >>");
			is = dao.addLike(param);
		}
		return is;
	}

	@Override
	public Boolean checkLike(Map<String, Object> param) {
		logger.info("<< GuestServiceImpl : checkLike >>");
		return dao.checkLike(param);
	}

	@Override
	public Boolean removeLike(Map<String, Object> param) {
		logger.info("<< GuestServiceImpl : removeLike >>");
		Boolean is = false;
		if(dao.removeHeart(param)) {
			logger.info("<< removeHeart >>");
			is = dao.removeLike(param);
		}
		return is;
	}

}
