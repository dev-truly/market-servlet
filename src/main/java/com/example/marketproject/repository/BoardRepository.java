package com.example.marketproject.repository;

import com.example.marketproject.vo.BoardConfigVO;
import com.example.marketproject.vo.BoardVO;

import java.util.List;

public class BoardRepository extends AbstractRepository<BoardVO>  {
	public BoardRepository() {
		super(BoardVO.class);
	}

	public Long selectMaxRef(String boardCode) {
		List<BoardVO> boardList = selectByQuery(String.format("Select max(ref) ref from board where board_code = '%s' and `delete` = 'n'", boardCode));
		Long result = 0L;
		if (boardList.size() > 0) {
			result = boardList.get(0).getRef();
		}
		return result;
	}

	public List<BoardVO> selectByFindBoardNoAndBoardCode(Long boardNo, String boardCode) {
		List<BoardVO> boardList = selectByQuery(String.format("Select board_no, board_code, title, writer, read_count, content, reg_date, attach_cnt from board where board_code = '%s' and board_no = %d and `delete` = 'n'",
				boardCode, boardNo));

		return boardList;
	}

	public List<BoardVO> selectByFindPageSearch(int from, int to, String boardCode,
												String searchType, String searchValue) {
		String query;
		if (searchValue != null && !searchValue.isEmpty()) {
			query = String.format("Select board_no, board_code, title, writer, read_count, reg_date, attach_cnt from board where board_code = '%s' and %s like '%s' and `delete` = 'n' order by ref desc, step limit %d OFFSET %d",
					boardCode, searchType, "%" + searchValue + "%", to - from, from);
		}
		else {
			query = String.format("Select board_no, board_code, title, writer, read_count, reg_date, attach_cnt from board where board_code = '%s' and `delete` = 'n' order by ref desc, step limit %d OFFSET %d",
					boardCode, to - from, from);
		}

		List<BoardVO> board = selectByQuery(query);

		return board;
	}

	public int findBoardCodeTotalCount(String boardCode, String searchType, String searchValue) {
		String query;
		if (searchValue != null && !searchValue.isEmpty()) {
			query = String.format("Select count(*) from board where board_code = '%s' and %s like '%s' and `delete` = 'n'",
					boardCode, searchType, "%" + searchValue + "%");
		}
		else {
			query = String.format("Select count(*) from board where board_code = '%s' and `delete` = 'n'",
					boardCode);
		}

		return queryCount(query);
	}

	public int selectByFindBoardNoAndPassword(Long boardNo, String boardPassword) {
		int boardCnt = 0;
		boardCnt = queryCount(String.format("Select count(*) cnt From board Where board_no = %d and password = '%s'",
				boardNo, boardPassword
			)
		);

		return boardCnt;
	}

	public int deleteByFindBoardNoAndBoardCode(Long boardNo, String boardCode) {
		return updateByQuery(String.format("Update board Set `delete` = 'y' Where board_no = %d and board_code = '%s'", boardNo, boardCode));
	}

	public int updateAttachCntByFindBoardNo(Long boardNo, int attachCount) {
		return updateByQuery(String.format("Update board Set attach_cnt = %d Where board_no = %d", attachCount, boardNo));
	}
}
