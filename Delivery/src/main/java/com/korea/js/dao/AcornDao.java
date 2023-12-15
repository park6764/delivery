package com.korea.js.dao;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.Acorn;

@Mapper
public interface AcornDao {
	/**
	 * 도토리 충전
	 * @param acorn 도토리 이동 정보
	 * @return 충전 성공 시 1, 실패 시 0;
	 */
	public int acornCharging(Acorn acorn);
	/**
	 * 메뉴 주문
	 * @param acorn 도토리 이동 정보
	 * @return 주문 성공 시 1, 실패 시 0;
	 */
	public int orderAcorn(Acorn acorn);
}
