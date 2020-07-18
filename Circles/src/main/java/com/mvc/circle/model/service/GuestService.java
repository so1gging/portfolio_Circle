package com.mvc.circle.model.service;

import java.util.List;
import java.util.Map;

import com.mvc.circle.model.vo.GuestbookVO;
import com.mvc.circle.model.vo.Paging;

public interface GuestService {

	List<GuestbookVO> listGuestbook(Paging paging);

	Paging guestbookPaging(Integer page);

	Boolean addGuestbook(GuestbookVO guestbook);

	Boolean modifyGuestbook(GuestbookVO guestbook);

	Boolean deleteGuestbook(Integer guest_no);

	Boolean addLike(Map<String, Object> param);

	Boolean checkLike(Map<String, Object> param);

	Boolean removeLike(Map<String, Object> param);
	
}
