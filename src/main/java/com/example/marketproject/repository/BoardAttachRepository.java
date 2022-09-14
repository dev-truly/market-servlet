package com.example.marketproject.repository;

import com.example.marketproject.vo.BoardAttachVO;
import com.example.marketproject.vo.BoardVO;

import java.util.List;

public class BoardAttachRepository extends AbstractRepository<BoardAttachVO>  {
	public BoardAttachRepository() {
		super(BoardAttachVO.class);
	}

	public List<BoardAttachVO> selectByBoardNo(Long boardNo) {
		List<BoardAttachVO> boardAttachList = selectByQuery(String.format("Select attach_no, board_no, ori_file_name, server_file_name from board_attach where board_no = %d", boardNo));

		return boardAttachList;
	}

	public int selectAttachCntByBoardNo(Long boardNo) {
		int result = queryCount(String.format("Select count(*) cnt where board_no = %d", boardNo));

		return result;
	}
}
