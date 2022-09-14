package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.repository.BoardRepository;
import com.example.marketproject.service.BoardService;
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

@WebServlet(name = "DefaultBoardDeleteServlet", value = "/board/free/delete")
public class DefaultBoardDeleteServlet extends HttpServlet {
    BoardService boardService = new BoardService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Util.ajaxJsonSet(req, resp, "UTF-8");
        PrintWriter out = resp.getWriter();

        JsonParser jsonParser = new JsonParser();
        JsonElement je = jsonParser.parse(Util.readBody(req));
        Map<String, Object> resultMap = new HashMap<>();

        String boardCode = Util.pathVariable(req, 2);

        resultMap.put("result",
            boardService.boardDelete(je.getAsJsonObject().get("boardNo").getAsLong(), boardCode)
        );

        Gson gson = new Gson();
        out.print(gson.toJson(resultMap));
        out.flush();
    }
/*
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }*/
}
