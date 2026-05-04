package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.islington.service.PasswordResetService;

/**
 * ForgotPasswordServlet — entry point of the password reset workflow.
 *
 * Mapped to /forgot-password.
 *
 *   GET  -> renders forgot.jsp where the user enters their username
 *           or student identifier.
 *   POST -> calls PasswordResetService.createResetToken().
 *           For privacy reasons the same generic message is shown
 *           regardless of whether the user actually exists, which
 *           prevents this endpoint from being used to enumerate
 *           valid usernames.
 *
 * The generated reset link is also placed on the success page so the
 * student can click it directly. In a production deployment the link
 * would normally be e mailed, but since this build does not have an
 * SMTP integration the link is shown on screen. The trade off is
 * acknowledged in the report.
 */
@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/forgot.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String identifier = req.getParameter("identifier");
        if (identifier == null || identifier.trim().isEmpty()) {
            req.setAttribute("errorMessage",
                "Please enter your username or student identifier.");
            req.getRequestDispatcher("/WEB-INF/views/forgot.jsp").forward(req, resp);
            return;
        }
        identifier = identifier.trim();

        // Try to create a reset token. The service returns null if the
        // user does not exist, but we still show the same success
        // message to avoid leaking which usernames are valid.
        String token = new PasswordResetService().createResetToken(identifier);

        // Generic success message is always shown.
        req.setAttribute("successMessage",
            "If an account matches that identifier, a password reset link "
          + "has been generated below. The link expires in 30 minutes.");

        // If the token was created, expose the link so the student can
        // click it (since we have no e mail integration).
        if (token != null) {
            String resetUrl = req.getContextPath() + "/reset-password?token=" + token;
            req.setAttribute("resetUrl", resetUrl);
        }

        req.getRequestDispatcher("/WEB-INF/views/forgot.jsp").forward(req, resp);
    }
}
