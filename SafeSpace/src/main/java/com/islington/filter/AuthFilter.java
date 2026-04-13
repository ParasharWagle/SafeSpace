package com.islington.filter;

import java.io.IOException;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * AuthFilter — Servlet Filter that protects student and admin routes.
 * Intercepts all requests to /student/* and /admin/* URL patterns.
 * Redirects unauthorised users to the login page.
 * Ensures role-based access control (Week 7 — Servlet Filters).
 */
@WebFilter({"/student/*", "/admin/*"})
public class AuthFilter extends HttpFilter {

    /**
     * doFilter — intercepts every request matching the URL patterns
     * and checks whether the user has a valid session with the correct role.
     *
     * @param req   the incoming HTTP request
     * @param res   the outgoing HTTP response
     * @param chain the filter chain to continue if authorised
     */
    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        // Retrieve the current session without creating a new one
        HttpSession session = req.getSession(false);

        // Get the requested URI to determine which protected area is being accessed
        String requestURI = req.getRequestURI();

        // Get the context path for building redirect URLs
        String contextPath = req.getContextPath();

        // Check 1: If no session exists or no role attribute is set, user is not logged in
        if (session == null || session.getAttribute("role") == null) {
            // Redirect unauthenticated user to the login page
            res.sendRedirect(contextPath + "/login");
            return; // Stop filter chain — do not proceed to the servlet
        }

        // Retrieve the user's role from the session
        String role = (String) session.getAttribute("role");

        // Check 2: If a STUDENT is trying to access admin pages, block them
        if ("STUDENT".equals(role) && requestURI.contains("/admin/")) {
            // Redirect student back to their own dashboard
            res.sendRedirect(contextPath + "/student/dashboard");
            return; // Stop filter chain
        }

        // Check 3: If a COUNSELOR is trying to access student pages, block them
        if ("COUNSELOR".equals(role) && requestURI.contains("/student/")) {
            // Redirect counselor back to their own dashboard
            res.sendRedirect(contextPath + "/admin/dashboard");
            return; // Stop filter chain
        }

        // All checks passed — allow the request to continue to the servlet
        chain.doFilter(req, res);
    }
}
