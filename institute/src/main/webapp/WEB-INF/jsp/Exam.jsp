<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>EduEra — Computer Technology Courses</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #002b5c;
            --secondary-blue: #00509e;
            --accent-yellow: #ffdd59;
            --light-blue: #e2eafc;
            --dark-blue: #001833;
            --white: #ffffff;
            --gray-light: #f3f7ff;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            --shadow-light: 0 2px 8px rgba(0, 0, 0, 0.1);
            --radius: 12px;
            --transition: all 0.3s ease;
            
            /* Additional gradients for course cards */
            --gradient-secondary: linear-gradient(135deg, #0ea5e9, #0369a1);
            --gradient-purple: linear-gradient(135deg, #7c3aed, #4c1d95);
            --gradient-red: linear-gradient(135deg, #ef4444, #b91c1c);
            --gradient-green: linear-gradient(135deg, #10b981, #065f46);
            --gradient-yellow: linear-gradient(135deg, #f59e0b, #b45309);
            --gradient-cyan: linear-gradient(135deg, #06b6d4, #075985);
            --gradient-orange: linear-gradient(135deg, #f97316, #9a3412);
            --gradient-indigo: linear-gradient(135deg, #a78bfa, #5b21b6);
            --gradient-teal: linear-gradient(135deg, #60a5fa, #064e3b);
            --gradient-pink: linear-gradient(135deg, #f43f5e, #9f1239);
            --gradient-emerald: linear-gradient(135deg, #34d399, #166534);
            --gradient-violet: linear-gradient(135deg, #8b5cf6, #6d28d9);
            --gradient-primary: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            --shadow-medium: 0 10px 40px rgba(0, 43, 92, 0.12);
            --shadow-heavy: 0 15px 50px rgba(0, 43, 92, 0.15);
            --border-radius: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--gray-light);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 10% 20%, rgba(0, 91, 234, 0.05) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(124, 58, 237, 0.05) 0%, transparent 20%);
            z-index: -1;
        }

        /* ================= NAVBAR (From Previous Program) ================= */
        .navbar-custom {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            padding: 0.8rem 2rem;
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            color: var(--white) !important;
            font-weight: 700;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: var(--transition);
        }

        .navbar-brand:hover {
            transform: translateY(-2px);
        }

        .logo-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-yellow);
            padding: 2px;
        }

        .nav-link {
            color: var(--light-blue) !important;
            font-size: 0.95rem;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            margin: 0 0.2rem;
            border-radius: 6px;
            transition: var(--transition);
            position: relative;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--accent-yellow);
            transition: var(--transition);
            transform: translateX(-50%);
        }

        .nav-link:hover {
            color: var(--white) !important;
            background: rgba(255, 255, 255, 0.1);
        }

        .nav-link:hover::after {
            width: 80%;
        }

        .nav-link.active {
            color: var(--primary-blue) !important;
            background: var(--accent-yellow);
            font-weight: 600;
                pointer-events: none;

        }
.nav-link.active:hover {
    background: #a6c8ff !important;
    color: #002b5c !important;
}
.nav-link:focus,
.nav-link:focus-visible {
    background: none !important;
    color: var(--light-blue) !important;
    outline: none !important;
}

.nav-link.active {
    pointer-events: none;
}

        .nav-link.active::after {
            display: none;
        }

        .navbar-toggler {
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 0.5rem;
        }

        .navbar-toggler:focus {
            box-shadow: 0 0 0 2px rgba(255, 255, 255, 0.25);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* ================= HERO SECTION ================= */
        .hero-section {
            padding: 60px 0 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 3.2rem;
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 15px;
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: #64748b;
            max-width: 700px;
            margin: 0 auto 40px;
        }

        .stats-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }

        .stat-item {
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            min-width: 160px;
            transition: var(--transition);
        }

        .stat-item:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-medium);
        }

        .stat-number {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 2.5rem;
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            line-height: 1;
        }

        .stat-label {
            color: #64748b;
            font-size: 0.95rem;
            margin-top: 8px;
        }

        /* ================= CATEGORIES ================= */
        .categories-section {
            padding: 20px 0 50px;
        }

        .category-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding: 0 20px;
        }

        .category-label {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--primary-blue);
            position: relative;
            display: inline-block;
        }

        .category-label::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            border-radius: 2px;
        }

        .course-count {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            padding: 6px 15px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            box-shadow: var(--shadow-light);
        }

        /* ================= COURSE CARDS ================= */
        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            padding: 0 20px;
            margin-bottom: 50px;
        }

        .course-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--shadow-light);
            transition: var(--transition);
            border: 1px solid #e2e8f0;
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
        }

        .course-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
        }

        .course-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-heavy);
        }

        .course-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: white;
            margin-bottom: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .course-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 1.4rem;
            color: var(--primary-blue);
            margin-bottom: 10px;
            line-height: 1.3;
        }

        .course-category {
            display: inline-block;
            padding: 6px 15px;
            background: #f1f5f9;
            color: #64748b;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 15px;
        }

        .course-description {
            color: #64748b;
            font-size: 0.95rem;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .course-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }

        .difficulty {
            font-size: 0.85rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .exam-btn {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 6px 20px rgba(0, 43, 92, 0.15);
        }

        .exam-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 43, 92, 0.25);
            color: white;
            text-decoration: none;
        }

        /* Card Colors */
        .card-1::before { background: var(--gradient-secondary); }
        .card-1 .course-icon { background: var(--gradient-secondary); }

        .card-2::before { background: var(--gradient-purple); }
        .card-2 .course-icon { background: var(--gradient-purple); }

        .card-3::before { background: var(--gradient-red); }
        .card-3 .course-icon { background: var(--gradient-red); }

        .card-4::before { background: var(--gradient-green); }
        .card-4 .course-icon { background: var(--gradient-green); }

        .card-5::before { background: var(--gradient-yellow); }
        .card-5 .course-icon { background: var(--gradient-yellow); }

        .card-6::before { background: var(--gradient-cyan); }
        .card-6 .course-icon { background: var(--gradient-cyan); }

        .card-7::before { background: var(--gradient-orange); }
        .card-7 .course-icon { background: var(--gradient-orange); }

        .card-8::before { background: var(--gradient-indigo); }
        .card-8 .course-icon { background: var(--gradient-indigo); }

        .card-9::before { background: var(--gradient-teal); }
        .card-9 .course-icon { background: var(--gradient-teal); }

        .card-10::before { background: var(--gradient-pink); }
        .card-10 .course-icon { background: var(--gradient-pink); }

        .card-11::before { background: var(--gradient-cyan); }
        .card-11 .course-icon { background: var(--gradient-cyan); }

        .card-12::before { background: var(--gradient-emerald); }
        .card-12 .course-icon { background: var(--gradient-emerald); }

        .card-13::before { background: var(--gradient-secondary); }
        .card-13 .course-icon { background: var(--gradient-secondary); }

        .card-14::before { background: var(--gradient-orange); }
        .card-14 .course-icon { background: var(--gradient-orange); }

        .card-15::before { background: var(--gradient-violet); }
        .card-15 .course-icon { background: var(--gradient-violet); }

        .card-16::before { background: var(--gradient-red); }
        .card-16 .course-icon { background: var(--gradient-red); }

        /* ================= FOOTER ================= */
        .footer {
            background: var(--dark-blue);
            color: var(--white);
            padding: 3rem 0 1.5rem;
            margin-top: 4rem;
        }

        .footer-container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-box {
            padding: 1rem;
        }

        .footer-box h2, .footer-box h3 {
            margin-bottom: 1.5rem;
            color: var(--accent-yellow);
            font-weight: 600;
        }

        .footer-box h2 {
            font-size: 2rem;
        }

        .footer-box h3 {
            font-size: 1.3rem;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-box h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--accent-yellow);
            border-radius: 2px;
        }

        .footer-box p {
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.8;
            margin-bottom: 1.5rem;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-links a:hover {
            color: var(--accent-yellow);
            transform: translateX(5px);
        }

        .footer-links a i {
            width: 20px;
            text-align: center;
        }

        .contact-info {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 15px;
            color: rgba(255, 255, 255, 0.8);
        }

        .contact-item i {
            color: var(--accent-yellow);
            font-size: 1.2rem;
            width: 30px;
        }

        .footer-bottom {
            text-align: center;
            padding: 1.5rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
        }

        /* ================= RESPONSIVE DESIGN ================= */
        @media (max-width: 1200px) {
            .hero-title {
                font-size: 2.8rem;
            }
            
            .courses-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .hero-title {
                font-size: 2.4rem;
            }
            
            .category-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .stat-item {
                min-width: 140px;
            }
            
            .footer-container {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .footer-links a:hover {
                transform: none;
            }
            
            .contact-item {
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .navbar-custom {
                padding: 0.8rem 1rem;
            }
            
            .hero-title {
                font-size: 2rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .stats-container {
                gap: 20px;
            }
            
            .stat-item {
                min-width: 120px;
                padding: 15px;
            }
            
            .stat-number {
                font-size: 2rem;
            }
            
            .courses-grid {
                grid-template-columns: repeat(auto-fill, minmax(100%, 1fr));
            }
            
            .course-card {
                padding: 20px;
            }
            
            .vm-container {
                grid-template-columns: 1fr;
            }
            
            .vm-title {
                font-size: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .hero-section {
                padding: 40px 0 30px;
            }
            
            .hero-title {
                font-size: 1.8rem;
            }
            
            .hero-subtitle {
                font-size: 1rem;
            }
            
            .stats-container {
                flex-direction: column;
                align-items: center;
            }
            
            .stat-item {
                width: 100%;
                max-width: 250px;
            }
            
            .category-label {
                font-size: 1.5rem;
            }
            
            .exam-btn {
                width: 100%;
                justify-content: center;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .stat-item {
                padding: 1rem;
            }
            
            .nav-link {
                padding: 0.5rem 0.8rem !important;
                font-size: 0.9rem;
            }
        }

        /* Animation */
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

        .fade-in {
            animation: fadeInUp 0.6s ease forwards;
        }

        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
        .delay-5 { animation-delay: 0.5s; }

        /* Scroll to top button */
        .scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: var(--shadow-medium);
            transition: var(--transition);
            opacity: 0;
            visibility: hidden;
            z-index: 1000;
        }

        .scroll-top.active {
            opacity: 1;
            visibility: visible;
        }

        .scroll-top:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-heavy);
        }
    </style>
</head>

<body>
	<!-- ================= NAVBAR (From Previous Program) ================= -->
	<nav class="navbar navbar-expand-lg navbar-custom">
	    <div class="container-fluid">
	        <img src="${pageContext.request.contextPath}/images/logo2.jpeg" class="logo-img" alt="EduEra Logo">
	        <a class="navbar-brand" href="${pageContext.request.contextPath}/">EduEra</a>

	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
	            <span class="navbar-toggler-icon"></span>
	        </button>

	        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
	            <ul class="navbar-nav">
	                <li class="nav-item">
	                    <a class="nav-link" href="${pageContext.request.contextPath}/student-dashboard">
	                        <i class="fas fa-home"></i> Home
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="${pageContext.request.contextPath}/student-course">
	                        <i class="fas fa-book"></i> Courses
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link active" href="${pageContext.request.contextPath}/exam">
	                        <i class="fas fa-file-alt"></i> Examination
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="${pageContext.request.contextPath}/certificateF1">
	                        <i class="fas fa-award"></i> Certificate
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">
	                        <i class="fas fa-envelope"></i> Contact Us
	                    </a>
	                </li>
	            </ul>
	        </div>
	    </div>
	</nav>

	<!-- ================= HERO SECTION ================= -->
	<section class="hero-section">
	    <div class="container">
	        <h1 class="hero-title fade-in">Master Computer Technology with EduEra</h1>
	        <p class="hero-subtitle fade-in delay-1">Comprehensive courses designed by industry experts. Click <strong>Give Exam</strong> to test your knowledge in any course.</p>
	        
	        <div class="stats-container">
	            <div class="stat-item fade-in delay-2">
	                <div class="stat-number">16</div>
	                <div class="stat-label">Courses</div>
	            </div>
	            <div class="stat-item fade-in delay-3">
	                <div class="stat-number">4</div>
	                <div class="stat-label">Categories</div>
	            </div>
	            <div class="stat-item fade-in delay-4">
	                <div class="stat-number">100%</div>
	                <div class="stat-label">Practical</div>
	            </div>
	            <div class="stat-item fade-in delay-5">
	                <div class="stat-number">24/7</div>
	                <div class="stat-label">Support</div>
	            </div>
	        </div>
	    </div>
	</section>

	<!-- ================= COURSES BY CATEGORY ================= -->
	<div class="container categories-section">
	    <!-- Programming Languages -->
	    <div class="category-header">
	        <h2 class="category-label">Programming Languages</h2>
	        <span class="course-count">5 Courses</span>
	    </div>
	    <div class="courses-grid">
	        <!-- C Programming -->
	        <div class="course-card card-1 fade-in delay-1">
	            <div class="course-icon">
	                <i class="fas fa-c"></i>
	            </div>
	            <h3 class="course-title">C Programming</h3>
	            <span class="course-category">Programming Languages</span>
	            <p class="course-description">Master the fundamentals of C programming, memory management, and system-level programming.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Beginner</span>
	                <a href="${pageContext.request.contextPath}/giveexamc" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- C++ Programming -->
	        <div class="course-card card-2 fade-in delay-2">
	            <div class="course-icon">
	                <i class="fas fa-plus"></i>
	            </div>
	            <h3 class="course-title">C++ Programming</h3>
	            <span class="course-category">Programming Languages</span>
	            <p class="course-description">Learn object-oriented programming, templates, STL, and modern C++ features.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/cpp-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Java Programming -->
	        <div class="course-card card-3 fade-in delay-3">
	            <div class="course-icon">
	                <i class="fab fa-java"></i>
	            </div>
	            <h3 class="course-title">Java Programming</h3>
	            <span class="course-category">Programming Languages</span>
	            <p class="course-description">Build robust applications with Java, Spring Framework, and enterprise development patterns.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/java-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Python Programming -->
	        <div class="course-card card-4 fade-in delay-4">
	            <div class="course-icon">
	                <i class="fab fa-python"></i>
	            </div>
	            <h3 class="course-title">Python Programming</h3>
	            <span class="course-category">Programming Languages</span>
	            <p class="course-description">Learn Python for web development, data science, automation, and machine learning.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Beginner</span>
	                <a href="${pageContext.request.contextPath}/python-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- JavaScript -->
	        <div class="course-card card-5 fade-in delay-5">
	            <div class="course-icon">
	                <i class="fab fa-js"></i>
	            </div>
	            <h3 class="course-title">JavaScript</h3>
	            <span class="course-category">Programming Languages</span>
	            <p class="course-description">Master frontend and backend JavaScript with React, Node.js, and modern frameworks.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/javascript-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>
	    </div>

	    <!-- Web, App & Software Development -->
	    <div class="category-header">
	        <h2 class="category-label">Web, App & Software Development</h2>
	        <span class="course-count">4 Courses</span>
	    </div>
	    <div class="courses-grid">
	        <!-- Full Stack -->
	        <div class="course-card card-6 fade-in delay-1">
	            <div class="course-icon">
	                <i class="fas fa-code"></i>
	            </div>
	            <h3 class="course-title">Full-Stack Development</h3>
	            <span class="course-category">Web Development</span>
	            <p class="course-description">Become a full-stack developer with HTML, CSS, JavaScript, and backend technologies.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Advanced</span>
	                <a href="${pageContext.request.contextPath}/fullstack-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Android -->
	        <div class="course-card card-7 fade-in delay-2">
	            <div class="course-icon">
	                <i class="fab fa-android"></i>
	            </div>
	            <h3 class="course-title">Android Development</h3>
	            <span class="course-category">App Development</span>
	            <p class="course-description">Build native Android apps using Java/Kotlin and modern Android architecture patterns.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/android-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Software Engineering -->
	        <div class="course-card card-8 fade-in delay-3">
	            <div class="course-icon">
	                <i class="fas fa-cogs"></i>
	            </div>
	            <h3 class="course-title">Software Engineering</h3>
	            <span class="course-category">Software Development</span>
	            <p class="course-description">Master SDLC, Agile methodologies, design patterns, and software architecture.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Advanced</span>
	                <a href="${pageContext.request.contextPath}/software-engineering-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Git & GitHub -->
	        <div class="course-card card-9 fade-in delay-4">
	            <div class="course-icon">
	                <i class="fab fa-git-alt"></i>
	            </div>
	            <h3 class="course-title">Git & GitHub</h3>
	            <span class="course-category">Version Control</span>
	            <p class="course-description">Learn professional version control, collaboration, and CI/CD with Git and GitHub.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Beginner</span>
	                <a href="${pageContext.request.contextPath}/git-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>
	    </div>

	    <!-- Core Computer Science -->
	    <div class="category-header">
	        <h2 class="category-label">Core Computer Science</h2>
	        <span class="course-count">4 Courses</span>
	    </div>
	    <div class="courses-grid">
	        <!-- DSA -->
	        <div class="course-card card-10 fade-in delay-1">
	            <div class="course-icon">
	                <i class="fas fa-project-diagram"></i>
	            </div>
	            <h3 class="course-title">Data Structures & Algorithms</h3>
	            <span class="course-category">Core CS</span>
	            <p class="course-description">Master essential data structures, algorithms, and problem-solving techniques.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Advanced</span>
	                <a href="${pageContext.request.contextPath}/dsa-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- OS -->
	        <div class="course-card card-11 fade-in delay-2">
	            <div class="course-icon">
	                <i class="fas fa-desktop"></i>
	            </div>
	            <h3 class="course-title">Operating Systems</h3>
	            <span class="course-category">Core CS</span>
	            <p class="course-description">Understand OS concepts, processes, memory management, and file systems.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/os-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- DBMS -->
	        <div class="course-card card-12 fade-in delay-3">
	            <div class="course-icon">
	                <i class="fas fa-database"></i>
	            </div>
	            <h3 class="course-title">Database Management System</h3>
	            <span class="course-category">Core CS</span>
	            <p class="course-description">Learn SQL, database design, normalization, and transaction management.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/dbms-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Computer Networks -->
	        <div class="course-card card-13 fade-in delay-4">
	            <div class="course-icon">
	                <i class="fas fa-network-wired"></i>
	            </div>
	            <h3 class="course-title">Computer Networks</h3>
	            <span class="course-category">Core CS</span>
	            <p class="course-description">Understand networking protocols, TCP/IP, routing, and network security.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/networks-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>
	    </div>

	    <!-- Modern & Emerging Technologies -->
	    <div class="category-header">
	        <h2 class="category-label">Modern & Emerging Technologies</h2>
	        <span class="course-count">3 Courses</span>
	    </div>
	    <div class="courses-grid">
	        <!-- AI & ML -->
	        <div class="course-card card-14 fade-in delay-1">
	            <div class="course-icon">
	                <i class="fas fa-robot"></i>
	            </div>
	            <h3 class="course-title">Artificial Intelligence</h3>
	            <span class="course-category">Emerging Tech</span>
	            <p class="course-description">Explore AI, machine learning, neural networks, and practical AI applications.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Advanced</span>
	                <a href="${pageContext.request.contextPath}/ai-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Cloud Computing -->
	        <div class="course-card card-15 fade-in delay-2">
	            <div class="course-icon">
	                <i class="fas fa-cloud"></i>
	            </div>
	            <h3 class="course-title">Cloud Computing</h3>
	            <span class="course-category">Emerging Tech</span>
	            <p class="course-description">Master cloud platforms, services, deployment, and cloud architecture.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Intermediate</span>
	                <a href="${pageContext.request.contextPath}/cloud-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>

	        <!-- Cyber Security -->
	        <div class="course-card card-16 fade-in delay-3">
	            <div class="course-icon">
	                <i class="fas fa-shield-alt"></i>
	            </div>
	            <h3 class="course-title">Cyber Security</h3>
	            <span class="course-category">Emerging Tech</span>
	            <p class="course-description">Learn ethical hacking, security protocols, and cyber defense strategies.</p>
	            <div class="course-meta">
	                <span class="difficulty"><i class="fas fa-signal"></i> Advanced</span>
	                <a href="${pageContext.request.contextPath}/cybersecurity-quiz" class="exam-btn"><i class="fas fa-play-circle"></i> Give Exam</a>
	            </div>
	        </div>
	    </div>
	</div>

	<!-- ================= FOOTER (From Previous Program) ================= -->
	<footer class="footer">
	    <div class="footer-container">
	        <div class="footer-box">
	            <h2>EduEra</h2>
	            <p>Your one-stop platform for learning programming and technology through structured courses and quality content designed for modern learners.</p>
	        </div>

	        <div class="footer-box">
	            <h3>Quick Links</h3>
	            <div class="footer-links">
	                <a href="${pageContext.request.contextPath}/student-dashboard"><i class="fas fa-home"></i> Home</a>
	                <a href="${pageContext.request.contextPath}/student-course"><i class="fas fa-book"></i> Courses</a>
	                <a href="${pageContext.request.contextPath}/exam"><i class="fas fa-file-alt"></i> Examination</a>
	                <a href="${pageContext.request.contextPath}/certificateF1"><i class="fas fa-award"></i> Certificate</a>
	                <a href="${pageContext.request.contextPath}/contact"><i class="fas fa-envelope"></i> Contact Us</a>
	            </div>
	        </div>

	        <div class="footer-box">
	            <h3>Contact Info</h3>
	            <div class="contact-info">
	                <div class="contact-item">
	                    <i class="fas fa-envelope"></i>
	                    <span>support@eduera.com</span>
	                </div>
	                <div class="contact-item">
	                    <i class="fas fa-phone"></i>
	                    <span>+91 98765 43210</span>
	                </div>
	                <div class="contact-item">
	                    <i class="fas fa-map-marker-alt"></i>
	                    <span>Mumbai, India</span>
	                </div>
	            </div>
	        </div>
	    </div>

	    <div class="footer-bottom">
	        © 2025 EduEra — All Rights Reserved | Designed with <i class="fas fa-heart" style="color: #ff6b6b;"></i> for Education
	    </div>
	</footer>

	<!-- Scroll to Top Button -->
	<div class="scroll-top" id="scrollTop">
	    <i class="fas fa-arrow-up"></i>
	</div>
    <script>
        // Add active state to current page in navbar
        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = window.location.pathname.split('/').pop();
            const navLinks = document.querySelectorAll('.nav-link');
            
            navLinks.forEach(link => {
                const linkHref = link.getAttribute('href');
                // For this Courses page, we want to highlight the Courses link
                // NEW CODE (Correct - checks current page)
if (linkHref === currentPage) {
    link.classList.add('active');
} else {
                    link.classList.remove('active');
                }
            });
        });

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar-custom');
            if (window.scrollY > 50) {
                navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.2)';
            } else {
                navbar.style.boxShadow = 'var(--shadow)';
            }
            
            // Scroll to top button
            const scrollTopBtn = document.getElementById('scrollTop');
            if (window.scrollY > 300) {
                scrollTopBtn.classList.add('active');
            } else {
                scrollTopBtn.classList.remove('active');
            }
        });

        // Scroll to top functionality
        document.getElementById('scrollTop').addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Add animation to cards on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -100px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                }
            });
        }, observerOptions);

        // Observe all course cards
        document.querySelectorAll('.course-card').forEach(card => {
            observer.observe(card);
        });
    </script>
</body>
</html>