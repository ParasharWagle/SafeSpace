<%-- ============================================================
    footer.jsp — shared site footer.
    Included at the bottom of every page via
    <%@ include file="footer.jsp" %> (or ../footer.jsp from sub-folders).

    Contains:
      - Emergency Exit floating button (quick-hide the site)
      - Brand strip + quick links + support links
      - Copyright with Islington College attribution
    ============================================================ --%>

<!-- Emergency Exit: one tap to redirect to Google -->
<a href="https://www.google.com" class="emergency-exit" title="Quick exit to Google">
    <span class="material-symbols-outlined">exit_to_app</span>
    Exit
</a>

<footer class="footer">
    <div class="footer-grid">

        <!-- Brand blurb -->
        <div class="footer-brand">
            <div class="footer-brand-name">
                <span class="logo-chip"><span class="material-symbols-outlined">shield_person</span></span>
                SafeSpace
            </div>
            <p>
                An anonymous student-safety platform empowering students to report
                incidents, attach evidence, and connect with trained counselors &mdash;
                all without revealing their identity.
            </p>
            <div class="footer-copyright">
                &copy; <%= java.time.Year.now().getValue() %> SafeSpace.
                Built with care at Islington College, Kathmandu.
            </div>
        </div>

        <!-- Link columns -->
        <div class="footer-links-area">

            <div class="footer-col">
                <h4>Platform</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#features">Features</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#charts">Charts</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Support</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">Crisis Hotline</a></li>
                    <li><a href="#">Resource Library</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Legal</h4>
                <ul>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">FERPA Compliance</a></li>
                    <li><a href="#">Cookie Settings</a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>

</body>
</html>
