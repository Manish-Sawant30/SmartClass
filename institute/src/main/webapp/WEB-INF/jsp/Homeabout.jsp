<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - SmartClass</title>
    
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
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
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

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        @keyframes glow {
            0% { box-shadow: 0 0 5px var(--soft-purple); }
            50% { box-shadow: 0 0 20px var(--soft-purple), 0 0 30px var(--medium-purple); }
            100% { box-shadow: 0 0 5px var(--soft-purple); }
        }

        .animate-fade-up {
            animation: fadeInUp 0.8s ease forwards;
        }

        .animate-fade-left {
            animation: fadeInLeft 0.8s ease forwards;
        }

        .animate-fade-right {
            animation: fadeInRight 0.8s ease forwards;
        }

        .animate-scale {
            animation: scaleIn 0.6s ease forwards;
        }

        .animate-float {
            animation: float 3s ease-in-out infinite;
        }

        .animate-glow {
            animation: glow 2s ease-in-out infinite;
        }

        .delay-1 { animation-delay: 0.2s; opacity: 0; animation-fill-mode: forwards; }
        .delay-2 { animation-delay: 0.4s; opacity: 0; animation-fill-mode: forwards; }
        .delay-3 { animation-delay: 0.6s; opacity: 0; animation-fill-mode: forwards; }
        .delay-4 { animation-delay: 0.8s; opacity: 0; animation-fill-mode: forwards; }

        /* ================= NAVBAR ================= */
        .navbar-custom {
            background: rgba(45, 27, 60, 0.95);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 2px solid var(--medium-purple);
        }

        .navbar-brand {
            color: var(--white) !important;
            font-weight: 800;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
        }

        .navbar-brand i {
            color: var(--accent-gold);
            font-size: 2rem;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .nav-link {
            color: var(--text-light) !important;
            font-weight: 500;
            padding: 0.6rem 1.2rem !important;
            border-radius: 30px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
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
            padding: 0.6rem 1.8rem !important;
            border-radius: 30px;
            font-weight: 600;
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
            padding: 0.6rem 1.8rem !important;
            border-radius: 30px;
            font-weight: 700;
            transition: var(--transition);
        }

        .btn-signup:hover {
            background: transparent;
            color: var(--accent-gold) !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        /* ================= ABOUT HERO ================= */
        .about-hero {
            padding: 100px 20px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .about-hero::before {
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

        .about-hero h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 0.8s ease forwards;
        }

        .about-hero p {
            font-size: 1.3rem;
            max-width: 800px;
            margin: 0 auto 2rem;
            color: var(--light-purple);
            animation: fadeInUp 0.8s ease 0.2s forwards;
            opacity: 0;
        }

        .hero-stats {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 3rem;
            margin-top: 3rem;
            animation: fadeInUp 0.8s ease 0.4s forwards;
            opacity: 0;
        }

        .stat-item {
            text-align: center;
            transition: var(--transition);
        }

        .stat-item:hover {
            transform: scale(1.1);
        }

        .stat-number {
            font-weight: 800;
            font-size: 2.5rem;
            color: var(--accent-gold);
            margin-bottom: 0.5rem;
            text-shadow: 0 0 20px rgba(230, 184, 0, 0.5);
        }

        .stat-text {
            font-size: 1rem;
            color: var(--light-purple);
        }

        /* ================= ABOUT CONTENT ================= */
        .about-section {
            padding: 5rem 0;
        }

        .section-title {
            font-weight: 700;
            font-size: 2.5rem;
            color: var(--white);
            margin-bottom: 1.5rem;
            position: relative;
            display: inline-block;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--accent-gold);
            border-radius: 2px;
        }

        .about-content {
            margin-bottom: 4rem;
        }

        .about-text {
            font-size: 1.1rem;
            line-height: 1.8;
            color: var(--text-light);
        }

        .highlight-box {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-left: 5px solid var(--accent-gold);
            padding: 2rem;
            border-radius: var(--radius);
            margin: 2rem 0;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(155, 126, 176, 0.3);
        }

        /* ================= PLATFORM FEATURES ================= */
        .features-section {
            padding: 5rem 0;
            background: rgba(0, 0, 0, 0.2);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 2.5rem;
            height: 100%;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
            border-top: 4px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
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

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .feature-card:hover::before {
            opacity: 1;
        }

        .feature-card.admin:hover {
            border-top-color: var(--royal-purple);
        }

        .feature-card.teacher:hover {
            border-top-color: var(--medium-purple);
        }

        .feature-card.student:hover {
            border-top-color: var(--soft-purple);
        }

        .feature-card.parent:hover {
            border-top-color: var(--light-purple);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            color: var(--accent-gold);
            font-size: 2rem;
            transition: var(--transition);
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 0 30px rgba(230, 184, 0, 0.3);
        }

        .feature-title {
            font-weight: 600;
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--white);
        }

        .feature-description {
            color: var(--light-purple);
            margin-bottom: 1.5rem;
        }

        .feature-list {
            list-style: none;
            padding: 0;
        }

        .feature-list li {
            margin-bottom: 0.8rem;
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .feature-list li i {
            color: var(--accent-gold);
            font-size: 0.9rem;
        }

        /* ================= WORKFLOW ================= */
        .workflow-section {
            padding: 5rem 0;
        }

        .workflow-container {
            position: relative;
            padding: 2rem 0;
        }

        .workflow-steps {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 25px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .workflow-step {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 2rem;
            text-align: center;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
            position: relative;
            overflow: hidden;
        }

        .workflow-step:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .step-number {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--accent-gold);
            font-weight: 700;
            font-size: 1.3rem;
            transition: var(--transition);
        }

        .workflow-step:hover .step-number {
            transform: scale(1.1);
            box-shadow: 0 0 20px rgba(230, 184, 0, 0.3);
        }

        .step-title {
            font-weight: 600;
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: var(--white);
        }

        .step-description {
            color: var(--text-light);
        }

        /* ================= TESTIMONIALS ================= */
        .testimonials-section {
            padding: 5rem 0;
            background: rgba(0, 0, 0, 0.2);
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .testimonial-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
            position: relative;
            overflow: hidden;
        }

        .testimonial-card::before {
            content: '"';
            position: absolute;
            top: -20px;
            right: 20px;
            font-size: 8rem;
            color: rgba(230, 184, 0, 0.1);
            font-family: serif;
        }

        .testimonial-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .testimonial-content {
            font-style: italic;
            margin-bottom: 1.5rem;
            color: var(--text-light);
            font-size: 1rem;
            line-height: 1.8;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
        }

        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-gold);
            margin-right: 1rem;
            font-size: 1.2rem;
        }

        .author-info h4 {
            font-weight: 600;
            margin-bottom: 0.2rem;
            color: var(--white);
        }

        .author-info p {
            font-size: 0.9rem;
            color: var(--light-purple);
        }

        /* ================= CTA SECTION ================= */
        .cta-section {
            padding: 5rem 0;
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
            background: radial-gradient(circle at 30% 50%, rgba(230, 184, 0, 0.15) 0%, transparent 50%),
                        radial-gradient(circle at 70% 50%, rgba(155, 126, 176, 0.15) 0%, transparent 50%);
        }

        .cta-title {
            font-weight: 800;
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            color: var(--white);
            position: relative;
            z-index: 1;
        }

        .cta-description {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 2rem;
            color: var(--light-purple);
            position: relative;
            z-index: 1;
        }

        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin-top: 2rem;
            flex-wrap: wrap;
            position: relative;
            z-index: 1;
        }

        .cta-btn {
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .cta-btn::before {
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

        .cta-btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .cta-btn-primary {
            background: var(--accent-gold);
            color: var(--dark-purple);
        }

        .cta-btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(230, 184, 0, 0.3);
        }

        .cta-btn-secondary {
            background: transparent;
            color: var(--white);
            border: 2px solid var(--soft-purple);
        }

        .cta-btn-secondary:hover {
            background: var(--soft-purple);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(155, 126, 176, 0.3);
        }

        /* ================= FOOTER ================= */
        .footer {
            background: var(--dark-purple);
            padding: 80px 20px 30px;
            border-top: 2px solid var(--royal-purple);
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto 50px;
        }

        .footer-logo {
            font-size: 1.8rem;
            font-weight: 800;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--accent-gold);
        }

        .footer-description {
            color: var(--light-purple);
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .footer-links h3 {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--white);
        }

        .footer-links ul {
            list-style: none;
            padding: 0;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: var(--light-purple);
            text-decoration: none;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-links a:hover {
            color: var(--accent-gold);
            transform: translateX(5px);
        }

        .social-icons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .social-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border: 2px solid transparent;
        }

        .social-icon:hover {
            background: var(--accent-gold);
            color: var(--dark-purple);
            transform: translateY(-3px) scale(1.1);
            border-color: var(--white);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid rgba(155, 126, 176, 0.3);
            color: var(--light-purple);
            font-size: 0.95rem;
        }

        /* ================= RESPONSIVE ================= */
        @media (min-width: 640px) {
            .features-grid,
            .testimonials-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .workflow-steps {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .footer-content {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .about-hero h1 {
                font-size: 4rem;
            }
        }

        @media (min-width: 1024px) {
            .features-grid {
                grid-template-columns: repeat(4, 1fr);
            }
            
            .testimonials-grid {
                grid-template-columns: repeat(3, 1fr);
            }
            
            .workflow-steps {
                grid-template-columns: repeat(4, 1fr);
            }
            
            .footer-content {
                grid-template-columns: repeat(4, 1fr);
            }
        }

        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 20px;
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

            <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home-about">
                            <i class="fas fa-info-circle"></i> About
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home-courses">
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

    <!-- ================= ABOUT HERO ================= -->
    <section class="about-hero">
        <div class="container">
            <h1>Revolutionizing Education with SmartClass</h1>
            <p>SmartClass is a comprehensive learning management platform that connects administrators, teachers, students, and parents in a seamless educational ecosystem.</p>
            
            <div class="hero-stats">
                <div class="stat-item">
                    <div class="stat-number">4</div>
                    <div class="stat-text">Integrated Modules</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">10K+</div>
                    <div class="stat-text">Active Students</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-text">Expert Teachers</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">99%</div>
                    <div class="stat-text">Satisfaction Rate</div>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= ABOUT CONTENT ================= -->
    <section class="about-section">
        <div class="container">
            <div class="about-content">
                <h2 class="section-title animate-fade-up">Our Integrated Platform</h2>
                <div class="about-text animate-fade-up delay-1">
                    <p>SmartClass is not just another learning platform - it's a complete educational ecosystem designed to streamline communication, enhance learning outcomes, and simplify administration for modern educational institutions.</p>
                    
                    <div class="highlight-box animate-scale delay-2">
                        <h3 class="mb-3" style="color: var(--accent-gold);">How It Works</h3>
                        <p>Administrators manage the entire platform, creating accounts for teachers, students, and parents. Teachers upload course materials, videos, notes, and track student progress. Students access exclusive content, take tests, and communicate with teachers. Parents monitor their child's attendance, grades, and connect with teachers - all in one integrated system.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= PLATFORM FEATURES ================= -->
    <section class="features-section">
        <div class="container">
            <h2 class="section-title text-center mb-5 animate-fade-up">Four Modules, One Platform</h2>
            
            <div class="features-grid">
                <!-- Admin Module -->
                <div class="feature-card admin animate-fade-left delay-1">
                    <div class="feature-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h3 class="feature-title">Admin Module</h3>
                    <p class="feature-description">Complete control and oversight of the entire educational ecosystem</p>
                    <ul class="feature-list">
                        <li><i class="fas fa-check-circle"></i> Create & manage user accounts</li>
                        <li><i class="fas fa-check-circle"></i> Assign login credentials</li>
                        <li><i class="fas fa-check-circle"></i> Monitor platform activity</li>
                        <li><i class="fas fa-check-circle"></i> Course management</li>
                        <li><i class="fas fa-check-circle"></i> Generate comprehensive reports</li>
                    </ul>
                </div>
                
                <!-- Teacher Module -->
                <div class="feature-card teacher animate-fade-up delay-2">
                    <div class="feature-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <h3 class="feature-title">Teacher Module</h3>
                    <p class="feature-description">Empower educators with tools for effective teaching and student engagement</p>
                    <ul class="feature-list">
                        <li><i class="fas fa-check-circle"></i> Upload videos & course notes</li>
                        <li><i class="fas fa-check-circle"></i> Track student attendance</li>
                        <li><i class="fas fa-check-circle"></i> Upload marks & assessments</li>
                        <li><i class="fas fa-check-circle"></i> Communicate with students & parents</li>
                        <li><i class="fas fa-check-circle"></i> Monitor student progress</li>
                    </ul>
                </div>
                
                <!-- Student Module -->
                <div class="feature-card student animate-fade-right delay-3">
                    <div class="feature-icon">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <h3 class="feature-title">Student Module</h3>
                    <p class="feature-description">Personalized learning experience with exclusive access to educational resources</p>
                    <ul class="feature-list">
                        <li><i class="fas fa-check-circle"></i> Access exclusive video lectures</li>
                        <li><i class="fas fa-check-circle"></i> Download course notes & materials</li>
                        <li><i class="fas fa-check-circle"></i> Take online MCQ examinations</li>
                        <li><i class="fas fa-check-circle"></i> Communicate with teachers for doubts</li>
                        <li><i class="fas fa-check-circle"></i> Track personal progress & grades</li>
                    </ul>
                </div>
                
                <!-- Parent Module -->
                <div class="feature-card parent animate-fade-up delay-4">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="feature-title">Parent Module</h3>
                    <p class="feature-description">Stay connected with your child's educational journey and progress</p>
                    <ul class="feature-list">
                        <li><i class="fas fa-check-circle"></i> Monitor student attendance</li>
                        <li><i class="fas fa-check-circle"></i> View test scores & grades</li>
                        <li><i class="fas fa-check-circle"></i> Communicate with teachers</li>
                        <li><i class="fas fa-check-circle"></i> Track academic progress</li>
                        <li><i class="fas fa-check-circle"></i> Receive important notifications</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= WORKFLOW ================= -->
    <section class="workflow-section">
        <div class="container">
            <h2 class="section-title text-center mb-5 animate-fade-up">Seamless Educational Workflow</h2>
            
            <div class="workflow-steps">
                <div class="workflow-step animate-fade-left delay-1">
                    <div class="step-number">1</div>
                    <h3 class="step-title">Admin Setup</h3>
                    <p class="step-description">Administrator creates accounts and assigns login credentials to teachers, students, and parents</p>
                </div>
                
                <div class="workflow-step animate-fade-up delay-2">
                    <div class="step-number">2</div>
                    <h3 class="step-title">Content Delivery</h3>
                    <p class="step-description">Teachers upload course materials, videos, and notes for student access</p>
                </div>
                
                <div class="workflow-step animate-fade-right delay-3">
                    <div class="step-number">3</div>
                    <h3 class="step-title">Learning & Assessment</h3>
                    <p class="step-description">Students access materials, take tests, and communicate with teachers</p>
                </div>
                
                <div class="workflow-step animate-fade-up delay-4">
                    <div class="step-number">4</div>
                    <h3 class="step-title">Progress Tracking</h3>
                    <p class="step-description">Parents monitor attendance, grades, and connect with teachers</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= TESTIMONIALS ================= -->
    <section class="testimonials-section">
        <div class="container">
            <h2 class="section-title text-center mb-5 animate-fade-up">What Our Users Say</h2>
            
            <div class="testimonials-grid">
                <div class="testimonial-card animate-fade-left delay-1">
                    <div class="testimonial-content">
                        "As an administrator, SmartClass has simplified our school management tremendously. Creating and managing accounts for all stakeholders is now effortless."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <div class="author-info">
                            <h4>Robert Johnson</h4>
                            <p>School Administrator</p>
                        </div>
                    </div>
                </div>
                
                <div class="testimonial-card animate-fade-up delay-2">
                    <div class="testimonial-content">
                        "Uploading lecture videos and tracking student progress has never been easier. The platform helps me focus more on teaching than administrative tasks."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <div class="author-info">
                            <h4>Dr. Sarah Williams</h4>
                            <p>Mathematics Teacher</p>
                        </div>
                    </div>
                </div>
                
                <div class="testimonial-card animate-fade-right delay-3">
                    <div class="testimonial-content">
                        "I can finally monitor my daughter's attendance and test scores in real-time. The communication feature with teachers is invaluable for her academic success."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="author-info">
                            <h4>Lisa Chen</h4>
                            <p>Parent</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= CTA SECTION ================= -->
    <section class="cta-section">
        <div class="container">
            <h2 class="cta-title animate-fade-up">Ready to Transform Education with SmartClass?</h2>
            <p class="cta-description animate-fade-up delay-1">Join thousands of educational institutions already using SmartClass to enhance learning outcomes and streamline administration.</p>
            
            <div class="cta-buttons animate-fade-up delay-2">
                <a href="${pageContext.request.contextPath}/signup" class="cta-btn cta-btn-primary">
                    <i class="fas fa-rocket"></i> Get Started Free
                </a>
                <a href="${pageContext.request.contextPath}/home-contact" class="cta-btn cta-btn-secondary">
                    <i class="fas fa-calendar-alt"></i> Schedule a Demo
                </a>
            </div>
        </div>
    </section>

    <!-- ================= FOOTER ================= -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-about animate-fade-left">
                    <div class="footer-logo">
                        <i class="fas fa-graduation-cap"></i> SmartClass
                    </div>
                    <p class="footer-description">
                        Empowering students worldwide with cutting-edge technology education and practical skills for the digital age.
                    </p>
                    <div class="social-icons">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                
                <div class="footer-links animate-fade-up">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-about"><i class="fas fa-chevron-right"></i> About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-courses"><i class="fas fa-chevron-right"></i> All Courses</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-contact"><i class="fas fa-chevron-right"></i> Contact</a></li>
                    </ul>
                </div>
                
                <div class="footer-links animate-fade-up">
                    <h3>Platform Modules</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/adminlogin"><i class="fas fa-chevron-right"></i> Admin Portal</a></li>
                        <li><a href="${pageContext.request.contextPath}/teacher-login"><i class="fas fa-chevron-right"></i> Teacher Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/student-login"><i class="fas fa-chevron-right"></i> Student Learning</a></li>
                        <li><a href="${pageContext.request.contextPath}/parents/login"><i class="fas fa-chevron-right"></i> Parent Monitoring</a></li>
                    </ul>
                </div>
                
                <div class="footer-links animate-fade-right">
                    <h3>Contact Info</h3>
                    <ul>
                        <li><a href="#"><i class="fas fa-map-marker-alt"></i> 123 Tech Street, Silicon Valley</a></li>
                        <li><a href="tel:+11234567890"><i class="fas fa-phone"></i> +1 (123) 456-7890</a></li>
                        <li><a href="mailto:info@smartclass.com"><i class="fas fa-envelope"></i> info@smartclass.com</a></li>
                        <li><a href="#"><i class="fas fa-clock"></i> Mon-Fri: 9AM-6PM</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom animate-fade-up">
                <p>&copy; 2025 SmartClass - Integrated Learning Management Platform. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Set active nav link based on current page
        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = window.location.pathname.split('/').pop();
            const navLinks = document.querySelectorAll('.nav-link');
            
            navLinks.forEach(link => {
                const href = link.getAttribute('href');
                link.classList.remove('active');
                
                if (href === currentPage || (currentPage === '' && href === '/')) {
                    link.classList.add('active');
                }
            });
            
            // Add animation on scroll
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, { threshold: 0.1 });
            
            document.querySelectorAll('.feature-card, .workflow-step, .testimonial-card').forEach(el => {
                observer.observe(el);
            });
        });
    </script>
</body>
</html>