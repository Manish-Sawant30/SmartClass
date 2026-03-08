<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate Verification | EduEra</title>
    
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

        /* Navbar styles */
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

        /* Form Container */
        .form-container {
            width: 90%;
            max-width: 550px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .certificate-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 2.5rem;
            box-shadow: var(--shadow);
            border-top: 5px solid var(--secondary-blue);
            position: relative;
            overflow: hidden;
        }

        .certificate-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary-blue), var(--secondary-blue));
        }

        .certificate-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .certificate-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--secondary-blue), var(--primary-blue));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--white);
            font-size: 2rem;
        }

        .certificate-header h2 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-blue);
            margin-bottom: 0.5rem;
        }

        .certificate-header p {
            color: #666;
            font-size: 1rem;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--primary-blue);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 0.9rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--white);
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: var(--secondary-blue);
            box-shadow: 0 0 0 3px rgba(0, 80, 158, 0.1);
        }

        .form-select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23002b5c' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 16px;
        }

        .error-input {
            border-color: #ef4444;
        }

        .error-message {
            color: #ef4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .submit-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--secondary-blue), var(--primary-blue));
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 1rem;
        }

        .submit-btn:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .submit-btn:hover:not(:disabled) {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 80, 158, 0.3);
        }

        /* Alert Styles */
        .alert-custom {
            position: fixed;
            top: 100px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            max-width: 400px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            border-radius: 8px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* Info Box */
        .info-box {
            background: #f0f9ff;
            border-left: 4px solid var(--secondary-blue);
            padding: 1rem;
            border-radius: 6px;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: #475569;
        }

        .info-box i {
            color: var(--secondary-blue);
            margin-right: 8px;
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-spinner {
            text-align: center;
        }

        .loading-spinner i {
            font-size: 3rem;
            color: var(--primary-blue);
            margin-bottom: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .certificate-card {
                padding: 2rem 1.5rem;
            }
            
            .certificate-header h2 {
                font-size: 1.8rem;
            }
            
            .form-container {
                margin: 40px auto;
            }
            
            .alert-custom {
                left: 20px;
                right: 20px;
                max-width: none;
            }
        }
    </style>
</head>

<body>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner">
            <i class="fas fa-spinner fa-spin"></i>
            <h4>Verifying credentials...</h4>
        </div>
    </div>

    <!-- Navigation Bar -->
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
										<li class="nav-item">
											                    <a class="nav-link" href="${pageContext.request.contextPath}/studenttestscore">
											                        <i class="fas fa-chart-line"></i> My Results
											                    </a>
											                </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/certificate/verify">
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

    <!-- Certificate Verification Form -->
    <div class="form-container">
        <div class="certificate-card">
            <div class="certificate-header">
                <div class="certificate-icon">
                    <i class="fas fa-award"></i>
                </div>
                <h2>Certificate Verification</h2>
                <p>Enter your credentials to access your certificate</p>
            </div>

            <!-- Step 1: Login Form -->
            <form id="loginForm" onsubmit="verifyCredentials(event)">
                <div class="form-group">
                    <label class="form-label" for="studentId">
                        <i class="fas fa-user-graduate"></i> Student ID
                    </label>
                    <input type="text" id="studentId" name="studentId" class="form-input" 
                           placeholder="Enter your Student ID" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <input type="password" id="password" name="password" class="form-input" 
                           placeholder="Enter your password" required>
                </div>

                <div id="loginError" class="alert alert-danger" style="display: none;"></div>

                <button type="submit" class="submit-btn" id="verifyBtn">
                    <i class="fas fa-check-circle"></i> Verify Credentials
                </button>
            </form>

            <!-- Step 2: Course Selection (Hidden initially) -->
            <div id="courseSelection" style="display: none;">
                <hr class="my-4">
                <h5 class="text-center mb-3">Select Course for Certificate</h5>
                
                <form id="certificateForm" action="${pageContext.request.contextPath}/certificate/verify" method="POST">
                    <input type="hidden" id="verifiedStudentId" name="studentId">
                    <input type="hidden" id="verifiedPassword" name="password">
                    
                    <div class="form-group">
                        <label class="form-label" for="courseName">
                            <i class="fas fa-book-open"></i> Select Course
                        </label>
                        <select class="form-select" id="courseName" name="courseName" required>
                            <option value="">-- Choose a course --</option>
                        </select>
                    </div>

                    <div id="eligibilityMessage" class="alert alert-info" style="display: none;"></div>
                    <div id="courseError" class="alert alert-danger" style="display: none;"></div>

                    <button type="submit" class="submit-btn" id="getCertificateBtn">
                        <i class="fas fa-award"></i> Get Certificate
                    </button>
                    
                    <button type="button" class="btn btn-link mt-2" onclick="backToLogin()">
                        <i class="fas fa-arrow-left"></i> Back to Login
                    </button>
                </form>
            </div>

            <!-- Error Display from Server -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="info-box mt-3">
                <i class="fas fa-info-circle"></i>
                <span>Note: Only active students who have passed all tests (50%+) are eligible for certificates</span>
            </div>

            <div class="text-center mt-3">
                <small class="text-muted">
                    <i class="fas fa-shield-alt me-1"></i>
                    Your credentials are securely verified
                </small>
            </div>
        </div>
    </div>

	<script>
	    const API_BASE = '${pageContext.request.contextPath}';
	    
	    // Show/hide loading overlay
	    function showLoading() {
	        document.getElementById('loadingOverlay').style.display = 'flex';
	    }
	    
	    function hideLoading() {
	        document.getElementById('loadingOverlay').style.display = 'none';
	    }

	    // Back to login form
	    function backToLogin() {
	        document.getElementById('loginForm').style.display = 'block';
	        document.getElementById('courseSelection').style.display = 'none';
	        document.getElementById('loginError').style.display = 'none';
	        document.getElementById('studentId').value = '';
	        document.getElementById('password').value = '';
	    }

	    // Verify credentials via AJAX
	    async function verifyCredentials(event) {
	        event.preventDefault();
	        
	        const studentId = document.getElementById('studentId').value.trim();
	        const password = document.getElementById('password').value.trim();
	        const loginError = document.getElementById('loginError');
	        
	        if (!studentId || !password) {
	            loginError.textContent = 'Please enter both Student ID and Password';
	            loginError.style.display = 'block';
	            return;
	        }
	        
	        showLoading();
	        loginError.style.display = 'none';
	        
	        try {
	            const response = await fetch(API_BASE + '/certificate/api/student/verify', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify({
	                    studentId: studentId,
	                    password: password
	                })
	            });
	            
	            const data = await response.json();
	            hideLoading();
	            
	            console.log('Verification response:', data);
	            
	            if (data.success) {
	                // Store verified credentials
	                document.getElementById('verifiedStudentId').value = studentId;
	                document.getElementById('verifiedPassword').value = password;
	                
	                // Populate course dropdown
	                const courseSelect = document.getElementById('courseName');
	                courseSelect.innerHTML = '<option value="">-- Choose a course --</option>';
	                
	                if (data.courses && data.courses.length > 0) {
	                    let eligibleFound = false;
	                    
	                    data.courses.forEach(course => {
	                        const option = document.createElement('option');
	                        option.value = course;
	                        
	                        // Check eligibility for this course
	                        const isEligible = data.eligibleCourses && data.eligibleCourses[course];
	                        
	                        if (isEligible) {
	                            option.textContent = course + ' ✓ Eligible';
	                            option.style.fontWeight = 'bold';
	                            option.style.color = '#28a745';
	                            option.setAttribute('data-eligible', 'true');
	                            eligibleFound = true;
	                        } else {
	                            option.textContent = course + ' (Not Eligible)';
	                            option.style.color = '#999';
	                            option.setAttribute('data-eligible', 'false');
	                        }
	                        
	                        courseSelect.appendChild(option);
	                    });
	                    
	                    // Show eligibility summary
	                    const eligibleCount = data.eligibleCount || 0;
	                    const totalCourses = data.courses.length;
	                    
	                    const eligibilityMsg = document.getElementById('eligibilityMessage');
	                    
	                    if (eligibleCount > 0) {
	                        eligibilityMsg.innerHTML = 
	                            '<i class="fas fa-check-circle me-2" style="color: #28a745;"></i>' +
	                            'You are eligible for <strong>' + eligibleCount + '</strong> out of ' + totalCourses + ' courses. ' +
	                            'Select a course to view your certificate.';
	                        eligibilityMsg.className = 'alert alert-success';
	                        eligibilityMsg.style.display = 'block';
	                        
	                        // Enable the submit button
	                        document.getElementById('getCertificateBtn').disabled = false;
	                    } else {
	                        eligibilityMsg.innerHTML = 
	                            '<i class="fas fa-exclamation-triangle me-2" style="color: #ffc107;"></i>' +
	                            'You are not eligible for any certificates yet. ' +
	                            'You need to pass all unit tests (50%+) AND the final test (50%+) in a course.';
	                        eligibilityMsg.className = 'alert alert-warning';
	                        eligibilityMsg.style.display = 'block';
	                        
	                        // Disable the submit button
	                        document.getElementById('getCertificateBtn').disabled = true;
	                    }
	                    
	                    document.getElementById('courseError').style.display = 'none';
	                    
	                    // Show course selection
	                    document.getElementById('loginForm').style.display = 'none';
	                    document.getElementById('courseSelection').style.display = 'block';
	                } else {
	                    loginError.textContent = 'No courses found for this student';
	                    loginError.style.display = 'block';
	                }
	                
	            } else {
	                loginError.textContent = data.message || 'Invalid Student ID or Password';
	                loginError.style.display = 'block';
	            }
	            
	        } catch (error) {
	            hideLoading();
	            console.error('Error:', error);
	            loginError.textContent = 'An error occurred. Please try again.';
	            loginError.style.display = 'block';
	        }
	    }

	    // Handle course selection change
	    document.getElementById('courseName').addEventListener('change', function() {
	        const selectedOption = this.options[this.selectedIndex];
	        const isEligible = selectedOption.getAttribute('data-eligible') === 'true';
	        const submitBtn = document.getElementById('getCertificateBtn');
	        const courseError = document.getElementById('courseError');
	        
	        if (this.value) {
	            if (!isEligible) {
	                courseError.innerHTML = 
	                    '<i class="fas fa-exclamation-triangle me-2"></i>' +
	                    'You are not eligible for a certificate in this course. ' +
	                    'You need to pass all unit tests (50%+) AND the final test (50%+).';
	                courseError.style.display = 'block';
	                submitBtn.disabled = true;
	            } else {
	                courseError.style.display = 'none';
	                submitBtn.disabled = false;
	            }
	        } else {
	            courseError.style.display = 'none';
	            submitBtn.disabled = true;
	        }
	    });

	    // Auto-focus on student ID field
	    document.addEventListener('DOMContentLoaded', function() {
	        document.getElementById('studentId').focus();
	        
	        // Check if there's an error message from server
	        const errorMsg = '${error}';
	        if (errorMsg) {
	            const loginError = document.getElementById('loginError');
	            loginError.textContent = errorMsg;
	            loginError.style.display = 'block';
	        }
	    });
	</script>
</body>
</html>