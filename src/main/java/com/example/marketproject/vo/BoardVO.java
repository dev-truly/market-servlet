package com.example.marketproject.vo;

import lombok.Data;

import java.util.Date;

// Member 테이블의 데이터를 저장하는 VO클래스

/*** 문서 정보를 저장하는 주석
 *  @author instructor
 */
@Data
public class BoardVO {
	public final static String TABLENAME = "board";
	public final static String INDEXNAME = "boardNo";

	private Long boardNo;
	private String boardCode;
	private Long ref;
	private int depth;
	private int step;
	private String title;
	private String content;
	private String password;
	private String writer;
	private Long memberNo;
	private int attachCnt;
	private Date modifyDate;
	private int readCount;
	private String delete;
	private Date regDate;
}
