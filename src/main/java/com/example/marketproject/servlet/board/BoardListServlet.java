package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.service.BoardConfigService;
import com.example.marketproject.service.BoardService;
import com.example.marketproject.vo.BoardConfigVO;
import com.example.marketproject.vo.BoardVO;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BoardListServlet", urlPatterns = {"/api/board/notice/list", "/api/board/free/list"})
public class BoardListServlet extends HttpServlet {
    JsonParser jsonParser = new JsonParser();
    Gson gson = new Gson();
    BoardService boardService = new BoardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Util.ajaxJsonSet(req, resp, "UTF-8"); // ajax 통신 전용 req, resp set 메소드
        PrintWriter out = resp.getWriter();

        Map<String, Object> resultData = new HashMap<>();

        int pageNo = (req.getParameter("pageNo") == null) ? 1 : Integer.parseInt(req.getParameter("pageNo"));
        int pageSize = (req.getParameter("pageSize") == null) ? 10 : Integer.parseInt(req.getParameter("pageSize"));
        int paginationLength = (req.getParameter("paginationLength") == null) ? 10 : Integer.parseInt(req.getParameter("paginationLength"));
        String searchType = (req.getParameter("searchType") == null) ? null : req.getParameter("searchType");
        String searchValue = (req.getParameter("searchValue") == null) ? null : req.getParameter("searchValue");
        int from = (pageNo - 1) * pageSize;
        int to = from + pageSize;

        String boardCode = Util.pathVariable(req, 3);
        int totalCount = boardService.findBoardCodeTotalCount(boardCode, searchType, searchValue);
        resultData.put("totalCount", totalCount);

        int lastPageNo = (int)Math.ceil(totalCount / pageSize);

        if (totalCount > 0 && lastPageNo + 1 >= pageNo) {
            while (true) {
                List<BoardVO> boardList = boardService.findBoardByPage(from, to,
                        boardCode, searchType, searchValue
                );

                if (boardList.size() > 0) {
                    resultData.put("result", true);
                    resultData.put("data", boardList);
                    break;
                }
            }
        }
        else {
            resultData.put("result", false);
            resultData.put("err_code", "02");
        }

        String jsonData = gson.toJson(resultData);
        out.print(jsonData);
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
