package com.korea.js.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.Menu;

@Mapper
public interface MenuDao {
	/**
	 * 메뉴 추가
	 * @param menu 메뉴 정보
	 * @return 추가 성공 시 1, 실패 시 0;
	 */
	public int addMenu(Menu menu);
	/**
	 * 메뉴 리스트
	 * @param restaurantId 레스토랑 아이디
	 * @return 메뉴 리스트
	 */
	public List<Menu> menus(Long restaurantId);
}
