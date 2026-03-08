<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Test Score Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
           * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --light-gray: #e9ecef;
            --border-radius: 10px;
            --box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }

        /* Navbar Styles */
        .navbar-custom {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 10px 0;
            margin-bottom: 30px;
        }

        .navbar-custom .navbar-brand {
            color: white !important;
            font-weight: 700;
            font-size: 1.5rem;
            margin-left: 10px;
        }

        .navbar-custom .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 8px 15px;
            margin: 0 5px;
            border-radius: 8px;
            transition: var(--transition);
        }

        .navbar-custom .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
            color: white !important;
            transform: translateY(-2px);
        }

        .navbar-custom .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            color: white !important;
            font-weight: 600;
        }

        .navbar-custom .nav-link i {
            margin-right: 8px;
            font-size: 1.1rem;
        }

        .logo-img {
            height: 40px;
            width: auto;
            margin-right: 10px;
            border-radius: 5px;
        }

        /* Navbar toggler styling */
        .navbar-toggler {
            border: 2px solid rgba(255, 255, 255, 0.5);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.9%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        body {
            background-color: #f5f7ff;
            color: var(--dark);
            line-height: 1.6;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header Styles */
        header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 25px 30px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            box-shadow: var(--box-shadow);
            position: relative;
            overflow: hidden;
        }

        header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 L100,0 L100,100 Z" fill="rgba(255,255,255,0.1)"/></svg>');
            background-size: cover;
        }

        .header-content {
            position: relative;
            z-index: 1;
        }

        h1 {
            font-size: 2.4rem;
            margin-bottom: 8px;
            font-weight: 700;
        }

        .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
        }

        /* Dashboard Stats */
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--box-shadow);
            display: flex;
            align-items: center;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 1.8rem;
            color: white;
        }

        .stat-icon.students { background: linear-gradient(135deg, #3498db, #2980b9); }
        .stat-icon.courses { background: linear-gradient(135deg, #9b59b6, #8e44ad); }
        .stat-icon.average { background: linear-gradient(135deg, #2ecc71, #27ae60); }
        .stat-icon.top-score { background: linear-gradient(135deg, #e74c3c, #c0392b); }

        .stat-info h3 {
            font-size: 2.2rem;
            margin-bottom: 5px;
            color: var(--dark);
        }

        .stat-info p {
            color: var(--gray);
            font-size: 0.95rem;
        }

        /* Main Content Layout */
        .main-content {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        @media (max-width: 1100px) {
            .main-content {
                grid-template-columns: 1fr;
            }
        }

        /* Form Styles */
        .form-container {
            background: white;
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--box-shadow);
            height: fit-content;
        }

        .form-container h2 {
            margin-bottom: 25px;
            color: var(--primary);
            font-size: 1.5rem;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--light-gray);
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid var(--light-gray);
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background-color: white;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }

        .select-wrapper {
            position: relative;
        }

        .select-wrapper::after {
            content: '\f078';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            top: 50%;
            right: 16px;
            transform: translateY(-50%);
            color: var(--gray);
            pointer-events: none;
        }

        select.form-control {
            appearance: none;
            padding-right: 40px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }

        .btn {
            padding: 14px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex: 1;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: var(--light-gray);
            color: var(--dark);
        }

        .btn-secondary:hover {
            background-color: #dee2e6;
        }

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
        }

        .btn-warning {
            background-color: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background-color: #e67e22;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        /* Table Styles */
        .table-container {
            background: white;
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .table-header h2 {
            color: var(--primary);
            font-size: 1.5rem;
        }

        .table-actions {
            display: flex;
            gap: 10px;
        }

        .btn-sm {
            padding: 10px 16px;
            font-size: 0.9rem;
        }

        .search-box {
            position: relative;
            width: 250px;
        }

        .search-box input {
            width: 100%;
            padding: 12px 16px 12px 42px;
            border: 2px solid var(--light-gray);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: var(--transition);
        }

        .search-box input:focus {
            border-color: var(--primary);
            outline: none;
        }

        .search-box i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: var(--primary);
            color: white;
        }

        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            border: none;
        }

        th:first-child {
            border-top-left-radius: 8px;
        }

        th:last-child {
            border-top-right-radius: 8px;
        }

        td {
            padding: 16px 15px;
            border-bottom: 1px solid var(--light-gray);
            color: var(--dark);
        }

        tr:hover {
            background-color: rgba(67, 97, 238, 0.03);
        }

        .student-id {
            font-weight: 600;
            color: var(--primary);
        }

        .student-name {
            font-weight: 500;
        }

        .course-name {
            display: inline-block;
            padding: 6px 12px;
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .score {
            font-weight: 700;
            font-size: 1.1rem;
        }

        .score.high {
            color: var(--success);
        }

        .score.medium {
            color: var(--warning);
        }

        .score.low {
            color: var(--danger);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            color: white;
            font-size: 0.9rem;
        }

        .edit-btn {
            background-color: var(--warning);
        }

        .edit-btn:hover {
            background-color: #e67e22;
            transform: translateY(-2px);
        }

        .delete-btn {
            background-color: var(--danger);
        }

        .delete-btn:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: var(--gray);
        }

        .no-data i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: var(--light-gray);
        }

        .no-data h3 {
            font-size: 1.3rem;
            margin-bottom: 10px;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: white;
            border-radius: var(--border-radius);
            width: 90%;
            max-width: 500px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            animation: modalFadeIn 0.3s;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--light-gray);
        }

        .modal-header h3 {
            color: var(--dark);
            font-size: 1.4rem;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--gray);
            transition: var(--transition);
        }

        .close-btn:hover {
            color: var(--danger);
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
        }

        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: var(--border-radius);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: rgba(46, 204, 113, 0.1);
            border-left-color: var(--success);
            color: #155724;
        }

        .alert-error {
            background-color: rgba(231, 76, 60, 0.1);
            border-left-color: var(--danger);
            color: #721c24;
        }

        .alert i {
            font-size: 1.2rem;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 25px;
            color: var(--gray);
            font-size: 0.9rem;
            margin-top: 20px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
            
            .dashboard-stats {
                grid-template-columns: 1fr;
            }
            
            .table-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .search-box {
                width: 100%;
            }
            
            .table-container {
                padding: 20px;
            }
            
            table {
                display: block;
                overflow-x: auto;
            }
            
            .navbar-custom .nav-link {
                padding: 10px 15px;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-custom fixed-top">
        <div class="container-fluid">
            <img src="${pageContext.request.contextPath}/images/logo2.jpeg" class="logo-img" alt="EduEra Logo">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">EduEra Teacher</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/teacher/dashboard">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/courses">
                            <i class="fas fa-book"></i> Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/courses-attendance">
                            <i class="fas fa-clipboard-check"></i> Attendance
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/testscore">
                            <i class="fas fa-chart-line"></i> Test Score
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/studentstore">
                            <i class="fas fa-user-graduate"></i> Students
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/parentstore">
                            <i class="fas fa-users"></i> Parents
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container" style="margin-top: 80px;">
        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Header -->
        <header>
            <div class="header-content">
                <h1>Student Test Score Management System</h1>
                <p class="subtitle">Track and manage student test scores across various programming and computer science courses with full CRUD operations.</p>
            </div>
        </header>

        <!-- Dashboard Stats -->
        <div class="dashboard-stats">
            <div class="stat-card">
                <div class="stat-icon students">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3 id="totalStudents">${dashboardStats.totalStudents}</h3>
                    <p>Total Students</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon courses">
                    <i class="fas fa-book-open"></i>
                </div>
                <div class="stat-info">
                    <h3 id="totalCourses">${dashboardStats.totalCourses}</h3>
                    <p>Courses Tracked</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon average">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-info">
                    <h3 id="averageScore">${dashboardStats.averageScore}%</h3>
                    <p>Average Score</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon top-score">
                    <i class="fas fa-trophy"></i>
                </div>
                <div class="stat-info">
                    <h3 id="topScore">${dashboardStats.topScore}</h3>
                    <p>Top Score</p>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Form Section -->
            <div class="form-container">
                <h2><i class="fas fa-plus-circle"></i> Add Student Score</h2>
                <form action="${pageContext.request.contextPath}/testscore/add" method="post" id="studentForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="studentId"><i class="fas fa-id-card"></i> Student ID</label>
                            <input type="text" id="studentId" name="studentId" class="form-control" placeholder="e.g., S001" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="studentName"><i class="fas fa-user"></i> Student Name</label>
                            <input type="text" id="studentName" name="studentName" class="form-control" placeholder="e.g., John Smith" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="course"><i class="fas fa-graduation-cap"></i> Course</label>
                        <div class="select-wrapper">
                            <select id="course" name="course" class="form-control" required>
                                <option value="">Select a course</option>
                                <c:forEach var="course" items="${allCourses}">
                                    <option value="${course}">${course}</option>
                                </c:forEach>
                                <!-- Fallback options if no courses in database -->
                                <option value="C Programming">C Programming</option>
                                <option value="C++ Programming">C++ Programming</option>
                                <option value="Java Programming">Java Programming</option>
                                <option value="Python Programming">Python Programming</option>
                                <option value="JavaScript">JavaScript</option>
                                <option value="Full Stack Development">Full Stack Development</option>
                                <option value="Android Development">Android Development</option>
                                <option value="Software Engineering">Software Engineering</option>
                                <option value="Git & GitHub">Git & GitHub</option>
                                <option value="Data Structures & Algorithms">Data Structures & Algorithms</option>
                                <option value="Operating Systems">Operating Systems</option>
                                <option value="DBMS">DBMS</option>
                                <option value="Computer Networks">Computer Networks</option>
                                <option value="Artificial Intelligence">Artificial Intelligence</option>
                                <option value="Cloud Computing">Cloud Computing</option>
                                <option value="Cyber Security & Ethical Hacking">Cyber Security & Ethical Hacking</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="testScore"><i class="fas fa-percentage"></i> Test Score (0-100)</label>
                        <input type="number" id="testScore" name="testScore" class="form-control" min="0" max="100" placeholder="Enter score (0-100)" required>
                        <div style="margin-top: 8px; font-size: 0.85rem; color: var(--gray);">
                            <span id="scoreIndicator">Enter a score between 0 and 100</span>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Score
                        </button>
                        <button type="button" onclick="resetForm()" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Clear
                        </button>
                    </div>
                </form>
            </div>

            <!-- Table Section -->
            <div class="table-container">
                <div class="table-header">
                    <h2><i class="fas fa-list"></i> Student Scores</h2>
                    <div class="table-actions">
                        <form action="${pageContext.request.contextPath}/testscore/search" method="get" class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" name="query" id="searchInput" placeholder="Search students or courses..." value="${searchQuery}">
                        </form>
                        <button id="exportBtn" class="btn btn-primary btn-sm" onclick="exportData()">
                            <i class="fas fa-file-export"></i> Export
                        </button>
                    </div>
                </div>
                
                <div id="tableWrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Course</th>
                                <th>Score</th>
                                <th>Grade</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="studentTableBody">
                            <c:choose>
                                <c:when test="${not empty testScores}">
                                    <c:forEach var="score" items="${testScores}">
                                        <tr>
                                            <td class="student-id">${score.studentId}</td>
                                            <td class="student-name">${score.studentName}</td>
                                            <td><span class="course-name">${score.course}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${score.testScore >= 90}">
                                                        <span class="score high">${score.testScore}</span>
                                                    </c:when>
                                                    <c:when test="${score.testScore >= 70}">
                                                        <span class="score medium">${score.testScore}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="score low">${score.testScore}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${score.testScore >= 90}"><strong>A</strong></c:when>
                                                    <c:when test="${score.testScore >= 80}"><strong>B</strong></c:when>
                                                    <c:when test="${score.testScore >= 70}"><strong>C</strong></c:when>
                                                    <c:when test="${score.testScore >= 60}"><strong>D</strong></c:when>
                                                    <c:otherwise><strong>F</strong></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="action-btn edit-btn" onclick="editScore(${score.id}, '${score.studentId}', '${score.studentName}', '${score.course}', ${score.testScore})">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="action-btn delete-btn" onclick="confirmDelete(${score.id}, '${score.studentName}', '${score.studentId}', '${score.course}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6">
                                            <div class="no-data">
                                                <i class="fas fa-database"></i>
                                                <h3>No Student Scores Found</h3>
                                                <p>Add student scores using the form on the left to get started.</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            <p>Student Test Score Management System &copy; 2023 | Spring Boot + MySQL + JSP</p>
        </footer>
    </div>

    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-edit"></i> Edit Student Score</h3>
                <button class="close-btn" onclick="closeEditModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="editForm" method="post">
                    <input type="hidden" id="editId" name="id">
                    <div class="form-group">
                        <label for="editStudentId">Student ID</label>
                        <input type="text" id="editStudentId" class="form-control" disabled>
                    </div>
                    <div class="form-group">
                        <label for="editStudentName">Student Name</label>
                        <input type="text" id="editStudentName" name="studentName" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="editCourse">Course</label>
                        <input type="text" id="editCourse" class="form-control" disabled>
                    </div>
                    <div class="form-group">
                        <label for="editTestScore">Test Score (0-100)</label>
                        <input type="number" id="editTestScore" name="testScore" class="form-control" min="0" max="100" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
                <button type="button" class="btn btn-success" onclick="submitEditForm()">Update Score</button>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-exclamation-triangle"></i> Confirm Deletion</h3>
                <button class="close-btn" onclick="closeDeleteModal()">&times;</button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the score record for <strong id="deleteStudentName"></strong> (ID: <strong id="deleteStudentId"></strong>) in <strong id="deleteCourseName"></strong>?</p>
                <p>This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                <a id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Score indicator functionality
        const testScoreInput = document.getElementById('testScore');
        const scoreIndicator = document.getElementById('scoreIndicator');
        
        if (testScoreInput) {
            testScoreInput.addEventListener('input', updateScoreIndicator);
        }
        
        function updateScoreIndicator() {
            const score = parseInt(testScoreInput.value) || 0;
            
            if (score >= 90) {
                scoreIndicator.textContent = 'Excellent (A)';
                scoreIndicator.style.color = 'var(--success)';
            } else if (score >= 80) {
                scoreIndicator.textContent = 'Good (B)';
                scoreIndicator.style.color = '#2ecc71';
            } else if (score >= 70) {
                scoreIndicator.textContent = 'Average (C)';
                scoreIndicator.style.color = 'var(--warning)';
            } else if (score >= 60) {
                scoreIndicator.textContent = 'Below Average (D)';
                scoreIndicator.style.color = '#e67e22';
            } else if (score > 0) {
                scoreIndicator.textContent = 'Poor (F)';
                scoreIndicator.style.color = 'var(--danger)';
            } else {
                scoreIndicator.textContent = 'Enter a score between 0 and 100';
                scoreIndicator.style.color = 'var(--gray)';
            }
        }
        
        // Form reset
        function resetForm() {
            document.getElementById('studentForm').reset();
            updateScoreIndicator();
        }
        
        // Edit functionality - FIXED
        function editScore(id, studentId, studentName, course, testScore) {
            document.getElementById('editId').value = id;
            document.getElementById('editStudentId').value = studentId;
            document.getElementById('editStudentName').value = studentName;
            document.getElementById('editCourse').value = course;
            document.getElementById('editTestScore').value = testScore;
            
            // Set form action
            document.getElementById('editForm').action = '${pageContext.request.contextPath}/testscore/update/' + id;
            
            document.getElementById('editModal').style.display = 'flex';
        }
        
        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }
        
        function submitEditForm() {
            const score = parseInt(document.getElementById('editTestScore').value);
            if (score < 0 || score > 100) {
                alert('Test score must be between 0 and 100.');
                return;
            }
            document.getElementById('editForm').submit();
        }
        
        // Delete functionality - FIXED
        function confirmDelete(id, studentName, studentId, course) {
            document.getElementById('deleteStudentName').textContent = studentName;
            document.getElementById('deleteStudentId').textContent = studentId;
            document.getElementById('deleteCourseName').textContent = course;
            
            // Set delete link - FIXED: Properly set the href
            const deleteLink = '${pageContext.request.contextPath}/testscore/delete/' + id;
            document.getElementById('confirmDeleteBtn').setAttribute('href', deleteLink);
            
            document.getElementById('deleteModal').style.display = 'flex';
        }
        
        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
        
        // Export functionality
        function exportData() {
            // Create CSV content
            let csvContent = "data:text/csv;charset=utf-8,";
            csvContent += "Student ID,Student Name,Course,Test Score,Grade,Created Date\n";
            
            <c:forEach var="score" items="${testScores}">
                const score${score.id} = ${score.testScore};
                let grade${score.id};
                if (score${score.id} >= 90) grade${score.id} = "A";
                else if (score${score.id} >= 80) grade${score.id} = "B";
                else if (score${score.id} >= 70) grade${score.id} = "C";
                else if (score${score.id} >= 60) grade${score.id} = "D";
                else grade${score.id} = "F";
                
                const date${score.id} = new Date('${score.createdAt}');
                const formattedDate${score.id} = date${score.id}.toISOString().split('T')[0];
                
                csvContent += '"${score.studentId}","${score.studentName}","${score.course}",${score.testScore},"' + grade${score.id} + '",' + formattedDate${score.id} + '\n';
            </c:forEach>
            
            // Create download link
            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "student_scores_export.csv");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            updateScoreIndicator();
            
            // Auto-hide alerts after 5 seconds
            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    alert.style.opacity = '0';
                    alert.style.transition = 'opacity 0.5s ease';
                    setTimeout(() => {
                        if (alert.parentNode) {
                            alert.parentNode.removeChild(alert);
                        }
                    }, 500);
                });
            }, 5000);
            
            // Search functionality
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        this.closest('form').submit();
                    }
                });
            }
        });
        
        // Close modals when clicking outside
        window.onclick = function(event) {
            const editModal = document.getElementById('editModal');
            const deleteModal = document.getElementById('deleteModal');
            
            if (event.target === editModal) {
                closeEditModal();
            }
            if (event.target === deleteModal) {
                closeDeleteModal();
            }
        };
    </script>
</body>
</html>