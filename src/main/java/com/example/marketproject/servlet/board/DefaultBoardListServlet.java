package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.service.BoardConfigService;
import com.example.marketproject.vo.BoardConfigVO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "DefaultBoardListServlet", urlPatterns = {"/board/notice/list", "/board/free/list"})
public class DefaultBoardListServlet extends HttpServlet {

    BoardConfigService boardConfigService = new BoardConfigService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String boardType = Util.pathVariable(req, 2);

        BoardConfigVO boardConfig = boardConfigService.getBoardName(boardType);

        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/board/default/list.jsp?board=" + boardType + "&boardName=" + boardConfig.getBoardName() + "&" + req.getQueryString());
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
