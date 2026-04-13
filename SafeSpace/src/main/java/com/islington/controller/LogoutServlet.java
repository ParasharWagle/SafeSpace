package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * LogoutServlet — handles user logout for SafeSpace.
 * Mapped to /logout — invalidates the current session
 * and redirects the user to the login page.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    /**
     * doGet — processes the logout request.
     * Invalidates the current session to clear all user data
     * and redirects to the login page.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve the current session without creating a new one
        HttpSession session = req.getSession(false);

        // If a session exists, invalidate it to clear all stored attributes
        if (session != null) {
            session.invalidate();
        }

        // Redirect to the login page after logout
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
