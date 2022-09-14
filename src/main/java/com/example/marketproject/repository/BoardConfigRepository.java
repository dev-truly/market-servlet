package com.example.marketproject.repository;

import com.example.marketproject.vo.BoardConfigVO;
import com.example.marketproject.vo.MemberVO;

import java.util.List;

public class BoardConfigRepository extends AbstractRepository<BoardConfigVO>  {
	public BoardConfigRepository() {
		super(BoardConfigVO.class);
	}

	public BoardConfigVO selectByFindBoardCode(String boardCode) {
		BoardConfigVO boardConfig = null;
		List<BoardConfigVO> boardConfigList = selectByQuery(
			String.format("Select board_name, board_code from board_config where board_code = '%s'", boardCode)
		);

		if (boardConfigList.size() > 0) {
			boardConfig = boardConfigList.get(0);
		}

		return boardConfig;
	}
}
