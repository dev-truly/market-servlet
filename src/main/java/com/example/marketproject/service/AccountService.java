package com.example.marketproject.service;

import com.example.marketproject.common.Util;
import com.example.marketproject.repository.MemberRepository;
import com.example.marketproject.vo.MemberVO;

/**
 * 
 * @author godo
 *
 */
public class AccountService {

	MemberRepository memberRepository = new MemberRepository();

	// 서비스(비즈니스) 로직은 DAO와 다르게 서비스 명을 활용한 메소드명 사용
	// 최초 개발당시 특별한 로직이 구성되지 않으나 추후 비즈니스로직 추가로 인한 별도 클래스 구성의 번거로움을 피하기 위해 선 개발 되는 경우가 많음
	public int registerMember(MemberVO member) {
		
		String passwd = member.getPassword();
		passwd = Util.getHashedString(passwd, "SHA-256");
		member.setPassword(passwd);

		return memberRepository.save(member);
	}

	public boolean memberIdCheck(String memberId) {
		boolean result = true;
		int memberResult = memberRepository.selectByMemberId(memberId);
		if (memberResult == 0) {
			result = false;
		}
		return result;
	}

	public MemberVO findMemberByIdAndPasswd(String memberId, String passwd) {
		
		passwd = Util.getHashedString(passwd, "SHA-256");
		MemberVO member = memberRepository.selectFindByIdAndPassword(memberId, passwd);

		return member;
	}
	
	
}
