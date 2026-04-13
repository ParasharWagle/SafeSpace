<!-- ============================================================
     FOOTER
     ============================================================ -->
<footer class="footer">
    <div class="footer-grid">
        <!-- Left column: Brand info -->
        <div class="footer-brand">
            <div class="footer-brand-name">
                <span class="material-symbols-outlined">shield_with_heart</span>
                SafeSpace
            </div>
            <p>
                A confidential platform designed to empower students to report
                incidents anonymously and access support resources without fear
                of exposure or retaliation.
            </p>
            <div class="footer-copyright">
                &copy; 2026 SafeSpace. All rights reserved. Built with care at Islington College.
            </div>
        </div>

        <!-- Right columns: Links -->
        <div class="footer-links-area">
            <!-- Legal links -->
            <div class="footer-col">
                <h4>Legal</h4>
                <ul>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Data Handling</a></li>
                    <li><a href="#">Accessibility</a></li>
                </ul>
            </div>

            <!-- Support links -->
            <div class="footer-col">
                <h4>Support</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Crisis Resources</a></li>
                    <li><a href="#">Counseling Services</a></li>
                </ul>
            </div>

            <!-- Platform links -->
            <div class="footer-col">
                <h4>Platform</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home#how-it-works">How It Works</a></li>
                    <li><a href="${pageContext.request.contextPath}/login">Student Portal</a></li>
                    <li><a href="#">Report an Issue</a></li>
                    <li><a href="#">System Status</a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<!-- ============================================================
     EMERGENCY EXIT BUTTON — present on every page
     Clicking this immediately navigates to Google to cover tracks.
     ============================================================ -->
<a href="https://www.google.com"
   class="emergency-exit"
   id="quick-exit-btn"
   title="Quick Exit — leaves this site immediately"
   onclick="window.open('https://www.google.com','_self'); return false;">
    <span class="material-symbols-outlined">close</span>
    Quick Exit
</a>

</body>
</html>
