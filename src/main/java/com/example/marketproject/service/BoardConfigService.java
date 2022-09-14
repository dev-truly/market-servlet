package com.example.marketproject.service;

import com.example.marketproject.repository.BoardConfigRepository;
import com.example.marketproject.vo.BoardConfigVO;

import java.util.List;

public class BoardConfigService {
    BoardConfigRepository boardConfigRepository = new BoardConfigRepository();
    public BoardConfigVO getBoardName(String boardCode) {
        BoardConfigVO boardConfig = boardConfigRepository.selectByFindBoardCode(boardCode);

        return boardConfig;
    }
}
