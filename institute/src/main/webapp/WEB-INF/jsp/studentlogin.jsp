<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#9b7eb0">
    <title>SmartClass | Student Login</title>
    
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
            --extra-light-purple: #e9e0f0;
            --accent-gold: #e6b800;
            --white: #ffffff;
            --off-white: #f8f4ff;
            --text-dark: #2d1b3c;
            --text-light: #5a3d6e;
            --shadow: 0 8px 20px rgba(90, 61, 110, 0.15);
            --shadow-sm: 0 4px 10px rgba(90, 61, 110, 0.1);
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, var(--light-purple) 0%, var(--extra-light-purple) 100%);
            position: relative;
            overflow-x: hidden;
            padding: 20px;
        }

        /* ================= BACKGROUND PATTERN ================= */
        .bg-pattern {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0.3;
            background-image: 
                radial-gradient(circle at 25% 25%, var(--soft-purple) 2px, transparent 2px),
                radial-gradient(circle at 75% 75%, var(--medium-purple) 2px, transparent 2px);
            background-size: 60px 60px;
            pointer-events: none;
        }

        /* ================= DECORATIVE CIRCLES ================= */
        .deco-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(90, 61, 110, 0.05);
            pointer-events: none;
        }

        .circle-1 {
            width: 300px;
            height: 300px;
            top: -150px;
            right: -150px;
            background: radial-gradient(circle, rgba(155, 126, 176, 0.2) 0%, transparent 70%);
            animation: float 20s infinite;
        }

        .circle-2 {
            width: 400px;
            height: 400px;
            bottom: -200px;
            left: -200px;
            background: radial-gradient(circle, rgba(196, 176, 212, 0.15) 0%, transparent 70%);
            animation: float 25s infinite reverse;
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

        .animate-scale {
            animation: scaleIn 0.5s ease forwards;
        }

        .delay-1 { animation-delay: 0.1s; opacity: 0; animation-fill-mode: forwards; }
        .delay-2 { animation-delay: 0.2s; opacity: 0; animation-fill-mode: forwards; }
        .delay-3 { animation-delay: 0.3s; opacity: 0; animation-fill-mode: forwards; }
        .delay-4 { animation-delay: 0.4s; opacity: 0; animation-fill-mode: forwards; }
        .delay-5 { animation-delay: 0.5s; opacity: 0; animation-fill-mode: forwards; }
        .delay-6 { animation-delay: 0.6s; opacity: 0; animation-fill-mode: forwards; }

        /* ================= LOGIN CONTAINER ================= */
        .login-wrapper {
            width: 100%;
            max-width: 420px;
            z-index: 10;
            position: relative;
            margin: 20px;
        }

		.login-container {
		            background: rgba(255, 255, 255, 0.9);
		            backdrop-filter: blur(10px);
		            width: 100%;
		            padding: 40px 35px;
		            border-radius: var(--radius);
		            box-shadow: var(--shadow);
		            text-align: center;
		            border: 2px solid rgba(155, 126, 176, 0.3);
		            transform: translateY(0);
					display: flex;
					   flex-direction: column;
		            transition: var(--transition);
					align-items: center;   /* This centers everything */

		        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(90, 61, 110, 0.2);
            border-color: var(--soft-purple);
        }

        /* ================= LOGO ================= */
        .logo-container {
            position: relative;
            margin-bottom: 15px;
            display: inline-block;
        }

        .logo-img {
            width: 130px;
            height: 130px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid var(--soft-purple);
            box-shadow: 0 10px 25px rgba(90, 61, 110, 0.2);
            transition: var(--transition);
            background: var(--white);
            padding: 5px;
        }

        .logo-img:hover {
            transform: scale(1.05) rotate(5deg);
            box-shadow: 0 15px 30px rgba(90, 61, 110, 0.3);
            border-color: var(--accent-gold);
        }

        .logo-ring {
            position: absolute;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 2px dashed var(--soft-purple);
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            animation: rotate 20s infinite linear;
        }

        @keyframes rotate {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        /* ================= TITLE ================= */
        h2 {
            color: var(--dark-purple);
            font-size: 32px;
            margin-bottom: 30px;
            font-weight: 700;
            position: relative;
            display: inline-block;
        }

        h2:after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: linear-gradient(to right, var(--soft-purple), var(--accent-gold));
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        /* ================= MESSAGES ================= */
        .message {
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            margin-bottom: 20px;
            font-size: 14px;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 4px solid transparent;
        }

        .message i {
            font-size: 18px;
        }

        .message.error {
            background: #fee9e6;
            color: #d32f2f;
            border-left-color: #d32f2f;
        }

        .message.success {
            background: #e8f5e9;
            color: #2e7d32;
            border-left-color: #2e7d32;
        }

        /* ================= FORM ================= */
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--soft-purple);
            font-size: 18px;
            transition: var(--transition);
            z-index: 1;
        }

        input {
            width: 100%;
            padding: 16px 20px 16px 50px;
            border: 2px solid var(--extra-light-purple);
            border-radius: var(--radius-sm);
            font-size: 16px;
            background: var(--white);
            transition: var(--transition);
            outline: none;
            color: var(--text-dark);
        }

        input:focus {
            border-color: var(--soft-purple);
            box-shadow: 0 5px 15px rgba(155, 126, 176, 0.2);
            transform: translateY(-2px);
        }

        input:focus + .input-icon {
            color: var(--accent-gold);
        }

        input::placeholder {
            color: #aaa;
        }

        /* ================= BUTTON ================= */
        button {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            border: none;
            border-radius: var(--radius-sm);
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 8px 20px rgba(90, 61, 110, 0.2);
            letter-spacing: 0.5px;
        }

        button:hover {
            background: linear-gradient(135deg, var(--medium-purple), var(--royal-purple));
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(90, 61, 110, 0.3);
        }

        button:active {
            transform: translateY(-1px);
        }

        button i {
            margin-right: 8px;
        }

        /* ================= LINKS ================= */
        .links {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .forgot-link {
            color: var(--text-light);
            text-decoration: none;
            font-size: 15px;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 30px;
        }

        .forgot-link i {
            color: var(--accent-gold);
            transition: var(--transition);
        }

        .forgot-link:hover {
            color: var(--accent-gold);
            background: rgba(155, 126, 176, 0.1);
        }

        .signup-link {
            color: var(--text-light);
            font-size: 15px;
        }

        .signup-link a {
            color: var(--royal-purple);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            margin-left: 5px;
            padding: 4px 8px;
            border-radius: 20px;
        }

        .signup-link a:hover {
            color: var(--accent-gold);
            background: rgba(155, 126, 176, 0.1);
        }

        .back-link {
            color: var(--text-light);
            text-decoration: none;
            font-size: 15px;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 30px;
        }

        .back-link i {
            color: var(--accent-gold);
            transition: var(--transition);
        }

        .back-link:hover {
            color: var(--accent-gold);
            background: rgba(155, 126, 176, 0.1);
        }

        /* ================= RESPONSIVE ================= */
        
        /* Mobile */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px 25px;
            }
            
            .logo-img {
                width: 110px;
                height: 110px;
            }
            
            .logo-ring {
                width: 130px;
                height: 130px;
            }
            
            h2 {
                font-size: 28px;
            }
            
            input {
                padding: 14px 20px 14px 45px;
                font-size: 15px;
            }
            
            button {
                padding: 14px;
                font-size: 16px;
            }
        }

        /* Small Mobile */
        @media (max-width: 360px) {
            .login-container {
                padding: 25px 20px;
            }
            
            .logo-img {
                width: 100px;
                height: 100px;
            }
            
            .logo-ring {
                width: 120px;
                height: 120px;
            }
            
            h2 {
                font-size: 24px;
            }
            
            input {
                padding: 12px 15px 12px 40px;
            }
        }

        /* Tablet */
        @media (min-width: 768px) and (max-width: 992px) {
            .login-wrapper {
                max-width: 450px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            button:active {
                transform: scale(0.98);
            }
            
            .forgot-link:active,
            .signup-link a:active,
            .back-link:active {
                background: rgba(155, 126, 176, 0.2);
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
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
    <!-- Decorative Circles -->
    <div class="deco-circle circle-1"></div>
    <div class="deco-circle circle-2"></div>
    
    <div class="login-wrapper">
        <div class="login-container animate-scale">
            <!-- Logo -->
            <div class="logo-container animate-fade-up">
                <img src="${pageContext.request.contextPath}/images/logo2.jpeg" 
                     alt="SmartClass Logo" 
                     class="logo-img"
                     onerror="this.src='https://via.placeholder.com/130x130/9b7eb0/ffffff?text=SmartClass'">
                <div class="logo-ring"></div>
            </div>

            <!-- Title -->
            <h2 class="animate-fade-up delay-1">Student Login</h2>

            <!-- Display error message if exists -->
            <c:if test="${not empty error}">
                <div class="message error animate-fade-up delay-2">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/student-login" method="post">
                <div class="form-group animate-fade-up delay-3">
                    <div class="input-icon">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <input type="text" 
                           name="userId" 
                           placeholder="Student ID or Email" 
                           required
                           autocomplete="username">
                </div>
                
                <div class="form-group animate-fade-up delay-4">
                    <div class="input-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                    <input type="password" 
                           name="password" 
                           placeholder="Password" 
                           required
                           autocomplete="current-password">
                </div>

                <button type="submit" class="animate-fade-up delay-5">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>
            </form>
            
            <!-- Links -->
            <div class="links animate-fade-up delay-6">
                
                
                <div class="signup-link">
                    Don't have an account?
                    <a href="${pageContext.request.contextPath}/student-signup">Sign Up</a>
                </div>

                <a href="${pageContext.request.contextPath}/" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>
            </div>
        </div>
    </div>

    <!-- Font Awesome for icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Image fallback
            const logo = document.querySelector('.logo-img');
            if (logo) {
                logo.onerror = function() {
                    this.src = 'https://via.placeholder.com/130x130/9b7eb0/ffffff?text=SmartClass';
                };
            }
            
            // Input icon color change on focus
            const inputs = document.querySelectorAll('input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.querySelector('.input-icon').style.color = '#e6b800';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.querySelector('.input-icon').style.color = '#9b7eb0';
                });
            });
            
            // Touch feedback for mobile
            const button = document.querySelector('button');
            if (button) {
                button.addEventListener('touchstart', function() {
                    this.style.transform = 'scale(0.98)';
                }, { passive: true });
                
                button.addEventListener('touchend', function() {
                    this.style.transform = '';
                }, { passive: true });
                
                button.addEventListener('touchcancel', function() {
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