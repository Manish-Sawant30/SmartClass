<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Parent Portal | SmartClass</title>
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
            --extra-light-purple: #f0eaf5;
            --accent-gold: #e6b800;
            --white: #ffffff;
            --off-white: #faf7ff;
            --text-dark: #2d1b3c;
            --text-light: #5a3d6e;
            --text-muted: #7a5a8c;
            --shadow: 0 8px 20px rgba(90, 61, 110, 0.12);
            --shadow-lg: 0 10px 25px rgba(90, 61, 110, 0.15);
            --radius: 16px;
            --radius-sm: 10px;
            --transition: all 0.3s ease;
            
            /* Status colors */
            --notice: #ff7e5f;
            --suggestion: #6f42c1;
            --success: #4caf50;
            --warning: #ff9800;
            --info: #2196f3;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background: linear-gradient(135deg, var(--extra-light-purple) 0%, var(--light-purple) 100%);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* Top Navigation */
        .top-nav {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            color: var(--white);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-lg);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 4px solid var(--accent-gold);
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
            transition: var(--transition);
            border: 2px solid var(--accent-gold);
        }

        .logo:hover {
            transform: rotate(15deg) scale(1.1);
        }

        .logo-text h1 {
            font-size: 26px;
            font-weight: 700;
            background: linear-gradient(to right, #ffffff, var(--extra-light-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .logo-text p {
            font-size: 13px;
            opacity: 0.9;
            letter-spacing: 0.5px;
            color: var(--extra-light-purple);
        }

        .nav-links {
            display: flex;
            gap: 8px;
        }

        .nav-item {
            color: var(--white);
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: var(--transition);
            font-weight: 500;
            position: relative;
            overflow: hidden;
            border: 2px solid transparent;
        }

        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .nav-item:hover::before {
            left: 100%;
        }

        .nav-item:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--accent-gold);
            transform: translateY(-2px);
        }

        .nav-item.active {
            background: var(--accent-gold);
            color: var(--dark-purple);
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(230, 184, 0, 0.3);
        }

        .nav-item.notice-btn {
            background: rgba(255, 126, 95, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .nav-item.notice-btn:hover {
            background: var(--notice);
        }

        .nav-item.suggestion-btn {
            background: rgba(111, 66, 193, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .nav-item.suggestion-btn:hover {
            background: var(--suggestion);
        }

        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            color: var(--white);
            font-size: 24px;
            cursor: pointer;
            padding: 10px;
            border-radius: 8px;
            transition: var(--transition);
        }

        .mobile-menu-btn:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Main Content */
        .main-content {
            padding: 40px;
            max-width: 1400px;
            margin: 0 auto;
            min-height: calc(100vh - 160px);
        }

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            border-radius: var(--radius);
            padding: 40px;
            margin-bottom: 40px;
            box-shadow: var(--shadow-lg);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 30px;
            position: relative;
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(230, 184, 0, 0.1) 1px, transparent 1px);
            background-size: 30px 30px;
            transform: rotate(15deg);
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% { transform: rotate(15deg) translateY(0); }
            100% { transform: rotate(15deg) translateY(-30px); }
        }

        .welcome-text {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .welcome-text h2 {
            font-size: 36px;
            margin-bottom: 15px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .welcome-text p {
            opacity: 0.9;
            font-size: 18px;
            line-height: 1.6;
            color: var(--extra-light-purple);
        }

        .welcome-actions {
            display: flex;
            gap: 15px;
            position: relative;
            z-index: 1;
        }

        .btn-test-scores {
            background: var(--accent-gold);
            color: var(--dark-purple);
            border: none;
            padding: 16px 32px;
            border-radius: 50px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            border: 2px solid transparent;
        }

        .btn-test-scores:hover {
            background: transparent;
            border-color: var(--accent-gold);
            color: var(--accent-gold);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(230, 184, 0, 0.3);
        }

        .btn-test-scores i {
            font-size: 22px;
            color: var(--dark-purple);
        }

        .btn-test-scores:hover i {
            color: var(--accent-gold);
        }

        /* Action Cards */
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .action-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 35px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: 2px solid var(--light-purple);
            text-decoration: none;
            color: inherit;
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--royal-purple), var(--accent-gold));
        }

        .action-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-lg);
            border-color: var(--soft-purple);
        }

        .action-card.notice {
            background: linear-gradient(145deg, #fff9f5, var(--white));
        }

        .action-card.suggestion {
            background: linear-gradient(145deg, #f8f5ff, var(--white));
        }

        .action-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            color: var(--white);
            flex-shrink: 0;
            transition: var(--transition);
        }

        .action-card:hover .action-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .action-card.notice .action-icon {
            background: linear-gradient(135deg, var(--notice), #ff9f4b);
        }

        .action-card.suggestion .action-icon {
            background: linear-gradient(135deg, var(--suggestion), #b380ff);
        }

        .action-content h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .action-card.notice .action-content h3 {
            color: var(--notice);
        }

        .action-card.suggestion .action-content h3 {
            color: var(--suggestion);
        }

        .action-content p {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .action-badge {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background: rgba(90, 61, 110, 0.1);
            color: var(--royal-purple);
        }

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        /* Feature Card */
        .feature-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 35px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: 2px solid var(--light-purple);
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--royal-purple), var(--accent-gold));
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-lg);
            border-color: var(--soft-purple);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin-bottom: 25px;
            color: var(--white);
            transition: var(--transition);
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .feature-card.attendance .feature-icon {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
        }

        .feature-card.tests .feature-icon {
            background: linear-gradient(135deg, var(--soft-purple), var(--light-purple));
        }

        .feature-content h3 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--text-dark);
        }

        .feature-content p {
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .feature-cta {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: var(--royal-purple);
            font-weight: 500;
            text-decoration: none;
            transition: gap 0.3s ease;
        }

        .feature-card:hover .feature-cta {
            gap: 15px;
        }

        /* Daily Inspiration */
        .inspiration-section {
            background: linear-gradient(135deg, #ffd9b0, #ffb8b8);
            border-radius: var(--radius);
            padding: 40px;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        .inspiration-section::before {
            content: '"';
            position: absolute;
            top: 20px;
            left: 40px;
            font-size: 120px;
            font-family: 'Outfit', sans-serif;
            color: rgba(255, 255, 255, 0.3);
            font-weight: 700;
        }

        .inspiration-quote {
            font-size: 22px;
            font-style: italic;
            line-height: 1.8;
            color: var(--dark-purple);
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .inspiration-author {
            font-size: 16px;
            font-weight: 500;
            color: var(--royal-purple);
        }

        /* Stats Overview */
        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 25px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border: 2px solid var(--light-purple);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            border-color: var(--soft-purple);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--white);
            transition: var(--transition);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-card:nth-child(1) .stat-icon { background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple)); }
        .stat-card:nth-child(2) .stat-icon { background: linear-gradient(135deg, var(--soft-purple), var(--light-purple)); }
        .stat-card:nth-child(3) .stat-icon { background: linear-gradient(135deg, var(--success), #45a049); }
        .stat-card:nth-child(4) .stat-icon { background: linear-gradient(135deg, var(--warning), #f57c00); }

        .stat-info h3 {
            font-size: 32px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 14px;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            border-top: 4px solid var(--accent-gold);
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path fill="rgba(255,255,255,0.05)" d="M0,0 L100,0 L100,100 Z"/></svg>');
            background-size: cover;
        }

        .footer-content {
            position: relative;
            z-index: 1;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 20px 0;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: var(--transition);
            padding: 5px 10px;
            border-radius: 20px;
        }

        .footer-links a:hover {
            color: var(--accent-gold);
            background: rgba(255, 255, 255, 0.1);
        }

        .footer-text {
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
            margin-top: 20px;
            line-height: 1.6;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .dashboard-grid, .action-cards {
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            }
            
            .welcome-section {
                padding: 30px;
            }
        }

        @media (max-width: 768px) {
            .top-nav {
                padding: 15px 20px;
                flex-wrap: wrap;
            }
            
            .mobile-menu-btn {
                display: block;
            }
            
            .nav-links {
                display: none;
                width: 100%;
                flex-direction: column;
                margin-top: 15px;
                gap: 10px;
            }
            
            .nav-links.show {
                display: flex;
            }
            
            .nav-item {
                width: 100%;
                justify-content: center;
            }
            
            .main-content {
                padding: 20px;
            }
            
            .welcome-section {
                text-align: center;
                padding: 30px 20px;
                flex-direction: column;
            }
            
            .welcome-actions {
                width: 100%;
                justify-content: center;
            }
            
            .btn-test-scores {
                width: 100%;
                justify-content: center;
            }
            
            .feature-card, .action-card {
                padding: 25px;
            }
            
            .action-card {
                flex-direction: column;
                text-align: center;
            }
            
            .stats-overview {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .logo {
                width: 50px;
                height: 50px;
                font-size: 24px;
            }
            
            .logo-text h1 {
                font-size: 22px;
            }
            
            .logo-text p {
                font-size: 12px;
            }
            
            .welcome-text h2 {
                font-size: 28px;
            }
            
            .welcome-text p {
                font-size: 16px;
            }
            
            .dashboard-grid, .action-cards {
                grid-template-columns: 1fr;
            }
            
            .feature-card, .action-card {
                padding: 20px;
            }
            
            .btn-test-scores {
                padding: 14px 24px;
                font-size: 16px;
            }
            
            .inspiration-quote {
                font-size: 18px;
            }
            
            .stat-info h3 {
                font-size: 28px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn-test-scores:active,
            .feature-card:active,
            .action-card:active,
            .stat-card:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>
   
    <!-- Top Navigation -->
    <nav class="top-nav">
        <div class="logo-section">
            <div class="logo">
                <i class="fas fa-hands-helping"></i>
            </div>
            <div class="logo-text">
                <h1>Parent Connect</h1>
                <p>Your Gateway to Academic Success</p>
            </div>
        </div>
        
        <button class="mobile-menu-btn" id="mobileMenuBtn">
            <i class="fas fa-bars"></i>
        </button>
        
        <div class="nav-links" id="navLinks">
            <a href="${pageContext.request.contextPath}/parent/dashboard" class="nav-item active" data-page="dashboard">
                <i class="fas fa-home"></i>
                Home
            </a>
            
            <a href="${pageContext.request.contextPath}/parenttestscore" class="nav-item" data-page="tests">
                <i class="fas fa-chart-line"></i>
                Test Scores
            </a>
            <a href="${pageContext.request.contextPath}/parent/notices" class="nav-item notice-btn" data-page="notices">
                <i class="fas fa-bullhorn"></i>
                Notices
            </a>
            <a href="${pageContext.request.contextPath}/suggestions/parent/list" class="nav-item suggestion-btn" data-page="suggestions">
                <i class="fas fa-comment"></i>
                My Suggestions
            </a>
        </div>
    </nav>
    
    <!-- Main Content -->
    <main class="main-content">
        <!-- Welcome Section -->
        <section class="welcome-section">
            <div class="welcome-text">
                <h2>Welcome to Your Parent Portal</h2>
                <p>Stay connected with your child's academic journey. Access attendance, test scores, and communicate directly with educators - all in one place.</p>
            </div>
            <div class="welcome-actions">
                <a href="${pageContext.request.contextPath}/parenttestscore" class="btn-test-scores">
                    <i class="fas fa-chart-line"></i>
                    View Test Scores
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </section>

        <!-- Action Cards for Notice and Suggestion -->
        <div class="action-cards">
            <a href="${pageContext.request.contextPath}/parent/notices" class="action-card notice">
                <div class="action-icon">
                    <i class="fas fa-bullhorn"></i>
                </div>
                <div class="action-content">
                    <h3>Notice Board</h3>
                    <p>View all announcements and notices from the school. Stay updated with important information about your child.</p>
                    <span class="action-badge">3 New Notices</span>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/suggestions/parent/create" class="action-card suggestion">
                <div class="action-icon">
                    <i class="fas fa-comment"></i>
                </div>
                <div class="action-content">
                    <h3>Submit Suggestion</h3>
                    <p>Share your feedback, suggestions, or concerns with the school administration. Your voice matters in improving education.</p>
                    <span class="action-badge">Submit Now</span>
                </div>
            </a>
        </div>
    
        <center>

            <a href="${pageContext.request.contextPath}/parenttestscore" class="feature-card tests">
                <div class="feature-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="feature-content">
                    <h3>Test Scores & Performance</h3>
                    <p>Access detailed test reports, performance analytics, and subject-wise scores to track academic progress effectively.</p>
                    <span class="feature-cta">
                        Check Scores
                        <i class="fas fa-arrow-right"></i>
                    </span>
                </div>
            </a>
        </div>
</center>
        <!-- Daily Inspiration -->
        <section class="inspiration-section">
            <p class="inspiration-quote" id="dailyQuote">
                Education is not the filling of a pail, but the lighting of a fire.
            </p>
            <p class="inspiration-author" id="quoteAuthor">- William Butler Yeats</p>
        </section>

        <!-- Stats Overview -->
        <div class="stats-overview">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <h3 id="realTime"></h3>
                    <p>Current Time</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stat-info">
                    <h3 id="currentDate"></h3>
                    <p>Today's Date</p>
                </div>
            </div>

            

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <div class="stat-info">
                    <h3>100%</h3>
                    <p>Secure Portal</p>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="logo-section" style="justify-content: center; margin-bottom: 20px;">
                <div class="logo" style="background: rgba(255, 255, 255, 0.2);">
                    <i class="fas fa-hands-helping"></i>
                </div>
                <div class="logo-text">
                    <h1 style="background: linear-gradient(to right, #ffffff, var(--extra-light-purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Parent Connect</h1>
                    <p style="color: rgba(255, 255, 255, 0.9);">Empowering Parental Involvement</p>
                </div>
            </div>
            
            <p class="footer-text">
                © 2025 SmartClass Parent Portal. All rights reserved.<br>
                Designed to keep you connected with your child's academic journey.
            </p>
        </div>
    </footer>

    <script>
        // Initialize application
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile menu toggle
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const navLinks = document.getElementById('navLinks');
            
            mobileMenuBtn.addEventListener('click', () => {
                navLinks.classList.toggle('show');
                mobileMenuBtn.innerHTML = navLinks.classList.contains('show') 
                    ? '<i class="fas fa-times"></i>' 
                    : '<i class="fas fa-bars"></i>';
            });

            // Navigation active state
            const navItems = document.querySelectorAll('.nav-item');
            navItems.forEach(item => {
                item.addEventListener('click', function() {
                    navItems.forEach(nav => nav.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Daily inspiration quotes
            const quotes = [
                {
                    text: "Education is the most powerful weapon which you can use to change the world.",
                    author: "Nelson Mandela"
                },
                {
                    text: "The roots of education are bitter, but the fruit is sweet.",
                    author: "Aristotle"
                },
                {
                    text: "Education is not preparation for life; education is life itself.",
                    author: "John Dewey"
                },
                {
                    text: "A child miseducated is a child lost.",
                    author: "John F. Kennedy"
                },
                {
                    text: "The function of education is to teach one to think intensively and to think critically.",
                    author: "Martin Luther King Jr."
                }
            ];

            // Set random daily quote
            const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];
            document.getElementById('dailyQuote').textContent = randomQuote.text;
            document.getElementById('quoteAuthor').textContent = `- ${randomQuote.author}`;

            // Update real-time clock
            function updateDateTime() {
                const now = new Date();
                
                // Update time
                const timeOptions = { hour: '2-digit', minute: '2-digit', second: '2-digit' };
                document.getElementById('realTime').textContent = now.toLocaleTimeString('en-US', timeOptions);
                
                // Update date
                const dateOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                document.getElementById('currentDate').textContent = now.toLocaleDateString('en-US', dateOptions);
            }

            // Initial update
            updateDateTime();
            
            // Update every second
            setInterval(updateDateTime, 1000);

            // Feature card animations
            const featureCards = document.querySelectorAll('.feature-card, .action-card');
            featureCards.forEach(card => {
                card.addEventListener('mouseenter', () => {
                    const icon = card.querySelector('.feature-icon, .action-icon');
                    if (icon) {
                        icon.style.transform = 'scale(1.1) rotate(5deg)';
                    }
                });
                
                card.addEventListener('mouseleave', () => {
                    const icon = card.querySelector('.feature-icon, .action-icon');
                    if (icon) {
                        icon.style.transform = 'scale(1) rotate(0deg)';
                    }
                });
            });

            // Set active nav item based on current URL
            function setActiveNavItem() {
                const currentPath = window.location.pathname;
                const navItems = document.querySelectorAll('.nav-item');
                
                navItems.forEach(item => {
                    item.classList.remove('active');
                    
                    // Check which page we're on
                    const href = item.getAttribute('href');
                    if (href && currentPath.includes(href.replace('${pageContext.request.contextPath}', ''))) {
                        item.classList.add('active');
                    }
                    
                    // Special case for dashboard
                    if (currentPath.endsWith('/parent/dashboard') && item.getAttribute('data-page') === 'dashboard') {
                        item.classList.add('active');
                    }
                    
                    // Special case for test scores
                    if (currentPath.includes('parenttestscore') && item.getAttribute('data-page') === 'tests') {
                        item.classList.add('active');
                    }
                });
            }
            
            // Set active nav on page load
            setActiveNavItem();

            // Add keyboard navigation support
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && navLinks.classList.contains('show')) {
                    navLinks.classList.remove('show');
                    mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
                }
            });

            // Fetch unread notices count (simulated)
            setTimeout(() => {
                const unreadElement = document.getElementById('unreadNotices');
                if (unreadElement) {
                    // In a real app, this would come from an API
                    unreadElement.textContent = '3';
                }
            }, 1000);
            
            // Touch feedback for mobile
            const touchElements = document.querySelectorAll('.btn-test-scores, .feature-card, .action-card, .stat-card');
            touchElements.forEach(el => {
                el.addEventListener('touchstart', function() {
                    this.style.transform = 'scale(0.98)';
                }, { passive: true });
                
                el.addEventListener('touchend', function() {
                    this.style.transform = '';
                }, { passive: true });
                
                el.addEventListener('touchcancel', function() {
                    this.style.transform = '';
                }, { passive: true });
            });
        });
    </script>
</body>
</html>