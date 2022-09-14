package com.example.marketproject.servlet.board;

import com.example.marketproject.common.Util;
import com.example.marketproject.config.Function;
import com.example.marketproject.service.BoardAttachService;
import com.example.marketproject.service.BoardService;
import com.example.marketproject.vo.BoardAttachVO;
import com.example.marketproject.vo.BoardVO;
import com.example.marketproject.vo.MemberVO;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.MultipartParser;
import org.apache.taglibs.standard.lang.jstl.test.PageContextImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.servlet.jsp.PageContext;
import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "BoardWriteServlet", value = "/api/board/free/write")
public class BoardWriteServlet extends HttpServlet {
    HttpSession session;
    BoardService boardService = new BoardService();
    BoardAttachService boardAttachService = new BoardAttachService();
    Gson gson = new Gson();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Util.ajaxJsonSet(req, resp, "UTF-8"); // ajax 통신 전용 req, resp set 메소드
        session = req.getSession(false);
        PrintWriter out = resp.getWriter();

        String path = req.getServletContext().getRealPath("/WEB-INF/board-upload/");

        Map<String, Object> resultData = new HashMap<>();

        BoardVO board = new BoardVO();
        String boardCode = Util.pathVariable(req, 3);
        board.setRef(boardService.getBoardRef(boardCode) + 1);
        MultipartRequest multi = new MultipartRequest(
                req,
                path,
                1024 * 1024 * 30,
                "UTF-8",
                new DefaultFileRenamePolicy()
        );

        board.setBoardCode(boardCode);
        board.setTitle(multi.getParameter("title"));
        board.setPassword(Util.getHashedString(multi.getParameter("password"), "sha-1"));
        board.setContent(multi.getParameter("content"));
        board.setWriter(multi.getParameter("writer"));

        if (session != null && session.getAttribute("loginmember") != null) {
            MemberVO loginmember = (MemberVO) session.getAttribute("loginmember");
            board.setMemberNo(loginmember.getMemberNo());
        }

        int result = boardService.boardWrite(board);
        resultData.put("result", (result > 0) ? true : false);
        if (result > 0) {
            board.setBoardNo((long)result);
            BoardAttachVO boardAttach;
            int attachCount = 0;
            try {
                Enumeration files = multi.getFileNames();
                while (files.hasMoreElements()) {
                    boardAttach = new BoardAttachVO();
                    boardAttach.setBoardNo(board.getBoardNo());

                    String str = (String) files.nextElement();

                    String serverFileName = multi.getFilesystemName(str);

                    if (serverFileName != null) {
                        String oriFileName = multi.getOriginalFileName(str);
                        File oldFile = new File(path + serverFileName);

                        serverFileName = Util.makeUniqueFileName(serverFileName);
                        File newFile = new File(path + serverFileName);

                        oldFile.renameTo(newFile);

                        boardAttach.setOriFileName(oriFileName);
                        boardAttach.setServerFileName(serverFileName);
                        boardAttachService.boardAttachSave(boardAttach);

                        attachCount++;
                    }
                }

                if (attachCount > 0) {
                    board.setAttachCnt(attachCount);
                    boardService.boardUpdate(board);
                }
            } catch (Exception e) {
                e.printStackTrace();
                //throw new RuntimeException(e);
            }
        }

        String jsonData = gson.toJson(resultData);

        out.print(jsonData);
        out.flush();
    }
}
