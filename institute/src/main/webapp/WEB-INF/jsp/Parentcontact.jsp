<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduEra - Contact Us</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #002b5c;
            --primary-dark: #00509e;
        }

        body {
            background: #f3f7ff;
            font-family: Arial, sans-serif;
        }

        /* ================= NAVBAR ================= */
        .top-nav {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 3px 12px rgba(0,0,0,0.25);
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo {
            width: 60px;
            height: 60px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            transition: transform 0.3s ease;
        }

        .logo:hover {
            transform: rotate(15deg);
        }

        .logo-text h1 {
            font-size: 26px;
            font-weight: 700;
            background: linear-gradient(to right, #ffffff, #e2e8ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }

        .logo-text p {
            font-size: 13px;
            opacity: 0.9;
            margin: 0;
        }

        .nav-links {
            display: flex;
            gap: 10px;
        }

        .nav-item {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 30px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .nav-item:hover {
            background: rgba(255,255,255,0.15);
        }

        .nav-item.active {
            background: white;
            color: var(--primary);
            font-weight: 600;
        }

        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }

        /* ================= CONTACT SECTION ================= */
        .contact-section {
            width: 90%;
            margin: 40px auto;
            padding: 40px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.15);
        }

        .contact-title {
            text-align: center;
            font-size: 34px;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 30px;
        }

        .contact-box {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .contact-card {
            width: 30%;
            background: #f1f5ff;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .contact-card:hover {
            transform: translateY(-5px);
        }

        .contact-card img {
            width: 60px;
            margin-bottom: 12px;
        }

        .contact-card a {
            text-decoration: none;
            color: var(--primary-dark);
            font-weight: bold;
            display: block;
            margin-top: 8px;
        }

        /* ================= FOOTER ================= */
        .footer {
            background: #0d1b2a;
            color: #e0eaff;
            padding: 40px 0 20px 0;
        }

        .footer-content {
            width: 90%;
            margin: auto;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .footer-column h3 {
            color: #ffca3a;
            margin-bottom: 12px;
        }

        .footer-column p,
        .footer-column a {
            font-size: 15px;
            color: #d4e0ff;
            text-decoration: none;
            margin-bottom: 8px;
        }

        .footer-column a:hover {
            color: white;
        }

        .footer-bottom {
            text-align: center;
            font-size: 14px;
            border-top: 1px solid #324a70;
            padding-top: 10px;
            margin-top: 20px;
        }

        /* Responsive */
        @media(max-width: 768px) {
            .nav-links {
                display: none;
                flex-direction: column;
                width: 100%;
                gap: 10px;
                margin-top: 10px;
            }
            .nav-links.show {
                display: flex;
            }
            .nav-item {
                justify-content: center;
            }
            .mobile-menu-btn {
                display: block;
            }
            .contact-card {
                width: 100%;
            }
            .footer-column {
                width: 100%;
            }
        }

        @media(max-width: 992px) {
            .contact-card {
                width: 48%;
            }
        }
    </style>
</head>
<body>
	<!-- ================= NAVBAR ================= -->
	<nav class="top-nav">
	    <div class="logo-section">
	        <div class="logo">
	            <i class="fa-solid fa-hands-helping"></i>
	        </div>
	        <div class="logo-text">
	            <h1>Parent Connect</h1>
	            <p>Your Gateway to Academic Success</p>
	        </div>
	    </div>

	    <button class="mobile-menu-btn" id="mobileMenuBtn">
	        <i class="fa-solid fa-bars"></i>
	    </button>

	    <div class="nav-links" id="navLinks">
	        <a href="${pageContext.request.contextPath}/parent/dashboard" class="nav-item"><i class="fa-solid fa-home"></i> Home</a>
	        <a href="${pageContext.request.contextPath}/parent-attendance" class="nav-item"><i class="fa-solid fa-clipboard-check"></i> Attendance</a>
	        <a href="${pageContext.request.contextPath}/parenttestscore" class="nav-item"><i class="fa-solid fa-chart-line"></i> Test Scores</a>
	        <a href="${pageContext.request.contextPath}/parent-contact" class="nav-item active"><i class="fa-solid fa-users"></i> Contact</a>
	    </div>
	</nav>

	<!-- ================= CONTACT SECTION ================= -->
	<div class="contact-section">
	    <h1 class="contact-title">Get in Touch With Us</h1>
	    <div class="contact-box">
	        <div class="contact-card">
	            <img src="https://cdn-icons-png.flaticon.com/512/124/124034.png" alt="WhatsApp">
	            <h4>WhatsApp</h4>
	            <a href="https://wa.me/919876543210">Chat Now</a>
	        </div>
	        <div class="contact-card">
	            <img src="https://cdn-icons-png.flaticon.com/512/597/597177.png" alt="Call">
	            <h4>Call Us</h4>
	            <a href="tel:+919876543210">+91 98765 43210</a>
	        </div>
	        <div class="contact-card">
	            <img src="https://cdn-icons-png.flaticon.com/512/542/542638.png" alt="Email">
	            <h4>Email</h4>
	            <a href="mailto:support@eduera.com">support@eduera.com</a>
	        </div>
	    </div>
	</div>

	<!-- ================= FOOTER ================= -->
	<footer class="footer">
	    <div class="footer-content">
	        <div class="footer-column">
	            <h3>About EduEra</h3>
	            <p>We provide high-quality courses, notes, and lectures to help students grow in the world of technology.</p>
	        </div>
	        <div class="footer-column">
	            <h3>Useful Links</h3>
	            <a href="${pageContext.request.contextPath}/">Home</a>
	            <a href="${pageContext.request.contextPath}/courses">Courses</a>
	            <a href="${pageContext.request.contextPath}/notes">Notes</a>
	            <a href="${pageContext.request.contextPath}/subscriptions">Subscriptions</a>
	        </div>
	        <div class="footer-column">
	            <h3>Support</h3>
	            <p>Email: support@eduera.com</p>
	            <p>Phone: +91 98765 43210</p>
	            <p>Location: Mumbai, India</p>
	        </div>
	        <div class="footer-column">
	            <h3>Social Media</h3>
	            <a href="https://instagram.com">Instagram</a>
	            <a href="https://youtube.com">YouTube</a>
	            <a href="https://linkedin.com">LinkedIn</a>
	        </div>
	    </div>
	    <div class="footer-bottom">
	        © 2025 EduEra • Made with ❤️ for Students
	    </div>
	</footer>

    <!-- JS for mobile menu -->
    <script>
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const navLinks = document.getElementById('navLinks');

        mobileMenuBtn.addEventListener('click', () => {
            navLinks.classList.toggle('show');
        });
    </script>
</body>
</html>
