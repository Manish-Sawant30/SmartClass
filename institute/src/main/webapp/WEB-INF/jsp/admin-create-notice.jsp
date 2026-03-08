<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Create Notice | SmartClass</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            --error: #f44336;
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
            min-height: 100vh;
            padding: 30px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .card {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        .card-header {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            color: var(--white);
            padding: 25px 30px;
            border-bottom: 4px solid var(--accent-gold);
        }

        .card-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }

        .card-header h1 i {
            color: var(--accent-gold);
            margin-right: 10px;
        }

        .card-header p {
            opacity: 0.95;
            font-size: 15px;
            color: var(--extra-light-purple);
        }

        .card-body {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
        }

        label i {
            color: var(--accent-gold);
            margin-right: 8px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            font-size: 15px;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
        }

        .form-control:focus {
            border-color: var(--soft-purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        .form-control::placeholder {
            color: var(--text-muted);
            opacity: 0.6;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .radio-group {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: var(--accent-gold);
        }

        .radio-option label {
            margin-bottom: 0;
            cursor: pointer;
            color: var(--text-light);
            font-weight: 500;
        }

        .target-select {
            margin-top: 15px;
            padding: 20px;
            background: var(--extra-light-purple);
            border-radius: var(--radius-sm);
            display: none;
            border: 2px solid var(--light-purple);
        }

        .target-select.show {
            display: block;
        }

        .preview-box {
            background: var(--extra-light-purple);
            border-left: 4px solid var(--accent-gold);
            padding: 20px;
            border-radius: var(--radius-sm);
            margin-top: 20px;
            display: none;
            border: 2px solid var(--light-purple);
        }

        .preview-box.show {
            display: block;
        }

        .preview-title {
            font-weight: 600;
            color: var(--royal-purple);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .preview-title i {
            color: var(--accent-gold);
        }

        .recipient-count {
            font-size: 24px;
            font-weight: 700;
            color: var(--royal-purple);
        }

        .recipient-list {
            margin-top: 15px;
            max-height: 200px;
            overflow-y: auto;
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 10px;
            border: 2px solid var(--light-purple);
        }

        .recipient-item {
            padding: 8px;
            border-bottom: 1px solid var(--light-purple);
            font-size: 14px;
            color: var(--text-light);
        }

        .recipient-item i {
            color: var(--accent-gold);
            margin-right: 8px;
        }

        .recipient-item:last-child {
            border-bottom: none;
        }

        .btn {
            padding: 14px 28px;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
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
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        .btn-secondary {
            background: var(--royal-purple);
            color: var(--white);
        }

        .btn-secondary:hover {
            background: transparent;
            border-color: var(--royal-purple);
            color: var(--royal-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(90, 61, 110, 0.3);
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .loading {
            display: none;
            align-items: center;
            gap: 10px;
            color: var(--royal-purple);
            margin-top: 10px;
            padding: 10px;
            background: var(--extra-light-purple);
            border-radius: var(--radius-sm);
            border: 2px solid var(--light-purple);
        }

        .loading i {
            animation: spin 1s linear infinite;
            color: var(--accent-gold);
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .error-message {
            color: var(--error);
            font-size: 14px;
            margin-top: 5px;
            padding: 8px;
            background: rgba(244, 67, 54, 0.1);
            border-radius: var(--radius-sm);
            border-left: 4px solid var(--error);
        }

        .valid-message {
            color: var(--success);
            font-size: 14px;
            margin-top: 5px;
            padding: 8px;
            background: rgba(76, 175, 80, 0.1);
            border-radius: var(--radius-sm);
            border-left: 4px solid var(--success);
        }

        .student-info {
            background: var(--white);
            padding: 15px;
            border-radius: var(--radius-sm);
            margin-top: 10px;
            display: none;
            border: 2px solid var(--light-purple);
        }

        .student-info.show {
            display: block;
        }

        .student-detail {
            font-size: 14px;
            padding: 8px 0;
            border-bottom: 1px dashed var(--light-purple);
            color: var(--text-light);
        }

        .student-detail:last-child {
            border-bottom: none;
        }

        .student-detail strong {
            color: var(--royal-purple);
            width: 80px;
            display: inline-block;
            font-weight: 600;
        }

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%235a3d6e' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 15px;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .card-header {
                padding: 20px;
            }
            
            .card-header h1 {
                font-size: 24px;
            }
            
            .card-body {
                padding: 20px;
            }
            
            .radio-group {
                flex-direction: column;
                gap: 15px;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .card-header h1 {
                font-size: 22px;
            }
            
            .card-header p {
                font-size: 14px;
            }
            
            .form-control {
                padding: 12px 14px;
                font-size: 14px;
            }
            
            .preview-box {
                padding: 15px;
            }
            
            .recipient-count {
                font-size: 20px;
            }
            
            .student-detail strong {
                width: 70px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .radio-option:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h1><i class="fas fa-pen-alt"></i> Create New Notice</h1>
            <p>Send announcements to parents based on your target selection</p>
        </div>
        
        <div class="card-body">
            <form id="noticeForm" action="${pageContext.request.contextPath}/admin/notices/create" method="post">
                <div class="form-group">
                    <label for="title"><i class="fas fa-heading"></i> Notice Title *</label>
                    <input type="text" id="title" name="title" class="form-control" 
                           placeholder="e.g., Parent-Teacher Meeting" required>
                </div>
                
                <div class="form-group">
                    <label for="content"><i class="fas fa-file-alt"></i> Notice Content *</label>
                    <textarea id="content" name="content" class="form-control" 
                              placeholder="Write your notice here..." required></textarea>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-users"></i> Send To *</label>
                    <div class="radio-group">
                        <div class="radio-option">
                            <input type="radio" name="targetType" id="targetAll" value="ALL" checked>
                            <label for="targetAll">All Parents</label>
                        </div>
                        <div class="radio-option">
                            <input type="radio" name="targetType" id="targetCourse" value="COURSE">
                            <label for="targetCourse">Specific Course</label>
                        </div>
                        <div class="radio-option">
                            <input type="radio" name="targetType" id="targetStudent" value="STUDENT">
                            <label for="targetStudent">Specific Student</label>
                        </div>
                    </div>
                </div>
                
                <!-- Course Selection -->
                <div class="target-select" id="courseSelect">
                    <div class="form-group">
                        <label for="courseValue"><i class="fas fa-book"></i> Select Course *</label>
                        <select id="courseValue" name="targetValue" class="form-control">
                            <option value="">-- Choose a course --</option>
                            <c:forEach var="course" items="${courses}">
                                <option value="${course}">${course}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <!-- Student Selection -->
                <div class="target-select" id="studentSelect">
                    <div class="form-group">
                        <label for="studentValue"><i class="fas fa-id-card"></i> Enter Student ID *</label>
                        <input type="text" id="studentValue" name="targetValue" class="form-control" 
                               placeholder="e.g., STU1001">
                        <div class="error-message" id="studentError"></div>
                        <div class="valid-message" id="studentValid"></div>
                        
                        <!-- Student Info Preview (shows when student is found) -->
                        <div class="student-info" id="studentInfo">
                            <div class="student-detail">
                                <strong>Name:</strong> <span id="studentName"></span>
                            </div>
                            <div class="student-detail">
                                <strong>Courses:</strong> <span id="studentCourses"></span>
                            </div>
                            <!-- FIXED: Removed the Parent row entirely -->
                        </div>
                    </div>
                </div>
                
                <!-- Preview Button -->
                <div class="form-group">
                    <button type="button" class="btn btn-secondary" id="previewBtn" onclick="previewTargets()">
                        <i class="fas fa-eye"></i> Preview Recipients
                    </button>
                </div>
                
                <!-- Loading Indicator -->
                <div class="loading" id="loading">
                    <i class="fas fa-spinner"></i> Fetching recipients...
                </div>
                
                <!-- Preview Box -->
                <div class="preview-box" id="previewBox">
                    <div class="preview-title">
                        <i class="fas fa-users"></i> Recipients Preview
                    </div>
                    <div>
                        Total Recipients: <span class="recipient-count" id="recipientCount">0</span>
                    </div>
                    <div class="recipient-list" id="recipientList">
                        <!-- Will be populated by JavaScript -->
                    </div>
                </div>
                
                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/admin/notices" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="fas fa-paper-plane"></i> Send Notice
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Get context path for URLs
    const ctxPath = '${pageContext.request.contextPath}';
    
    const targetAll = document.getElementById('targetAll');
    const targetCourse = document.getElementById('targetCourse');
    const targetStudent = document.getElementById('targetStudent');
    const courseSelect = document.getElementById('courseSelect');
    const studentSelect = document.getElementById('studentSelect');
    const courseValue = document.getElementById('courseValue');
    const studentValue = document.getElementById('studentValue');
    const previewBox = document.getElementById('previewBox');
    const loading = document.getElementById('loading');
    const recipientCount = document.getElementById('recipientCount');
    const recipientList = document.getElementById('recipientList');
    const studentError = document.getElementById('studentError');
    const studentValid = document.getElementById('studentValid');
    const studentInfo = document.getElementById('studentInfo');
    const studentName = document.getElementById('studentName');
    const studentCourses = document.getElementById('studentCourses');
    const submitBtn = document.getElementById('submitBtn');
    
    // Radio change handlers
    targetAll.addEventListener('change', function() {
        courseSelect.classList.remove('show');
        studentSelect.classList.remove('show');
        previewBox.classList.remove('show');
        studentInfo.classList.remove('show');
        studentError.textContent = '';
        studentValid.textContent = '';
        // Clear and disable target value inputs
        document.querySelectorAll('input[name="targetValue"]').forEach(input => {
            input.value = '';
            input.disabled = true;
        });
        document.querySelectorAll('select[name="targetValue"]').forEach(select => {
            select.value = '';
            select.disabled = true;
        });
    });
    
    targetCourse.addEventListener('change', function() {
        courseSelect.classList.add('show');
        studentSelect.classList.remove('show');
        previewBox.classList.remove('show');
        studentInfo.classList.remove('show');
        studentError.textContent = '';
        studentValid.textContent = '';
        
        // Enable course select, disable others
        document.querySelectorAll('input[name="targetValue"]').forEach(input => {
            input.value = '';
            input.disabled = true;
        });
        document.querySelectorAll('select[name="targetValue"]').forEach(select => {
            select.disabled = true;
        });
        courseValue.disabled = false;
    });
    
    targetStudent.addEventListener('change', function() {
        studentSelect.classList.add('show');
        courseSelect.classList.remove('show');
        previewBox.classList.remove('show');
        studentInfo.classList.remove('show');
        studentError.textContent = '';
        studentValid.textContent = '';
        
        // Enable student input, disable others
        document.querySelectorAll('input[name="targetValue"]').forEach(input => {
            input.value = '';
            input.disabled = true;
        });
        document.querySelectorAll('select[name="targetValue"]').forEach(select => {
            select.value = '';
            select.disabled = true;
        });
        studentValue.disabled = false;
    });
    
    // Initialize - disable target value inputs initially
    targetAll.checked = true;
    document.querySelectorAll('input[name="targetValue"]').forEach(input => input.disabled = true);
    document.querySelectorAll('select[name="targetValue"]').forEach(select => select.disabled = true);
    
    // Validate student ID on input - FIXED: Removed parent fetching
    let studentIdTimeout;
    studentValue.addEventListener('input', function() {
        clearTimeout(studentIdTimeout);
        const studentId = this.value.trim();
        
        // Hide previous messages
        studentError.textContent = '';
        studentValid.textContent = '';
        studentInfo.classList.remove('show');
        
        if (studentId.length > 0) {
            studentIdTimeout = setTimeout(() => {
                // Show loading indicator
                studentValid.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Checking student ID...';
                studentValid.style.color = 'var(--royal-purple)';
                
                fetch(ctxPath + '/student/courses/' + encodeURIComponent(studentId))
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Student found
                            studentValid.innerHTML = '<i class="fas fa-check-circle"></i> Student found!';
                            studentValid.style.color = 'var(--success)';
                            studentError.textContent = '';
                            
                            // Display student info
                            studentName.textContent = data.studentName || 'N/A';
                            studentCourses.textContent = data.courses ? data.courses.join(', ') : 'None';
                            
                            // FIXED: No longer fetching parent info
                            
                            studentInfo.classList.add('show');
                        } else {
                            // Student not found
                            studentError.textContent = '❌ ' + (data.message || 'Student ID not found');
                            studentValid.textContent = '';
                            studentInfo.classList.remove('show');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        studentError.textContent = '❌ Error checking student ID';
                        studentValid.textContent = '';
                        studentInfo.classList.remove('show');
                    });
            }, 500);
        } else {
            studentError.textContent = '';
            studentValid.textContent = '';
            studentInfo.classList.remove('show');
        }
    });
    
    // Preview function - FIXED: Properly handle targetValue
    function previewTargets() {
        let targetType, targetValue;
        
        if (targetAll.checked) {
            targetType = 'ALL';
            targetValue = '';
        } else if (targetCourse.checked) {
            targetType = 'COURSE';
            targetValue = courseValue.value;
            if (!targetValue) {
                alert('Please select a course');
                return;
            }
        } else if (targetStudent.checked) {
            targetType = 'STUDENT';
            targetValue = studentValue.value.trim();
            if (!targetValue) {
                alert('Please enter a student ID');
                return;
            }
            
            // Validate student exists before preview
            if (studentError.textContent) {
                alert('Please enter a valid student ID');
                return;
            }
        } else {
            alert('Please select a target type');
            return;
        }
        
        // Show loading
        loading.style.display = 'flex';
        previewBox.classList.remove('show');
        
        // Build URL properly
        let url = ctxPath + '/admin/notices/preview-targets?targetType=' + targetType;
        if (targetValue) {
            url += '&targetValue=' + encodeURIComponent(targetValue);
        }
        
        fetch(url)
            .then(response => response.json())
            .then(data => {
                loading.style.display = 'none';
                
                if (data.error) {
                    alert(data.error);
                    return;
                }
                
                recipientCount.textContent = data.count;
                
                if (data.count > 0) {
                    recipientList.innerHTML = '';
                    data.parents.forEach(parent => {
                        const item = document.createElement('div');
                        item.className = 'recipient-item';
                        item.innerHTML = '<i class="fas fa-user"></i> ' + parent.name + 
                                       ' (Student: ' + parent.studentId + ')';
                        recipientList.appendChild(item);
                    });
                } else {
                    recipientList.innerHTML = '<div style="color: var(--text-muted); text-align: center; padding: 15px;">' +
                                            '<i class="fas fa-info-circle"></i> No recipients found</div>';
                }
                
                previewBox.classList.add('show');
            })
            .catch(error => {
                loading.style.display = 'none';
                console.error('Error:', error);
                alert('Error fetching recipients');
            });
    }
    
    // Form validation
    document.getElementById('noticeForm').addEventListener('submit', function(e) {
        if (!targetAll.checked && !targetCourse.checked && !targetStudent.checked) {
            e.preventDefault();
            alert('Please select who to send this notice to');
            return;
        }
        
        if (targetCourse.checked && !courseValue.value) {
            e.preventDefault();
            alert('Please select a course');
            courseValue.focus();
            return;
        }
        
        if (targetStudent.checked) {
            if (!studentValue.value.trim()) {
                e.preventDefault();
                alert('Please enter a student ID');
                studentValue.focus();
                return;
            }
            
            if (studentError.textContent) {
                e.preventDefault();
                alert('Please enter a valid student ID');
                studentValue.focus();
                return;
            }
        }
        
        if (!confirm('Are you sure you want to send this notice?')) {
            e.preventDefault();
        }
    });
    
    // Touch feedback for mobile
    document.addEventListener('DOMContentLoaded', function() {
        const touchElements = document.querySelectorAll('.btn, .radio-option');
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