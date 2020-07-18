package com.mvc.circle.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.circle.model.vo.GuestbookVO;

@Repository
public class GuestDaoImpl implements GuestDao{
	Logger logger = LoggerFactory.getLogger(GuestDaoImpl.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<GuestbookVO> listGuestbook(int startRow,int endRow) {
		logger.info("<< GuestDaoImpl : listGuestbook >>");
		
		List<GuestbookVO> list = new ArrayList<GuestbookVO>();
		Map<String,Integer> param = new HashMap<String,Integer>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		try {
			list = sqlSession.selectList(NAMESPACE+"listGuestbook",param);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}
		
		return list;
	}

	@Override
	public int totalGuestbook() {
		logger.info("<< GuestDaoImpl : totalGuestbook >>");
		int count = 0;
		
		try {
			count = sqlSession.selectOne(NAMESPACE+"totalGuestbook");
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}
		
		return count;
	}

	@Override
	public Boolean addGuestbook(GuestbookVO guestbook) {
		logger.info("<< GuestDaoImpl : addGuestbook >>");
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"addGuestbook",guestbook);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (res>0)?true:false;
	}

	@Override
	public Boolean modifyGuestbook(GuestbookVO guestbook) {
		logger.info("<< GuestDaoImpl : modifyGuestbook >>");
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"modifyGuestbook",guestbook);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (res>0)?true:false;
	}

	@Override
	public Boolean deleteGuestbook(Integer guest_no) {
		logger.info("<< GuestDaoImpl : deleteGuestbook >>");
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteGuestbook",guest_no);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (res>0)?true:false;
	}

	@Override
	public Boolean checkLike(Map<String, Object> param) {
		logger.info("<< GuestDaoImpl : checkLike >>");
		String user_email=null;
		try {
			user_email = sqlSession.selectOne(NAMESPACE+"checkLike",param);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (user_email!=null)?true:false;
	}

	@Override
	public Boolean removeLike(Map<String, Object> param) {
		logger.info("<< GuestDaoImpl : removeLike >>");
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"removeLike",param);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (res>0)?true:false;
	}

	@Override
	public Boolean addLike(Map<String, Object> param) {
		logger.info("<< GuestDaoImpl : addLike >>");
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"addLike",param);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (res>0)?true:false;
	}

	@Override
	public Boolean addHeart(Map<String, Object> param) {
		logger.info("<< GuestDaoImpl : addHeart >>");
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"addHeart",param.get("guest_no"));
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (res>0)?true:false;
	}

	@Override
	public boolean removeHeart(Map<String, Object> param) {
		logger.info("<< GuestDaoImpl : removeHeart >>");
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"removeHeart",param);
		} catch (Exception e) {
			logger.error("<< GuestDaoImpl : error >>");
			logger.error(e.getMessage());
		}

		return (res>0)?true:false;
	}

}
