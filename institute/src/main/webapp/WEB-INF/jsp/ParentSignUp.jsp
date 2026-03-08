<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Parent Registration | SmartClass</title>
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
            --shadow-sm: 0 4px 10px rgba(90, 61, 110, 0.08);
            --radius: 16px;
            --radius-sm: 10px;
            --transition: all 0.3s ease;
            
            /* Status colors */
            --success: #4caf50;
            --error: #f44336;
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: var(--text-dark);
        }

        .container {
            width: 100%;
            max-width: 520px;
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 2px solid var(--light-purple);
            transition: var(--transition);
        }

        .header {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            color: var(--white);
            padding: 25px 30px;
            text-align: center;
            position: relative;
            border-bottom: 4px solid var(--accent-gold);
        }

        .header h1 {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }

        .header p {
            font-size: 15px;
            opacity: 0.95;
            font-weight: 400;
            color: var(--extra-light-purple);
        }

        .header-icon {
            position: absolute;
            top: 20px;
            right: 25px;
            background: rgba(255, 255, 255, 0.2);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            border: 2px solid var(--accent-gold);
        }

        .form-container {
            padding: 35px 30px;
            background: var(--white);
        }

        .note-box {
            background: var(--extra-light-purple);
            border-left: 4px solid var(--accent-gold);
            padding: 18px;
            border-radius: var(--radius-sm);
            margin-bottom: 30px;
            display: flex;
            align-items: flex-start;
            border: 2px solid var(--light-purple);
        }

        .note-icon {
            color: var(--accent-gold);
            margin-right: 12px;
            font-size: 20px;
            margin-top: 2px;
        }

        .note-box p {
            color: var(--text-light);
            font-size: 15px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 22px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 15px;
        }

        label i {
            color: var(--accent-gold);
            margin-right: 8px;
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent-gold);
            font-size: 18px;
            z-index: 2;
        }

        input {
            width: 100%;
            padding: 16px 16px 16px 50px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            font-size: 16px;
            transition: var(--transition);
            background-color: var(--white);
            color: var(--text-dark);
        }

        input:focus {
            outline: none;
            border-color: var(--soft-purple);
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        input::placeholder {
            color: var(--text-muted);
            opacity: 0.6;
        }

        input:read-only {
            background-color: var(--extra-light-purple);
            cursor: not-allowed;
            color: var(--text-muted);
        }

        .course-preview {
            background: var(--extra-light-purple);
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            padding: 15px;
            margin-top: 5px;
        }

        .course-preview h4 {
            color: var(--royal-purple);
            margin-bottom: 10px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .course-preview h4 i {
            color: var(--accent-gold);
        }

        .course-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .course-badge {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 500;
            border: 2px solid var(--accent-gold);
        }

        .loading {
            display: none;
            color: var(--royal-purple);
            font-size: 14px;
            margin-top: 5px;
            padding: 8px;
            background: var(--extra-light-purple);
            border-radius: var(--radius-sm);
            border: 2px solid var(--light-purple);
        }

        .loading i {
            margin-right: 8px;
            color: var(--accent-gold);
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .error-message {
            color: var(--error);
            font-size: 14px;
            margin-top: 8px;
            display: flex;
            align-items: center;
            background: rgba(244, 67, 54, 0.1);
            padding: 10px;
            border-radius: var(--radius-sm);
            display: none;
            border-left: 4px solid var(--error);
        }

        .error-message i {
            margin-right: 8px;
            font-size: 16px;
            color: var(--error);
        }

        .success-message {
            color: var(--success);
            font-size: 14px;
            margin-top: 5px;
            display: none;
            padding-left: 5px;
        }

        /* Password toggle */
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--soft-purple);
            cursor: pointer;
            font-size: 18px;
            z-index: 2;
            transition: var(--transition);
        }

        .password-toggle:hover {
            color: var(--accent-gold);
        }

        .btn {
            width: 100%;
            padding: 18px;
            background: var(--accent-gold);
            color: var(--dark-purple);
            border: none;
            border-radius: 50px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: var(--transition);
            margin-top: 10px;
            border: 2px solid transparent;
        }

        .btn:hover {
            background: transparent;
            border-color: var(--accent-gold);
            color: var(--accent-gold);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn i {
            margin-left: 10px;
            font-size: 18px;
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
            background: var(--light-purple);
            color: var(--text-muted);
            border-color: var(--light-purple);
        }

        .btn:disabled:hover {
            background: var(--light-purple);
            color: var(--text-muted);
            transform: none;
            box-shadow: none;
        }

        .footer {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: var(--text-muted);
        }

        .footer a {
            color: var(--royal-purple);
            text-decoration: none;
            font-weight: 600;
            padding: 3px 8px;
            border-radius: 20px;
            transition: var(--transition);
        }

        .footer a:hover {
            color: var(--accent-gold);
            background: var(--extra-light-purple);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                max-width: 95%;
            }
            
            .form-container {
                padding: 25px 20px;
            }
            
            .header {
                padding: 20px;
            }
            
            .header h1 {
                font-size: 22px;
            }
            
            input {
                padding: 14px 14px 14px 45px;
                font-size: 15px;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 10px;
            }
            
            .container {
                border-radius: var(--radius-sm);
            }
            
            .header h1 {
                font-size: 20px;
            }
            
            .header p {
                font-size: 14px;
            }
            
            .header-icon {
                width: 40px;
                height: 40px;
                font-size: 18px;
                top: 15px;
                right: 15px;
            }
            
            .form-container {
                padding: 20px 15px;
            }
            
            .note-box {
                padding: 15px;
                flex-direction: column;
                text-align: center;
            }
            
            .note-icon {
                margin-right: 0;
                margin-bottom: 10px;
            }
            
            .btn {
                padding: 16px;
                font-size: 16px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .password-toggle:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-user-plus"></i> Parent Registration</h1>
            <p>Create your parent account to connect with your child's education</p>
            <div class="header-icon">
                <i class="fas fa-graduation-cap"></i>
            </div>
        </div>
        
        <div class="form-container">
            <div class="note-box">
                <div class="note-icon">
                    <i class="fas fa-info-circle"></i>
                </div>
                <p>Enter your child's Student ID. Their enrolled courses will be automatically linked to your account.</p>
            </div>
            
            <!-- Display error message if any -->
            <c:if test="${not empty error}">
                <div class="error-message" style="display: flex; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>
            
            <form id="signupForm" action="${pageContext.request.contextPath}/parent/signup" method="post">
                <div class="form-group">
                    <label for="fullName"><i class="fas fa-user"></i> Parent Full Name *</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user"></i>
                        <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email Address *</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="mobileNumber"><i class="fas fa-phone"></i> Mobile Number *</label>
                    <div class="input-with-icon">
                        <i class="fas fa-phone"></i>
                        <input type="tel" id="mobileNumber" name="mobileNumber" placeholder="Enter your mobile number" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="studentId"><i class="fas fa-id-card"></i> Student ID *</label>
                    <div class="input-with-icon">
                        <i class="fas fa-id-card"></i>
                        <input type="text" id="studentId" name="studentId" placeholder="Enter your child's Student ID" required>
                    </div>
                    <div class="loading" id="loadingCourses">
                        <i class="fas fa-spinner"></i> Fetching student courses...
                    </div>
                    <div class="error-message" id="studentError"></div>
                </div>
                
                <!-- Courses Preview (Hidden initially) -->
                <div class="course-preview" id="coursePreview" style="display: none;">
                    <h4><i class="fas fa-book-open"></i> Child's Enrolled Courses:</h4>
                    <div class="course-badges" id="courseBadges"></div>
                    <input type="hidden" name="courses" id="coursesInput">
                </div>
                
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Create Password *</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Create a strong password (min. 8 characters)" required minlength="8">
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword"><i class="fas fa-lock"></i> Confirm Password *</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Retype your password" required minlength="8">
                        <button type="button" class="password-toggle" id="toggleConfirmPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div id="errorText" class="error-message">
                    <i class="fas fa-exclamation-circle"></i> <span id="errorMessage"></span>
                </div>
                
                <button type="submit" class="btn" id="submitBtn" disabled>
                    Create Account <i class="fas fa-arrow-right"></i>
                </button>
                
                <div class="footer">
                    Already have an account? <a href="${pageContext.request.contextPath}/parents/login">Sign In</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('signupForm');
            const errorText = document.getElementById('errorText');
            const errorMessage = document.getElementById('errorMessage');
            const togglePassword = document.getElementById('togglePassword');
            const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const studentIdInput = document.getElementById('studentId');
            const loadingCourses = document.getElementById('loadingCourses');
            const coursePreview = document.getElementById('coursePreview');
            const courseBadges = document.getElementById('courseBadges');
            const coursesInput = document.getElementById('coursesInput');
            const studentError = document.getElementById('studentError');
            const submitBtn = document.getElementById('submitBtn');
            
            let studentIdTimeout;
            let validatedStudentId = null;
            
            // Toggle password visibility
            if (togglePassword && passwordInput) {
                togglePassword.addEventListener('click', function() {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
                });
            }
            
            if (toggleConfirmPassword && confirmPasswordInput) {
                toggleConfirmPassword.addEventListener('click', function() {
                    const type = confirmPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    confirmPasswordInput.setAttribute('type', type);
                    this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
                });
            }
            
            // Fetch student courses when student ID loses focus
            studentIdInput.addEventListener('blur', function() {
                const studentId = this.value.trim();
                
                if (studentId.length === 0) {
                    return;
                }
                
                // Clear previous timeout
                if (studentIdTimeout) {
                    clearTimeout(studentIdTimeout);
                }
                
                // Show loading
                loadingCourses.style.display = 'block';
                coursePreview.style.display = 'none';
                studentError.style.display = 'none';
                validatedStudentId = null;
                submitBtn.disabled = true;
                
                // Set timeout to avoid too many requests
                studentIdTimeout = setTimeout(function() {
                    fetch('${pageContext.request.contextPath}/student/courses/' + encodeURIComponent(studentId))
                        .then(response => response.json())
                        .then(data => {
                            loadingCourses.style.display = 'none';
                            
                            if (data.success) {
                                if (data.courses && data.courses.length > 0) {
                                    // Display courses
                                    courseBadges.innerHTML = '';
                                    data.courses.forEach(course => {
                                        const badge = document.createElement('span');
                                        badge.className = 'course-badge';
                                        badge.textContent = course;
                                        courseBadges.appendChild(badge);
                                    });
                                    
                                    // Set hidden input value
                                    coursesInput.value = JSON.stringify(data.courses);
                                    
                                    // Show preview
                                    coursePreview.style.display = 'block';
                                    validatedStudentId = studentId;
                                    
                                    // Enable submit button if other validations pass
                                    validateForm();
                                } else {
                                    studentError.innerHTML = '<i class="fas fa-exclamation-circle"></i> This student has no enrolled courses';
                                    studentError.style.display = 'flex';
                                    submitBtn.disabled = true;
                                }
                            } else {
                                studentError.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + data.message;
                                studentError.style.display = 'flex';
                                submitBtn.disabled = true;
                            }
                        })
                        .catch(error => {
                            loadingCourses.style.display = 'none';
                            studentError.innerHTML = '<i class="fas fa-exclamation-circle"></i> Error fetching student data';
                            studentError.style.display = 'flex';
                            submitBtn.disabled = true;
                            console.error('Error:', error);
                        });
                }, 500);
            });
            
            // Real-time password validation
            function validatePasswords() {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                
                if (errorText) {
                    errorText.style.display = 'none';
                }
                
                if (password && confirmPassword && password !== confirmPassword) {
                    errorMessage.textContent = "Passwords do not match!";
                    errorText.style.display = 'flex';
                    return false;
                }
                
                if (password && password.length < 8) {
                    errorMessage.textContent = "Password should be at least 8 characters long";
                    errorText.style.display = 'flex';
                    return false;
                }
                
                return true;
            }
            
            function validateForm() {
                const passwordValid = validatePasswords();
                const studentValid = validatedStudentId !== null;
                
                submitBtn.disabled = !(passwordValid && studentValid);
            }
            
            passwordInput.addEventListener('input', validateForm);
            confirmPasswordInput.addEventListener('input', validateForm);
            
            // Mobile number validation (optional - can add if needed)
            const mobileInput = document.getElementById('mobileNumber');
            if (mobileInput) {
                mobileInput.addEventListener('input', function() {
                    this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);
                });
            }
            
            // Form submission
            if (form) {
                form.addEventListener('submit', function(event) {
                    if (!validatedStudentId) {
                        event.preventDefault();
                        studentError.innerHTML = '<i class="fas fa-exclamation-circle"></i> Please enter a valid student ID';
                        studentError.style.display = 'flex';
                        return;
                    }
                    
                    if (!validatePasswords()) {
                        event.preventDefault();
                        return;
                    }
                });
            }
            
            // Touch feedback for mobile
            const touchElements = document.querySelectorAll('.btn, .password-toggle');
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