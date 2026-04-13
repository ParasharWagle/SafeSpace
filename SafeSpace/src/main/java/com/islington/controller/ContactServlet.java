package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * ContactServlet — handles the public contact/support page.
 * Mapped to /contact — no authentication required.
 * Supports GET (show form) and POST (process contact submission).
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    /**
     * doGet — displays the contact page with the support form.
     * Simply forwards to the contact.jsp view.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Forward to the contact view — JSP handles presentation only
        req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, resp);
    }

    /**
     * doPost — processes the contact form submission.
     * Validates that the preferred name and message are not empty.
     * Sets a success message and forwards back to the contact page.
     *
     * @param req  the HTTP request object containing form data
     * @param resp the HTTP response object
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve form inputs
        String name     = req.getParameter("name");
        String email    = req.getParameter("email");
        String category = req.getParameter("category");
        String message  = req.getParameter("message");

        // Input validation — name and message are required
        if (name == null    || name.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {

            // Set error message and forward back to contact page
            req.setAttribute("errorMessage", "Please provide your name and message.");
            req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, resp);
            return;
        }

        // Trim whitespace from inputs
        name    = name.trim();
        message = message.trim();

        // In a full implementation, we would save this to a database or send an email.
        // For this coursework, we simply acknowledge the submission with a success message.

        // Set success message to display on the contact page
        req.setAttribute("successMessage", "Thank you, " + name + ". Your message has been received. We will respond within 24 hours.");

        // Forward back to the contact page (not redirect, so we can show the message)
        req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, resp);
    }
}
