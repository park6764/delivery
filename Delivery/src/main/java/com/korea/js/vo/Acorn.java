package com.korea.js.vo;

import lombok.Data;

@Data
public class Acorn {
	private Long acornId;            // 도토리 번호
	private String fromUserId;       // 누가
	private String inputDt;          // 충전 날짜
	private Long inputAcorn;         // 충전 도토리
	private String toUserId;         // 누구에게
	private String outputDt;         // 사용 날짜
	private Long outputAcorn;        // 사용 도토리
	private Long totalAcorn;         // 총 보유 도토리
}
