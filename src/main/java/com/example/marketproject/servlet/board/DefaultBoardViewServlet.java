package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.service.BoardConfigService;
import com.example.marketproject.service.BoardService;
import com.example.marketproject.vo.BoardConfigVO;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "DefaultBoardViewServlet", urlPatterns = {"/board/notice/view", "/board/free/view"})
public class DefaultBoardViewServlet extends HttpServlet {
    BoardConfigService boardConfigService = new BoardConfigService();
    BoardService boardService = new BoardService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String boardType = Util.pathVariable(req, 2);

        BoardConfigVO boardConfig = boardConfigService.getBoardName(boardType);

        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/board/default/view.jsp?board=" + boardType + "&boardName=" + boardConfig.getBoardName() + "&" + req.getQueryString());
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        Map<Object, Object> resultData = new HashMap<>();

        req.setCharacterEncoding("UTF-8");

        JsonParser jsonParser = new JsonParser();
        JsonElement je = jsonParser.parse(Util.readBody(req));
        boolean result = boardService.boardPasswordCheck(
            je.getAsJsonObject().get("boardNo").getAsLong(),
                Util.getHashedString(je.getAsJsonObject().get("boardPassword").getAsString(), "sha-1")
        );

        resultData.put("result", result);
        Gson gson = new Gson();
        String jsonData = gson.toJson(resultData);
        out.print(jsonData);
        out.flush();
        //gson.
    }
}
