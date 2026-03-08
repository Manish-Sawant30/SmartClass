<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartClass - Integrated Learning Management Platform</title>
    
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

        /* ================= HERO SECTION ================= */
        .hero-section {
            padding: 100px 20px;
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
            max-width: 900px;
            margin: 0 auto;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.2;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .hero-title span {
            color: var(--accent-gold);
            position: relative;
            display: inline-block;
        }

        .hero-title span::after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 0;
            width: 100%;
            height: 8px;
            background: var(--accent-gold);
            opacity: 0.3;
            border-radius: 4px;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            margin-bottom: 40px;
            opacity: 0.9;
            color: var(--text-light);
        }

        .hero-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-hero {
            padding: 14px 40px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .btn-hero::before {
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

        .btn-hero:hover::before {
            width: 300px;
            height: 300px;
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

        /* ================= WELCOME SECTION ================= */
        .welcome-section {
            padding: 60px 20px;
            position: relative;
        }

        .welcome-box {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 50px;
            max-width: 700px;
            margin: 0 auto;
            text-align: center;
            border: 2px solid rgba(155, 126, 176, 0.3);
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }

        .welcome-box::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(230, 184, 0, 0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .welcome-logo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--accent-gold);
            margin-bottom: 25px;
            box-shadow: 0 0 30px rgba(230, 184, 0, 0.3);
            transition: var(--transition);
        }

        .welcome-logo:hover {
            transform: scale(1.1) rotate(5deg);
        }

        .welcome-title {
            color: var(--white);
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .welcome-tagline {
            color: var(--light-purple);
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .welcome-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }

        .welcome-btn {
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .welcome-btn::before {
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

        .welcome-btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .welcome-btn-primary {
            background: var(--royal-purple);
            color: var(--white);
        }

        .welcome-btn-primary:hover {
            background: var(--medium-purple);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(90, 61, 110, 0.4);
        }

        .welcome-btn-secondary {
            background: transparent;
            color: var(--white);
            border: 2px solid var(--soft-purple);
        }

        .welcome-btn-secondary:hover {
            background: var(--soft-purple);
            transform: translateY(-3px);
        }

        .welcome-divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
            color: var(--soft-purple);
        }

        .welcome-divider::before,
        .welcome-divider::after {
            content: "";
            flex: 1;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--soft-purple), transparent);
        }

        .welcome-divider span {
            padding: 0 20px;
            font-size: 0.95rem;
        }

        /* ================= PLATFORM OVERVIEW ================= */
        .platform-overview {
            padding: 80px 20px;
            background: rgba(0, 0, 0, 0.2);
        }

        .section-title {
            text-align: center;
            font-size: 2.8rem;
            font-weight: 800;
            color: var(--white);
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .section-subtitle {
            text-align: center;
            color: var(--light-purple);
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 50px;
        }

        .platform-grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .platform-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            padding: 35px 25px;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
            position: relative;
            overflow: hidden;
        }

        .platform-card::before {
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

        .platform-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .platform-card:hover::before {
            opacity: 1;
        }

        .platform-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 25px;
            color: var(--accent-gold);
            font-size: 2.2rem;
            transition: var(--transition);
        }

        .platform-card:hover .platform-icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 0 30px rgba(230, 184, 0, 0.3);
        }

        .platform-card h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--white);
            margin-bottom: 20px;
        }

        .platform-card ul {
            list-style: none;
            padding: 0;
        }

        .platform-card li {
            padding: 10px 0;
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 0.95rem;
            border-bottom: 1px solid rgba(155, 126, 176, 0.2);
        }

        .platform-card li:last-child {
            border-bottom: none;
        }

        .platform-card li i {
            color: var(--accent-gold);
            font-size: 1rem;
        }

        /* ================= FEATURES ================= */
        .features-section {
            padding: 80px 20px;
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
            padding: 35px 25px;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .feature-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--royal-purple), var(--accent-gold), var(--medium-purple));
            transform: scaleX(0);
            transition: transform 0.5s ease;
        }

        .feature-card:hover::after {
            transform: scaleX(1);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .feature-icon {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: var(--accent-gold);
            font-size: 2rem;
            transition: var(--transition);
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(360deg);
        }

        .feature-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--white);
            margin-bottom: 15px;
        }

        .feature-description {
            color: var(--text-light);
            line-height: 1.7;
            font-size: 0.95rem;
        }

        /* ================= STATS ================= */
        .stats-section {
            background: linear-gradient(135deg, var(--dark-purple), var(--deep-purple));
            padding: 80px 20px;
            position: relative;
            overflow: hidden;
        }

        .stats-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(230, 184, 0, 0.1) 0%, transparent 70%);
            animation: rotate 30s linear infinite;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            max-width: 1000px;
            margin: 0 auto;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .stat-item {
            padding: 20px;
            transition: var(--transition);
        }

        .stat-item:hover {
            transform: scale(1.1);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            color: var(--accent-gold);
            margin-bottom: 5px;
            text-shadow: 0 0 20px rgba(230, 184, 0, 0.5);
        }

        .stat-label {
            font-size: 1rem;
            color: var(--light-purple);
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* ================= COURSES ================= */
        .courses-section {
            padding: 80px 20px;
            background: rgba(0, 0, 0, 0.2);
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .course-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(155, 126, 176, 0.2);
        }

        .course-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .course-image {
            height: 180px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-gold);
            font-size: 3.5rem;
            position: relative;
            overflow: hidden;
        }

        .course-image::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
        }

        .course-content {
            padding: 25px;
        }

        .course-category {
            display: inline-block;
            padding: 5px 15px;
            background: rgba(155, 126, 176, 0.2);
            color: var(--light-purple);
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .course-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--white);
            margin-bottom: 10px;
        }

        .course-description {
            color: var(--text-light);
            margin-bottom: 20px;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .course-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid rgba(155, 126, 176, 0.2);
        }

        .course-meta span {
            color: var(--light-purple);
            font-size: 0.9rem;
        }

        .course-meta span i {
            color: var(--accent-gold);
            margin-right: 5px;
        }

        .course-btn {
            background: var(--royal-purple);
            color: var(--white);
            padding: 8px 20px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: var(--transition);
            border: 2px solid transparent;
        }

        .course-btn:hover {
            background: transparent;
            border-color: var(--accent-gold);
            color: var(--accent-gold);
            transform: translateY(-2px);
        }

        /* ================= CTA ================= */
        .cta-section {
            padding: 100px 20px;
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
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 20px;
            color: var(--white);
            position: relative;
            z-index: 1;
        }

        .cta-description {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 40px;
            color: var(--light-purple);
            position: relative;
            z-index: 1;
        }

        /* ================= FOOTER ================= */
        .footer {
            background: var(--dark-purple);
            padding: 80px 20px 30px;
            border-top: 2px solid var(--royal-purple);
            position: relative;
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
            .platform-grid,
            .features-grid,
            .courses-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .stats-grid {
                grid-template-columns: repeat(4, 1fr);
            }
            
            .footer-content {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .hero-title {
                font-size: 4rem;
            }
        }

        @media (min-width: 1024px) {
            .platform-grid,
            .features-grid,
            .courses-grid {
                grid-template-columns: repeat(3, 1fr);
            }
            
            .platform-grid {
                grid-template-columns: repeat(4, 1fr);
            }
            
            .footer-content {
                grid-template-columns: repeat(3, 1fr);
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/">
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
                <h1 class="hero-title animate-fade-up">
                    Transform Education with <span>SmartClass</span>
                </h1>
                <p class="hero-subtitle animate-fade-up delay-1">
                    An integrated learning management platform connecting administrators, teachers, students, and parents in one seamless ecosystem.
                </p>
                <div class="hero-buttons animate-fade-up delay-2">
                    <a href="#platform" class="btn-hero btn-hero-primary">
                        <i class="fas fa-rocket"></i> Explore Platform
                    </a>
                    <a href="#courses" class="btn-hero btn-hero-secondary">
                        <i class="fas fa-play-circle"></i> View Courses
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= WELCOME SECTION ================= -->
    <section class="welcome-section">
        <div class="container">
            <div class="welcome-box animate-scale">
                <img src="${pageContext.request.contextPath}/images/logo2.jpeg" alt="SmartClass Logo" class="welcome-logo animate-float">
                <h2 class="welcome-title">Welcome to SmartClass</h2>
                <p class="welcome-tagline">Your journey to excellence begins here</p>
                
                <div class="welcome-buttons">
                    <a href="${pageContext.request.contextPath}/signup" class="welcome-btn welcome-btn-primary">
                        <i class="fas fa-user-plus"></i> Create Free Account
                    </a>
                    <a href="#platform" class="welcome-btn welcome-btn-secondary">
                        <i class="fas fa-info-circle"></i> How It Works
                    </a>
                </div>
                
                <div class="welcome-divider">
                    <span>Already have an account?</span>
                </div>
                
                <a href="${pageContext.request.contextPath}/loginusers" class="welcome-btn welcome-btn-primary">
                    <i class="fas fa-sign-in-alt"></i> Login to Dashboard
                </a>
            </div>
        </div>
    </section>

    <!-- ================= PLATFORM OVERVIEW ================= -->
    <section id="platform" class="platform-overview">
        <div class="container">
            <h2 class="section-title animate-fade-up">Complete Educational Ecosystem</h2>
            <p class="section-subtitle animate-fade-up delay-1">Four integrated modules working together to transform education</p>
            
            <div class="platform-grid">
                <div class="platform-card animate-fade-left delay-1">
                    <div class="platform-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h3>Admin Module</h3>
                    <ul>
                        <li><i class="fas fa-check-circle"></i> User Account Management</li>
                        <li><i class="fas fa-check-circle"></i> Course & Content Control</li>
                        <li><i class="fas fa-check-circle"></i> System Analytics</li>
                        <li><i class="fas fa-check-circle"></i> Report Generation</li>
                    </ul>
                </div>
                
                <div class="platform-card animate-fade-up delay-2">
                    <div class="platform-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <h3>Teacher Module</h3>
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Upload Video Lectures</li>
                        <li><i class="fas fa-check-circle"></i> Share Study Materials</li>
                        <li><i class="fas fa-check-circle"></i> Create MCQ Tests</li>
                        <li><i class="fas fa-check-circle"></i> Track Attendance</li>
                    </ul>
                </div>
                
                <div class="platform-card animate-fade-right delay-3">
                    <div class="platform-icon">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <h3>Student Module</h3>
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Access Course Content</li>
                        <li><i class="fas fa-check-circle"></i> Take Online Tests</li>
                        <li><i class="fas fa-check-circle"></i> Download Materials</li>
                        <li><i class="fas fa-check-circle"></i> Track Progress</li>
                    </ul>
                </div>
                
                <div class="platform-card animate-fade-up delay-4">
                    <div class="platform-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>Parent Module</h3>
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Monitor Attendance</li>
                        <li><i class="fas fa-check-circle"></i> View Test Scores</li>
                        <li><i class="fas fa-check-circle"></i> Track Performance</li>
                        <li><i class="fas fa-check-circle"></i> Receive Updates</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= FEATURES ================= -->
    <section class="features-section">
        <div class="container">
            <h2 class="section-title animate-fade-up">Why Choose SmartClass?</h2>
            <p class="section-subtitle animate-fade-up delay-1">We provide the perfect learning environment with cutting-edge tools</p>
            
            <div class="features-grid">
                <div class="feature-card animate-fade-left delay-1">
                    <div class="feature-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <h3 class="feature-title">Expert Instructors</h3>
                    <p class="feature-description">Learn from industry professionals with years of real-world experience.</p>
                </div>
                
                <div class="feature-card animate-fade-up delay-2">
                    <div class="feature-icon">
                        <i class="fas fa-laptop-code"></i>
                    </div>
                    <h3 class="feature-title">Hands-on Projects</h3>
                    <p class="feature-description">Build real projects that you can showcase in your portfolio.</p>
                </div>
                
                <div class="feature-card animate-fade-right delay-3">
                    <div class="feature-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3 class="feature-title">Flexible Learning</h3>
                    <p class="feature-description">Learn at your own pace with 24/7 access to course materials.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= STATS ================= -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item animate-scale">
                    <div class="stat-number">16+</div>
                    <div class="stat-label">Courses</div>
                </div>
                <div class="stat-item animate-scale delay-1">
                    <div class="stat-number">4</div>
                    <div class="stat-label">Modules</div>
                </div>
                <div class="stat-item animate-scale delay-2">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Access</div>
                </div>
                <div class="stat-item animate-scale delay-3">
                    <div class="stat-number">98%</div>
                    <div class="stat-label">Success</div>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= COURSES ================= -->
    <section id="courses" class="courses-section">
        <div class="container">
            <h2 class="section-title animate-fade-up">Popular Courses</h2>
            <p class="section-subtitle animate-fade-up delay-1">Start your learning journey with our most popular courses</p>
            
            <div class="courses-grid">
                <div class="course-card animate-fade-left delay-1">
                    <div class="course-image">
                        <i class="fab fa-python"></i>
                    </div>
                    <div class="course-content">
                        <span class="course-category">Programming</span>
                        <h3 class="course-title">Python Programming</h3>
                        <p class="course-description">Master Python for web development, data science, and automation.</p>
                        <div class="course-meta">
                            <span><i class="fas fa-clock"></i> 40 hours</span>
                            <a href="${pageContext.request.contextPath}/home-courses" class="course-btn">Learn More</a>
                        </div>
                    </div>
                </div>
                
                <div class="course-card animate-fade-up delay-2">
                    <div class="course-image">
                        <i class="fas fa-robot"></i>
                    </div>
                    <div class="course-content">
                        <span class="course-category">AI & ML</span>
                        <h3 class="course-title">Artificial Intelligence</h3>
                        <p class="course-description">Learn AI fundamentals, machine learning algorithms, and applications.</p>
                        <div class="course-meta">
                            <span><i class="fas fa-clock"></i> 45 hours</span>
                            <a href="${pageContext.request.contextPath}/home-courses" class="course-btn">Learn More</a>
                        </div>
                    </div>
                </div>
                
                <div class="course-card animate-fade-right delay-3">
                    <div class="course-image">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="course-content">
                        <span class="course-category">Security</span>
                        <h3 class="course-title">Cyber Security</h3>
                        <p class="course-description">Protect systems and networks from cyber threats and vulnerabilities.</p>
                        <div class="course-meta">
                            <span><i class="fas fa-clock"></i> 35 hours</span>
                            <a href="${pageContext.request.contextPath}/home-courses" class="course-btn">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/home-courses" class="btn-hero btn-hero-primary animate-scale">
                    <i class="fas fa-book-open"></i> View All 16+ Courses
                </a>
            </div>
        </div>
    </section>

    <!-- ================= CTA SECTION ================= -->
    <section class="cta-section">
        <div class="container">
            <h2 class="cta-title animate-fade-up">Ready to Transform Your Learning Experience?</h2>
            <p class="cta-description animate-fade-up delay-1">
                Join thousands of students, teachers, and parents already using SmartClass.
            </p>
            <div class="hero-buttons animate-fade-up delay-2">
                <a href="${pageContext.request.contextPath}/signup" class="btn-hero btn-hero-primary">
                    <i class="fas fa-user-plus"></i> Get Started Free
                </a>
                <a href="${pageContext.request.contextPath}/home-courses" class="btn-hero btn-hero-secondary">
                    <i class="fas fa-book-open"></i> Browse Courses
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
                
                <div class="footer-links animate-fade-right">
                    <h3>Contact Info</h3>
                    <ul>
                        <li><a href="#"><i class="fas fa-map-marker-alt"></i> 123 Tech Street, Silicon Valley</a></li>
                        <li><a href="tel:+11234567890"><i class="fas fa-phone"></i> +1 (123) 456-7890</a></li>
                        <li><a href="mailto:info@smartclass.com"><i class="fas fa-envelope"></i> info@smartclass.com</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom animate-fade-up">
                <p>&copy; 2026 SmartClass. All rights reserved.</p>
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
            
            // Smooth scrolling for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    const href = this.getAttribute('href');
                    if (href === '#' || href.includes('.jsp')) return;
                    
                    e.preventDefault();
                    const targetElement = document.querySelector(href);
                    if (targetElement) {
                        window.scrollTo({
                            top: targetElement.offsetTop - 80,
                            behavior: 'smooth'
                        });
                    }
                });
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
            
            document.querySelectorAll('.platform-card, .feature-card, .course-card').forEach(el => {
                observer.observe(el);
            });
        });
    </script>
</body>
</html>