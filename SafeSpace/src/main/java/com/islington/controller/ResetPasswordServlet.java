package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.service.PasswordResetService;

/**
 * ResetPasswordServlet — completes the password reset workflow.
 *
 * Mapped to /reset-password. Expects a 'token' query parameter on
 * both GET and POST so the page knows which user to update.
 *
 *   GET  -> validates the token. If valid, renders reset.jsp with the
 *           token kept in a hidden field. If invalid or expired, it
 *           shows an error page that links back to the forgot password
 *           form.
 *   POST -> validates the token again, validates the two new password
 *           fields against each other, calls PasswordResetService
 *           .updatePassword and redirects to /login on success with
 *           a success flash so the login page can show a green banner.
 */
@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String token = req.getParameter("token");
        String username = new PasswordResetService().findUsernameByToken(token);
        if (username == null) {
            req.setAttribute("errorMessage",
                "This password reset link is invalid or has expired. "
              + "Please request a new one.");
            req.getRequestDispatcher("/WEB-INF/views/reset.jsp").forward(req, resp);
            return;
        }

        // Token valid — pass it through to the form so the POST has it
        req.setAttribute("token", token);
        req.setAttribute("username", username);
        req.getRequestDispatcher("/WEB-INF/views/reset.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String token = req.getParameter("token");
        String pwd1  = req.getParameter("password");
        String pwd2  = req.getParameter("confirmPassword");

        // Re validate the token on every POST, in case it expired
        // between the GET render and the form submission.
        PasswordResetService service = new PasswordResetService();
        String username = service.findUsernameByToken(token);
        if (username == null) {
            req.setAttribute("errorMessage",
                "This password reset link is invalid or has expired.");
            req.getRequestDispatcher("/WEB-INF/views/reset.jsp").forward(req, resp);
            return;
        }

        // Server side validation of the new password
        if (pwd1 == null || pwd1.length() < 6) {
            req.setAttribute("errorMessage",
                "Password must be at least 6 characters long.");
            req.setAttribute("token", token);
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/views/reset.jsp").forward(req, resp);
            return;
        }
        if (!pwd1.equals(pwd2)) {
            req.setAttribute("errorMessage",
                "The two passwords do not match. Please try again.");
            req.setAttribute("token", token);
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/views/reset.jsp").forward(req, resp);
            return;
        }

        // Apply the change. The service also clears the reset token
        // and resets the failed attempt counter so a previously locked
        // account is unlocked at the same moment its password changes.
        boolean ok = service.updatePassword(username, pwd1);
        if (!ok) {
            req.setAttribute("errorMessage",
                "Could not update the password. Please try again.");
            req.setAttribute("token", token);
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/views/reset.jsp").forward(req, resp);
            return;
        }

        // Clear any lingering session and redirect to login with a flash
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
        resp.sendRedirect(req.getContextPath() + "/login?reset=true");
    }
}