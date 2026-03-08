<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#2d1b3c">
    <title>SmartClass - Login Access</title>
    
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
            
            /* Role-specific colors */
            --admin-color: #ff6b6b;
            --teacher-color: #4ecdc4;
            --student-color: #45b7d1;
            --parent-color: #96ceb4;
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
        .delay-4 { animation-delay: 0.4s; opacity: 0; animation-fill-mode: forwards; }

        /* ================= MAIN CONTAINER ================= */
        .login-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* ================= HEADER ================= */
        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo-container {
            display: inline-flex;
            align-items: center;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            padding: 15px 30px;
            border-radius: 50px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 25px;
            border: 2px solid rgba(155, 126, 176, 0.3);
            transition: var(--transition);
        }

        .logo-container:hover {
            transform: translateY(-3px);
            border-color: var(--accent-gold);
        }

        .logo-icon {
            font-size: 30px;
            color: var(--accent-gold);
            margin-right: 12px;
        }

        .logo-text {
            font-size: 28px;
            font-weight: 800;
            color: var(--white);
            letter-spacing: 0.5px;
        }

        .page-title {
            text-align: center;
            color: var(--white);
            font-size: 2.2rem;
            margin-bottom: 15px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .page-subtitle {
            text-align: center;
            color: var(--light-purple);
            font-size: 1rem;
            max-width: 600px;
            margin: 0 auto 40px;
            line-height: 1.6;
        }

        /* ================= ROLE CARDS GRID ================= */
        .roles-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-bottom: 50px;
        }

        .role-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 30px 20px;
            text-align: center;
            transition: var(--transition);
            border: 2px solid rgba(155, 126, 176, 0.2);
            text-decoration: none;
            display: block;
            position: relative;
            overflow: hidden;
        }

        .role-card::before {
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

        .role-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .role-card:hover::before {
            opacity: 1;
        }

        .role-card.admin:hover {
            border-color: var(--admin-color);
        }

        .role-card.teacher:hover {
            border-color: var(--teacher-color);
        }

        .role-card.student:hover {
            border-color: var(--student-color);
        }

        .role-card.parent:hover {
            border-color: var(--parent-color);
        }

        .image-wrapper {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            margin: 0 auto 20px;
            padding: 5px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            transition: var(--transition);
        }

        .role-card:hover .image-wrapper {
            transform: scale(1.05);
            box-shadow: 0 0 25px rgba(230, 184, 0, 0.3);
        }

        .role-image {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--accent-gold);
        }

        .role-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            transition: var(--transition);
        }

        .admin .role-title {
            color: var(--admin-color);
        }

        .teacher .role-title {
            color: var(--teacher-color);
        }

        .student .role-title {
            color: var(--student-color);
        }

        .parent .role-title {
            color: var(--parent-color);
        }

        .role-description {
            color: var(--text-light);
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .role-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 500;
            transition: var(--transition);
        }

        .admin .role-badge {
            background: rgba(255, 107, 107, 0.15);
            color: var(--admin-color);
        }

        .teacher .role-badge {
            background: rgba(78, 205, 196, 0.15);
            color: var(--teacher-color);
        }

        .student .role-badge {
            background: rgba(69, 183, 209, 0.15);
            color: var(--student-color);
        }

        .parent .role-badge {
            background: rgba(150, 206, 180, 0.15);
            color: var(--parent-color);
        }

        .role-card:hover .role-badge {
            background: var(--accent-gold);
            color: var(--dark-purple);
        }

        /* ================= FOOTER ================= */
        .footer {
            text-align: center;
            padding-top: 30px;
            border-top: 2px solid rgba(155, 126, 176, 0.3);
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 20px;
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
            font-size: 1rem;
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
            font-size: 0.9rem;
            color: var(--light-purple);
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
            background: radial-gradient(circle, rgba(155, 126, 176, 0.1) 0%, transparent 70%);
        }

        .circle-1 {
            width: 300px;
            height: 300px;
            top: -150px;
            right: -150px;
            animation: float 20s infinite;
        }

        .circle-2 {
            width: 400px;
            height: 400px;
            bottom: -200px;
            left: -200px;
            animation: float 25s infinite reverse;
        }

        @keyframes float {
            0% { transform: translate(0, 0); }
            50% { transform: translate(30px, 30px); }
            100% { transform: translate(0, 0); }
        }

        /* ================= RESPONSIVE BREAKPOINTS ================= */
        
        /* Mobile (up to 576px) - already using 1 column */

        /* Tablet (576px and up) */
        @media (min-width: 576px) {
            .page-title {
                font-size: 2.5rem;
            }
            
            .page-subtitle {
                font-size: 1.1rem;
            }
            
            .roles-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }
            
            .logo-text {
                font-size: 30px;
            }
            
            .logo-icon {
                font-size: 32px;
            }
        }

        /* Desktop (992px and up) */
        @media (min-width: 992px) {
            body {
                padding: 30px;
            }
            
            .page-title {
                font-size: 3rem;
            }
            
            .page-subtitle {
                font-size: 1.2rem;
            }
            
            .roles-grid {
                grid-template-columns: repeat(4, 1fr);
                gap: 25px;
            }
            
            .logo-container {
                padding: 18px 40px;
            }
            
            .logo-text {
                font-size: 32px;
            }
            
            .logo-icon {
                font-size: 34px;
            }
            
            .image-wrapper {
                width: 160px;
                height: 160px;
            }
            
            .role-title {
                font-size: 1.6rem;
            }
            
            .footer-links {
                gap: 40px;
            }
        }

        /* Large Desktop (1200px and up) */
        @media (min-width: 1200px) {
            .roles-grid {
                gap: 30px;
            }
            
            .image-wrapper {
                width: 170px;
                height: 170px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .role-card:active {
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
            input {
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

    <div class="login-container">
        <!-- Header -->
        <div class="header">
            <div class="logo-container animate-scale">
                <i class="fas fa-graduation-cap logo-icon"></i>
                <div class="logo-text">SmartClass</div>
            </div>
            <h1 class="page-title animate-fade-up">Login Access</h1>
            <p class="page-subtitle animate-fade-up delay-1">Select your role to access the SmartClass educational platform</p>
        </div>

        <!-- Roles Grid -->
        <div class="roles-grid">
            <!-- Admin -->
            <a href="${pageContext.request.contextPath}/adminlogin" class="role-card admin animate-fade-up delay-1">
                <div class="image-wrapper">
                    <img src="${pageContext.request.contextPath}/images/admin.jpeg" alt="Administrator" class="role-image" 
                         onerror="this.src='https://via.placeholder.com/170x170/5a3d6e/ffffff?text=Admin'">
                </div>
                <h3 class="role-title">Administrator</h3>
                <p class="role-description">System management, user accounts, and platform oversight</p>
                <div class="role-badge">
                    <i class="fas fa-sign-in-alt"></i> Access Portal
                </div>
            </a>

            <!-- Teacher -->
            <a href="${pageContext.request.contextPath}/teacher-login" class="role-card teacher animate-fade-up delay-2">
                <div class="image-wrapper">
                    <img src="${pageContext.request.contextPath}/images/teacher.jpeg" alt="Teacher" class="role-image"
                         onerror="this.src='https://via.placeholder.com/170x170/5a3d6e/ffffff?text=Teacher'">
                </div>
                <h3 class="role-title">Teacher</h3>
                <p class="role-description">Course management, content upload, and student tracking</p>
                <div class="role-badge">
                    <i class="fas fa-sign-in-alt"></i> Access Portal
                </div>
            </a>

            <!-- Student -->
            <a href="${pageContext.request.contextPath}/student-login" class="role-card student animate-fade-up delay-3">
                <div class="image-wrapper">
                    <img src="${pageContext.request.contextPath}/images/student.jpeg" alt="Student" class="role-image"
                         onerror="this.src='https://via.placeholder.com/170x170/5a3d6e/ffffff?text=Student'">
                </div>
                <h3 class="role-title">Student</h3>
                <p class="role-description">Course access, learning materials, and online tests</p>
                <div class="role-badge">
                    <i class="fas fa-sign-in-alt"></i> Access Portal
                </div>
            </a>

            <!-- Parent -->
            <a href="${pageContext.request.contextPath}/parents/login" class="role-card parent animate-fade-up delay-4">
                <div class="image-wrapper">
                    <img src="${pageContext.request.contextPath}/images/parent.jpeg" alt="Parent" class="role-image"
                         onerror="this.src='https://via.placeholder.com/170x170/5a3d6e/ffffff?text=Parent'">
                </div>
                <h3 class="role-title">Parent</h3>
                <p class="role-description">Monitor attendance, test scores, and student progress</p>
                <div class="role-badge">
                    <i class="fas fa-sign-in-alt"></i> Access Portal
                </div>
            </a>
        </div>

        <!-- Footer -->
        <div class="footer animate-fade-up">
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
                <a href="${pageContext.request.contextPath}/signup" class="footer-link">
                    <i class="fas fa-user-plus"></i> Create Account
                </a>
            </div>
            <p class="copyright">&copy; 2025 SmartClass Learning Platform. All rights reserved.</p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Image fallback handling
            const images = document.querySelectorAll('.role-image');
            
            images.forEach(img => {
                img.onerror = function() {
                    // If image fails to load, show colored placeholder with text
                    const role = this.closest('.role-card').querySelector('.role-title').textContent;
                    const colors = {
                        'Administrator': '#ff6b6b',
                        'Teacher': '#4ecdc4',
                        'Student': '#45b7d1',
                        'Parent': '#96ceb4'
                    };
                    const color = colors[role] || '#5a3d6e';
                    this.src = `https://via.placeholder.com/170x170/${color.replace('#', '')}/ffffff?text=${role}`;
                };
            });
            
            // Add touch feedback for mobile
            const cards = document.querySelectorAll('.role-card');
            
            cards.forEach(card => {
                card.addEventListener('touchstart', function() {
                    this.style.transform = 'scale(0.98)';
                }, { passive: true });
                
                card.addEventListener('touchend', function() {
                    this.style.transform = '';
                }, { passive: true });
                
                card.addEventListener('touchcancel', function() {
                    this.style.transform = '';
                }, { passive: true });
            });
            
            // Intersection Observer for scroll animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });
            
            document.querySelectorAll('.role-card').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                observer.observe(card);
            });
            
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