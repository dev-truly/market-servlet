package com.example.marketproject.servlet.account;

import com.example.marketproject.config.Function;
import com.example.marketproject.service.AccountService;
import com.example.marketproject.vo.MemberVO;
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

@WebServlet(urlPatterns = {"/account/join-check"})
public class MemberCheckServlet extends HttpServlet {
	private MemberVO member = new MemberVO();
	private AccountService accountService = new AccountService();

	private Gson jsonParser = new Gson();

	//화면 요청에 대한 화면 응답
	/*@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/account/register.jsp");
		rd.forward(req, resp);
	}*/
	
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

		resultData.put("result", accountService.memberIdCheck(je.getAsJsonObject().get("memberId").getAsString()));
		//resultData.put("result", accountService.memberIdCheck(req.getParameter("memberId")));

		String jsonData = jsonParser.toJson(resultData);

		out.print(jsonData);
		out.flush();
	}
}
