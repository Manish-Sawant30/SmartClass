<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Registration Successful | SmartClass</title>
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
            --success: #4caf50;
            --warning: #ff9800;
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .success-container {
            max-width: 800px;
            width: 100%;
            margin: 0 auto;
        }

        /* Success Card */
        .success-card {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            padding: 50px 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        .success-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--royal-purple), var(--accent-gold), var(--medium-purple));
        }

        /* Success Icon */
        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, var(--success), #45a049);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            position: relative;
            animation: successPulse 2s infinite;
            border: 4px solid var(--accent-gold);
        }

        @keyframes successPulse {
            0% { box-shadow: 0 0 0 0 rgba(76, 175, 80, 0.4); }
            70% { box-shadow: 0 0 0 20px rgba(76, 175, 80, 0); }
            100% { box-shadow: 0 0 0 0 rgba(76, 175, 80, 0); }
        }

        .success-icon i {
            font-size: 48px;
            color: var(--white);
        }

        /* Success Content */
        .success-content h1 {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 15px;
            background: linear-gradient(to right, var(--royal-purple), var(--medium-purple));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .success-content p {
            font-size: 18px;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 30px;
        }

        /* Student ID Badge */
        .student-id-badge {
            display: inline-block;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            padding: 12px 25px;
            border-radius: 50px;
            font-size: 20px;
            font-weight: 600;
            margin: 20px 0;
            box-shadow: var(--shadow);
            border: 2px solid var(--accent-gold);
        }

        .student-id-badge i {
            margin-right: 10px;
            color: var(--accent-gold);
        }

        /* Welcome Message */
        .welcome-message {
            font-size: 20px;
            font-weight: 500;
            color: var(--text-dark);
            margin: 25px 0;
            padding: 20px;
            background: linear-gradient(135deg, rgba(90, 61, 110, 0.1), rgba(126, 87, 194, 0.1));
            border-radius: var(--radius);
            border-left: 5px solid var(--accent-gold);
            border: 2px solid var(--light-purple);
        }

        .welcome-message strong {
            color: var(--royal-purple);
        }

        /* Countdown Timer */
        .countdown-timer {
            background: linear-gradient(135deg, #fff9e6, #fff2d0);
            border-radius: var(--radius);
            padding: 20px;
            margin: 30px 0;
            border: 2px solid var(--accent-gold);
        }

        .countdown-timer h4 {
            font-size: 16px;
            color: var(--royal-purple);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
        }

        .countdown-timer h4 i {
            color: var(--accent-gold);
        }

        .timer {
            font-size: 24px;
            font-weight: 700;
            color: var(--dark-purple);
            font-family: 'Outfit', sans-serif;
        }

        /* Next Steps */
        .next-steps {
            background-color: var(--extra-light-purple);
            border-radius: var(--radius);
            padding: 30px;
            margin: 40px 0;
            text-align: left;
            border-left: 4px solid var(--accent-gold);
            border: 2px solid var(--light-purple);
        }

        .next-steps h3 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--royal-purple);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .next-steps h3 i {
            color: var(--accent-gold);
        }

        .steps-list {
            list-style: none;
        }

        .steps-list li {
            padding: 12px 0;
            border-bottom: 1px solid var(--light-purple);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .steps-list li:last-child {
            border-bottom: none;
        }

        .step-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 600;
            box-shadow: var(--shadow);
            flex-shrink: 0;
            border: 2px solid var(--accent-gold);
        }

        .step-content h4 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--text-dark);
        }

        .step-content p {
            font-size: 14px;
            color: var(--text-muted);
            margin: 0;
        }

        /* Student Info Summary */
        .info-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }

        .info-card {
            background: var(--extra-light-purple);
            border-radius: var(--radius);
            padding: 20px;
            text-align: center;
            transition: var(--transition);
            border: 2px solid var(--light-purple);
        }

        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .info-card i {
            font-size: 24px;
            color: var(--accent-gold);
            margin-bottom: 15px;
        }

        .info-card h4 {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-card p {
            font-size: 18px;
            font-weight: 600;
            color: var(--royal-purple);
            margin: 0;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 15px 30px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            font-size: 16px;
            text-decoration: none;
            border: 2px solid transparent;
        }

        .btn-primary {
            background: var(--accent-gold);
            color: var(--dark-purple);
        }

        .btn-primary:hover {
            background: transparent;
            border-color: var(--accent-gold);
            color: var(--accent-gold);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        .btn-outline {
            background: transparent;
            color: var(--royal-purple);
            border: 2px solid var(--royal-purple);
        }

        .btn-outline:hover {
            background: var(--royal-purple);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: var(--shadow);
        }

        /* Footer */
        .footer-note {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid var(--light-purple);
            color: var(--text-muted);
            font-size: 14px;
        }

        .footer-note a {
            color: var(--royal-purple);
            text-decoration: none;
            font-weight: 500;
            padding: 3px 8px;
            border-radius: 20px;
            transition: var(--transition);
        }

        .footer-note a:hover {
            color: var(--accent-gold);
            background: var(--extra-light-purple);
        }

        /* Confetti Effect */
        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: var(--royal-purple);
            border-radius: 50%;
            opacity: 0.7;
            animation: confetti-fall 3s linear forwards;
        }

        @keyframes confetti-fall {
            0% {
                transform: translateY(-100px) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(600px) rotate(360deg);
                opacity: 0;
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .success-card {
                padding: 30px 20px;
            }
            
            .success-content h1 {
                font-size: 28px;
            }
            
            .success-content p {
                font-size: 16px;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
            
            .info-summary {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .success-icon {
                width: 80px;
                height: 80px;
            }
            
            .success-icon i {
                font-size: 36px;
            }
            
            .next-steps {
                padding: 20px;
            }
            
            .student-id-badge {
                font-size: 16px;
                padding: 10px 20px;
            }
            
            .timer {
                font-size: 20px;
            }
            
            .welcome-message {
                font-size: 18px;
                padding: 15px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .info-card:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-card">
            <!-- Success Icon -->
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            
            <!-- Success Message -->
            <div class="success-content">
                <h1>Registration Successful!</h1>
                <p>Congratulations! Your student account has been created successfully.</p>
                
                <!-- Welcome Message -->
                <div class="welcome-message">
                    <i class="fas fa-graduation-cap" style="margin-right: 10px; color: var(--accent-gold);"></i>
                    Welcome to <strong>SmartClass Learning Platform</strong>! Your journey to excellence begins now.
                </div>
                
                <!-- Countdown Timer -->
                <div class="countdown-timer">
                    <h4><i class="fas fa-clock"></i> Redirecting to dashboard in:</h4>
                    <div class="timer" id="countdown">10 seconds</div>
                </div>
                
                <!-- Next Steps -->
                <div class="next-steps">
                    <h3><i class="fas fa-list-check"></i> Next Steps</h3>
                    <ul class="steps-list">
                        <li>
                            <div class="step-icon">1</div>
                            <div class="step-content">
                                <h4>Complete Your Profile</h4>
                                <p>Add your personal details and upload your profile picture</p>
                            </div>
                        </li>
                        <li>
                            <div class="step-icon">2</div>
                            <div class="step-content">
                                <h4>Explore Your Courses</h4>
                                <p>Access study materials, assignments, and video lectures</p>
                            </div>
                        </li>
                        <li>
                            <div class="step-icon">3</div>
                            <div class="step-content">
                                <h4>Join Class Sessions</h4>
                                <p>Attend live classes and interact with instructors</p>
                            </div>
                        </li>
                        <li>
                            <div class="step-icon">4</div>
                            <div class="step-content">
                                <h4>Start Learning</h4>
                                <p>Begin your first lesson and track your progress</p>
                            </div>
                        </li>
                    </ul>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/student-login" class="btn btn-primary">
                        <i class="fas fa-tachometer-alt"></i> Go to Dashboard
                    </a>
                    
                    <button class="btn btn-outline" onclick="window.print()">
                        <i class="fas fa-print"></i> Print Details
                    </button>
                </div>
            </div>
        </div>
    </div>
             
    <script>
        // Generate confetti effect
        function createConfetti() {
            const colors = ['#5a3d6e', '#7a5a8c', '#9b7eb0', '#c4b0d4', '#e6b800', '#4caf50'];
            const container = document.querySelector('.success-card');

            for (let i = 0; i < 50; i++) {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
                confetti.style.width = Math.random() * 10 + 5 + 'px';
                confetti.style.height = confetti.style.width;
                confetti.style.animationDelay = Math.random() * 2 + 's';

                container.appendChild(confetti);

                setTimeout(() => confetti.remove(), 3000);
            }
        }

        // Countdown timer
        function startCountdown() {
            let seconds = 10;
            const countdownElement = document.getElementById('countdown');

            const countdownInterval = setInterval(() => {
                seconds--;
                countdownElement.textContent = seconds + " second" + (seconds != 1 ? "s" : "");

                if (seconds <= 0) {
                    clearInterval(countdownInterval);
                    window.location.href = "${pageContext.request.contextPath}/student-login";
                }
            }, 1000);
        }

        // Get URL parameters
        function getUrlParams() {
            const params = new URLSearchParams(window.location.search);
            return {
                name: params.get('name') || 'Alex Johnson',
                email: params.get('email') || 'alex.johnson@smartclass.com',
                course: params.get('course') || 'Full Stack Development'
            };
        }

        // Generate Student ID
        function generateStudentId() {
            const year = new Date().getFullYear();
            const randomNum = Math.floor(Math.random() * 9000) + 1000;
            return `STU${year}${randomNum}`;
        }

        // Format Date
        function formatDate(date) {
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        }

        // Initialize Page
        document.addEventListener('DOMContentLoaded', function() {
            createConfetti();
            startCountdown();

            const params = getUrlParams();

            // Update student info if elements exist
            const studentNameEl = document.getElementById('studentName');
            const studentEmailEl = document.getElementById('studentEmail');
            const courseNameEl = document.getElementById('courseName');
            const studentIdEl = document.getElementById('studentId');
            const regDateEl = document.getElementById('regDate');
            
            if (studentNameEl) studentNameEl.textContent = params.name;
            if (studentEmailEl) studentEmailEl.textContent = params.email;
            if (courseNameEl) courseNameEl.textContent = params.course;
            if (studentIdEl) studentIdEl.textContent = generateStudentId();
            if (regDateEl) regDateEl.textContent = formatDate(new Date());

            setInterval(createConfetti, 3000);
            
            // Touch feedback for mobile
            const touchElements = document.querySelectorAll('.btn, .info-card');
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

        // Print Styling
        window.onbeforeprint = function() {
            const style = document.createElement('style');
            style.innerHTML = `
                @media print {
                    body * { visibility: hidden; }
                    .success-container, .success-container * { visibility: visible; }
                    .success-container { position: absolute; left: 0; top: 0; width: 100%; }
                    .action-buttons, .countdown-timer { display: none !important; }
                }
            `;
            document.head.appendChild(style);
        };
    </script>
</body>
</html>