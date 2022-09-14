package com.example.marketproject.vo;

import lombok.Data;

import java.util.Date;

// Member 테이블의 데이터를 저장하는 VO클래스

/*** 문서 정보를 저장하는 주석
 *  @author instructor
 */
@Data
public class BoardConfigVO {
	public final static String TABLENAME = "board_config";
	public final static String INDEXNAME = "boardConfigNo";

	private Long boardConfigNo;
	private String boardName;
	private String boardCode;
	private String regDate;
}
