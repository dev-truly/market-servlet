package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.service.BoardConfigService;
import com.example.marketproject.vo.BoardConfigVO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DefaultBoardWriteServlet", urlPatterns = {"/board/free/write"})
public class DefaultBoardWriteServlet extends HttpServlet {
    BoardConfigService boardConfigService = new BoardConfigService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String boardType = Util.pathVariable(req, 2);

        BoardConfigVO boardConfig = boardConfigService.getBoardName(boardType);

        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/board/default/write.jsp?board=" + boardType + "&boardName=" + boardConfig.getBoardName() + "&" + req.getQueryString());
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
