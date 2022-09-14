package com.example.marketproject.servlet.board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AttachDownServlet", value = "/board/attach/download")
public class AttachDownServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get PrintWriter object
        PrintWriter out = resp.getWriter();
        // File name
        String serverFileName = req.getParameter("serverFileName");
        String oriFileName = req.getParameter("oriFileName");
        // File path
        String path = req.getServletContext().getRealPath("/WEB-INF/board-upload/");

        // Set the content type and header of the response.
        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition",
                "attachment; filename=\""
                        + oriFileName + "\"");
        // Get FileInputStream object to identify the path
        FileInputStream inputStream = new FileInputStream(path + serverFileName);

        // Loop through the document and write into the
        // output.
        int in;
        while ((in = inputStream.read()) != -1) {
            out.write(in);
        }

        // Close FileInputStream and PrintWriter object
        inputStream.close();
        out.close();
    }
}
