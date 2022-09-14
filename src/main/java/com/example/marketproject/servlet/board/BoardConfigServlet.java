package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.service.BoardConfigService;
import com.example.marketproject.vo.BoardConfigVO;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "BoardConfigServlet", value = "/board-config/code")
public class BoardConfigServlet extends HttpServlet {
    JsonParser jsonParser = new JsonParser();
    Gson gson = new Gson();
    BoardConfigService boardConfigService = new BoardConfigService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Util.ajaxJsonSet(req, resp, "UTF-8"); // ajax 통신 전용 req, resp set 메소드
        PrintWriter out = resp.getWriter();

        Map<String, Object> resultData = new HashMap<>();

        JsonElement je = jsonParser.parse(Util.readBody(req));
        BoardConfigVO boardConfig = boardConfigService.getBoardName(
                req.getParameter("boardCode")
        );
        if (boardConfig == null) {
            resultData.put("result", false);
        } else {
            resultData.put("result", true);
            resultData.put("data", boardConfig);
        }

        String jsonData = gson.toJson(resultData);

        out.print(jsonData);
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
