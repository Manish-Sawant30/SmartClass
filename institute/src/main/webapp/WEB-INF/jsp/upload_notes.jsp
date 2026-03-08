<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Study Materials | Teacher Dashboard</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-blue: #003b8e;
            --dark-blue: #001f54;
            --light-blue: #e8f4ff;
            --success-green: #28a745;
            --warning-yellow: #ffc107;
            --danger-red: #dc3545;
            --mcq-purple: #6f42c1;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
            color: #1f2937;
            margin: 0;
            padding: 0;
        }

        /* ================= NAVBAR STYLES (SAME AS TEACHERDASHBOARD.JSP) ================= */
        .navbar-custom {
            background: linear-gradient(135deg, var(--primary-blue), var(--dark-blue));
            padding: 12px 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .navbar-brand {
            color: #ffffff !important;
            font-weight: 700;
            font-size: 22px;
            margin-left: 10px;
        }

        .nav-link {
            color: #e0e7ff !important;
            font-size: 15px;
            padding: 8px 15px !important;
            transition: 0.2s ease;
            border-radius: 6px;
            margin-left: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.25);
            color: white !important;
        }

        .nav-link.active {
            background: rgba(255, 255, 255, 0.35);
            color: white !important;
            font-weight: 600;
        }

        .logo-img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
            margin-right: 10px;
        }

        .dashboard-container {
            padding: 30px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-top: 4px solid var(--primary-blue);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary-blue);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-blue);
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            margin-top: 5px;
        }

        .upload-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            color: var(--primary-blue);
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 0.25rem rgba(0, 59, 142, 0.25);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue), var(--dark-blue));
            border: none;
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 59, 142, 0.3);
        }

        .final-test-section {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .final-test-btn {
            background: white;
            color: #f5576c;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 18px;
            transition: all 0.3s ease;
        }

        .final-test-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .content-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .content-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 1px solid #eee;
        }

        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            padding: 20px;
            background: var(--light-blue);
            border-bottom: 1px solid #ddd;
            position: relative;
        }

        .content-type {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .type-document {
            background: #e3f2fd;
            color: #1976d2;
        }

        .type-media {
            background: #e8f5e9;
            color: #388e3c;
        }

        .mcq-badge {
            display: inline-block;
            background: var(--mcq-purple);
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            margin-left: 10px;
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-weight: 600;
            font-size: 1.2rem;
            margin-bottom: 10px;
            color: #333;
        }

        .card-text {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 15px;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 13px;
            text-decoration: none;
            color: white;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-primary { background: var(--primary-blue); }
        .btn-info { background: #17a2b8; }
        .btn-success { background: #28a745; }
        .btn-danger { background: #dc3545; }
        .btn-primary:hover, .btn-info:hover, .btn-success:hover, .btn-danger:hover {
            transform: translateY(-2px);
            filter: brightness(1.1);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            grid-column: 1 / -1;
        }

        .empty-state i {
            font-size: 70px;
            color: #e0e0e0;
            margin-bottom: 20px;
        }

        .badge {
            padding: 8px 16px;
            font-size: 14px;
        }

        .modal-header.bg-primary { background: var(--primary-blue); }
        .modal-header.bg-danger { background: #dc3545; }
        .modal-header.bg-info { background: #17a2b8; }
        .btn-close-white { filter: invert(1); }

        /* Toast notification styles */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }

        .toast-message {
            padding: 15px 25px;
            border-radius: 8px;
            color: white;
            font-weight: 500;
            margin-bottom: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            animation: slideIn 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .toast-success { background: #28a745; }
        .toast-error { background: #dc3545; }
        .toast-info { background: #17a2b8; }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOut {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        /* Loading overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 9999;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .loading-content {
            background: white;
            padding: 20px 40px;
            border-radius: 10px;
            text-align: center;
        }

        @media (max-width: 768px) {
            .dashboard-container { padding: 15px; }
            .content-grid { grid-template-columns: 1fr; }
            .stats-container { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</head>
<body>
    <%
        // Check if teacher is logged in
        if (session.getAttribute("teacher") == null) {
            response.sendRedirect(request.getContextPath() + "/teacher/login");
            return;
        }
        
        // Get teacher info from session
        com.example.institute.model.Teacher teacher = (com.example.institute.model.Teacher) session.getAttribute("teacher");
        String teacherId = teacher.getTeacherId();
        String teacherName = teacher.getFullName();
        String teacherStatus = teacher.getStatus().toString();
        Long teacherDbId = teacher.getId(); // This is the actual database ID
        
        System.out.println("Teacher logged in: " + teacherName + " (ID: " + teacherId + ", DB ID: " + teacherDbId + ")");
    %>
    
    <input type="hidden" id="sessionTeacherId" value="<%= teacherDbId %>">
    <input type="hidden" id="sessionTeacherDisplayId" value="<%= teacherId %>">
    <input type="hidden" id="sessionTeacherName" value="<%= teacherName %>">

    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer"></div>

    <!-- ================= NAVIGATION BAR (SAME AS TEACHERDASHBOARD.JSP) ================= -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <img src="${pageContext.request.contextPath}/images/logo2.jpeg" class="logo-img" alt="EduEra Logo">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">SmartClass Teacher</a>

            <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/upload-notes">
                            <i class="fas fa-book"></i> Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/teachertestscore">
                            <i class="fas fa-chart-line"></i> Student Results
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
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/teacher/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="dashboard-container">
        <div class="alert alert-success" id="teacherInfoBanner">
            <i class="fas fa-chalkboard-teacher me-2"></i>
            <span id="teacherName">Welcome, <%= teacherName %> (ID: <%= teacherId %>)</span>
            <span class="badge bg-primary ms-3">Status: <%= teacherStatus %></span>
        </div>

        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-file-pdf"></i></div>
                <div class="stat-number" id="documentsCount">0</div>
                <div class="stat-label">Documents Uploaded</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-video"></i></div>
                <div class="stat-number" id="mediaCount">0</div>
                <div class="stat-label">Video Links Added</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-question-circle"></i></div>
                <div class="stat-number" id="mcqCount">0</div>
                <div class="stat-label">MCQ Questions</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <div class="stat-number" id="studentsCount">0</div>
                <div class="stat-label">My Students</div>
            </div>
        </div>

        <div class="final-test-section">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h3><i class="fas fa-trophy me-2"></i> Final MCQ Test Management</h3>
                    <p class="mb-0">Create and manage final tests for your courses. Students with 50%+ average in unit tests are eligible.</p>
                </div>
                <div class="col-md-4 text-end">
                    <button class="final-test-btn" onclick="openFinalTestModal()"><i class="fas fa-plus-circle me-2"></i> Create Final Test</button>
                </div>
            </div>
        </div>

        <div class="upload-section">
            <h3 class="section-title"><i class="fas fa-book-open"></i> My Teaching Subjects</h3>
            <div id="mySubjectsList" class="d-flex flex-wrap gap-3 mb-4">
                <div class="text-muted">Loading your specializations...</div>
            </div>
        </div>

        <!-- Upload Document Section -->
        <div class="upload-section">
            <h3 class="section-title"><i class="fas fa-upload"></i> Upload Document/Notes</h3>
            <div class="form-container">
                <form id="uploadDocumentForm" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">Title *</label>
                            <input type="text" class="form-control" id="contentTitle" name="contentTitle" required placeholder="Enter document title">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="contentDescription" name="contentDescription" rows="3" placeholder="Enter document description"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Subject/Course *</label>
                            <select class="form-select" id="subjectName" name="subjectName" required>
                                <option value="">Select Subject</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Number of Pages</label>
                            <input type="number" class="form-control" id="pageCount" name="pageCount" min="1" placeholder="Optional">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Document File *</label>
                            <input type="file" class="form-control" id="documentFile" name="documentFile" accept=".pdf,.doc,.docx,.txt,.ppt,.pptx" required>
                            <small class="text-muted">Supported formats: PDF, DOC, DOCX, TXT, PPT, PPTX (Max 10MB)</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Educator ID</label>
                            <input type="text" class="form-control" id="educatorId" name="educatorId" value="<%= teacherDbId %>" readonly>
                        </div>
                        <div class="col-md-12 mt-4">
                            <button type="submit" class="btn btn-primary btn-lg"><i class="fas fa-upload me-2"></i> Upload Document</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Add Video Link Section -->
        <div class="upload-section">
            <h3 class="section-title"><i class="fas fa-video"></i> Add Video Lecture Link</h3>
            <div class="form-container">
                <form id="addVideoForm">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">Video Title *</label>
                            <input type="text" class="form-control" id="videoTitle" name="contentTitle" required placeholder="Enter video title">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="videoDescription" name="contentDescription" rows="2" placeholder="Enter video description"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Subject/Course *</label>
                            <select class="form-select" id="videoSubject" name="subjectName" required>
                                <option value="">Select Subject</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Duration (minutes)</label>
                            <input type="number" class="form-control" id="durationValue" name="durationValue" min="1" placeholder="Optional">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Video URL *</label>
                            <input type="url" class="form-control" id="mediaUrl" name="mediaUrl" required placeholder="https://youtube.com/watch?v=...">
                        </div>
                        <div class="col-md-12 mt-4">
                            <button type="submit" class="btn btn-primary btn-lg"><i class="fas fa-plus-circle me-2"></i> Add Video Link</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Uploaded Content Section -->
        <div class="upload-section">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="section-title mb-0"><i class="fas fa-list"></i> My Study Materials & MCQ Tests</h3>
                <div class="d-flex gap-2">
                    <select class="form-select" id="filterSubject" style="width: auto;">
                        <option value="">All Subjects</option>
                    </select>
                    <select class="form-select" id="filterType" style="width: auto;">
                        <option value="">All Types</option>
                        <option value="DOCUMENT">Documents</option>
                        <option value="MEDIA">Videos</option>
                    </select>
                </div>
            </div>
            <div class="content-grid" id="contentGrid">
                <div class="empty-state">
                    <i class="fas fa-spinner fa-spin fa-3x"></i>
                    <h3>Loading your materials...</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Add MCQ Modal -->
    <div class="modal fade" id="addMCQModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title"><i class="fas fa-question-circle me-2"></i> Add MCQ Questions</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addMCQForm">
                        <input type="hidden" id="mcqContentId">
                        <div class="mb-3">
                            <label class="form-label">Content Title</label>
                            <input type="text" class="form-control" id="mcqContentTitle" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Subject</label>
                            <input type="text" class="form-control" id="mcqSubject" readonly>
                        </div>
                        <hr>
                        <h6 class="text-primary mb-3">Question 1</h6>
                        <div class="mb-3">
                            <label class="form-label">Question Text *</label>
                            <textarea class="form-control" id="question1" rows="2" required></textarea>
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Option A *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-success text-white">A</span>
                                    <input type="text" class="form-control" id="optionA1" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Option B *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-info text-white">B</span>
                                    <input type="text" class="form-control" id="optionB1" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Option C *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-warning text-dark">C</span>
                                    <input type="text" class="form-control" id="optionC1" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Option D *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-danger text-white">D</span>
                                    <input type="text" class="form-control" id="optionD1" required>
                                </div>
                            </div>
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Correct Option *</label>
                                <select class="form-select" id="correct1" required>
                                    <option value="">Select</option>
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                </select>
                            </div>
                            <div class="col-md-8">
                                <label class="form-label">Explanation (Optional)</label>
                                <input type="text" class="form-control" id="explanation1">
                            </div>
                        </div>
                        <hr>
                        <div id="additionalQuestions"></div>
                        <div class="text-center mt-3">
                            <button type="button" class="btn btn-outline-primary" onclick="addQuestionField()">
                                <i class="fas fa-plus me-2"></i> Add Another Question
                            </button>
                        </div>
                        <div class="text-end mt-4">
                            <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i> Save MCQ Questions</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Create Final Test Modal -->
    <div class="modal fade" id="finalTestModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="fas fa-trophy me-2"></i> Create Final MCQ Test</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="finalTestForm">
                        <div class="mb-3">
                            <label class="form-label">Select Course *</label>
                            <select class="form-select" id="finalTestCourse" required>
                                <option value="">Select Course</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Test Title *</label>
                            <input type="text" class="form-control" id="finalTestTitle" required placeholder="e.g., Final Examination - Java Programming">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="finalTestDescription" rows="2"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Passing Percentage *</label>
                            <input type="number" class="form-control" id="passingPercentage" value="50" min="1" max="100" required>
                        </div>
                        <hr>
                        <h6 class="text-danger mb-3">Add Questions for Final Test</h6>
                        <div id="finalQuestions"></div>
                        <div class="text-center mt-3">
                            <button type="button" class="btn btn-outline-danger" onclick="addFinalQuestion()">
                                <i class="fas fa-plus me-2"></i> Add Question
                            </button>
                        </div>
                        <div class="text-end mt-4">
                            <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger"><i class="fas fa-save me-2"></i> Create Final Test</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- View MCQ Questions Modal -->
    <div class="modal fade" id="viewMCQModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title"><i class="fas fa-eye me-2"></i> MCQ Questions</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="viewMCQContent"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i> Confirm Delete</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete "<strong id="deleteContentTitle"></strong>"?</p>
                    <p class="text-danger">This action cannot be undone. All associated MCQ questions will also be deleted.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn"><i class="fas fa-trash me-2"></i>Delete</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Get teacher info from session
        const currentTeacherId = <%= teacherDbId %>;
        const currentTeacherDisplayId = '<%= teacherId %>';
        const currentTeacherName = '<%= teacherName %>';
        
        console.log('Teacher logged in:', currentTeacherName, 'DB ID:', currentTeacherId, 'Display ID:', currentTeacherDisplayId);
        
        const API_BASE = 'http://localhost:8086/content';
        const MCQ_API = 'http://localhost:8086/api/mcq';
        let teacherSubjects = [];
        let questionCount = 1;
        let finalQuestionCount = 0;
        let deleteContentId = null;

        document.addEventListener('DOMContentLoaded', function() {
            loadTeacherSpecializations();
            loadStatistics();
            loadContent();
            setupEventListeners();
            
            // Set active nav based on current URL
            const currentPath = window.location.pathname;
            document.querySelectorAll('.nav-link').forEach(link => {
                const href = link.getAttribute('href');
                if (href && currentPath.includes(href)) {
                    link.classList.add('active');
                }
            });
        });

        // Toast notification function
        function showToast(message, type) {
            const container = document.getElementById('toastContainer');
            const toast = document.createElement('div');
            toast.className = 'toast-message toast-' + type;
            toast.innerHTML = '<i class="fas ' + (type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-info-circle') + ' me-2"></i>' + message;
            container.appendChild(toast);
            
            setTimeout(() => {
                toast.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => {
                    toast.remove();
                }, 300);
            }, 3000);
        }

        // Loading overlay functions
        function showLoading(message) {
            const loadingDiv = document.createElement('div');
            loadingDiv.id = 'loadingOverlay';
            loadingDiv.className = 'loading-overlay';
            loadingDiv.innerHTML = 
                '<div class="loading-content">' +
                    '<div class="spinner-border text-primary mb-3" role="status"></div>' +
                    '<h5>' + message + '</h5>' +
                '</div>';
            document.body.appendChild(loadingDiv);
        }

        function hideLoading() {
            const loadingDiv = document.getElementById('loadingOverlay');
            if (loadingDiv) {
                loadingDiv.remove();
            }
        }

        function escapeHTML(text) {
            if (!text) return '';
            return String(text)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        async function loadTeacherSpecializations() {
            try {
                // Show loading state
                const subjectsList = document.getElementById('mySubjectsList');
                subjectsList.innerHTML = '<div class="spinner-border text-primary me-2" role="status"><span class="visually-hidden">Loading...</span></div> Loading your specializations...';
                
                // Fetch teacher's specializations from the database
                const response = await fetch('${pageContext.request.contextPath}/teacher/specializations/' + currentTeacherId);
                
                if (response.ok) {
                    const data = await response.json();
                    console.log('API Response:', data);
                    
                    if (data.success && data.specializations && data.specializations.length > 0) {
                        teacherSubjects = data.specializations;
                    } else if (data.success && Array.isArray(data)) {
                        teacherSubjects = data;
                    } else if (data.specializations && Array.isArray(data.specializations)) {
                        teacherSubjects = data.specializations;
                    } else {
                        teacherSubjects = [];
                    }
                } else {
                    console.warn('API returned status:', response.status);
                    teacherSubjects = [];
                }
                
                // If still no subjects, try to get from teacher object in session
                if (!teacherSubjects || teacherSubjects.length === 0) {
                    console.log('Trying to get specializations from session teacher object');
                    
                    // Get the teacher's specializations from the page
                    <c:if test="${not empty teacher and not empty teacher.specializations}">
                        teacherSubjects = [
                            <c:forEach var="spec" items="${teacher.specializations}" varStatus="status">
                                '${spec.name}'<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ];
                        console.log('Specializations from JSP:', teacherSubjects);
                    </c:if>
                }
                
                // If still no subjects, use fallback
                if (!teacherSubjects || teacherSubjects.length === 0) {
                    teacherSubjects = [
                        'Java Programming',
                        'Python Programming',
                        'Data Structures & Algorithms',
                        'Database Management Systems',
                        'Web Development',
                        'C Programming',
                        'C++ Programming',
                        'JavaScript',
                        'Full Stack Development',
                        'Android Development',
                        'Software Engineering',
                        'Git & GitHub',
                        'Operating Systems',
                        'DBMS',
                        'Computer Networks',
                        'Artificial Intelligence',
                        'Cloud Computing',
                        'Cyber Security & Ethical Hacking'
                    ];
                    console.log('Using fallback subjects list');
                }
                
                // Display subjects as badges
                if (teacherSubjects && teacherSubjects.length > 0) {
                    subjectsList.innerHTML = '';
                    teacherSubjects.forEach(subject => {
                        subjectsList.innerHTML += '<span class="badge bg-primary p-3 fs-6"><i class="fas fa-book me-2"></i>' + escapeHTML(subject) + '</span>';
                    });
                    
                    // Populate all dropdowns with teacher's subjects
                    const subjectSelects = ['subjectName', 'videoSubject', 'filterSubject', 'finalTestCourse'];
                    subjectSelects.forEach(id => {
                        const select = document.getElementById(id);
                        if (select) {
                            select.innerHTML = '<option value="">Select Subject</option>';
                            teacherSubjects.forEach(subject => {
                                select.innerHTML += '<option value="' + escapeHTML(subject) + '">' + escapeHTML(subject) + '</option>';
                            });
                        }
                    });
                    
                    // After loading subjects, reload content to filter by teacher's subjects
                    loadContent();
                } else {
                    subjectsList.innerHTML = '<span class="text-warning">No specializations found for this teacher. Please contact admin.</span>';
                }
                
            } catch (error) {
                console.error('Error loading teacher specializations:', error);
                document.getElementById('mySubjectsList').innerHTML = 
                    '<span class="text-danger">Error loading specializations. Please refresh the page.</span>';
                
                // Use fallback subjects
                teacherSubjects = [
                    'Java Programming',
                    'Python Programming',
                    'Data Structures & Algorithms'
                ];
                
                // Display fallback subjects
                const subjectsList = document.getElementById('mySubjectsList');
                subjectsList.innerHTML = '';
                teacherSubjects.forEach(subject => {
                    subjectsList.innerHTML += '<span class="badge bg-primary p-3 fs-6"><i class="fas fa-book me-2"></i>' + escapeHTML(subject) + '</span>';
                });
                
                const subjectSelects = ['subjectName', 'videoSubject', 'filterSubject', 'finalTestCourse'];
                subjectSelects.forEach(id => {
                    const select = document.getElementById(id);
                    if (select) {
                        select.innerHTML = '<option value="">Select Subject</option>';
                        teacherSubjects.forEach(subject => {
                            select.innerHTML += '<option value="' + escapeHTML(subject) + '">' + escapeHTML(subject) + '</option>';
                        });
                    }
                });
            }
        }

        async function loadStatistics() {
            try {
                const stats = await (await fetch(API_BASE + '/api/statistics')).json();
                document.getElementById('documentsCount').textContent = stats.documentCount || 0;
                document.getElementById('mediaCount').textContent = stats.mediaCount || 0;
                
                try {
                    const mcqData = await (await fetch(MCQ_API + '/count/teacher/' + currentTeacherId)).json();
                    document.getElementById('mcqCount').textContent = mcqData.count || 0;
                } catch (e) {
                    document.getElementById('mcqCount').textContent = '0';
                }
            } catch (error) {
                console.error('Error loading statistics:', error);
                document.getElementById('documentsCount').textContent = '0';
                document.getElementById('mediaCount').textContent = '0';
                document.getElementById('mcqCount').textContent = '0';
            }
        }

        function setupEventListeners() {
            document.getElementById('uploadDocumentForm').addEventListener('submit', uploadDocument);
            document.getElementById('addVideoForm').addEventListener('submit', addVideoLink);
            document.getElementById('addMCQForm').addEventListener('submit', saveMCQQuestions);
            document.getElementById('finalTestForm').addEventListener('submit', createFinalTest);
            document.getElementById('filterSubject').addEventListener('change', filterContent);
            document.getElementById('filterType').addEventListener('change', filterContent);
            document.getElementById('confirmDeleteBtn').addEventListener('click', deleteContent);
        }

        async function loadContent() {
            try {
                const response = await fetch(API_BASE + '/api/all');
                let content = await response.json();
                
                // Filter content to only show materials for teacher's subjects
                if (teacherSubjects && teacherSubjects.length > 0) {
                    content = content.filter(item => teacherSubjects.includes(item.subjectName));
                }
                
                renderContent(content);
            } catch (error) {
                console.error('Error loading content:', error);
                const grid = document.getElementById('contentGrid');
                grid.innerHTML = '<div class="empty-state"><i class="fas fa-sticky-note fa-3x mb-3"></i><h3>No study materials found</h3><p>Error loading content. Please refresh the page.</p></div>';
            }
        }

        function renderContent(contentList) {
            const grid = document.getElementById('contentGrid');
            
            if (!contentList || contentList.length === 0) {
                grid.innerHTML = '<div class="empty-state"><i class="fas fa-sticky-note fa-3x mb-3"></i><h3>No study materials uploaded yet</h3><p>Upload your first document or video using the forms above.</p></div>';
                return;
            }
            
            grid.innerHTML = '';
            
            contentList.forEach(item => {
                const isDocument = item.contentCategory === 'DOCUMENT';
                const card = document.createElement('div');
                card.className = 'content-card';
                card.id = 'content-card-' + item.contentId;
                
                card.innerHTML = 
                    '<div class="card-header">' +
                        '<span class="content-type ' + (isDocument ? 'type-document' : 'type-media') + '">' +
                            '<i class="fas ' + (isDocument ? 'fa-file-pdf' : 'fa-video') + ' me-1"></i> ' + (isDocument ? 'Document' : 'Video') +
                        '</span>' +
                        '<span class="mcq-badge">' +
                            '<i class="fas fa-question-circle me-1"></i>' +
                            '<span id="mcqCount_' + item.contentId + '">0</span> MCQs' +
                        '</span>' +
                        '<h5 class="card-title mt-2">' + escapeHTML(item.contentTitle) + '</h5>' +
                    '</div>' +
                    '<div class="card-body">' +
                        '<p class="card-text">' + escapeHTML(item.contentDescription || 'No description provided.') + '</p>' +
                        '<div class="d-flex justify-content-between align-items-center">' +
                            '<small class="text-muted"><i class="fas fa-book me-1"></i> ' + escapeHTML(item.subjectName) + '</small>' +
                            '<small class="text-muted"><i class="fas fa-calendar me-1"></i> ' + escapeHTML(item.formattedDate || 'Recent') + '</small>' +
                        '</div>' +
                    '</div>' +
                    '<div class="card-footer">' +
                        '<div class="action-buttons">' +
                            '<button class="action-btn btn-primary btn-sm" onclick="openAddMCQModal(' + item.contentId + ', \'' + escapeHTML(item.contentTitle) + '\', \'' + escapeHTML(item.subjectName) + '\')">' +
                                '<i class="fas fa-plus-circle me-1"></i> Add MCQ' +
                            '</button>' +
                            '<button class="action-btn btn-info btn-sm" onclick="viewMCQQuestions(' + item.contentId + ')">' +
                                '<i class="fas fa-eye me-1"></i> View MCQs' +
                            '</button>' +
                            (isDocument ? 
                                '<a href="' + API_BASE + '/download/document/' + item.contentId + '" class="action-btn btn-success btn-sm" download>' +
                                    '<i class="fas fa-download me-1"></i> Download' +
                                '</a>' : 
                                '<a href="' + escapeHTML(item.mediaLink) + '" class="action-btn btn-danger btn-sm" target="_blank">' +
                                    '<i class="fas fa-play me-1"></i> Watch' +
                                '</a>'
                            ) +
                            '<button class="action-btn btn-danger btn-sm" onclick="confirmDelete(' + item.contentId + ', \'' + escapeHTML(item.contentTitle) + '\')">' +
                                '<i class="fas fa-trash me-1"></i> Delete' +
                            '</button>' +
                        '</div>' +
                    '</div>';
                
                grid.appendChild(card);
                loadMCQCount(item.contentId);
            });
        }

        async function loadMCQCount(contentId) {
            try {
                const data = await (await fetch(MCQ_API + '/count/' + contentId)).json();
                const span = document.getElementById('mcqCount_' + contentId);
                if (span) span.textContent = data.count || 0;
            } catch (error) {
                console.error('Error loading MCQ count for content ' + contentId + ':', error);
                const span = document.getElementById('mcqCount_' + contentId);
                if (span) span.textContent = '0';
            }
        }

        function openAddMCQModal(contentId, title, subject) {
            document.getElementById('mcqContentId').value = contentId;
            document.getElementById('mcqContentTitle').value = title;
            document.getElementById('mcqSubject').value = subject;
            
            // Reset form
            document.getElementById('question1').value = '';
            document.getElementById('optionA1').value = '';
            document.getElementById('optionB1').value = '';
            document.getElementById('optionC1').value = '';
            document.getElementById('optionD1').value = '';
            document.getElementById('correct1').value = '';
            document.getElementById('explanation1').value = '';
            
            // Remove additional questions
            document.getElementById('additionalQuestions').innerHTML = '';
            questionCount = 1;
            
            const modal = new bootstrap.Modal(document.getElementById('addMCQModal'));
            modal.show();
        }

        function addQuestionField() {
            questionCount++;
            const container = document.getElementById('additionalQuestions');
            const questionHtml = 
                '<hr>' +
                '<h6 class="text-primary mb-3">Question ' + questionCount + '</h6>' +
                '<div class="mb-3">' +
                    '<label class="form-label">Question Text *</label>' +
                    '<textarea class="form-control" id="question' + questionCount + '" rows="2" required></textarea>' +
                '</div>' +
                '<div class="row g-3 mb-3">' +
                    '<div class="col-md-6">' +
                        '<label class="form-label">Option A *</label>' +
                        '<div class="input-group">' +
                            '<span class="input-group-text bg-success text-white">A</span>' +
                            '<input type="text" class="form-control" id="optionA' + questionCount + '" required>' +
                        '</div>' +
                    '</div>' +
                    '<div class="col-md-6">' +
                        '<label class="form-label">Option B *</label>' +
                        '<div class="input-group">' +
                            '<span class="input-group-text bg-info text-white">B</span>' +
                            '<input type="text" class="form-control" id="optionB' + questionCount + '" required>' +
                        '</div>' +
                    '</div>' +
                    '<div class="col-md-6">' +
                        '<label class="form-label">Option C *</label>' +
                        '<div class="input-group">' +
                            '<span class="input-group-text bg-warning text-dark">C</span>' +
                            '<input type="text" class="form-control" id="optionC' + questionCount + '" required>' +
                        '</div>' +
                    '</div>' +
                    '<div class="col-md-6">' +
                        '<label class="form-label">Option D *</label>' +
                        '<div class="input-group">' +
                            '<span class="input-group-text bg-danger text-white">D</span>' +
                            '<input type="text" class="form-control" id="optionD' + questionCount + '" required>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="row g-3 mb-3">' +
                    '<div class="col-md-4">' +
                        '<label class="form-label">Correct Option *</label>' +
                        '<select class="form-select" id="correct' + questionCount + '" required>' +
                            '<option value="">Select</option>' +
                            '<option value="A">A</option>' +
                            '<option value="B">B</option>' +
                            '<option value="C">C</option>' +
                            '<option value="D">D</option>' +
                        '</select>' +
                    '</div>' +
                    '<div class="col-md-8">' +
                        '<label class="form-label">Explanation (Optional)</label>' +
                        '<input type="text" class="form-control" id="explanation' + questionCount + '">' +
                    '</div>' +
                '</div>';
            
            container.insertAdjacentHTML('beforeend', questionHtml);
        }

        async function saveMCQQuestions(e) {
            e.preventDefault();
            
            const contentId = document.getElementById('mcqContentId').value;
            const questions = [];
            
            for (let i = 1; i <= questionCount; i++) {
                const question = {
                    contentId: parseInt(contentId),
                    questionText: document.getElementById('question' + i).value,
                    optionA: document.getElementById('optionA' + i).value,
                    optionB: document.getElementById('optionB' + i).value,
                    optionC: document.getElementById('optionC' + i).value,
                    optionD: document.getElementById('optionD' + i).value,
                    correctOption: document.getElementById('correct' + i).value,
                    explanation: document.getElementById('explanation' + i).value,
                    createdBy: currentTeacherId
                };
                
                if (!question.questionText || !question.optionA || !question.optionB || 
                    !question.optionC || !question.optionD || !question.correctOption) {
                    alert('Please fill all required fields for Question ' + i);
                    return;
                }
                
                questions.push(question);
            }
            
            try {
                showLoading('Saving MCQ questions...');
                
                const response = await fetch(MCQ_API + '/add', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(questions)
                });
                
                const result = await response.json();
                hideLoading();
                
                if (result.success) {
                    showToast('MCQ questions added successfully!', 'success');
                    bootstrap.Modal.getInstance(document.getElementById('addMCQModal')).hide();
                    loadMCQCount(contentId);
                    loadStatistics();
                } else {
                    showToast('Error: ' + (result.message || 'Unknown error occurred'), 'error');
                }
            } catch (error) {
                hideLoading();
                console.error('Error saving MCQ:', error);
                showToast('Error saving MCQ questions. Please try again.', 'error');
            }
        }

        async function viewMCQQuestions(contentId) {
            try {
                const response = await fetch(MCQ_API + '/content/' + contentId);
                const questions = await response.json();
                
                let html = '<div class="list-group">';
                
                if (questions.length === 0) {
                    html = '<p class="text-center text-muted">No MCQ questions added yet for this material.</p>';
                } else {
                    questions.forEach((q, index) => {
                        html += 
                            '<div class="list-group-item mb-3">' +
                                '<h6 class="mb-2">Q' + (index + 1) + ': ' + escapeHTML(q.questionText) + '</h6>' +
                                '<div class="row g-2 mb-2">' +
                                    '<div class="col-md-6"><span class="badge bg-success">A</span> ' + escapeHTML(q.optionA) + '</div>' +
                                    '<div class="col-md-6"><span class="badge bg-info">B</span> ' + escapeHTML(q.optionB) + '</div>' +
                                    '<div class="col-md-6"><span class="badge bg-warning text-dark">C</span> ' + escapeHTML(q.optionC) + '</div>' +
                                    '<div class="col-md-6"><span class="badge bg-danger">D</span> ' + escapeHTML(q.optionD) + '</div>' +
                                '</div>' +
                                '<p class="mb-0 text-success"><i class="fas fa-check-circle me-1"></i> Correct Answer: ' + q.correctOption + '</p>' +
                                (q.explanation ? '<small class="text-muted">Explanation: ' + escapeHTML(q.explanation) + '</small>' : '') +
                            '</div>';
                    });
                }
                html += '</div>';
                document.getElementById('viewMCQContent').innerHTML = html;
                
                const modal = new bootstrap.Modal(document.getElementById('viewMCQModal'));
                modal.show();
                
            } catch (error) {
                console.error('Error viewing MCQ:', error);
                showToast('Error loading MCQ questions.', 'error');
            }
        }

        function openFinalTestModal() {
            // Populate courses from teacher's subjects
            const courseSelect = document.getElementById('finalTestCourse');
            courseSelect.innerHTML = '<option value="">Select Course</option>';
            teacherSubjects.forEach(subject => {
                courseSelect.innerHTML += '<option value="' + escapeHTML(subject) + '">' + escapeHTML(subject) + '</option>';
            });
            
            // Reset form
            document.getElementById('finalTestTitle').value = '';
            document.getElementById('finalTestDescription').value = '';
            document.getElementById('passingPercentage').value = '50';
            document.getElementById('finalQuestions').innerHTML = '';
            finalQuestionCount = 0;
            
            const modal = new bootstrap.Modal(document.getElementById('finalTestModal'));
            modal.show();
        }

        function addFinalQuestion() {
            finalQuestionCount++;
            const container = document.getElementById('finalQuestions');
            
            const questionHtml = 
                '<div class="card mb-3 p-3" id="finalQ' + finalQuestionCount + '">' +
                    '<h6 class="text-danger mb-2">Question ' + finalQuestionCount + '</h6>' +
                    '<div class="mb-2">' +
                        '<input type="text" class="form-control" id="finalQText' + finalQuestionCount + '" placeholder="Question text" required>' +
                    '</div>' +
                    '<div class="row g-2 mb-2">' +
                        '<div class="col-md-6">' +
                            '<input type="text" class="form-control" id="finalQA' + finalQuestionCount + '" placeholder="Option A" required>' +
                        '</div>' +
                        '<div class="col-md-6">' +
                            '<input type="text" class="form-control" id="finalQB' + finalQuestionCount + '" placeholder="Option B" required>' +
                        '</div>' +
                        '<div class="col-md-6">' +
                            '<input type="text" class="form-control" id="finalQC' + finalQuestionCount + '" placeholder="Option C" required>' +
                        '</div>' +
                        '<div class="col-md-6">' +
                            '<input type="text" class="form-control" id="finalQD' + finalQuestionCount + '" placeholder="Option D" required>' +
                        '</div>' +
                    '</div>' +
                    '<div class="row">' +
                        '<div class="col-md-6">' +
                            '<select class="form-select" id="finalQCorrect' + finalQuestionCount + '" required>' +
                                '<option value="">Correct Option</option>' +
                                '<option value="A">A</option>' +
                                '<option value="B">B</option>' +
                                '<option value="C">C</option>' +
                                '<option value="D">D</option>' +
                            '</select>' +
                        '</div>' +
                        '<div class="col-md-6">' +
                            '<button type="button" class="btn btn-danger btn-sm" onclick="removeFinalQuestion(' + finalQuestionCount + ')">' +
                                '<i class="fas fa-trash me-1"></i> Remove' +
                            '</button>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            
            container.insertAdjacentHTML('beforeend', questionHtml);
        }

        function removeFinalQuestion(num) {
            const element = document.getElementById('finalQ' + num);
            if (element) element.remove();
        }

        async function createFinalTest(e) {
            e.preventDefault();
            
            const course = document.getElementById('finalTestCourse').value;
            const title = document.getElementById('finalTestTitle').value;
            const description = document.getElementById('finalTestDescription').value;
            const passingPercentage = document.getElementById('passingPercentage').value;
            
            if (!course || !title) {
                showToast('Please fill all required fields', 'error');
                return;
            }
            
            const questions = [];
            for (let i = 1; i <= finalQuestionCount; i++) {
                const questionText = document.getElementById('finalQText' + i)?.value;
                const optionA = document.getElementById('finalQA' + i)?.value;
                const optionB = document.getElementById('finalQB' + i)?.value;
                const optionC = document.getElementById('finalQC' + i)?.value;
                const optionD = document.getElementById('finalQD' + i)?.value;
                const correctOption = document.getElementById('finalQCorrect' + i)?.value;
                
                if (questionText && optionA && optionB && optionC && optionD && correctOption) {
                    questions.push({
                        questionText: questionText,
                        optionA: optionA,
                        optionB: optionB,
                        optionC: optionC,
                        optionD: optionD,
                        correctOption: correctOption
                    });
                }
            }
            
            if (questions.length === 0) {
                showToast('Please add at least one question', 'error');
                return;
            }
            
            console.log('Creating final test with data:', {
                course: course,
                title: title,
                description: description,
                passingPercentage: parseInt(passingPercentage),
                questions: questions,
                createdBy: currentTeacherId
            });
            
            try {
                showLoading('Creating final test...');
                
                const response = await fetch(MCQ_API + '/final/create', {
                    method: 'POST',
                    headers: { 
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        course: course,
                        title: title,
                        description: description,
                        passingPercentage: parseInt(passingPercentage),
                        questions: questions,
                        createdBy: currentTeacherId
                    })
                });
                
                const result = await response.json();
                hideLoading();
                
                if (result.success) {
                    showToast('Final test created successfully!', 'success');
                    
                    // Close modal
                    const modal = bootstrap.Modal.getInstance(document.getElementById('finalTestModal'));
                    modal.hide();
                    
                    // Refresh content to show new test
                    loadContent();
                    
                } else {
                    console.error('Server error response:', result);
                    showToast('Error: ' + (result.message || 'Unknown error occurred'), 'error');
                }
            } catch (error) {
                hideLoading();
                console.error('Error creating final test:', error);
                showToast('Error: ' + error.message, 'error');
            }
        }

        function filterContent() {
            loadContent().then(content => {
                const subject = document.getElementById('filterSubject').value;
                const type = document.getElementById('filterType').value;
                
                let filtered = content;
                if (subject) {
                    filtered = filtered.filter(item => item.subjectName === subject);
                }
                if (type) {
                    filtered = filtered.filter(item => item.contentCategory === type);
                }
                renderContent(filtered);
            });
        }

        async function uploadDocument(e) {
            e.preventDefault();
            
            const formData = new FormData();
            formData.append('contentTitle', document.getElementById('contentTitle').value);
            formData.append('contentDescription', document.getElementById('contentDescription').value);
            formData.append('subjectName', document.getElementById('subjectName').value);
            formData.append('pageCount', document.getElementById('pageCount').value || 0);
            formData.append('educatorId', currentTeacherId);
            
            const fileInput = document.getElementById('documentFile');
            if (fileInput.files[0]) {
                formData.append('documentFile', fileInput.files[0]);
            }
            
            try {
                showLoading('Uploading document...');
                
                const response = await fetch(API_BASE + '/api/upload/document', {
                    method: 'POST',
                    body: formData
                });
                
                const result = await response.json();
                hideLoading();
                
                if (result.success) {
                    showToast('Document uploaded successfully!', 'success');
                    document.getElementById('uploadDocumentForm').reset();
                    loadStatistics();
                    loadContent();
                } else {
                    showToast('Error: ' + result.message, 'error');
                }
            } catch (error) {
                hideLoading();
                console.error('Upload error:', error);
                showToast('Error uploading document. Please try again.', 'error');
            }
        }

        async function addVideoLink(e) {
            e.preventDefault();
            
            const formData = new FormData();
            formData.append('contentTitle', document.getElementById('videoTitle').value);
            formData.append('contentDescription', document.getElementById('videoDescription').value);
            formData.append('subjectName', document.getElementById('videoSubject').value);
            formData.append('mediaUrl', document.getElementById('mediaUrl').value);
            formData.append('durationValue', document.getElementById('durationValue').value || 0);
            formData.append('educatorId', currentTeacherId);
            
            try {
                showLoading('Adding video link...');
                
                const response = await fetch(API_BASE + '/api/add/media', {
                    method: 'POST',
                    body: formData
                });
                
                const result = await response.json();
                hideLoading();
                
                if (result.success) {
                    showToast('Video link added successfully!', 'success');
                    document.getElementById('addVideoForm').reset();
                    loadStatistics();
                    loadContent();
                } else {
                    showToast('Error: ' + result.message, 'error');
                }
            } catch (error) {
                hideLoading();
                console.error('Add video error:', error);
                showToast('Error adding video link. Please try again.', 'error');
            }
        }

        // Delete confirmation functions
        function confirmDelete(contentId, contentTitle) {
            deleteContentId = contentId;
            document.getElementById('deleteContentTitle').textContent = contentTitle;
            const modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            modal.show();
        }

        async function deleteContent() {
            if (!deleteContentId) return;
            
            const modal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
            modal.hide();
            
            try {
                showLoading('Deleting content...');
                
                const response = await fetch(API_BASE + '/api/remove/' + deleteContentId, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                
                const result = await response.json();
                hideLoading();
                
                if (result.success) {
                    // Remove card from UI
                    const card = document.getElementById('content-card-' + deleteContentId);
                    if (card) {
                        card.remove();
                    }
                    
                    showToast('Content deleted successfully!', 'success');
                    
                    // Reload statistics
                    loadStatistics();
                    
                    // Check if grid is empty
                    const grid = document.getElementById('contentGrid');
                    if (grid.children.length === 0) {
                        grid.innerHTML = '<div class="empty-state"><i class="fas fa-sticky-note fa-3x mb-3"></i><h3>No study materials uploaded yet</h3><p>Upload your first document or video using the forms above.</p></div>';
                    }
                } else {
                    showToast('Error deleting content: ' + result.message, 'error');
                }
            } catch (error) {
                hideLoading();
                console.error('Delete error:', error);
                showToast('Error deleting content. Please try again.', 'error');
            } finally {
                deleteContentId = null;
            }
        }
    </script>
</body>
</html>