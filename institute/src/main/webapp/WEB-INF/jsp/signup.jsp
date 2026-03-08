<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#2d1b3c">
    <title>SmartClass - Student Signup</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --dark-purple: #2d1b3c;
            --deep-purple: #3e2a4d;
            --royal-purple: #5a3d6e;
            --medium-purple: #7a5a8c;
            --soft-purple: #9b7eb0;
            --light-purple: #c4b0d4;
            --accent-gold: #e6b800;
            --white: #ffffff;
            --off-white: #f8f4ff;
            --gray-light: #e9e5f0;
            --text-light: #d6d0e0;
            --shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            --shadow-sm: 0 4px 10px rgba(0, 0, 0, 0.2);
            --radius: 16px;
            --radius-sm: 10px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            
            /* Student color */
            --student-color: #45b7d1;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background: linear-gradient(135deg, var(--dark-purple) 0%, var(--deep-purple) 100%);
            color: var(--white);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 15px;
            line-height: 1.6;
            overflow-x: hidden;
            position: relative;
        }

        /* ================= BACKGROUND DECORATION ================= */
        .bg-decoration {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
            overflow: hidden;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(155, 126, 176, 0.15) 0%, transparent 70%);
        }

        .circle-1 {
            width: 400px;
            height: 400px;
            top: -200px;
            right: -200px;
            animation: float 25s infinite;
        }

        .circle-2 {
            width: 500px;
            height: 500px;
            bottom: -250px;
            left: -250px;
            animation: float 30s infinite reverse;
        }

        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(30px, 30px) rotate(120deg); }
            66% { transform: translate(-20px, 20px) rotate(240deg); }
            100% { transform: translate(0, 0) rotate(360deg); }
        }

        /* ================= ANIMATIONS ================= */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .animate-fade-up {
            animation: fadeInUp 0.6s ease forwards;
        }

        .animate-fade {
            animation: fadeIn 0.6s ease forwards;
        }

        .animate-scale {
            animation: scaleIn 0.5s ease forwards;
        }

        .delay-1 { animation-delay: 0.1s; opacity: 0; animation-fill-mode: forwards; }
        .delay-2 { animation-delay: 0.2s; opacity: 0; animation-fill-mode: forwards; }
        .delay-3 { animation-delay: 0.3s; opacity: 0; animation-fill-mode: forwards; }

        /* ================= MAIN CONTAINER ================= */
        .signup-container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* ================= HEADER ================= */
        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-wrapper {
            display: inline-flex;
            align-items: center;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            padding: 12px 30px;
            border-radius: 50px;
            border: 2px solid rgba(155, 126, 176, 0.3);
            margin-bottom: 20px;
            transition: var(--transition);
        }

        .logo-wrapper:hover {
            border-color: var(--accent-gold);
            transform: translateY(-3px);
        }

        .logo-icon {
            font-size: 32px;
            color: var(--accent-gold);
            margin-right: 12px;
        }

        .logo-text {
            font-size: 28px;
            font-weight: 800;
            color: var(--white);
            letter-spacing: 1px;
        }

        .tagline {
            color: var(--light-purple);
            font-size: 1.1rem;
            margin-top: 5px;
        }

        /* ================= MAIN CONTENT BOX ================= */
        .content-box {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 40px 20px;
            box-shadow: var(--shadow);
            border: 2px solid rgba(155, 126, 176, 0.3);
            position: relative;
            overflow: hidden;
        }

        .content-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(to right, var(--royal-purple), var(--accent-gold), var(--medium-purple));
        }

        .content-box::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(230, 184, 0, 0.05) 0%, transparent 70%);
            pointer-events: none;
        }

        h2 {
            text-align: center;
            color: var(--white);
            font-size: 2rem;
            margin-bottom: 15px;
            position: relative;
            padding-bottom: 15px;
            font-weight: 700;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--accent-gold);
            border-radius: 2px;
        }

        .subtitle {
            text-align: center;
            color: var(--light-purple);
            font-size: 1rem;
            margin-bottom: 40px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }

        /* ================= STUDENT CARD ================= */
        .student-card {
            background: rgba(255, 255, 255, 0.03);
            border-radius: var(--radius);
            padding: 40px 30px;
            text-align: center;
            transition: var(--transition);
            border: 2px solid rgba(155, 126, 176, 0.2);
            position: relative;
            overflow: hidden;
            max-width: 450px;
            margin: 0 auto;
        }

        .student-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at top right, rgba(230, 184, 0, 0.1), transparent);
            opacity: 0;
            transition: var(--transition);
        }

        .student-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
            border-color: var(--student-color);
        }

        .student-card:hover::before {
            opacity: 1;
        }

        .image-wrapper {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            margin: 0 auto 25px;
            padding: 5px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            transition: var(--transition);
        }

        .student-card:hover .image-wrapper {
            transform: scale(1.05);
            box-shadow: 0 0 25px rgba(230, 184, 0, 0.3);
        }

        .card-image {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--accent-gold);
        }

        .student-card h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--student-color);
        }

        .student-card p {
            color: var(--text-light);
            line-height: 1.7;
            margin-bottom: 30px;
            font-size: 1rem;
        }

        /* ================= BUTTON ================= */
        .btn-signup {
            width: 100%;
            padding: 16px 20px;
            border: none;
            border-radius: 50px;
            color: var(--white);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            letter-spacing: 0.5px;
            text-decoration: none;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
            min-height: 56px;
            background: linear-gradient(135deg, var(--student-color), #2a8fb3);
        }

        .btn-signup::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn-signup:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-signup:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(69, 183, 209, 0.4);
            background: linear-gradient(135deg, #2a8fb3, var(--student-color));
        }

        .btn-signup:active {
            transform: translateY(-1px);
        }

        .btn-signup i {
            font-size: 1.2rem;
        }

        /* ================= FOOTER ================= */
        .footer {
            text-align: center;
            margin-top: 30px;
            padding: 20px;
            border-top: 2px solid rgba(155, 126, 176, 0.3);
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .footer-link {
            color: var(--light-purple);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 0.95rem;
            padding: 8px 16px;
            border-radius: 30px;
            min-height: 44px;
        }

        .footer-link i {
            color: var(--accent-gold);
            transition: var(--transition);
        }

        .footer-link:hover {
            color: var(--accent-gold);
            transform: translateY(-2px);
            background: rgba(255, 255, 255, 0.05);
        }

        .footer-link:hover i {
            transform: scale(1.1);
        }

        .copyright {
            color: var(--light-purple);
            font-size: 0.9rem;
        }

        .login-prompt {
            margin-bottom: 15px;
        }

        .login-link {
            color: var(--accent-gold);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .login-link:hover {
            color: var(--white);
            transform: translateX(3px);
        }

        /* ================= RESPONSIVE BREAKPOINTS ================= */
        
        /* Mobile (up to 576px) */
        @media (max-width: 576px) {
            .logo-text {
                font-size: 24px;
            }
            
            .logo-icon {
                font-size: 26px;
            }
            
            h2 {
                font-size: 1.8rem;
            }
            
            .subtitle {
                font-size: 0.95rem;
            }
            
            .student-card {
                padding: 30px 20px;
            }
            
            .image-wrapper {
                width: 140px;
                height: 140px;
            }
            
            .student-card h3 {
                font-size: 1.5rem;
            }
            
            .btn-signup {
                font-size: 1rem;
                padding: 14px 20px;
            }
            
            .footer-links {
                gap: 15px;
            }
            
            .footer-link {
                font-size: 0.9rem;
                padding: 6px 12px;
            }
        }

        /* Tablet (576px and up) */
        @media (min-width: 576px) {
            .logo-text {
                font-size: 28px;
            }
            
            .logo-icon {
                font-size: 30px;
            }
            
            h2 {
                font-size: 2rem;
            }
            
            .content-box {
                padding: 40px 30px;
            }
        }

        /* Desktop (992px and up) */
        @media (min-width: 992px) {
            body {
                padding: 30px;
            }
            
            .logo-wrapper {
                padding: 15px 40px;
            }
            
            .logo-text {
                font-size: 32px;
            }
            
            .logo-icon {
                font-size: 34px;
            }
            
            h2 {
                font-size: 2.2rem;
            }
            
            .image-wrapper {
                width: 170px;
                height: 170px;
            }
            
            .student-card h3 {
                font-size: 1.9rem;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .student-card:active {
                transform: scale(0.98);
            }
            
            .btn-signup:active {
                transform: scale(0.98);
            }
            
            .footer-link:active {
                background: rgba(255, 255, 255, 0.1);
            }
        }

        /* iOS font size adjustment prevention */
        @media screen and (-webkit-min-device-pixel-ratio: 0) {
            select,
            textarea,
            input,
            button {
                font-size: 16px !important;
            }
        }
    </style>
</head>
<body>
    <!-- Background Decoration -->
    <div class="bg-decoration">
        <div class="bg-circle circle-1"></div>
        <div class="bg-circle circle-2"></div>
    </div>

    <div class="signup-container">
        <!-- Header with logo -->
        <div class="header">
            <div class="logo-wrapper animate-scale">
                <i class="fas fa-graduation-cap logo-icon"></i>
                <span class="logo-text">SmartClass</span>
            </div>
            <p class="tagline animate-fade-up delay-1">Empowering the future of education, together</p>
        </div>

        <!-- Main content box -->
        <div class="content-box animate-fade-up">
            <h2>Join SmartClass Today</h2>
            <p class="subtitle">Begin your educational journey with our personalized learning platform</p>
            
            <!-- Student Card Only -->
            <div class="student-card animate-fade-up delay-1">
                <div class="image-wrapper">
                    <img src="${pageContext.request.contextPath}/images/student.jpeg" 
                         alt="Student" 
                         class="card-image"
                         onerror="this.src='https://via.placeholder.com/170x170/45b7d1/ffffff?text=Student'">
                </div>
                <h3>Student</h3>
                <p>Access interactive courses, track your progress, submit assignments, and connect with educators to enhance your learning experience.</p>
                <a href="${pageContext.request.contextPath}/student-signup" class="btn-signup">
                    <i class="fas fa-user-plus"></i> Sign Up as Student
                </a>
            </div>

            <!-- Footer inside box -->
            <div class="footer">
                <div class="login-prompt">
                    <span style="color: var(--light-purple);">Already have an account? </span>
                    <a href="${pageContext.request.contextPath}/loginusers" class="login-link">
                        <i class="fas fa-sign-in-alt"></i> Login here
                    </a>
                </div>
                
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/" class="footer-link">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <a href="${pageContext.request.contextPath}/home-about" class="footer-link">
                        <i class="fas fa-info-circle"></i> About
                    </a>
                    <a href="${pageContext.request.contextPath}/home-courses" class="footer-link">
                        <i class="fas fa-book"></i> Courses
                    </a>
                    <a href="${pageContext.request.contextPath}/home-contact" class="footer-link">
                        <i class="fas fa-envelope"></i> Contact
                    </a>
                </div>
                
                <p class="copyright">&copy; 2025 SmartClass Learning Platform. All rights reserved.</p>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Image fallback handling
            const image = document.querySelector('.card-image');
            
            if (image) {
                image.onerror = function() {
                    // If image fails to load, show colored placeholder with text
                    this.src = 'https://via.placeholder.com/170x170/45b7d1/ffffff?text=Student';
                };
            }
            
            // Add touch feedback for mobile
            const card = document.querySelector('.student-card');
            const button = document.querySelector('.btn-signup');
            
            if (card) {
                card.addEventListener('touchstart', function() {
                    this.style.transform = 'scale(0.98)';
                }, { passive: true });
                
                card.addEventListener('touchend', function() {
                    this.style.transform = '';
                }, { passive: true });
                
                card.addEventListener('touchcancel', function() {
                    this.style.transform = '';
                }, { passive: true });
            }
            
            if (button) {
                button.addEventListener('touchstart', function(e) {
                    e.stopPropagation();
                    this.style.transform = 'scale(0.98)';
                }, { passive: true });
                
                button.addEventListener('touchend', function(e) {
                    e.stopPropagation();
                    this.style.transform = '';
                }, { passive: true });
                
                button.addEventListener('touchcancel', function(e) {
                    e.stopPropagation();
                    this.style.transform = '';
                }, { passive: true });
            }
            
            // Smooth page transitions for links
            const links = document.querySelectorAll('a');
            links.forEach(link => {
                link.addEventListener('click', function(e) {
                    // Don't prevent default, just add a small visual feedback
                    this.style.opacity = '0.8';
                    setTimeout(() => {
                        this.style.opacity = '1';
                    }, 100);
                });
            });
        });
    </script>
</body>
</html>