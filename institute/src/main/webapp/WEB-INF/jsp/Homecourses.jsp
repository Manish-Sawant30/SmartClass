<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Courses - SmartClass | Learn Tech Skills</title>
    
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
            
            /* Gradient colors for course cards */
            --gradient-1: linear-gradient(135deg, #5a3d6e, #7a5a8c);
            --gradient-2: linear-gradient(135deg, #7a5a8c, #9b7eb0);
            --gradient-3: linear-gradient(135deg, #9b7eb0, #c4b0d4);
            --gradient-4: linear-gradient(135deg, #3e2a4d, #5a3d6e);
            --gradient-5: linear-gradient(135deg, #5a3d6e, #9b7eb0);
            --gradient-6: linear-gradient(135deg, #7a5a8c, #c4b0d4);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background: linear-gradient(135deg, var(--dark-purple) 0%, var(--deep-purple) 100%);
            color: var(--white);
            line-height: 1.6;
            min-height: 100vh;
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

        .animate-fade-up {
            animation: fadeInUp 0.6s ease forwards;
        }

        .animate-fade {
            animation: fadeIn 0.6s ease forwards;
        }

        .delay-1 { animation-delay: 0.1s; opacity: 0; animation-fill-mode: forwards; }
        .delay-2 { animation-delay: 0.2s; opacity: 0; animation-fill-mode: forwards; }
        .delay-3 { animation-delay: 0.3s; opacity: 0; animation-fill-mode: forwards; }

        /* ================= NAVBAR ================= */
        .navbar-custom {
            background: rgba(45, 27, 60, 0.95);
            backdrop-filter: blur(10px);
            padding: 0.8rem 1rem;
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 2px solid var(--medium-purple);
        }

        .navbar-brand {
            color: var(--white) !important;
            font-weight: 800;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
        }

        .navbar-brand i {
            color: var(--accent-gold);
            font-size: 1.8rem;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .logo-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-gold);
        }

        .nav-link {
            color: var(--text-light) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            border-radius: 30px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            font-size: 0.95rem;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .nav-link:hover::before {
            width: 300px;
            height: 300px;
        }

        .nav-link:hover {
            color: var(--white) !important;
        }

        .nav-link.active {
            background: var(--medium-purple);
            color: var(--white) !important;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(90, 61, 110, 0.5);
        }

        .btn-login {
            background: transparent;
            border: 2px solid var(--soft-purple);
            color: var(--white) !important;
            padding: 0.4rem 1.2rem !important;
            border-radius: 30px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: var(--transition);
        }

        .btn-login:hover {
            background: var(--soft-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(155, 126, 176, 0.4);
        }

        .btn-signup {
            background: var(--accent-gold);
            border: 2px solid var(--accent-gold);
            color: var(--dark-purple) !important;
            padding: 0.4rem 1.2rem !important;
            border-radius: 30px;
            font-weight: 700;
            font-size: 0.95rem;
            transition: var(--transition);
        }

        .btn-signup:hover {
            background: transparent;
            color: var(--accent-gold) !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        /* ================= HERO SECTION ================= */
        .hero-section {
            padding: 60px 15px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 20% 50%, rgba(90, 61, 110, 0.3) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(230, 184, 0, 0.15) 0%, transparent 50%);
            pointer-events: none;
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .hero-section h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .hero-section p {
            font-size: 1rem;
            margin-bottom: 30px;
            color: var(--light-purple);
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-hero {
            padding: 12px 30px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 2px solid transparent;
        }

        .btn-hero-primary {
            background: var(--accent-gold);
            color: var(--dark-purple);
        }

        .btn-hero-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(230, 184, 0, 0.3);
        }

        .btn-hero-secondary {
            background: transparent;
            color: var(--white);
            border: 2px solid var(--soft-purple);
        }

        .btn-hero-secondary:hover {
            background: var(--soft-purple);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(155, 126, 176, 0.3);
        }

        /* ================= SECTION COMMON ================= */
        .section-padding {
            padding: 50px 15px;
        }

        .section-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .section-title h2 {
            font-weight: 700;
            font-size: 2rem;
            color: var(--white);
            margin-bottom: 10px;
            position: relative;
            display: inline-block;
        }

        .section-title h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: var(--accent-gold);
            border-radius: 2px;
        }

        .section-title p {
            font-size: 1rem;
            color: var(--light-purple);
            max-width: 600px;
            margin: 0 auto;
        }

        /* ================= COURSE CATEGORIES ================= */
        .course-categories {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 30px;
            padding: 0 10px;
        }

        .category-btn {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(155, 126, 176, 0.3);
            padding: 8px 16px;
            border-radius: 30px;
            font-weight: 500;
            color: var(--text-light);
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .category-btn:hover,
        .category-btn.active {
            background: var(--medium-purple);
            color: var(--white);
            border-color: var(--soft-purple);
            transform: translateY(-2px);
        }

        /* ================= COURSES GRID ================= */
        .courses-section {
            background: rgba(0, 0, 0, 0.2);
        }

        .course-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }

        .course-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .course-header {
            padding: 25px 20px 15px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            position: relative;
            min-height: 100px;
        }

        .course-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .course-category {
            font-size: 0.85rem;
            color: var(--light-purple);
            font-weight: 500;
        }

        .course-body {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .course-desc {
            color: var(--text-light);
            margin-bottom: 15px;
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .course-features {
            list-style: none;
            padding: 0;
            margin-bottom: 15px;
        }

        .course-features li {
            padding: 5px 0;
            color: var(--text-light);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .course-features i {
            color: var(--accent-gold);
            font-size: 0.85rem;
            width: 18px;
        }

        .course-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid rgba(155, 126, 176, 0.2);
        }

        .course-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--accent-gold);
        }

        .course-price span {
            font-size: 0.85rem;
            color: var(--light-purple);
            font-weight: 400;
            text-decoration: line-through;
            margin-left: 5px;
        }

        .btn-enroll {
            background: var(--royal-purple);
            color: var(--white);
            padding: 6px 16px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: var(--transition);
            border: 2px solid transparent;
        }

        .btn-enroll:hover {
            background: transparent;
            border-color: var(--accent-gold);
            color: var(--accent-gold);
            transform: translateY(-2px);
        }

        /* ================= FEATURES SECTION ================= */
        .features-section {
            padding: 50px 15px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 25px 20px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
        }

        .feature-card:hover {
            transform: translateY(-5px);
            border-color: var(--soft-purple);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            border-radius: 20px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: var(--accent-gold);
            font-size: 1.5rem;
            transition: var(--transition);
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1);
        }

        .feature-card h3 {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--white);
            margin-bottom: 10px;
        }

        .feature-card p {
            color: var(--text-light);
            font-size: 0.9rem;
            line-height: 1.6;
        }

        /* ================= BENEFITS SECTION ================= */
        .benefits-section {
            background: rgba(0, 0, 0, 0.2);
            padding: 50px 15px;
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .benefit-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 25px 20px;
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
        }

        .benefit-card:hover {
            transform: translateY(-5px);
            border-color: var(--soft-purple);
        }

        .benefit-card h3 {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--white);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .benefit-card h3 i {
            color: var(--accent-gold);
        }

        .benefit-list {
            list-style: none;
            padding: 0;
        }

        .benefit-list li {
            padding: 6px 0;
            color: var(--text-light);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .benefit-list li i {
            color: var(--accent-gold);
            font-size: 0.85rem;
            width: 18px;
        }

        /* ================= CTA SECTION ================= */
        .cta-section {
            padding: 60px 15px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 50%, rgba(230, 184, 0, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 70% 50%, rgba(155, 126, 176, 0.1) 0%, transparent 50%);
        }

        .cta-content {
            max-width: 700px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .cta-section h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--white);
        }

        .cta-section p {
            font-size: 1rem;
            color: var(--light-purple);
            margin-bottom: 25px;
        }

        /* ================= FOOTER ================= */
        .footer {
            background: var(--dark-purple);
            padding: 50px 15px 20px;
            border-top: 2px solid var(--royal-purple);
        }

        .footer-content {
            display: grid;
            grid-template-columns: 1fr;
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto 30px;
        }

        .footer-logo {
            font-size: 1.5rem;
            font-weight: 800;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--accent-gold);
        }

        .footer-description {
            color: var(--light-purple);
            line-height: 1.6;
            margin-bottom: 15px;
            font-size: 0.9rem;
        }

        .footer-links h3 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--white);
        }

        .footer-links ul {
            list-style: none;
            padding: 0;
        }

        .footer-links li {
            margin-bottom: 8px;
        }

        .footer-links a {
            color: var(--light-purple);
            text-decoration: none;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
        }

        .footer-links a:hover {
            color: var(--accent-gold);
            transform: translateX(5px);
        }

        .social-icons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .social-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border: 2px solid transparent;
            font-size: 0.9rem;
        }

        .social-icon:hover {
            background: var(--accent-gold);
            color: var(--dark-purple);
            transform: translateY(-3px);
            border-color: var(--white);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid rgba(155, 126, 176, 0.3);
            color: var(--light-purple);
            font-size: 0.85rem;
        }

        /* ================= RESPONSIVE BREAKPOINTS ================= */
        /* Mobile (up to 576px) - already using 1 column */

        /* Tablet (576px and up) */
        @media (min-width: 576px) {
            .navbar-brand {
                font-size: 1.6rem;
            }
            
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .hero-section p {
                font-size: 1.1rem;
            }
            
            .section-title h2 {
                font-size: 2.2rem;
            }
            
            .course-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .benefits-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .footer-content {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Desktop (992px and up) */
        @media (min-width: 992px) {
            .navbar-custom {
                padding: 1rem 2rem;
            }
            
            .nav-link {
                padding: 0.6rem 1.2rem !important;
                font-size: 1rem;
            }
            
            .hero-section {
                padding: 80px 20px;
            }
            
            .hero-section h1 {
                font-size: 3rem;
            }
            
            .hero-section p {
                font-size: 1.2rem;
            }
            
            .section-padding {
                padding: 70px 20px;
            }
            
            .section-title h2 {
                font-size: 2.5rem;
            }
            
            .course-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 25px;
            }
            
            .features-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 25px;
            }
            
            .benefits-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 25px;
            }
            
            .footer-content {
                grid-template-columns: repeat(4, 1fr);
                gap: 40px;
            }
            
            .cta-section h2 {
                font-size: 2.2rem;
            }
        }

        /* Large Desktop (1200px and up) */
        @media (min-width: 1200px) {
            .container {
                max-width: 1280px;
                margin: 0 auto;
            }
            
            .hero-section h1 {
                font-size: 3.5rem;
            }
        }

        /* Fix for mobile navigation */
        @media (max-width: 991px) {
            .navbar-collapse {
                background: rgba(45, 27, 60, 0.98);
                padding: 1rem;
                border-radius: var(--radius);
                margin-top: 1rem;
                border: 1px solid var(--medium-purple);
            }
            
            .nav-item {
                margin: 0.5rem 0;
            }
            
            .nav-link {
                text-align: center;
            }
            
            .btn-login, .btn-signup {
                display: block;
                text-align: center;
                margin: 0.5rem 0 !important;
            }
        }
    </style>
</head>
<body>
    <!-- ================= NAVBAR ================= -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-graduation-cap"></i> SmartClass
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" style="background: var(--medium-purple); border: none;">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home-about">
                            <i class="fas fa-info-circle"></i> About
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home-courses">
                            <i class="fas fa-book"></i> Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home-contact">
                            <i class="fas fa-envelope"></i> Contact
                        </a>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <a class="nav-link btn-login" href="${pageContext.request.contextPath}/loginusers">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <a class="nav-link btn-signup" href="${pageContext.request.contextPath}/signup">
                            <i class="fas fa-user-plus"></i> Sign Up
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- ================= HERO SECTION ================= -->
    <section class="hero-section">
        <div class="container">
            <div class="hero-content">
                <h1 class="animate-fade-up">Master In-Demand Tech Skills</h1>
                <p class="animate-fade-up delay-1">Learn from industry experts with hands-on projects and a curriculum designed to launch your tech career. Join 50,000+ successful students.</p>
                <div class="hero-buttons animate-fade-up delay-2">
                    <a href="#courses" class="btn-hero btn-hero-primary">
                        <i class="fas fa-book-open"></i> Explore Courses
                    </a>
                    <a href="#benefits" class="btn-hero btn-hero-secondary">
                        <i class="fas fa-users"></i> Student Benefits
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= COURSES SECTION ================= -->
    <section id="courses" class="courses-section section-padding">
        <div class="container">
            <div class="section-title">
                <h2 class="animate-fade-up">Our Course Catalog</h2>
                <p class="animate-fade-up delay-1">Choose from industry-relevant courses designed for your success</p>
            </div>
            
            <div class="course-categories animate-fade-up delay-2">
                <button class="category-btn active" data-category="all">All Courses</button>
                <button class="category-btn" data-category="programming">Programming</button>
                <button class="category-btn" data-category="web">Web Dev</button>
                <button class="category-btn" data-category="core">Core CS</button>
                <button class="category-btn" data-category="advanced">Advanced</button>
            </div>
            
            <div class="course-grid">
                <!-- C Programming -->
                <div class="course-card animate-fade" data-category="programming">
                    <div class="course-header" style="background: var(--gradient-1);">
                        <div class="course-title">C Programming</div>
                        <div class="course-category">Programming Fundamentals</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Master C programming, memory management, and algorithms.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 80+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> 50+ exercises</li>
                            <li><i class="fas fa-check-circle"></i> Pointers & memory</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹999 <span>₹1,999</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- C++ Programming -->
                <div class="course-card animate-fade" data-category="programming">
                    <div class="course-header" style="background: var(--gradient-2);">
                        <div class="course-title">C++ Programming</div>
                        <div class="course-category">Object-Oriented</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Learn OOP, STL, and advanced C++ concepts.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 100+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> OOP & templates</li>
                            <li><i class="fas fa-check-circle"></i> STL algorithms</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹1,199 <span>₹2,399</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Java Programming -->
                <div class="course-card animate-fade" data-category="programming">
                    <div class="course-header" style="background: var(--gradient-3);">
                        <div class="course-title">Java Programming</div>
                        <div class="course-category">Enterprise</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Master Java, Spring Boot, and enterprise apps.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 120+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> Spring Boot</li>
                            <li><i class="fas fa-check-circle"></i> Multithreading</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹1,499 <span>₹2,999</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Python Programming -->
                <div class="course-card animate-fade" data-category="programming">
                    <div class="course-header" style="background: var(--gradient-4);">
                        <div class="course-title">Python Programming</div>
                        <div class="course-category">Versatile</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Python for web dev, data science, and automation.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 120+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> 10+ projects</li>
                            <li><i class="fas fa-check-circle"></i> Django framework</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹1,499 <span>₹2,999</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- JavaScript -->
                <div class="course-card animate-fade" data-category="web">
                    <div class="course-header" style="background: var(--gradient-5);">
                        <div class="course-title">JavaScript</div>
                        <div class="course-category">Web Development</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Modern JavaScript ES6+, React, Node.js.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 100+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> React & Node.js</li>
                            <li><i class="fas fa-check-circle"></i> API development</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹1,299 <span>₹2,599</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Full-Stack Development -->
                <div class="course-card animate-fade" data-category="web">
                    <div class="course-header" style="background: var(--gradient-6);">
                        <div class="course-title">Full-Stack Dev</div>
                        <div class="course-category">Complete Web</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Frontend, backend, database - complete web apps.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 200+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> 15+ projects</li>
                            <li><i class="fas fa-check-circle"></i> MERN stack</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹2,499 <span>₹4,999</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Data Structures & Algorithms -->
                <div class="course-card animate-fade" data-category="core">
                    <div class="course-header" style="background: var(--gradient-1);">
                        <div class="course-title">DSA</div>
                        <div class="course-category">Problem Solving</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Master DSA for coding interviews.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 150+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> 300+ problems</li>
                            <li><i class="fas fa-check-circle"></i> Interview prep</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹1,999 <span>₹3,999</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- DBMS -->
                <div class="course-card animate-fade" data-category="core">
                    <div class="course-header" style="background: var(--gradient-2);">
                        <div class="course-title">Database Management</div>
                        <div class="course-category">Data Management</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">SQL, database design, optimization.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 100+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> MySQL & PostgreSQL</li>
                            <li><i class="fas fa-check-circle"></i> Query optimization</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹1,399 <span>₹2,799</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Operating Systems -->
                <div class="course-card animate-fade" data-category="core">
                    <div class="course-header" style="background: var(--gradient-3);">
                        <div class="course-title">Operating Systems</div>
                        <div class="course-category">System Fundamentals</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Processes, memory management, file systems.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 80+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> Process scheduling</li>
                            <li><i class="fas fa-check-circle"></i> Memory management</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹1,299 <span>₹2,599</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Artificial Intelligence -->
                <div class="course-card animate-fade" data-category="advanced">
                    <div class="course-header" style="background: var(--gradient-4);">
                        <div class="course-title">AI & ML</div>
                        <div class="course-category">Advanced Tech</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Machine learning, neural networks, NLP.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 180+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> ML algorithms</li>
                            <li><i class="fas fa-check-circle"></i> Neural networks</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹3,499 <span>₹6,999</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Cloud Computing -->
                <div class="course-card animate-fade" data-category="advanced">
                    <div class="course-header" style="background: var(--gradient-5);">
                        <div class="course-title">Cloud Computing</div>
                        <div class="course-category">Cloud & DevOps</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">AWS, Azure, Docker, Kubernetes.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 140+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> Multi-cloud</li>
                            <li><i class="fas fa-check-circle"></i> Docker & K8s</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹2,599 <span>₹5,199</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
                
                <!-- Cyber Security -->
                <div class="course-card animate-fade" data-category="advanced">
                    <div class="course-header" style="background: var(--gradient-6);">
                        <div class="course-title">Cyber Security</div>
                        <div class="course-category">Security</div>
                    </div>
                    <div class="course-body">
                        <p class="course-desc">Ethical hacking, network security.</p>
                        <ul class="course-features">
                            <li><i class="fas fa-check-circle"></i> 160+ hours content</li>
                            <li><i class="fas fa-check-circle"></i> Penetration testing</li>
                            <li><i class="fas fa-check-circle"></i> Security tools</li>
                        </ul>
                        <div class="course-footer">
                            <div class="course-price">₹2,999 <span>₹5,999</span></div>
                            <a href="${pageContext.request.contextPath}/signup" class="btn-enroll">Enroll</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= PLATFORM FEATURES ================= -->
    <section class="features-section">
        <div class="container">
            <div class="section-title">
                <h2 class="animate-fade-up">SmartClass Features</h2>
                <p class="animate-fade-up delay-1">Everything you need for successful learning</p>
            </div>
            
            <div class="features-grid">
                <div class="feature-card animate-fade">
                    <div class="feature-icon">
                        <i class="fas fa-video"></i>
                    </div>
                    <h3>Video Lectures</h3>
                    <p>High-quality video lectures from industry experts</p>
                </div>
                
                <div class="feature-card animate-fade">
                    <div class="feature-icon">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <h3>Study Notes</h3>
                    <p>Comprehensive study materials for every topic</p>
                </div>
                
                <div class="feature-card animate-fade">
                    <div class="feature-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <h3>Progress Tracking</h3>
                    <p>Real-time progress tracking and analytics</p>
                </div>
                
                <div class="feature-card animate-fade">
                    <div class="feature-icon">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h3>Doubt Resolution</h3>
                    <p>24/7 doubt resolution with teachers</p>
                </div>
                
                <div class="feature-card animate-fade">
                    <div class="feature-icon">
                        <i class="fas fa-tasks"></i>
                    </div>
                    <h3>MCQ Tests</h3>
                    <p>Regular tests with instant results</p>
                </div>
                
                <div class="feature-card animate-fade">
                    <div class="feature-icon">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <h3>Parent Monitoring</h3>
                    <p>Track attendance and progress</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= BENEFITS SECTION ================= -->
    <section id="benefits" class="benefits-section">
        <div class="container">
            <div class="section-title">
                <h2 class="animate-fade-up">Benefits for All</h2>
                <p class="animate-fade-up delay-1">Integrated platform for students, teachers, and parents</p>
            </div>
            
            <div class="benefits-grid">
                <div class="benefit-card animate-fade">
                    <h3><i class="fas fa-user-graduate"></i> For Students</h3>
                    <ul class="benefit-list">
                        <li><i class="fas fa-check-circle"></i> Video lectures & notes</li>
                        <li><i class="fas fa-check-circle"></i> Online MCQ tests</li>
                        <li><i class="fas fa-check-circle"></i> Teacher communication</li>
                        <li><i class="fas fa-check-circle"></i> Progress tracking</li>
                    </ul>
                </div>
                
                <div class="benefit-card animate-fade">
                    <h3><i class="fas fa-chalkboard-teacher"></i> For Teachers</h3>
                    <ul class="benefit-list">
                        <li><i class="fas fa-check-circle"></i> Upload videos & notes</li>
                        <li><i class="fas fa-check-circle"></i> Track attendance</li>
                        <li><i class="fas fa-check-circle"></i> Upload marks</li>
                        <li><i class="fas fa-check-circle"></i> Parent communication</li>
                    </ul>
                </div>
                
                <div class="benefit-card animate-fade">
                    <h3><i class="fas fa-users"></i> For Parents</h3>
                    <ul class="benefit-list">
                        <li><i class="fas fa-check-circle"></i> Monitor attendance</li>
                        <li><i class="fas fa-check-circle"></i> View test scores</li>
                        <li><i class="fas fa-check-circle"></i> Track progress</li>
                        <li><i class="fas fa-check-circle"></i> Teacher communication</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= CTA SECTION ================= -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-content">
                <h2 class="animate-fade-up">Start Your Learning Journey Today</h2>
                <p class="animate-fade-up delay-1">Join thousands of successful students who transformed their careers with SmartClass</p>
                <div class="hero-buttons animate-fade-up delay-2">
                    <a href="${pageContext.request.contextPath}/signup" class="btn-hero btn-hero-primary">
                        <i class="fas fa-user-plus"></i> Get Started Free
                    </a>
                    <a href="${pageContext.request.contextPath}/home-contact" class="btn-hero btn-hero-secondary">
                        <i class="fas fa-calendar-alt"></i> Contact Us
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= FOOTER ================= -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-about">
                    <div class="footer-logo">
                        <i class="fas fa-graduation-cap"></i> SmartClass
                    </div>
                    <p class="footer-description">
                        Empowering students with cutting-edge technology education for the digital age.
                    </p>
                    <div class="social-icons">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                
                <div class="footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-about"><i class="fas fa-chevron-right"></i> About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-courses"><i class="fas fa-chevron-right"></i> Courses</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-contact"><i class="fas fa-chevron-right"></i> Contact</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h3>Categories</h3>
                    <ul>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Programming</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Web Development</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Core CS</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Advanced Tech</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h3>Contact Info</h3>
                    <ul>
                        <li><a href="#"><i class="fas fa-map-marker-alt"></i> 123 Tech Street</a></li>
                        <li><a href="tel:+11234567890"><i class="fas fa-phone"></i> +1 (123) 456-7890</a></li>
                        <li><a href="mailto:info@smartclass.com"><i class="fas fa-envelope"></i> info@smartclass.com</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2025 SmartClass. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Set active nav link
            const currentPage = window.location.pathname.split('/').pop();
            const navLinks = document.querySelectorAll('.nav-link');
            
            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href').includes(currentPage)) {
                    link.classList.add('active');
                }
            });
            
            // Smooth scrolling for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    const href = this.getAttribute('href');
                    if (href === '#' || href.includes('.jsp')) return;
                    
                    e.preventDefault();
                    const target = document.querySelector(href);
                    if (target) {
                        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                });
            });
            
            // Course filtering
            const categoryBtns = document.querySelectorAll('.category-btn');
            const courseCards = document.querySelectorAll('.course-card');
            
            categoryBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    categoryBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    
                    const category = this.dataset.category;
                    
                    courseCards.forEach(card => {
                        if (category === 'all' || card.dataset.category === category) {
                            card.style.display = 'flex';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });
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
            
            document.querySelectorAll('.course-card, .feature-card, .benefit-card').forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(20px)';
                el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                observer.observe(el);
            });
        });
    </script>
</body>
</html>