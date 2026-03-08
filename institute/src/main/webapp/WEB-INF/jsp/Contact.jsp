<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | EduEra</title>
    
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
            --radius: 16px;
            --radius-sm: 10px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
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
            box-shadow: 0 4px 12px rgba(255, 221, 89, 0.3);
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

        /* ================= CONTACT SECTION ================= */
        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .contact-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .contact-header h1 {
            font-size: 3rem;
            font-weight: 800;
            color: var(--primary-blue);
            margin-bottom: 1rem;
            position: relative;
            display: inline-block;
        }

        .contact-header h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--accent-yellow);
            border-radius: 2px;
        }

        .contact-header p {
            font-size: 1.2rem;
            color: #555;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.8;
        }

        /* Contact Cards Grid */
        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 4rem;
        }

        .contact-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 2.5rem;
            text-align: center;
            box-shadow: var(--shadow-light);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: 2px solid transparent;
        }

        .contact-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow);
            border-color: var(--accent-yellow);
        }

        .contact-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: var(--white);
            transition: var(--transition);
        }

        .contact-card:hover .contact-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .contact-card:nth-child(1) .contact-icon {
            background: linear-gradient(135deg, #25D366, #128C7E);
        }

        .contact-card:nth-child(2) .contact-icon {
            background: linear-gradient(135deg, #0077B5, #00509e);
        }

        .contact-card:nth-child(3) .contact-icon {
            background: linear-gradient(135deg, #FF0000, #FF6B6B);
        }

        .contact-card h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary-blue);
        }

        .contact-card p {
            color: #666;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
        }

        .contact-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 0.8rem 2rem;
            background: var(--primary-blue);
            color: var(--white);
            text-decoration: none;
            border-radius: 50px;
            font-weight: 500;
            transition: var(--transition);
            border: 2px solid transparent;
        }

        .contact-btn:hover {
            background: transparent;
            color: var(--primary-blue);
            border-color: var(--primary-blue);
            transform: translateY(-3px);
        }

        /* Contact Form */
        .contact-form-section {
            background: var(--white);
            border-radius: var(--radius);
            padding: 3rem;
            box-shadow: var(--shadow);
            margin-top: 4rem;
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-blue);
            margin-bottom: 2rem;
            text-align: center;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary-blue);
        }

        .form-control {
            width: 100%;
            padding: 0.9rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: var(--radius-sm);
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--secondary-blue);
            box-shadow: 0 0 0 3px rgba(0, 80, 158, 0.1);
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }

        .submit-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 1rem 2.5rem;
            background: linear-gradient(135deg, var(--secondary-blue), var(--primary-blue));
            color: var(--white);
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 1rem;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 80, 158, 0.3);
        }

        .form-success {
            display: none;
            background: #d1fae5;
            color: #065f46;
            padding: 1rem;
            border-radius: var(--radius-sm);
            margin-top: 1rem;
            text-align: center;
        }

        /* ================= FOOTER ================= */
        .footer {
            background: linear-gradient(135deg, var(--dark-blue), var(--primary-blue));
            color: var(--white);
            padding: 4rem 0 2rem;
            margin-top: 4rem;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 3rem;
        }

        .footer-column {
            padding: 1rem;
        }

        .footer-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 1.5rem;
        }

        .footer-logo-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-yellow);
        }

        .footer-logo-text h3 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--white);
        }

        .footer-logo-text p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
        }

        .footer-column h4 {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--accent-yellow);
            position: relative;
            padding-bottom: 10px;
        }

        .footer-column h4::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--accent-yellow);
            border-radius: 2px;
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
        }

        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        /* ================= RESPONSIVE DESIGN ================= */
        @media (max-width: 992px) {
            .contact-header h1 {
                font-size: 2.5rem;
            }
            
            .contact-form-section {
                padding: 2rem;
            }
        }

        @media (max-width: 768px) {
            .navbar-custom {
                padding: 0.8rem 1rem;
            }
            
            .contact-container {
                padding: 2rem 1rem;
            }
            
            .contact-grid {
                grid-template-columns: 1fr;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .contact-card {
                padding: 2rem;
            }
            
            .footer-container {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .footer-column h4::after {
                left: 50%;
                transform: translateX(-50%);
            }
            
            .footer-links a:hover {
                transform: none;
            }
        }

        @media (max-width: 576px) {
            .contact-header h1 {
                font-size: 2rem;
            }
            
            .contact-form-section {
                padding: 1.5rem;
            }
            
            .submit-btn {
                width: 100%;
                justify-content: center;
            }
            
            .contact-btn {
                width: 100%;
                justify-content: center;
            }
        }
		
    </style>
</head>

<body>
	<body class="container-fluid px-2 px-md-0">

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
                        <a class="nav-link" href="${pageContext.request.contextPath}/student-dashboard">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
					<li class="nav-item">
						                    <a class="nav-link" href="${pageContext.request.contextPath}/student-course">
						                        <i class="fas fa-book"></i> My Courses
						                    </a>
						                </li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/studenttestscore"><i class="fas fa-chart-line"></i> My Results</a></li>

                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/certificateF1">
                            <i class="fas fa-award"></i> Certificate
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/contact">
                            <i class="fas fa-envelope"></i> Contact Us
                        </a>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/student-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>

                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- ================= CONTACT SECTION ================= -->
    <main class="contact-container">
        <header class="contact-header">
            <h1>Get in Touch With Us</h1>
            <p>We're here to help! Reach out through any of these channels or send us a message directly.</p>
        </header>

        <div class="contact-grid">
            <!-- WhatsApp Card -->
            <div class="contact-card">
                <div class="contact-icon">
                    <i class="fab fa-whatsapp"></i>
                </div>
                <h3>WhatsApp Support</h3>
                <p>Quick chat support available 24/7 for instant assistance with your queries.</p>
                <a href="https://wa.me/919876543210" class="contact-btn" target="_blank">
                    <i class="fab fa-whatsapp"></i> Chat Now
                </a>
            </div>

            <!-- Phone Card -->
            <div class="contact-card">
                <div class="contact-icon">
                    <i class="fas fa-phone"></i>
                </div>
                <h3>Call Us</h3>
                <p>Speak directly with our support team during business hours (9 AM - 6 PM).</p>
                <a href="tel:+919876543210" class="contact-btn">
                    <i class="fas fa-phone"></i> +91 98765 43210
                </a>
            </div>

            <!-- Email Card -->
            <div class="contact-card">
                <div class="contact-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <h3>Email Support</h3>
                <p>Send detailed queries. We respond within 24 hours on business days.</p>
                <a href="mailto:support@eduera.com" class="contact-btn">
                    <i class="fas fa-envelope"></i> support@SmartClass.com
                </a>
            </div>
        </div>

       
    </main>

    <!-- ================= FOOTER ================= -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-column">
                <div class="footer-logo">
                    <img src="${pageContext.request.contextPath}/images/logo2.jpeg" class="footer-logo-img" alt="EduEra Logo">
                    <div class="footer-logo-text">
                        <h3>SmartClass</h3>
                        <p>Learn. Grow. Succeed.</p>
                    </div>
                </div>
                <p>Providing high-quality courses, notes, and lectures to help students grow in the world of technology.</p>
            </div>

            <div class="footer-column">
                <h4>Quick Links</h4>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/student-dashboard"><i class="fas fa-home"></i> Home</a>
                    <a href="${pageContext.request.contextPath}/courses"><i class="fas fa-book"></i> Courses</a>
                    <a href="${pageContext.request.contextPath}/notes"><i class="fas fa-sticky-note"></i> Notes</a>
                    <a href="${pageContext.request.contextPath}/certificateF1"><i class="fas fa-award"></i> Certificate</a>
                    <a href="${pageContext.request.contextPath}/exam"><i class="fas fa-file-alt"></i> Examination</a>
                </div>
            </div>

            <div class="footer-column">
                <h4>Contact Info</h4>
                <div class="footer-links">
                    <a href="mailto:support@eduera.com"><i class="fas fa-envelope"></i> support@SmartClass.com</a>
                    <a href="tel:+919876543210"><i class="fas fa-phone"></i> +91 98765 43210</a>
                    <a href="#"><i class="fas fa-map-marker-alt"></i> Mumbai, India</a>
                </div>
            </div>

          
        </div>

        <div class="footer-bottom">
            © 2025 SmartClass • Made with <i class="fas fa-heart" style="color: #ff6b6b;"></i> for Students
        </div>
    </footer>

    <!-- ================= JAVASCRIPT ================= -->
    <script>
        // Contact form submission
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form values
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const subject = document.getElementById('subject').value.trim();
            const message = document.getElementById('message').value.trim();
            
            // Validate form
            if (!name || !email || !subject || !message) {
                showAlert('Please fill in all required fields.', 'error');
                return;
            }
            
            if (!validateEmail(email)) {
                showAlert('Please enter a valid email address.', 'error');
                return;
            }
            
            // Show loading state
            const submitBtn = document.querySelector('.submit-btn');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
            submitBtn.disabled = true;
            
            // Simulate API call (replace with actual API call)
            setTimeout(function() {
                // Store form data (in real app, send to server)
                const formData = {
                    name: name,
                    email: email,
                    subject: subject,
                    message: message,
                    timestamp: new Date().toISOString()
                };
                
                // Store in localStorage for demo
                localStorage.setItem('lastContactMessage', JSON.stringify(formData));
                
                // Show success message
                document.getElementById('successMessage').style.display = 'block';
                showAlert('Message sent successfully! We\'ll get back to you soon.', 'success');
                
                // Reset form
                document.getElementById('contactForm').reset();
                
                // Reset button
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
                
                // Hide success message after 5 seconds
                setTimeout(function() {
                    document.getElementById('successMessage').style.display = 'none';
                }, 5000);
                
                // Scroll to top of form
                document.querySelector('.contact-form-section').scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }, 1500);
        });
        
        // Email validation
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }
        
        // Alert function
        function showAlert(message, type) {
            // Create alert element
            const alertDiv = document.createElement('div');
            const alertClass = type === 'error' ? 'danger' : 'success';
            const alertTitle = type === 'error' ? 'Error!' : 'Success!';
            alertDiv.className = 'alert alert-' + alertClass + ' alert-dismissible fade show';
            alertDiv.style.cssText = 'position: fixed; top: 80px; right: 20px; z-index: 9999; min-width: 300px; max-width: 400px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); border-radius: 8px; padding: 1rem;';
            
            alertDiv.innerHTML = '<strong>' + alertTitle + '</strong> ' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            
            // Add to body
            document.body.appendChild(alertDiv);
            
            // Auto remove after 5 seconds
            setTimeout(function() {
                if (alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
            
            // Close button functionality
            alertDiv.querySelector('.btn-close').addEventListener('click', function() {
                alertDiv.remove();
            });
        }
        
        // Contact buttons functionality
        document.querySelectorAll('.contact-btn').forEach(function(btn) {
            btn.addEventListener('click', function(e) {
                const contactType = this.querySelector('i').className;
                
                // Track contact click (analytics simulation)
                const contactData = {
                    type: contactType.includes('whatsapp') ? 'whatsapp' : 
                          contactType.includes('phone') ? 'phone' : 'email',
                    time: new Date().toISOString(),
                    url: this.href
                };
                
                console.log('Contact attempt:', contactData);
                // In real app, send to analytics
            });
        });
        
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation to contact cards
            const contactCards = document.querySelectorAll('.contact-card');
            contactCards.forEach(function(card, index) {
                card.style.animationDelay = (index * 0.1) + 's';
            });
            
            // Add keyboard navigation
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') {
                    // Close any open alerts
                    document.querySelectorAll('.alert').forEach(function(alert) {
                        alert.remove();
                    });
                }
            });
            
            // Form validation on input
            document.querySelectorAll('.form-control').forEach(function(input) {
                input.addEventListener('input', function() {
                    if (this.value.trim() !== '') {
                        this.style.borderColor = '#cbd5e1';
                    }
                });
            });
        });
    </script>
</body>
</html>