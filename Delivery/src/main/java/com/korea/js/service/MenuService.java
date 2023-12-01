package com.korea.js.service;

import java.util.List;

import com.korea.js.vo.Menu;

import jakarta.servlet.http.HttpServletRequest;

public interface MenuService {
	/**
	 * 메뉴 추가
	 * @param menu 메뉴 정보
	 * @return 추가 성공 시 1, 실패 시 0;
	 */
	public int addMenu(Menu menu, HttpServletRequest request);
	/**
	 * 메뉴 리스트
	 * @return 메뉴 리스트
	 */
	public List<Menu> menus();
}
