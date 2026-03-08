<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Student Signup | SmartClass</title>
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
        }

        .container {
            width: 100%;
            max-width: 600px;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        .header {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            color: var(--white);
            padding: 30px;
            text-align: center;
            border-bottom: 4px solid var(--accent-gold);
        }

        .logo-area {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .logo-img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--accent-gold);
            padding: 3px;
            background: var(--white);
        }

        .header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        .header p {
            font-size: 15px;
            opacity: 0.95;
            color: var(--extra-light-purple);
        }

        .form-container {
            padding: 35px 40px;
            max-height: 600px;
            overflow-y: auto;
            background: var(--white);
        }

        .form-group {
            margin-bottom: 22px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 8px;
            font-size: 15px;
        }

        .form-group label i {
            color: var(--accent-gold);
            margin-right: 8px;
        }

        .form-control {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            font-size: 16px;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--soft-purple);
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        .form-control::placeholder {
            color: var(--text-muted);
            opacity: 0.6;
        }

        .error-message {
            color: #f44336;
            font-size: 13px;
            margin-top: 5px;
            display: none;
            padding-left: 5px;
        }

        .success-message {
            color: #4caf50;
            font-size: 13px;
            margin-top: 5px;
            display: none;
            padding-left: 5px;
        }

        /* Courses Container - Multiple Selection */
        .courses-container {
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            padding: 15px;
            max-height: 250px;
            overflow-y: auto;
            background: var(--extra-light-purple);
        }

        .course-category {
            margin-bottom: 15px;
        }

        .course-category-title {
            font-weight: 600;
            color: var(--royal-purple);
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 2px solid var(--light-purple);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .course-category-title i {
            color: var(--accent-gold);
            font-size: 14px;
        }

        .course-checkbox {
            display: inline-flex;
            align-items: center;
            background: var(--white);
            border: 2px solid var(--light-purple);
            border-radius: 30px;
            padding: 8px 15px;
            margin: 5px;
            transition: var(--transition);
            cursor: pointer;
        }

        .course-checkbox:hover {
            background: var(--extra-light-purple);
            border-color: var(--soft-purple);
            transform: translateY(-2px);
        }

        .course-checkbox input[type="checkbox"] {
            margin-right: 8px;
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: var(--accent-gold);
        }

        .course-checkbox label {
            cursor: pointer;
            font-size: 14px;
            color: var(--text-light);
            font-weight: 500;
        }

        .selected-count {
            display: inline-block;
            margin-top: 10px;
            font-size: 14px;
            color: var(--royal-purple);
            font-weight: 600;
            background: var(--extra-light-purple);
            padding: 5px 15px;
            border-radius: 30px;
            border: 2px solid var(--light-purple);
        }

        .btn {
            width: 100%;
            padding: 16px;
            background: var(--accent-gold);
            color: var(--dark-purple);
            border: none;
            border-radius: 50px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
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

        .login-link {
            text-align: center;
            margin-top: 25px;
            color: var(--text-muted);
            font-size: 15px;
        }

        .login-link a {
            color: var(--royal-purple);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            padding: 5px 10px;
            border-radius: 30px;
        }

        .login-link a:hover {
            color: var(--accent-gold);
            background: var(--extra-light-purple);
        }

        .alert {
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            margin-bottom: 20px;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-error {
            background: rgba(244, 67, 54, 0.1);
            color: #f44336;
            border-left: 4px solid #f44336;
        }

        .alert-success {
            background: rgba(76, 175, 80, 0.1);
            color: #4caf50;
            border-left: 4px solid #4caf50;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                max-width: 100%;
            }
            
            .form-container {
                padding: 25px 20px;
            }
            
            .header {
                padding: 25px;
            }
            
            .header h1 {
                font-size: 24px;
            }
        }

        @media (max-width: 576px) {
            .header {
                padding: 20px;
            }
            
            .logo-img {
                width: 60px;
                height: 60px;
            }
            
            .header h1 {
                font-size: 22px;
            }
            
            .header p {
                font-size: 14px;
            }
            
            .form-container {
                padding: 20px 15px;
            }
            
            .form-control {
                padding: 12px 15px;
                font-size: 15px;
            }
            
            .btn {
                padding: 14px;
                font-size: 16px;
            }
            
            .course-checkbox {
                width: 100%;
                margin: 5px 0;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .course-checkbox:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo-area">
                <img src="${pageContext.request.contextPath}/images/logo2.jpeg" alt="SmartClass Logo" class="logo-img">
            </div>
            <h1><i class="fas fa-user-graduate"></i> Student Registration</h1>
            <p>Join thousands of students learning with SmartClass</p>
        </div>

        <div class="form-container">
            <!-- Display messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <form id="signupForm" action="${pageContext.request.contextPath}/student/signup" method="post">
                <div class="form-group">
                    <label for="fullName"><i class="fas fa-user"></i> Full Name *</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" 
                           placeholder="Enter your full name" required
                           value="${student.fullName != null ? student.fullName : ''}">
                </div>

                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email Address *</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           placeholder="Enter your email address" required
                           value="${student.email != null ? student.email : ''}">
                    <div id="emailError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="mobile"><i class="fas fa-phone"></i> Mobile Number *</label>
                    <input type="tel" id="mobile" name="mobile" class="form-control" 
                           placeholder="Enter your mobile number" required
                           value="${student.mobile != null ? student.mobile : ''}">
                    <div id="mobileError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="courses"><i class="fas fa-book-open"></i> Select Courses (Multiple) *</label>
                    <div class="courses-container" id="coursesContainer">
                        <!-- Programming Languages -->
                        <div class="course-category">
                            <div class="course-category-title"><i class="fas fa-code"></i> Programming Languages</div>
                            <div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="C Programming" id="courseC">
                                    <label for="courseC">C Programming</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="C++ Programming" id="courseCpp">
                                    <label for="courseCpp">C++ Programming</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Java Programming" id="courseJava">
                                    <label for="courseJava">Java Programming</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Python Programming" id="coursePython">
                                    <label for="coursePython">Python Programming</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="JavaScript" id="courseJS">
                                    <label for="courseJS">JavaScript</label>
                                </div>
                            </div>
                        </div>

                        <!-- Development -->
                        <div class="course-category">
                            <div class="course-category-title"><i class="fas fa-laptop-code"></i> Development</div>
                            <div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Full Stack Development" id="courseFullStack">
                                    <label for="courseFullStack">Full Stack Development</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Android Development" id="courseAndroid">
                                    <label for="courseAndroid">Android Development</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Software Engineering" id="courseSE">
                                    <label for="courseSE">Software Engineering</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Git & GitHub" id="courseGit">
                                    <label for="courseGit">Git & GitHub</label>
                                </div>
                            </div>
                        </div>

                        <!-- Computer Science Fundamentals -->
                        <div class="course-category">
                            <div class="course-category-title"><i class="fas fa-microchip"></i> Computer Science Fundamentals</div>
                            <div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Data Structures & Algorithms" id="courseDSA">
                                    <label for="courseDSA">Data Structures & Algorithms</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Operating Systems" id="courseOS">
                                    <label for="courseOS">Operating Systems</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="DBMS" id="courseDBMS">
                                    <label for="courseDBMS">DBMS</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Computer Networks" id="courseCN">
                                    <label for="courseCN">Computer Networks</label>
                                </div>
                            </div>
                        </div>

                        <!-- Advanced Technologies -->
                        <div class="course-category">
                            <div class="course-category-title"><i class="fas fa-robot"></i> Advanced Technologies</div>
                            <div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Artificial Intelligence" id="courseAI">
                                    <label for="courseAI">Artificial Intelligence</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Cloud Computing" id="courseCloud">
                                    <label for="courseCloud">Cloud Computing</label>
                                </div>
                                <div class="course-checkbox">
                                    <input type="checkbox" name="courses" value="Cyber Security & Ethical Hacking" id="courseCyber">
                                    <label for="courseCyber">Cyber Security & Ethical Hacking</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="selected-count" id="selectedCount">0 courses selected</div>
                    <div class="error-message" id="coursesError">Please select at least one course</div>
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Create Password *</label>
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Create a strong password (min. 6 characters)" required minlength="6">
                </div>

                <div class="form-group">
                    <label for="confirmPassword"><i class="fas fa-lock"></i> Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                           placeholder="Re-enter your password" required>
                    <div id="passwordMatch" class="error-message"></div>
                </div>

                <button type="submit" class="btn"><i class="fas fa-user-plus"></i> Create Account</button>
            </form>

            <div class="login-link">
                Already have an account? <a href="${pageContext.request.contextPath}/student-login">Login here</a>
            </div>
        </div>
    </div>

    <script>
        // Get all course checkboxes
        const courseCheckboxes = document.querySelectorAll('input[name="courses"]');
        const selectedCountDiv = document.getElementById('selectedCount');
        
        // Update selected count
        function updateSelectedCount() {
            const checked = document.querySelectorAll('input[name="courses"]:checked');
            selectedCountDiv.textContent = checked.length + ' course(s) selected';
        }
        
        // Add event listeners to checkboxes
        courseCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateSelectedCount);
        });

        // Form validation
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const selectedCourses = document.querySelectorAll('input[name="courses"]:checked');
            
            // Check if at least one course is selected
            if (selectedCourses.length === 0) {
                e.preventDefault();
                document.getElementById('coursesError').textContent = "Please select at least one course";
                document.getElementById('coursesError').style.display = 'block';
                return false;
            } else {
                document.getElementById('coursesError').style.display = 'none';
            }
            
            // Check password match
            if (password !== confirmPassword) {
                e.preventDefault();
                document.getElementById('passwordMatch').textContent = "Passwords do not match";
                document.getElementById('passwordMatch').style.color = '#f44336';
                document.getElementById('passwordMatch').style.display = 'block';
                return false;
            } else {
                document.getElementById('passwordMatch').style.display = 'none';
            }
            
            // Check password length
            if (password.length < 6) {
                e.preventDefault();
                alert("Password must be at least 6 characters long.");
                return false;
            }
            
            return true;
        });

        // Email validation
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }

        // Mobile validation
        function validateMobile(mobile) {
            const re = /^[0-9]{10}$/;
            return re.test(mobile);
        }

        // Real-time password match check
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            const matchDiv = document.getElementById('passwordMatch');
            
            if (confirmPassword.length === 0) {
                matchDiv.style.display = 'none';
                return;
            }
            
            if (password === confirmPassword) {
                matchDiv.textContent = '✓ Passwords match';
                matchDiv.style.color = '#4caf50';
                matchDiv.style.display = 'block';
            } else {
                matchDiv.textContent = '✗ Passwords do not match';
                matchDiv.style.color = '#f44336';
                matchDiv.style.display = 'block';
            }
        });

        // Real-time email validation
        document.getElementById('email').addEventListener('blur', function() {
            const email = this.value;
            const emailError = document.getElementById('emailError');
            
            if (email && !validateEmail(email)) {
                emailError.textContent = 'Please enter a valid email address';
                emailError.style.color = '#f44336';
                emailError.style.display = 'block';
            } else {
                emailError.style.display = 'none';
            }
        });

        // Real-time mobile validation
        document.getElementById('mobile').addEventListener('blur', function() {
            const mobile = this.value;
            const mobileError = document.getElementById('mobileError');
            
            if (mobile && !validateMobile(mobile)) {
                mobileError.textContent = 'Please enter a valid 10-digit mobile number';
                mobileError.style.color = '#f44336';
                mobileError.style.display = 'block';
            } else {
                mobileError.style.display = 'none';
            }
        });
    </script>
</body>
</html>