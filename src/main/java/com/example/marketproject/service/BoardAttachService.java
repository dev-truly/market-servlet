package com.example.marketproject.service;

import com.example.marketproject.repository.BoardAttachRepository;
import com.example.marketproject.repository.BoardRepository;
import com.example.marketproject.vo.BoardAttachVO;
import com.example.marketproject.vo.BoardVO;

import java.util.List;

public class BoardAttachService {
    List<BoardAttachVO> boardAttachList;
    BoardAttachVO boardAttachVO;
    BoardAttachRepository boardAttachRepository;

    public int boardAttachSave(BoardAttachVO boardAttach) {
        boardAttachRepository = new BoardAttachRepository();
        int result = boardAttachRepository.save(boardAttach);

        return result;
    }

    public List<BoardAttachVO> boardAttachList(Long boardNo) {
        boardAttachRepository = new BoardAttachRepository();
        return boardAttachRepository.selectByBoardNo(boardNo);
    }

    public boolean boardAttachDelete(Long attachNo) {
        boolean resultFlag = false;
        boardAttachRepository = new BoardAttachRepository();
        int result = boardAttachRepository.deleteById(attachNo);
        if (result > 0) resultFlag = true;

        return resultFlag;
    }

    public int boardAttachCount(Long boardNo) {
        boardAttachRepository = new BoardAttachRepository();
        return boardAttachRepository.selectAttachCntByBoardNo(boardNo);
    }

}
