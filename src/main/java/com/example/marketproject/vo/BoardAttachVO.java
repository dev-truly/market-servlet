package com.example.marketproject.vo;

import lombok.Data;

import java.util.Date;

@Data
public class BoardAttachVO {
	public final static String TABLENAME = "board_attach";
	public final static String INDEXNAME = "attachNo";

	private Long attachNo;
	private Long boardNo;
	private String oriFileName;
	private String serverFileName;
	private Date regDate;
}
