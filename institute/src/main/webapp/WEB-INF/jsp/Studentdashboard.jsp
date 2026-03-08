<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduEra - Student Dashboard</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

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
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
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
        }

        /* ================= NAVBAR ================= */
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

        /* ================= STUDENT DASHBOARD SPECIFIC STYLES ================= */
        .dashboard-container {
            width: 90%;
            max-width: 1400px;
            margin: 2rem auto;
        }

        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            border-radius: var(--radius);
            padding: 2.5rem;
            margin-bottom: 2rem;
            color: var(--white);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 2rem;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 30px 30px;
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .welcome-content {
            position: relative;
            z-index: 1;
            flex: 1;
        }

        .welcome-content h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .welcome-content p {
            font-size: 1.1rem;
            opacity: 0.95;
        }

        .student-info {
            display: flex;
            align-items: center;
            gap: 2rem;
            background: rgba(255, 255, 255, 0.1);
            padding: 1.2rem 2rem;
            border-radius: 50px;
            backdrop-filter: blur(10px);
            position: relative;
            z-index: 1;
        }

        .student-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--accent-yellow);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: var(--primary-blue);
            font-weight: 700;
        }

        .student-details h3 {
            font-size: 1.3rem;
            margin-bottom: 0.2rem;
        }

        .student-details p {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* NEW: Test Scores Button in Welcome Banner */
        .welcome-actions {
            display: flex;
            gap: 1rem;
            position: relative;
            z-index: 1;
        }

        .btn-test-scores {
            background: var(--accent-yellow);
            color: var(--primary-blue);
            border: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-test-scores:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            background: white;
        }

        .btn-test-scores i {
            font-size: 1.2rem;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-light);
            display: flex;
            align-items: center;
            gap: 1.5rem;
            transition: var(--transition);
            border-left: 5px solid var(--secondary-blue);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .stat-icon {
            width: 70px;
            height: 70px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--white);
        }

        .stat-icon.courses { background: linear-gradient(135deg, #28a745, #20c997); }
        .stat-icon.documents { background: linear-gradient(135deg, #17a2b8, #0dcaf0); }
        .stat-icon.videos { background: linear-gradient(135deg, #fd7e14, #ffc107); }
        .stat-icon.tests { background: linear-gradient(135deg, #6f42c1, #9d4edd); }

        .stat-info h3 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.2rem;
            color: var(--dark-blue);
        }

        .stat-info p {
            color: #666;
            font-size: 0.9rem;
            margin: 0;
        }

        /* Quick Actions */
        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-blue);
            margin: 2rem 0 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--accent-yellow);
            border-radius: 2px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .action-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            transition: var(--transition);
            text-decoration: none;
            color: inherit;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary-blue), var(--secondary-blue));
        }

        .action-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow);
            border-color: var(--secondary-blue);
        }

        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 12px;
            background: var(--light-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--secondary-blue);
            margin-bottom: 1.5rem;
            transition: var(--transition);
        }

        .action-card:hover .action-icon {
            background: var(--secondary-blue);
            color: var(--white);
        }

        .action-card h3 {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .action-card p {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }

        .action-arrow {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--secondary-blue);
            font-weight: 500;
            transition: var(--transition);
        }

        .action-card:hover .action-arrow {
            gap: 1rem;
            color: var(--primary-blue);
        }

        /* Recent Activity */
        .activity-section {
            background: var(--white);
            border-radius: var(--radius);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-light);
        }

        .activity-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .activity-header h3 {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-blue);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .view-all-link {
            color: var(--secondary-blue);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: var(--transition);
        }

        .view-all-link:hover {
            gap: 10px;
            color: var(--primary-blue);
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            padding: 1rem;
            background: var(--gray-light);
            border-radius: 8px;
            transition: var(--transition);
        }

        .activity-item:hover {
            background: var(--light-blue);
        }

        .activity-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            background: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: var(--secondary-blue);
        }

        .activity-details {
            flex: 1;
        }

        .activity-details h4 {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.2rem;
        }

        .activity-details p {
            font-size: 0.85rem;
            color: #666;
        }

        .activity-time {
            font-size: 0.85rem;
            color: #888;
        }

        /* Course Progress */
        .progress-section {
            background: var(--white);
            border-radius: var(--radius);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-light);
        }

        .course-progress-item {
            margin-bottom: 1.5rem;
        }

        .course-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .course-name {
            font-weight: 600;
            color: var(--dark-blue);
        }

        .course-percentage {
            color: var(--secondary-blue);
            font-weight: 600;
        }

        .progress-bar-container {
            width: 100%;
            height: 10px;
            background: var(--gray-light);
            border-radius: 5px;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(to right, var(--secondary-blue), var(--primary-blue));
            border-radius: 5px;
            transition: width 0.5s ease;
        }

        /* Certificate Card */
        .certificate-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: var(--radius);
            padding: 2rem;
            color: white;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .certificate-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 30px 30px;
            animation: float 20s linear infinite;
        }

        .certificate-content {
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .certificate-text h3 {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .certificate-text p {
            opacity: 0.9;
        }

        .certificate-btn {
            background: white;
            color: var(--primary-blue);
            padding: 1rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
        }

        .certificate-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            background: var(--accent-yellow);
            color: var(--primary-blue);
        }

        /* ================= HERO SLIDER ================= */
        .hero-slider {
            width: 100%;
            max-width: 1200px;
            height: 220px;
            margin: 2rem auto;
            position: relative;
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .slide {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 0.8s ease-in-out;
            padding: 2.5rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: var(--white);
            border-radius: var(--radius);
        }

        .slide.active {
            opacity: 1;
        }

        .slide h2 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .slide p {
            font-size: 1.1rem;
            max-width: 600px;
            line-height: 1.6;
            opacity: 0.95;
        }

        .slide:nth-child(1) {
            background: linear-gradient(135deg, #ffd700, #ffed4e);
            color: #002b5c;
        }

        .slide:nth-child(2) {
            background: linear-gradient(135deg, #28ae0d, #4ade80);
            color: var(--white);
        }

        .slide:nth-child(3) {
            background: linear-gradient(135deg, #0bc1b8, #5eead4);
            color: #002b5c;
        }

        .slide:nth-child(4) {
            background: linear-gradient(135deg, #1e0033, #7c3aed);
            color: var(--white);
        }

        .slider-controls {
            position: absolute;
            bottom: 20px;
            right: 20px;
            display: flex;
            gap: 10px;
        }

        .slider-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            backdrop-filter: blur(10px);
        }

        .slider-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.1);
        }

        .slider-dots {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
        }

        .dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            cursor: pointer;
            transition: var(--transition);
        }

        .dot.active {
            background: var(--white);
            transform: scale(1.2);
        }

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
        @media (max-width: 992px) {
            .welcome-banner {
                flex-direction: column;
                text-align: center;
                padding: 2rem;
            }
            
            .student-info {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }
            
            .welcome-actions {
                width: 100%;
                justify-content: center;
            }
            
            .slide h2 {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 768px) {
            .navbar-custom {
                padding: 0.8rem 1rem;
            }
            
            .dashboard-container {
                width: 95%;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .quick-actions {
                grid-template-columns: 1fr;
            }
            
            .hero-slider {
                height: 200px;
            }
            
            .slide {
                padding: 1.5rem;
            }
            
            .slide h2 {
                font-size: 1.6rem;
            }
            
            .slide p {
                font-size: 1rem;
            }
            
            .certificate-content {
                flex-direction: column;
                text-align: center;
            }
            
            .certificate-btn {
                width: 100%;
                justify-content: center;
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

        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .student-info {
                padding: 1rem;
                width: 100%;
            }
            
            .btn-test-scores {
                width: 100%;
                justify-content: center;
                padding: 0.8rem 1.5rem;
            }
            
            .activity-item {
                flex-direction: column;
                text-align: center;
                gap: 0.5rem;
            }
            
            .slider-controls {
                bottom: 10px;
                right: 10px;
            }
            
            .slider-btn {
                width: 35px;
                height: 35px;
            }
        }

        @media (max-width: 400px) {
            .nav-link {
                padding: 0.5rem 0.8rem !important;
                font-size: 0.9rem;
            }
            
            .hero-slider {
                height: 180px;
            }
            
            .slide h2 {
                font-size: 1.4rem;
            }
            
            .slide p {
                font-size: 0.9rem;
            }
            
            .welcome-content h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>

<body>
	<!-- ================= NAVIGATION BAR ================= -->
	<nav class="navbar navbar-expand-lg navbar-custom">
	    <div class="container-fluid">
	        <img src="${pageContext.request.contextPath}/images/logo2.jpeg" class="logo-img" alt="EduEra Logo">
	        <a class="navbar-brand" href="${pageContext.request.contextPath}/">SmartClass</a>

	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
	            <span class="navbar-toggler-icon"></span>
	        </button>

	        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
	            <ul class="navbar-nav">
	                <li class="nav-item">
	                    <a class="nav-link active" href="${pageContext.request.contextPath}/student-dashboard">
	                        <i class="fas fa-home"></i> Home
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="${pageContext.request.contextPath}/student-course">
	                        <i class="fas fa-book"></i> My Courses
	                    </a>
	                </li>
	                <!-- ADDED: Test Scores in Navigation -->
	                <li class="nav-item">
	                    <a class="nav-link" href="${pageContext.request.contextPath}/studenttestscore">
	                        <i class="fas fa-chart-line"></i> My Results
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
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/student-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>

	            </ul>
	        </div>
	    </div>
	</nav>

	<!-- ================= DASHBOARD CONTAINER ================= -->
	<div class="dashboard-container">
	    
	    <!-- ================= WELCOME BANNER ================= -->
	    <div class="welcome-banner">
	        <div class="welcome-content">
	            <h1>Welcome back !</h1>
	            <p>Continue your learning journey and track your progress</p>
	        </div>
	        
	        
	        
	        <!-- ADDED: Test Scores Button in Welcome Banner -->
	        <div class="welcome-actions">
	            <a href="${pageContext.request.contextPath}/studenttestscore" class="btn-test-scores">
	                <i class="fas fa-chart-line"></i>
	                View My Results
	                <i class="fas fa-arrow-right"></i>
	            </a>
	        </div>
	    </div>

	   
	    <!-- ================= QUICK ACTIONS ================= -->
	    <h2 class="section-title">Quick Actions</h2>
	    <div class="quick-actions">
	        <a href="${pageContext.request.contextPath}/student-course" class="action-card">
	            <div class="action-icon">
	                <i class="fas fa-book"></i>
	            </div>
	            <h3>Browse Courses</h3>
	            <p>Access your enrolled courses and study materials</p>
	            <div class="action-arrow">
	                Go to Courses <i class="fas fa-arrow-right"></i>
	            </div>
	        </a>

	        <!-- ADDED: Test Scores Quick Action Card -->
	        <a href="${pageContext.request.contextPath}/studenttestscore" class="action-card">
	            <div class="action-icon">
	                <i class="fas fa-chart-line"></i>
	            </div>
	            <h3>My Test Scores</h3>
	            <p>View your test results, performance analytics, and certificates</p>
	            <div class="action-arrow">
	                View Results <i class="fas fa-arrow-right"></i>
	            </div>
	        </a>

	        

	        <a href="${pageContext.request.contextPath}/certificateF1" class="action-card">
	            <div class="action-icon">
	                <i class="fas fa-award"></i>
	            </div>
	            <h3>Get Certificate</h3>
	            <p>Download your course completion certificates</p>
	            <div class="action-arrow">
	                View Certificates <i class="fas fa-arrow-right"></i>
	            </div>
	        </a>
	    </div>

	
    <!-- ================= JAVASCRIPT ================= -->
    <script>
        // Student data (in real app, this would come from session)
        const studentData = {
            name: "John Doe",
            id: "STU12345",
            enrolledCourses: 5,
            completedMaterials: 12,
            watchedVideos: 8,
            testsPassed: 4
        };

        // Update student info
        document.getElementById('studentName').textContent = studentData.name;
        document.getElementById('studentId').textContent = `Student ID: ${studentData.id}`;
        document.getElementById('enrolledCourses').textContent = studentData.enrolledCourses;
        document.getElementById('completedMaterials').textContent = studentData.completedMaterials;
        document.getElementById('watchedVideos').textContent = studentData.watchedVideos;
        document.getElementById('testsPassed').textContent = studentData.testsPassed;

        // Populate recent activity
        const activities = [
            { icon: 'fa-check-circle', title: 'Completed Test: Java Basics', time: '2 hours ago', score: '85%', passed: true },
            { icon: 'fa-play-circle', title: 'Watched: OOP Concepts', time: 'Yesterday', duration: '45 mins' },
            { icon: 'fa-download', title: 'Downloaded: Python Notes', time: '2 days ago', pages: 25 },
            { icon: 'fa-star', title: 'Passed: Data Structures Test', time: '3 days ago', score: '92%', passed: true },
            { icon: 'fa-video', title: 'Watched: Database Design', time: '5 days ago', duration: '30 mins' }
        ];

        const activityList = document.getElementById('recentActivity');
        activities.forEach(activity => {
            const item = document.createElement('div');
            item.className = 'activity-item';
            
            let details = '';
            if (activity.score) {
                details = `<span class="badge bg-${activity.passed ? 'success' : 'danger'} ms-2">Score: ${activity.score}</span>`;
            } else if (activity.duration) {
                details = `<span class="badge bg-info ms-2">${activity.duration}</span>`;
            } else if (activity.pages) {
                details = `<span class="badge bg-secondary ms-2">${activity.pages} pages</span>`;
            }
            
            item.innerHTML = 
                '<div class="activity-icon">' +
                    `<i class="fas ${activity.icon}"></i>` +
                '</div>' +
                '<div class="activity-details">' +
                    `<h4>${activity.title} ${details}</h4>` +
                    `<p>${activity.time}</p>` +
                '</div>';
            
            activityList.appendChild(item);
        });

        // Populate course progress
        const courses = [
            { name: 'Java Programming', progress: 75 },
            { name: 'Python Basics', progress: 60 },
            { name: 'Data Structures', progress: 45 },
            { name: 'Web Development', progress: 30 }
        ];

        const progressList = document.getElementById('courseProgress');
        courses.forEach(course => {
            const item = document.createElement('div');
            item.className = 'course-progress-item';
            item.innerHTML = 
                '<div class="course-info">' +
                    `<span class="course-name">${course.name}</span>` +
                    `<span class="course-percentage">${course.progress}%</span>` +
                '</div>' +
                '<div class="progress-bar-container">' +
                    `<div class="progress-bar-fill" style="width: ${course.progress}%;"></div>` +
                '</div>';
            
            progressList.appendChild(item);
        });

        // Slider functionality
        let slides = document.querySelectorAll(".slide");
        let dots = document.querySelectorAll(".dot");
        let currentSlide = 0;
        let slideInterval;

        function showSlide(n) {
            // Hide all slides
            slides.forEach(slide => slide.classList.remove("active"));
            dots.forEach(dot => dot.classList.remove("active"));
            
            // Show selected slide
            currentSlide = (n + slides.length) % slides.length;
            slides[currentSlide].classList.add("active");
            dots[currentSlide].classList.add("active");
        }

        function nextSlide() {
            showSlide(currentSlide + 1);
        }

        function prevSlide() {
            showSlide(currentSlide - 1);
        }

        function goToSlide(n) {
            showSlide(n);
        }

        function startAutoSlide() {
            slideInterval = setInterval(nextSlide, 4000);
        }

        function stopAutoSlide() {
            clearInterval(slideInterval);
        }

        // Initialize slider
        function initSlider() {
            showSlide(0);
            startAutoSlide();
            
            // Pause auto-slide on hover
            const slider = document.querySelector('.hero-slider');
            if (slider) {
                slider.addEventListener('mouseenter', stopAutoSlide);
                slider.addEventListener('mouseleave', startAutoSlide);
            }
            
            // Add keyboard navigation
            document.addEventListener('keydown', (e) => {
                if (e.key === 'ArrowLeft') prevSlide();
                if (e.key === 'ArrowRight') nextSlide();
            });
        }

        // Initialize everything when page loads
        document.addEventListener('DOMContentLoaded', function() {
            initSlider();
            
            // Navbar scroll effect
            window.addEventListener('scroll', function() {
                const navbar = document.querySelector('.navbar-custom');
                if (window.scrollY > 50) {
                    navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.2)';
                } else {
                    navbar.style.boxShadow = 'var(--shadow)';
                }
            });
            
            // Set active nav item based on current URL
            const currentPath = window.location.pathname;
            const navItems = document.querySelectorAll('.nav-link');
            
            navItems.forEach(item => {
                const href = item.getAttribute('href');
                if (href && currentPath.includes(href.replace('${pageContext.request.contextPath}', ''))) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            });
            
            // Special case for dashboard
            if (currentPath.endsWith('/student-dashboard')) {
                document.querySelector('.nav-link[href*="student-dashboard"]').classList.add('active');
            }
        });
    </script>
</body>
</html>