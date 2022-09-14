package com.example.marketproject.service;

import com.example.marketproject.repository.BoardRepository;
import com.example.marketproject.vo.BoardVO;

import java.util.List;

public class BoardService {
    List<BoardVO> boardList;
    BoardVO board;
    BoardRepository boardRepository;

    public BoardVO findBoardDetail(Long boardNo, String boardCode) {
        boardRepository = new BoardRepository();
        BoardVO board = null;
        List<BoardVO> boardList = boardRepository.selectByFindBoardNoAndBoardCode(boardNo, boardCode);

        if (boardList.size() > 0) {
            board = boardList.get(0);
            board.setReadCount(board.getReadCount() + 1);
            boardRepository.update(board);
        }

        return board;
    }
    public List<BoardVO> findBoardByPage (int from, int to, String boardCode, String searchType, String searchValue) {
        boardRepository = new BoardRepository();
        boardList = boardRepository.selectByFindPageSearch(from, to, boardCode, searchType, searchValue);

        return boardList;
    }

    public Long getBoardRef(String boardCode) {
        boardRepository = new BoardRepository();
        return boardRepository.selectMaxRef(boardCode);
    }

    public int findBoardCodeTotalCount(String boardCode, String searchType, String searchValue) {
        boardRepository = new BoardRepository();
        return boardRepository.findBoardCodeTotalCount(boardCode, searchType, searchValue);
    }

    public int boardWrite(BoardVO board) {
        boardRepository = new BoardRepository();
        int result = boardRepository.save(board);

        return result;
    }

    public int boardUpdate(BoardVO board) {
        return boardRepository.update(board);
    }

    public boolean boardPasswordCheck(Long boardNo, String boardPassword) {
        boolean result = false;
        boardRepository = new BoardRepository();
        if (boardRepository.selectByFindBoardNoAndPassword(boardNo, boardPassword) > 0)
            result = true;

        return result;
    }

    public boolean boardDelete(Long boardNo, String boardCode) {
        boolean result = false;
        boardRepository = new BoardRepository();
        int deleteFlag = boardRepository.deleteByFindBoardNoAndBoardCode(boardNo, boardCode);
        if (deleteFlag > 0) result = true;

        return result;
    }
}
