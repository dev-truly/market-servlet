package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.service.BoardAttachService;
import com.example.marketproject.service.BoardService;
import com.example.marketproject.vo.BoardVO;
import com.google.gson.Gson;
import com.google.gson.JsonParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BoardViewServlet", urlPatterns = {"/api/board/notice/view", "/api/board/free/view"})
public class BoardViewServlet extends HttpServlet {
    JsonParser jsonParser = new JsonParser();
    Gson gson = new Gson();
    BoardService boardService = new BoardService();
    BoardAttachService boardAttachService = new BoardAttachService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Util.ajaxJsonSet(req, resp, "UTF-8"); // ajax 통신 전용 req, resp set 메소드
        PrintWriter out = resp.getWriter();

        Map<String, Object> resultData = new HashMap<>();
        if (req.getParameter("boardNo") == null) {
            resultData.put("result", false);
            resultData.put("err_code", "01");
        }
        else {
            try {
                Long boardNo = Long.parseLong(req.getParameter("boardNo"));
                String boardCode = Util.pathVariable(req, 3);

                BoardVO board = boardService.findBoardDetail(boardNo, boardCode);

                if (board == null) {
                    resultData.put("result", false);
                    resultData.put("err_code", "02");
                }
                else {
                    resultData.put("result", true);
                    resultData.put("data", board);
                    if (board.getAttachCnt() > 0) {
                        resultData.put("attachData", boardAttachService.boardAttachList(board.getBoardNo()));
                    }
                }
            } catch (NumberFormatException e) {
                resultData.put("result", false);
                resultData.put("err_code", "03");
            }
        }

        String jsonData = gson.toJson(resultData);
        out.print(jsonData);
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
