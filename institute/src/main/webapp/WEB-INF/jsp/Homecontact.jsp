<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#2d1b3c">
    <title>Contact Us - SmartClass</title>
    
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
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background: linear-gradient(135deg, var(--dark-purple) 0%, var(--deep-purple) 100%);
            color: var(--white);
            line-height: 1.6;
            min-height: 100vh;
            overflow-x: hidden;
            width: 100%;
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
            width: 100%;
        }

        .navbar-brand {
            color: var(--white) !important;
            font-weight: 800;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
            white-space: nowrap;
        }

        .navbar-brand i {
            color: var(--accent-gold);
            font-size: 1.8rem;
        }

        .logo-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-gold);
        }

        .navbar-toggler {
            border: 2px solid var(--medium-purple);
            padding: 0.4rem 0.6rem;
            width: 44px;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.1);
        }

        .navbar-toggler-icon {
            filter: invert(1) brightness(100);
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.5);
        }

        .navbar-collapse {
            background: rgba(45, 27, 60, 0.98);
            backdrop-filter: blur(10px);
            padding: 1rem;
            border-radius: var(--radius);
            margin-top: 0.5rem;
            max-height: 80vh;
            overflow-y: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid var(--medium-purple);
        }

        .nav-link {
            color: var(--text-light) !important;
            font-weight: 500;
            padding: 0.8rem 1rem !important;
            border-radius: 30px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
            min-height: 48px;
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

        .nav-link:hover::before,
        .nav-link:active::before {
            width: 300px;
            height: 300px;
        }

        .nav-link:hover,
        .nav-link:active {
            color: var(--white) !important;
        }

        .nav-link.active {
            background: var(--medium-purple);
            color: var(--white) !important;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(90, 61, 110, 0.5);
        }

        .btn-login, .btn-signup {
            min-height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin: 0.5rem 0;
            width: 100%;
            text-align: center;
        }

        .btn-login {
            background: transparent;
            border: 2px solid var(--soft-purple);
            color: var(--white) !important;
            padding: 0.6rem 1.5rem !important;
            border-radius: 30px;
        }

        .btn-login:hover,
        .btn-login:active {
            background: var(--soft-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(155, 126, 176, 0.4);
        }

        .btn-signup {
            background: var(--accent-gold);
            border: 2px solid var(--accent-gold);
            color: var(--dark-purple) !important;
            padding: 0.6rem 1.5rem !important;
            border-radius: 30px;
            font-weight: 700;
        }

        .btn-signup:hover,
        .btn-signup:active {
            background: transparent;
            color: var(--accent-gold) !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        /* ================= CONTACT HERO ================= */
        .contact-hero {
            padding: 60px 15px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .contact-hero::before {
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

        .contact-hero h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
        }

        .contact-hero p {
            font-size: 1rem;
            max-width: 600px;
            margin: 0 auto;
            color: var(--light-purple);
            position: relative;
            z-index: 1;
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

        /* ================= CONTACT INFO CARDS ================= */
        .contact-section {
            background: rgba(0, 0, 0, 0.2);
        }

        .contact-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .contact-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 30px 20px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
        }

        .contact-card:hover {
            transform: translateY(-5px);
            border-color: var(--soft-purple);
            box-shadow: var(--shadow);
        }

        .contact-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: var(--accent-gold);
            font-size: 1.8rem;
            transition: var(--transition);
        }

        .contact-card:hover .contact-icon {
            transform: scale(1.1);
            box-shadow: 0 0 20px rgba(230, 184, 0, 0.3);
        }

        .contact-card h3 {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--white);
            margin-bottom: 15px;
        }

        .contact-details {
            color: var(--text-light);
            font-size: 0.95rem;
            line-height: 1.8;
        }

        .contact-details a {
            color: var(--light-purple);
            text-decoration: none;
            transition: var(--transition);
            word-break: break-word;
        }

        .contact-details a:hover {
            color: var(--accent-gold);
        }

        .contact-details p {
            margin-bottom: 5px;
        }

        /* ================= CONTACT FORM ================= */
        .form-section {
            padding: 50px 15px;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 30px 20px;
            border: 1px solid rgba(155, 126, 176, 0.2);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            color: var(--white);
            font-weight: 500;
            margin-bottom: 8px;
            display: block;
            font-size: 0.95rem;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(155, 126, 176, 0.3);
            border-radius: var(--radius-sm);
            color: var(--white);
            font-size: 1rem;
            transition: var(--transition);
            min-height: 48px;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent-gold);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 3px rgba(230, 184, 0, 0.1);
        }

        .form-control::placeholder {
            color: var(--light-purple);
            opacity: 0.7;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .btn-submit {
            background: var(--accent-gold);
            color: var(--dark-purple);
            border: 2px solid var(--accent-gold);
            padding: 14px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            width: 100%;
            justify-content: center;
            min-height: 52px;
        }

        .btn-submit:hover {
            background: transparent;
            color: var(--accent-gold);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        /* ================= FAQ SECTION ================= */
        .faq-section {
            background: rgba(0, 0, 0, 0.2);
            padding: 50px 15px;
        }

        .faq-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .faq-item {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            margin-bottom: 15px;
            border: 1px solid rgba(155, 126, 176, 0.2);
            overflow: hidden;
        }

        .faq-question {
            padding: 18px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            font-weight: 600;
            color: var(--white);
            min-height: 60px;
            transition: var(--transition);
        }

        .faq-question:hover,
        .faq-question:active {
            background: rgba(255, 255, 255, 0.1);
        }

        .faq-question span {
            font-size: 1rem;
            padding-right: 15px;
        }

        .faq-icon {
            color: var(--accent-gold);
            transition: var(--transition);
            font-size: 1rem;
            width: 24px;
            text-align: center;
        }

        .faq-answer {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: var(--transition);
            color: var(--text-light);
            font-size: 0.95rem;
            line-height: 1.7;
        }

        .faq-item.active .faq-answer {
            padding: 0 20px 20px;
            max-height: 500px;
        }

        .faq-item.active .faq-icon {
            transform: rotate(180deg);
        }

        /* ================= MAP SECTION ================= */
        .map-section {
            padding: 50px 15px;
        }

        .map-container {
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 2px solid rgba(155, 126, 176, 0.3);
            max-width: 1200px;
            margin: 0 auto;
        }

        .map-container iframe {
            width: 100%;
            height: 300px;
            border: 0;
            display: block;
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
            margin-bottom: 10px;
        }

        .footer-links a {
            color: var(--light-purple);
            text-decoration: none;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            min-height: 40px;
        }

        .footer-links a:hover,
        .footer-links a:active {
            color: var(--accent-gold);
            transform: translateX(5px);
        }

        .social-icons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .social-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border: 2px solid transparent;
            font-size: 1rem;
        }

        .social-icon:hover,
        .social-icon:active {
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
            
            .contact-hero h1 {
                font-size: 2.5rem;
            }
            
            .contact-hero p {
                font-size: 1.1rem;
            }
            
            .section-title h2 {
                font-size: 2.2rem;
            }
            
            .contact-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .footer-content {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .btn-submit {
                width: auto;
                min-width: 200px;
            }
            
            .form-container {
                padding: 40px 30px;
            }
        }

        /* Desktop (992px and up) */
        @media (min-width: 992px) {
            .navbar-custom {
                padding: 1rem 2rem;
            }
            
            .navbar-brand {
                font-size: 1.8rem;
            }
            
            .navbar-collapse {
                background: transparent;
                padding: 0;
                margin-top: 0;
                max-height: none;
                overflow-y: visible;
                border: none;
            }
            
            .nav-link {
                padding: 0.6rem 1.2rem !important;
                margin: 0 0.3rem;
                min-height: auto;
            }
            
            .btn-login, .btn-signup {
                margin: 0;
                min-width: 120px;
                min-height: auto;
            }
            
            .contact-hero {
                padding: 80px 20px;
            }
            
            .contact-hero h1 {
                font-size: 3rem;
            }
            
            .contact-hero p {
                font-size: 1.2rem;
            }
            
            .section-padding {
                padding: 70px 20px;
            }
            
            .section-title h2 {
                font-size: 2.5rem;
            }
            
            .contact-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 25px;
            }
            
            .form-section,
            .faq-section,
            .map-section {
                padding: 70px 20px;
            }
            
            .footer-content {
                grid-template-columns: repeat(4, 1fr);
                gap: 40px;
            }
            
            .map-container iframe {
                height: 400px;
            }
        }

        /* Large Desktop (1200px and up) */
        @media (min-width: 1200px) {
            .container {
                max-width: 1280px;
                margin: 0 auto;
            }
        }

        /* Fix for iOS zoom on input */
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
    <!-- ================= NAVBAR ================= -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-graduation-cap"></i> SmartClass
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-lg-center">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/home-courses">
                            <i class="fas fa-book"></i> Courses
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home-contact">
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

    <!-- ================= CONTACT HERO ================= -->
    <section class="contact-hero">
        <div class="container">
            <h1 class="animate-fade-up">Get in Touch</h1>
            <p class="animate-fade-up delay-1">We're here to help! Reach out to us for any questions or support you need.</p>
        </div>
    </section>

    <!-- ================= CONTACT INFO CARDS ================= -->
    <section class="contact-section section-padding">
        <div class="container">
            <div class="section-title">
                <h2 class="animate-fade-up">Contact Information</h2>
                <p class="animate-fade-up delay-1">Multiple ways to get in touch with us</p>
            </div>
            
            <div class="contact-grid">
                <div class="contact-card animate-fade">
                    <div class="contact-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <h3>Our Location</h3>
                    <div class="contact-details">
                        <p>123 Tech Street</p>
                        <p>Silicon Valley</p>
                        <p>San Francisco, CA 94107</p>
                    </div>
                </div>
                
                <div class="contact-card animate-fade delay-1">
                    <div class="contact-icon">
                        <i class="fas fa-phone-alt"></i>
                    </div>
                    <h3>Phone Numbers</h3>
                    <div class="contact-details">
                        <p>General: <a href="tel:+11234567890">+1 (123) 456-7890</a></p>
                        <p>Support: <a href="tel:+11234567891">+1 (123) 456-7891</a></p>
                        <p>Mon-Fri: 9AM-6PM PST</p>
                    </div>
                </div>
                
                <div class="contact-card animate-fade delay-2">
                    <div class="contact-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <h3>Email Addresses</h3>
                    <div class="contact-details">
                        <p><a href="mailto:info@smartclass.com">info@smartclass.com</a></p>
                        <p><a href="mailto:support@smartclass.com">support@smartclass.com</a></p>
                        <p><a href="mailto:admissions@smartclass.com">admissions@smartclass.com</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

   

    <!-- ================= FAQ SECTION ================= -->
    <section class="faq-section">
        <div class="container">
            <div class="section-title">
                <h2 class="animate-fade-up">Frequently Asked Questions</h2>
                <p class="animate-fade-up delay-1">Quick answers to common questions</p>
            </div>
            
            <div class="faq-container">
                <div class="faq-item animate-fade">
                    <div class="faq-question">
                        <span>How do I enroll in a course?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </div>
                    <div class="faq-answer">
                        You can enroll in any course by visiting our Courses page, selecting your desired course, and clicking the "Enroll Now" button. You'll be guided through the registration and payment process.
                    </div>
                </div>
                
                <div class="faq-item animate-fade delay-1">
                    <div class="faq-question">
                        <span>Do you offer any free courses?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </div>
                    <div class="faq-answer">
                        Yes! We offer free trial versions of all our courses. You can access the first few lessons of any course for free to see if it's right for you before making a purchase.
                    </div>
                </div>
                
                <div class="faq-item animate-fade delay-2">
                    <div class="faq-question">
                        <span>What payment methods do you accept?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </div>
                    <div class="faq-answer">
                        We accept all major credit cards (Visa, MasterCard, American Express), PayPal, and bank transfers. All payments are processed securely through our encrypted payment gateway.
                    </div>
                </div>
                
                <div class="faq-item animate-fade">
                    <div class="faq-question">
                        <span>Can I get a refund if I'm not satisfied?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </div>
                    <div class="faq-answer">
                        We offer a 30-day money-back guarantee for all our courses. If you're not satisfied with your purchase within 30 days, you can request a full refund with no questions asked.
                    </div>
                </div>
                
                <div class="faq-item animate-fade delay-1">
                    <div class="faq-question">
                        <span>Do you provide certificates upon completion?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </div>
                    <div class="faq-answer">
                        Yes! Upon successful completion of any course, you'll receive a digital certificate that you can share on LinkedIn or include in your resume and portfolio.
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= MAP SECTION ================= -->
    <section class="map-section">
        <div class="container">
            <div class="section-title">
                <h2 class="animate-fade-up">Find Us Here</h2>
                <p class="animate-fade-up delay-1">Visit our office for in-person consultations</p>
            </div>
            
            <div class="map-container animate-fade">
                <iframe 
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.6814343364205!2d-122.419416484682!3d37.77492977975913!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8085808c0f8c7b7d%3A0x8e2b8b5b1c0c5b1d!2s123%20Tech%20Street%2C%20San%20Francisco%2C%20CA%2094107!5e0!3m2!1sen!2sus!4v1621234567890!5m2!1sen!2sus" 
                    allowfullscreen="" 
                    loading="lazy"
                    title="SmartClass Office Location">
                </iframe>
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
                        <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                
                <div class="footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-about"><i class="fas fa-chevron-right"></i> About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-courses"><i class="fas fa-chevron-right"></i> All Courses</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-contact"><i class="fas fa-chevron-right"></i> Contact</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h3>Categories</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home-courses#programming"><i class="fas fa-chevron-right"></i> Programming</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-courses#web"><i class="fas fa-chevron-right"></i> Web Development</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-courses#core"><i class="fas fa-chevron-right"></i> Core CS</a></li>
                        <li><a href="${pageContext.request.contextPath}/home-courses#advanced"><i class="fas fa-chevron-right"></i> Advanced Tech</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h3>Contact Info</h3>
                    <ul>
                        <li><a href="#"><i class="fas fa-map-marker-alt"></i> 123 Tech Street, CA</a></li>
                        <li><a href="tel:+11234567890"><i class="fas fa-phone"></i> +1 (123) 456-7890</a></li>
                        <li><a href="mailto:info@smartclass.com"><i class="fas fa-envelope"></i> info@smartclass.com</a></li>
                        <li><a href="#"><i class="fas fa-clock"></i> Mon-Fri: 9AM-6PM</a></li>
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
            
            // Close navbar on mobile when clicking a link
            const navbarCollapse = document.getElementById('navbarNav');
            const bsCollapse = new bootstrap.Collapse(navbarCollapse, {
                toggle: false
            });
            
            navLinks.forEach(link => {
                link.addEventListener('click', () => {
                    if (window.innerWidth < 992) {
                        bsCollapse.hide();
                    }
                });
            });
            
            // FAQ Accordion
            const faqItems = document.querySelectorAll('.faq-item');
            
            faqItems.forEach(item => {
                const question = item.querySelector('.faq-question');
                
                question.addEventListener('click', () => {
                    // Close other items
                    faqItems.forEach(otherItem => {
                        if (otherItem !== item && otherItem.classList.contains('active')) {
                            otherItem.classList.remove('active');
                        }
                    });
                    
                    // Toggle current item
                    item.classList.toggle('active');
                });
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
            
            // Intersection Observer for scroll animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });
            
            document.querySelectorAll('.contact-card, .faq-item, .form-container, .map-container').forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(20px)';
                el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                observer.observe(el);
            });
        });
    </script>
</body>
</html>