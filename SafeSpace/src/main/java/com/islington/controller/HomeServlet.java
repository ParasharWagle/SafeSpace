package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * HomeServlet — handles the public landing page of SafeSpace.
 * Mapped to /home — no authentication required.
 * Simply forwards the request to the home.jsp view.
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    /**
     * doGet — handles GET requests to the home page.
     * Forwards the request to the home.jsp view inside WEB-INF.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Forward to the home view — JSP handles presentation only
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}
