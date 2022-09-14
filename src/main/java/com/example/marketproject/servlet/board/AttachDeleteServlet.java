package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.repository.AbstractRepository;
import com.example.marketproject.repository.BoardAttachRepository;
import com.example.marketproject.service.BoardAttachService;
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

@WebServlet(name = "AttachDeleteServlet", value = "/board/attach/delete")
public class AttachDeleteServlet extends HttpServlet {
    BoardAttachService boardAttachService = new BoardAttachService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Util.ajaxJsonSet(req, resp, "UTF-8");
        PrintWriter out = resp.getWriter();

        String path = req.getServletContext().getRealPath("/WEB-INF/board-upload/");

        JsonParser jsonParser = new JsonParser();
        JsonElement je = jsonParser.parse(Util.readBody(req));
        Map<String, Object> resultMap = new HashMap<>();

        boolean result = false;
        AbstractRepository.setTransaction();

        /*boolean attachDataResult = boardAttachService.boardAttachDelete(je.getAsJsonObject().get("attachNo").getAsLong());
        if (attachDataResult) {
            System.out.println(boardAttachService.boardAttachCount(je.getAsJsonObject().get("boardNo").getAsLong()));
        }*/
        AbstractRepository.transactionProcess(result);
        resultMap.put("result", result);

        Gson gson = new Gson();
        out.print(gson.toJson(resultMap));
        out.flush();
    }
}
