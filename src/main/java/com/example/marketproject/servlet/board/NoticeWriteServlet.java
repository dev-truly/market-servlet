package com.example.marketproject.servlet.board;

import com.example.marketproject.repository.BoardRepository;
import com.example.marketproject.vo.BoardVO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

@WebServlet(name = "NoticeWriteServlet", value = "/NoticeWriteServlet")
public class NoticeWriteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BoardVO board = new BoardVO();
        String url = "https://www.jakomo.co.kr/board/view.php?&bdId=notice&sno=%d";
        Long ref = 1L;
        BoardRepository boardRepository = new BoardRepository();
        for (int i = 1; i <= 381; i++) {
            Document doc = Jsoup.connect(String.format(url, i)).get();
            Iterator<Element> iter = doc.select("div.board_zone_view h3").iterator();
            while (iter.hasNext()) {
                board.setTitle(iter.next().text());
                board.setContent(doc.select("div.board_view_content").get(0).html());
                try {
                    board.setRegDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(doc.select("span.view_info_day  em").get(0).text().replaceAll("[.]", "-")));
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }
            }

            board.setBoardCode("notice");
            board.setRef(ref);
            board.setDelete("n");
            board.setWriter("작성자");
            int result = boardRepository.save(board);
            if (result > 0) {
                System.out.println("성공");
            }
            else {
                System.out.println("실패");
            }
            ref++;
        }

        /*


         */

        //https://www.kurly.com/board/notice/detail?no=1854
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
