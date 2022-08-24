package com.example.marketproject.servlet.account;

import com.example.marketproject.config.Function;
import com.example.marketproject.service.AccountService;
import com.example.marketproject.vo.MemberVO;
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

@WebServlet(name = "LoginServlet", value = "/account/login")
public class LoginServlet extends HttpServlet {
    HttpSession session;
    AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/account/login.jsp");
        rd.forward(req, resp);
    }

    // 회원 가입 여부 체크
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        Map<Object, Object> resultData = new HashMap<>();

        req.setCharacterEncoding("UTF-8");

        JsonParser jsonParser1 = new JsonParser();
        JsonElement je = jsonParser1.parse(Function.readBody(req));

        MemberVO member = accountService.findMemberByIdAndPasswd(
                je.getAsJsonObject().get("memberId").getAsString(),
                je.getAsJsonObject().get("passwd").getAsString()
        );

        if (member != null) {
            session = req.getSession();
            session.setAttribute("loginmember", member);
            resultData.put("result", true);
        }
        else {
            resultData.put("result", false);
        }
        //resultData.put("result", accountService.memberIdCheck());
        //resultData.put("result", accountService.memberIdCheck(req.getParameter("memberId")));

        Gson jsonParser = new Gson();
        String jsonData = jsonParser.toJson(resultData);

        out.print(jsonData);
        out.flush();
    }
}
