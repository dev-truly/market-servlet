package com.example.marketproject.servlet.account;

import com.example.marketproject.config.Function;
import com.example.marketproject.service.AccountService;
import com.example.marketproject.vo.MemberVO;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "SignUpServlet", value = "/account/signup")
public class SignUpServlet extends HttpServlet {
    MemberVO member = new MemberVO();
    AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/account/signup.jsp");
        rd.forward(req, resp);
    }

    // 등록 처리 요청에 대한 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        req.setCharacterEncoding("UTF-8");

        Map<Object, Object> resultData = new HashMap<>();

        JsonParser jsonParser = new JsonParser();
        JsonElement je = jsonParser.parse(Function.readBody(req));

        member.setMemberId(je.getAsJsonObject().get("memberId").getAsString());
        member.setPassword(je.getAsJsonObject().get("passwd").getAsString());
        member.setEmail(je.getAsJsonObject().get("email").getAsString());
        member.setMemberName(je.getAsJsonObject().get("memberName").getAsString());
        member.setTel(je.getAsJsonObject().get("tel").getAsString());

        // 2. 데이터 처리 -> 데이터 베이스에 저장
        int result = accountService.registerMember(member);

        resultData.put("result", accountService.memberIdCheck(je.getAsJsonObject().get("memberId").getAsString()));

        Gson gson = new Gson();
        String jsonData = gson.toJson(resultData);
        out.print(jsonData);
        out.flush();
    }
}
