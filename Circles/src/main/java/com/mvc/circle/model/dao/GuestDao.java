package com.mvc.circle.model.dao;

import java.util.List;
import java.util.Map;

import com.mvc.circle.model.vo.GuestbookVO;

public interface GuestDao {
	String NAMESPACE = "guestbook.";
	List<GuestbookVO> listGuestbook(int startRow,int endRow);
	int totalGuestbook();
	Boolean addGuestbook(GuestbookVO guestbook);
	Boolean modifyGuestbook(GuestbookVO guestbook);
	Boolean deleteGuestbook(Integer guest_no);
	Boolean checkLike(Map<String, Object> param);
	Boolean removeLike(Map<String, Object> param);
	Boolean addLike(Map<String, Object> param);
	Boolean addHeart(Map<String, Object> param);
	boolean removeHeart(Map<String, Object> param);

}
