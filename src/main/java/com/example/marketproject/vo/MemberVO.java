package com.example.marketproject.vo;

import lombok.Data;

import java.util.Date;

// Member 테이블의 데이터를 저장하는 VO클래스

/*** 문서 정보를 저장하는 주석
 *  @author instructor
 */
@Data
public class MemberVO {
	public final static String TABLENAME = "member";
	public final static String INDEXNAME = "memberNo";

	private Long memberNo;
	private String memberId;
	private String password;
	private String memberName;
	private String email;
	private String tel;
	private Date regDate;
	private int memberPoint;
	private int orderCount;
}
