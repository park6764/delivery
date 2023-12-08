package com.korea.js.dao;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.Acorn;

@Mapper
public interface AcornDao {
	/**
	 * 도토리 충전
	 * @param acorn 도토리 기록
	 * @return 충전 성공 시 1, 실패 시 0;
	 */
	public int acornCharging(Acorn acorn);
}
