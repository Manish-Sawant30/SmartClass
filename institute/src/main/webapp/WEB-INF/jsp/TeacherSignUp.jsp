<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Teacher Registration | SmartClass</title>
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
            max-width: 700px;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        /* Header */
        .form-header {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            padding: 25px 30px;
            text-align: center;
            color: var(--white);
            border-bottom: 4px solid var(--accent-gold);
        }

        .header-content {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 10px;
        }

        .form-icon {
            background: rgba(255, 255, 255, 0.2);
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            border: 2px solid var(--accent-gold);
        }

        .form-title {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .form-subtitle {
            font-size: 15px;
            opacity: 0.95;
            margin-top: 5px;
            color: var(--extra-light-purple);
        }

        /* Form body */
        .form-body {
            padding: 30px;
            max-height: 600px;
            overflow-y: auto;
            background: var(--white);
        }

        /* Form groups */
        .form-group {
            margin-bottom: 22px;
            position: relative;
        }

        .form-label {
            display: block;
            font-size: 15px;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            color: var(--accent-gold);
            width: 20px;
            text-align: center;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
            font-size: 16px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            transition: var(--transition);
            background-color: var(--white);
            color: var(--text-dark);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--soft-purple);
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        .form-input::placeholder {
            color: var(--text-muted);
            opacity: 0.6;
        }

        /* Specializations container */
        .specializations-container {
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            padding: 15px;
            max-height: 300px;
            overflow-y: auto;
            background-color: var(--extra-light-purple);
        }

        .category-section {
            margin-bottom: 20px;
        }

        .category-title {
            font-weight: 600;
            color: var(--royal-purple);
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 2px solid var(--light-purple);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .category-title i {
            color: var(--accent-gold);
            font-size: 14px;
        }

        .specialization-checkbox {
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

        .specialization-checkbox:hover {
            background: var(--extra-light-purple);
            border-color: var(--soft-purple);
            transform: translateY(-2px);
        }

        .specialization-checkbox input[type="checkbox"] {
            margin-right: 8px;
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: var(--accent-gold);
        }

        .specialization-checkbox label {
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

        /* Password toggle */
        .password-container {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--soft-purple);
            cursor: pointer;
            font-size: 18px;
            padding: 5px;
            transition: var(--transition);
        }

        .toggle-password:hover {
            color: var(--accent-gold);
        }

        /* Info box */
        .info-box {
            background: var(--extra-light-purple);
            padding: 18px;
            border-radius: var(--radius-sm);
            border-left: 4px solid var(--accent-gold);
            margin: 25px 0 30px;
            display: flex;
            gap: 12px;
            border: 2px solid var(--light-purple);
        }

        .info-icon {
            color: var(--accent-gold);
            font-size: 20px;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .info-text {
            font-size: 14px;
            color: var(--text-light);
            line-height: 1.5;
        }

        /* Submit button */
        .submit-btn {
            width: 100%;
            background: var(--accent-gold);
            color: var(--dark-purple);
            padding: 16px;
            font-size: 17px;
            font-weight: 700;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            letter-spacing: 0.5px;
            border: 2px solid transparent;
        }

        .submit-btn:hover {
            background: transparent;
            border-color: var(--accent-gold);
            color: var(--accent-gold);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        /* Back link */
        .back-link {
            text-align: center;
            margin-top: 25px;
        }

        .back-link a {
            color: var(--royal-purple);
            text-decoration: none;
            font-size: 15px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition);
            padding: 5px 15px;
            border-radius: 30px;
        }

        .back-link a:hover {
            color: var(--accent-gold);
            background: var(--extra-light-purple);
        }

        /* Error messages */
        .error-message {
            color: #f44336;
            font-size: 13px;
            margin-top: 5px;
            display: none;
            padding-left: 5px;
        }

        .form-input.error {
            border-color: #f44336;
        }

        .form-input.success {
            border-color: #4caf50;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                max-width: 100%;
            }
            
            .form-header {
                padding: 20px 25px;
            }
            
            .form-body {
                padding: 25px 20px;
            }
            
            .form-title {
                font-size: 24px;
            }
            
            .form-icon {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
        }

        @media (max-width: 576px) {
            .form-header {
                padding: 18px 20px;
            }
            
            .form-body {
                padding: 20px 15px;
            }
            
            .form-title {
                font-size: 22px;
            }
            
            .form-subtitle {
                font-size: 14px;
            }
            
            .form-input {
                padding: 12px 14px;
                font-size: 15px;
            }
            
            .submit-btn {
                padding: 14px;
                font-size: 16px;
            }
            
            .specialization-checkbox {
                width: 100%;
                margin: 5px 0;
            }
            
            .header-content {
                flex-direction: column;
                gap: 10px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .submit-btn:active,
            .specialization-checkbox:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Form Header -->
        <div class="form-header">
            <div class="header-content">
                <div class="form-icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <div>
                    <h1 class="form-title">Teacher Registration</h1>
                    <p class="form-subtitle">Join SmartClass as an educator</p>
                </div>
            </div>
        </div>

        <!-- Form Body -->
        <form class="form-body" action="${pageContext.request.contextPath}/teacher/signup" method="post">
            <!-- Display error message if any -->
            <c:if test="${not empty error}">
                <div class="alert alert-error" style="display: flex; align-items: center; gap: 10px; padding: 12px; border-radius: var(--radius-sm); background: rgba(244, 67, 54, 0.1); color: #f44336; border-left: 4px solid #f44336; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <!-- Full Name -->
            <div class="form-group">
                <label class="form-label" for="fullName">
                    <i class="fas fa-user"></i> Full Name
                </label>
                <input type="text" id="fullName" name="fullName" class="form-input" placeholder="Enter your full name" required>
                <div class="error-message" id="name-error">Please enter a valid name</div>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label class="form-label" for="email">
                    <i class="fas fa-envelope"></i> Email Address
                </label>
                <input type="email" id="email" name="email" class="form-input" placeholder="teacher@example.com" required>
                <div class="error-message" id="email-error">Please enter a valid email address</div>
            </div>

            <!-- Specializations (Multiple Selection) -->
            <div class="form-group">
                <label class="form-label" for="specializations">
                    <i class="fas fa-code"></i> Specializations (Select Multiple)
                </label>
                <div class="specializations-container">
                    <c:forEach var="entry" items="${specializationsByCategory}">
                        <div class="category-section">
                            <div class="category-title">
                                <i class="fas fa-folder"></i> ${entry.key}
                            </div>
                            <div>
                                <c:forEach var="spec" items="${entry.value}">
                                    <div class="specialization-checkbox">
                                        <input type="checkbox" 
                                               name="specializationIds" 
                                               value="${spec.id}" 
                                               id="spec_${spec.id}">
                                        <label for="spec_${spec.id}">${spec.name}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="selected-count" id="selectedCount">0 specializations selected</div>
                <div class="error-message" id="specialization-error">Please select at least one specialization</div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label class="form-label" for="password">
                    <i class="fas fa-lock"></i> Create Password
                </label>
                <div class="password-container">
                    <input type="password" id="password" name="password" class="form-input" placeholder="Create a secure password" required minlength="8">
                    <button type="button" class="toggle-password" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <div class="error-message" id="password-error">Password must be at least 8 characters</div>
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <label class="form-label" for="confirmPassword">
                    <i class="fas fa-lock"></i> Confirm Password
                </label>
                <div class="password-container">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="Re-enter your password" required minlength="8">
                    <button type="button" class="toggle-password" id="toggleConfirmPassword">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <div class="error-message" id="confirm-error">Passwords do not match</div>
            </div>

            <!-- Info Box -->
            <div class="info-box">
                <div class="info-icon">
                    <i class="fas fa-info-circle"></i>
                </div>
                <div class="info-text">
                    You will receive a confirmation email once the Admin verifies your information. Please ensure all details are accurate.
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="submit-btn">
                <i class="fas fa-paper-plane"></i> Send Registration Request
            </button>

            <!-- Back Link -->
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>
            </div>
        </form>
    </div>
    
    <script>
        // Password toggle functionality
        const togglePassword = document.getElementById('togglePassword');
        const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        if (togglePassword && password) {
            togglePassword.addEventListener('click', function() {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
            });
        }

        if (toggleConfirmPassword && confirmPassword) {
            toggleConfirmPassword.addEventListener('click', function() {
                const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPassword.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
            });
        }

        // Form validation
        const form = document.querySelector('form');
        const nameInput = document.getElementById('fullName');
        const emailInput = document.getElementById('email');
        const specializationCheckboxes = document.querySelectorAll('input[name="specializationIds"]');
        const passwordInput = document.getElementById('password');
        const confirmInput = document.getElementById('confirmPassword');
        const selectedCountDiv = document.getElementById('selectedCount');

        // Update selected count
        function updateSelectedCount() {
            const checked = document.querySelectorAll('input[name="specializationIds"]:checked');
            selectedCountDiv.textContent = checked.length + ' specialization(s) selected';
        }

        // Add event listeners to checkboxes
        specializationCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateSelectedCount);
        });

        // Real-time validation
        if (nameInput) nameInput.addEventListener('input', validateName);
        if (emailInput) emailInput.addEventListener('input', validateEmail);
        if (passwordInput) passwordInput.addEventListener('input', validatePassword);
        if (confirmInput) confirmInput.addEventListener('input', validatePasswordMatch);

        function validateName() {
            const errorElement = document.getElementById('name-error');
            if (nameInput.value.trim().length < 2) {
                nameInput.classList.add('error');
                nameInput.classList.remove('success');
                errorElement.style.display = 'block';
                return false;
            } else {
                nameInput.classList.remove('error');
                nameInput.classList.add('success');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validateEmail() {
            const errorElement = document.getElementById('email-error');
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailPattern.test(emailInput.value)) {
                emailInput.classList.add('error');
                emailInput.classList.remove('success');
                errorElement.style.display = 'block';
                return false;
            } else {
                emailInput.classList.remove('error');
                emailInput.classList.add('success');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validateSpecializations() {
            const errorElement = document.getElementById('specialization-error');
            const checked = document.querySelectorAll('input[name="specializationIds"]:checked');
            
            if (checked.length === 0) {
                errorElement.style.display = 'block';
                return false;
            } else {
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validatePassword() {
            const errorElement = document.getElementById('password-error');
            if (passwordInput.value.length < 8) {
                passwordInput.classList.add('error');
                passwordInput.classList.remove('success');
                errorElement.style.display = 'block';
                return false;
            } else {
                passwordInput.classList.remove('error');
                passwordInput.classList.add('success');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validatePasswordMatch() {
            const errorElement = document.getElementById('confirm-error');
            if (passwordInput.value !== confirmInput.value) {
                confirmInput.classList.add('error');
                confirmInput.classList.remove('success');
                errorElement.style.display = 'block';
                return false;
            } else {
                confirmInput.classList.remove('error');
                confirmInput.classList.add('success');
                errorElement.style.display = 'none';
                return true;
            }
        }

        // Form submission
        if (form) {
            form.addEventListener('submit', function(e) {
                // Run all validations
                const isNameValid = validateName();
                const isEmailValid = validateEmail();
                const isSpecializationsValid = validateSpecializations();
                const isPasswordValid = validatePassword();
                const isPasswordMatchValid = validatePasswordMatch();
                
                // If any validation fails, prevent submission
                if (!isNameValid || !isEmailValid || !isSpecializationsValid || !isPasswordValid || !isPasswordMatchValid) {
                    e.preventDefault();
                    // Scroll to first error
                    const firstError = document.querySelector('.error');
                    if (firstError) {
                        firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }
                }
            });
        }
    </script>
</body>
</html>