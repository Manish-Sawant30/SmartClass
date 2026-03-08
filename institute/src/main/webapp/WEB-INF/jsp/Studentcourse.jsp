<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses & Materials | EduEra Student</title>
    
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
            --white: #ffffff;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --info: #17a2b8;
            --mcq-purple: #6f42c1;
            --dark-blue: #001833;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            --shadow-light: 0 2px 8px rgba(0, 0, 0, 0.1);
            --radius: 16px;
            --radius-sm: 10px;
            --transition: all 0.3s ease;
            --material-blue: #0d6efd;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: #333;
            line-height: 1.6;
        }

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

        .student-container {
            padding: 30px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .student-banner {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            padding: 25px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .subjects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .subject-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            border: 1px solid #eee;
        }

        .subject-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .subject-header {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            padding: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .subject-header h3 {
            margin: 0;
            font-size: 1.4rem;
            font-weight: 600;
        }

        .subject-header p {
            margin: 5px 0 0;
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .materials-list {
            padding: 20px;
        }

        .material-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }

        .material-item:last-child {
            border-bottom: none;
        }

        .material-info {
            display: flex;
            align-items: center;
            gap: 15px;
            flex: 1;
        }

        .material-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .material-icon.document {
            background: #e3f2fd;
            color: #1976d2;
        }

        .material-icon.video {
            background: #e8f5e9;
            color: #388e3c;
        }

        .material-icon.mcq {
            background: #f3e5f5;
            color: #6f42c1;
        }

        .material-details h5 {
            margin: 0;
            font-size: 1rem;
            font-weight: 600;
        }

        .material-details small {
            color: #666;
            font-size: 0.8rem;
        }

        .material-actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: flex-end;
            min-width: 200px;
        }

        .btn-action {
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 0.85rem;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-download {
            background: var(--success);
            color: white;
        }

        .btn-watch {
            background: var(--danger);
            color: white;
        }

        .btn-mcq {
            background: var(--mcq-purple);
            color: white;
        }

        .btn-completed {
            background: #6c757d;
            color: white;
            cursor: not-allowed;
        }

        .btn-mcq:hover:not(.btn-completed) {
            transform: translateY(-2px);
            filter: brightness(1.1);
        }

        .btn-materials {
            background: var(--material-blue);
            color: white;
        }

        .btn-materials:hover {
            background: #0b5ed7;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(13, 110, 253, 0.3);
        }

        .eligibility-banner {
            background: linear-gradient(135deg, var(--success), #20c997);
            color: white;
            border-radius: 15px;
            padding: 20px 30px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .eligibility-banner.warning {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
        }

        .eligibility-banner.info {
            background: linear-gradient(135deg, var(--info), #0d6efd);
        }

        .eligibility-banner h3 {
            margin: 0 0 5px;
            font-size: 1.5rem;
        }

        .eligibility-banner p {
            margin: 0;
            opacity: 0.95;
        }

        .eligibility-btn {
            background: white;
            color: var(--primary-blue);
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            border: none;
        }

        .eligibility-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .progress-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .progress-completed {
            background: #d4edda;
            color: #155724;
        }

        .progress-pending {
            background: #fff3cd;
            color: #856404;
        }

        .final-test-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            background: #f093fb;
            color: white;
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

        .modal-header.bg-mcq {
            background: linear-gradient(135deg, var(--mcq-purple), #8a2be2);
            color: white;
        }

        .option-box {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .option-box:hover {
            border-color: var(--mcq-purple);
            background-color: #f8f9fa;
        }

        .option-box.selected {
            border-color: var(--mcq-purple);
            background-color: rgba(111, 66, 193, 0.05);
        }

        .option-prefix {
            display: inline-block;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: #f0f0f0;
            text-align: center;
            line-height: 30px;
            font-weight: 600;
            margin-right: 10px;
        }

        .option-box.selected .option-prefix {
            background: var(--mcq-purple);
            color: white;
        }

        .debug-panel {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            font-family: monospace;
            font-size: 12px;
            display: none;
        }

        .debug-panel.visible {
            display: block;
        }

        .debug-toggle {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            background: var(--primary-blue);
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 20px;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }

        @media (max-width: 768px) {
            .navbar-custom {
                padding: 0.8rem 1rem;
            }
            
            .student-container { padding: 15px; }
            .subjects-grid { grid-template-columns: 1fr; }
            .eligibility-banner { flex-direction: column; text-align: center; }
            .material-actions { flex-direction: column; align-items: flex-end; min-width: auto; }
            .btn-action { width: 100%; justify-content: center; }
        }
    </style>
</head>
<body>
    <%
        com.example.institute.model.Student student = (com.example.institute.model.Student) session.getAttribute("student");
        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }
        
        String studentId = student.getStudentId();
        String studentName = student.getFullName();
        java.util.List<String> enrolledCourses = student.getCourses();
    %>

    <input type="hidden" id="studentId" value="<%= studentId %>">
    <input type="hidden" id="studentName" value="<%= studentName %>">
    
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/student-course">
                            <i class="fas fa-book"></i> My Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/studenttestscore">
                            <i class="fas fa-chart-line"></i> My Results
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/certificate/verify">
                            <i class="fas fa-award"></i> Certificate
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                            <i class="fas fa-envelope"></i> Contact Us
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/student-logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <button class="debug-toggle" onclick="toggleDebug()">
        <i class="fas fa-bug"></i>
    </button>

    <div id="debugPanel" class="debug-panel">
        <h6>Debug Information</h6>
        <div id="debugContent"></div>
    </div>

    <div class="student-container">
        <div class="student-banner">
            <div class="d-flex align-items-center gap-4">
                <div class="bg-white rounded-circle p-3">
                    <i class="fas fa-user-graduate fa-3x" style="color: var(--primary-blue);"></i>
                </div>
                <div>
                    <h2>Welcome, <%= studentName %>!</h2>
                    <p class="mb-1">Student ID: <strong><%= studentId %></strong></p>
                    <p>Enrolled Courses: <strong><%= enrolledCourses != null ? String.join(", ", enrolledCourses) : "None" %></strong></p>
                </div>
            </div>
        </div>

        <div id="eligibilityBanner" style="display: none;"></div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3><i class="fas fa-book-open me-2" style="color: var(--primary-blue);"></i> My Course Materials</h3>
            <div>
                <select class="form-select" id="filterType" style="width: auto; display: inline-block; margin-right: 10px;">
                    <option value="">All Materials</option>
                    <option value="DOCUMENT">Documents Only</option>
                    <option value="MEDIA">Videos Only</option>
                    <option value="UNIT_TEST">Unit Tests Only</option>
                    <option value="FINAL_TEST">Final Tests Only</option>
                    <option value="STUDY_MATERIALS">Study Materials Only</option>
                </select>
            </div>
        </div>

        <div class="subjects-grid" id="coursesGrid">
            <div class="empty-state">
                <i class="fas fa-spinner fa-spin fa-3x"></i>
                <h3>Loading your course materials...</h3>
            </div>
        </div>
    </div>

    <!-- Take Test Modal -->
    <div class="modal fade" id="takeTestModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-mcq text-white">
                    <h5 class="modal-title"><i class="fas fa-pencil-alt me-2"></i> <span id="modalTestTitle"></span></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Important:</strong> You can only attempt this test once. Make sure you're ready before starting.
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="card bg-light">
                                <div class="card-body">
                                    <h6><i class="fas fa-question-circle me-2"></i>Test Details</h6>
                                    <p class="mb-1">Total Questions: <strong id="modalTotalQuestions">0</strong></p>
                                    <p class="mb-1">Passing Criteria: <strong>50%</strong></p>
                                    <p class="mb-0">Time Limit: <strong>No Limit</strong></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card bg-light">
                                <div class="card-body">
                                    <h6><i class="fas fa-list-ol me-2"></i>Instructions</h6>
                                    <ul class="mb-0 ps-3">
                                        <li>Read each question carefully</li>
                                        <li>You can change answers before submitting</li>
                                        <li>Results shown immediately after submission</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-success" onclick="startTest()" id="startTestBtn">
                        <i class="fas fa-play me-2"></i> Start Test
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Study Materials Modal -->
    <div class="modal fade" id="studyMaterialsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue)); color: white;">
                    <h5 class="modal-title"><i class="fas fa-book-open me-2"></i> <span id="modalCourseName"></span> - Study Materials</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="studyMaterialsContent">
                    <div class="text-center">
                        <i class="fas fa-spinner fa-spin fa-3x"></i>
                        <p>Loading materials...</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const API_BASE = '${pageContext.request.contextPath}';
        const MCQ_API = API_BASE + '/api/mcq';
        const CONTENT_API = API_BASE + '/content';
        
        let studentId = document.getElementById('studentId').value;
        let studentName = document.getElementById('studentName').value;
        let enrolledCourses = <%= enrolledCourses != null ? 
            "['" + String.join("','", enrolledCourses) + "']" : "[]" %>;
        
        let currentTestId = null;
        let currentTestType = null;
        let currentTestCourse = null;
        let currentTestTitle = null;
        let completedTests = new Set();
        let allContent = [];
        let eligibilityData = null;
        let finalTests = [];
        let courseEligibilityMap = new Map();
        let finalTestMap = new Map(); // Track which content IDs are final tests

        document.addEventListener('DOMContentLoaded', function() {
            console.log('Student ID:', studentId);
            console.log('Student Name:', studentName);
            console.log('Enrolled Courses:', enrolledCourses);
            
            loadEligibilityStatus();
            loadCourseMaterials();
            document.getElementById('filterType').addEventListener('change', filterMaterials);
            
            const currentPath = window.location.pathname;
            document.querySelectorAll('.nav-link').forEach(link => {
                const href = link.getAttribute('href');
                if (href && currentPath.includes(href)) {
                    link.classList.add('active');
                }
            });
        });

        function toggleDebug() {
            const panel = document.getElementById('debugPanel');
            panel.classList.toggle('visible');
        }

        function updateDebug(message) {
            const debugContent = document.getElementById('debugContent');
            debugContent.innerHTML += '<div>' + new Date().toLocaleTimeString() + ': ' + message + '</div>';
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

        function showStudyMaterials(courseName) {
            const modal = new bootstrap.Modal(document.getElementById('studyMaterialsModal'));
            document.getElementById('modalCourseName').textContent = courseName;
            
            const materialsContent = document.getElementById('studyMaterialsContent');
            
            const courseMaterials = allContent.filter(item => 
                item.subjectName === courseName && 
                (item.contentCategory === 'DOCUMENT' || item.contentCategory === 'MEDIA')
            );
            
            if (courseMaterials.length === 0) {
                materialsContent.innerHTML = '<div class="text-center py-4"><i class="fas fa-book-open fa-4x mb-3" style="color: #ccc;"></i><h5>No study materials available for this course</h5><p>Check back later for documents and videos.</p></div>';
            } else {
                let html = '<div class="list-group">';
                courseMaterials.forEach(item => {
                    const isDocument = item.contentCategory === 'DOCUMENT';
                    html += 
                        '<div class="list-group-item d-flex justify-content-between align-items-center">' +
                            '<div>' +
                                '<i class="fas ' + (isDocument ? 'fa-file-pdf' : 'fa-video') + ' me-3" style="color: ' + (isDocument ? '#dc3545' : '#198754') + ';"></i>' +
                                '<strong>' + escapeHTML(item.contentTitle) + '</strong><br>' +
                                '<small class="text-muted">' + (isDocument ? 'Document' : 'Video') + '</small>' +
                            '</div>' +
                            (isDocument ? 
                                '<a href="' + CONTENT_API + '/download/document/' + item.contentId + '" class="btn btn-sm btn-success" download>' +
                                    '<i class="fas fa-download"></i> Download' +
                                '</a>' : 
                                '<a href="' + escapeHTML(item.mediaLink) + '" class="btn btn-sm btn-danger" target="_blank">' +
                                    '<i class="fas fa-play"></i> Watch' +
                                '</a>'
                            ) +
                        '</div>';
                });
                html += '</div>';
                materialsContent.innerHTML = html;
            }
            
            modal.show();
        }

        async function loadEligibilityStatus() {
            try {
                console.log('Loading eligibility status from backend...');
                const response = await fetch(MCQ_API + '/student/eligibility/' + studentId);
                const data = await response.json();
                
                console.log('Full Eligibility Data from Backend:', data);
                
                if (data.success) {
                    eligibilityData = data;
                    
                    if (data.courseEligibility) {
                        courseEligibilityMap = new Map(Object.entries(data.courseEligibility));
                        console.log('Course Eligibility Map from backend:', Object.fromEntries(courseEligibilityMap));
                    }
                    
                    updateEligibilityBanner(data);
                } else {
                    console.error('Eligibility API returned success: false');
                }
            } catch (error) {
            }
        }

        function updateEligibilityBanner(data) {
            const banner = document.getElementById('eligibilityBanner');
            
            if (!data) return;
            
            let eligibleCourses = [];
            if (data.courseEligibility) {
                for (const [course, isEligible] of Object.entries(data.courseEligibility)) {
                    if (isEligible) {
                        eligibleCourses.push(course);
                    }
                }
            }
            
            if (eligibleCourses.length > 0) {
                banner.className = 'eligibility-banner';
                banner.innerHTML = 
                    '<div>' +
                        '<h3><i class="fas fa-check-circle me-2"></i> You are eligible for Final Tests!</h3>' +
                        '<p>You can now attempt the final examination for: <strong>' + eligibleCourses.join(', ') + '</strong></p>' +
                    '</div>' +
                    '<a href="#final-tests-section" class="eligibility-btn" onclick="scrollToFinalTests()">' +
                        '<i class="fas fa-arrow-right me-2"></i> Take Final Test' +
                    '</a>';
                banner.style.display = 'flex';
            } else {
                banner.style.display = 'none';
            }
        }

        async function loadCourseMaterials() {
            try {
                updateDebug('Fetching content from: ' + CONTENT_API + '/api/student-content');
                
                const response = await fetch(CONTENT_API + '/api/student-content', {
                    credentials: 'include',
                    headers: {
                        'Accept': 'application/json'
                    }
                });
                
                updateDebug('Response status: ' + response.status);
                
                if (!response.ok) {
                    throw new Error('HTTP error! status: ' + response.status);
                }
                
                const content = await response.json();
                updateDebug('Received content: ' + content.length + ' items');
                
                console.log('Received content:', content);
                allContent = content;
                
                if (content.length === 0) {
                    updateDebug('No content received from API');
                    document.getElementById('coursesGrid').innerHTML = 
                        '<div class="empty-state">' +
                            '<i class="fas fa-database fa-3x"></i>' +
                            '<h3>No materials available</h3>' +
                            '<p>There are no study materials for your enrolled courses yet.</p>' +
                        '</div>';
                    return;
                }
                
                await loadEligibilityStatus();
                await identifyFinalTests();
                
                // Pre-load all test statuses to avoid async issues in render
                const testStatusPromises = [];
                for (const item of content) {
                    if (item.hasMCQ) {
                        testStatusPromises.push(
                            getTestStatus(item.contentId).then(status => ({
                                contentId: item.contentId,
                                status: status
                            }))
                        );
                    }
                }
                
                const testStatuses = await Promise.all(testStatusPromises);
                const testStatusMap = new Map();
                testStatuses.forEach(item => {
                    testStatusMap.set(item.contentId, item.status);
                    if (item.status.completed) {
                        completedTests.add(item.contentId);
                    }
                });
                
                // Build finalTestMap from backend data
                for (const item of content) {
                    if (item.hasMCQ) {
                        try {
                            const response = await fetch(MCQ_API + '/content/' + item.contentId);
                            if (response.ok) {
                                const questions = await response.json();
                                const isFinalTest = questions.some(q => q.finalTest === true);
                                if (isFinalTest) {
                                    finalTestMap.set(item.contentId, true);
                                }
                            }
                        } catch (e) {
                            console.log('Error checking final test for content ' + item.contentId);
                        }
                    }
                }
                
                renderCourses();
                
            } catch (error) {
                console.error('Error loading materials:', error);
                updateDebug('Error: ' + error.message);
                document.getElementById('coursesGrid').innerHTML = 
                    '<div class="empty-state">' +
                        '<i class="fas fa-exclamation-circle fa-3x" style="color: #dc3545;"></i>' +
                        '<h3>Error loading materials</h3>' +
                        '<p>' + error.message + '</p>' +
                        '<button class="btn btn-primary mt-3" onclick="loadCourseMaterials()">' +
                            '<i class="fas fa-sync-alt me-2"></i>Retry' +
                        '</button>' +
                    '</div>';
            }
        }

        async function identifyFinalTests() {
            try {
                finalTests = [];
                
                for (const item of allContent) {
                    if (item.hasMCQ) {
                        try {
                            const response = await fetch(MCQ_API + '/content/' + item.contentId);
                            if (response.ok) {
                                const questions = await response.json();
                                const hasFinalTest = questions.some(q => q.finalTest === true);
                                if (hasFinalTest) {
                                    finalTests.push(item.contentId);
                                    finalTestMap.set(item.contentId, true);
                                }
                            }
                        } catch (e) {
                            console.log('Error checking final test for content ' + item.contentId);
                        }
                    }
                }
                
                console.log('Final tests identified:', finalTests);
            } catch (error) {
                console.error('Error identifying final tests:', error);
            }
        }

        async function getTestStatus(contentId) {
            try {
                const response = await fetch(MCQ_API + '/status/' + studentId + '/' + contentId);
                return await response.json();
            } catch (error) {
                console.error('Error getting test status for ' + contentId + ':', error);
                return { completed: false };
            }
        }

		function renderCourses() {
		    const grid = document.getElementById('coursesGrid');
		    
		    if (allContent.length === 0) {
		        grid.innerHTML = 
		            '<div class="empty-state">' +
		                '<i class="fas fa-book-open fa-3x"></i>' +
		                '<h3>No course materials available</h3>' +
		                '<p>Materials for your enrolled courses will appear here once uploaded by teachers.</p>' +
		            '</div>';
		        return;
		    }
		    
		    // Group by subject
		    const coursesMap = new Map();
		    
		    allContent.forEach(item => {
		        if (!coursesMap.has(item.subjectName)) {
		            coursesMap.set(item.subjectName, {
		                studyMaterials: [],
		                unitTests: [],
		                finalTests: []
		            });
		        }
		        
		        const courseData = coursesMap.get(item.subjectName);
		        
		        // Check if this content has MCQ and is final test
		        const isFinalTest = finalTestMap.get(item.contentId) || false;
		        
		        if (item.hasMCQ) {
		            if (isFinalTest) {
		                courseData.finalTests.push(item);
		            } else {
		                courseData.unitTests.push(item);
		            }
		        }
		        
		        // Add to study materials ONLY if it's document or media AND it's NOT a final test
		        // Final tests should NOT appear in study materials even if they have document category
		        if ((item.contentCategory === 'DOCUMENT' || item.contentCategory === 'MEDIA') && !isFinalTest) {
		            courseData.studyMaterials.push(item);
		        }
		    });
		    
		    grid.innerHTML = '';
		    
		    for (const [courseName, courseData] of coursesMap.entries()) {
		        const isCourseEligibleForFinal = courseEligibilityMap.get(courseName) || false;
		        
		        // Calculate taken unit tests
		        const takenUnitTests = courseData.unitTests.filter(t => completedTests.has(t.contentId)).length;
		        const totalUnitTests = courseData.unitTests.length;
		        
		        const card = document.createElement('div');
		        card.className = 'subject-card';
		        card.setAttribute('data-subject', courseName);
		        
		        // Header
		        let headerHtml = 
		            '<div class="subject-header">' +
		                '<div class="d-flex justify-content-between align-items-start">' +
		                    '<div>' +
		                        '<h3>' + escapeHTML(courseName) + '</h3>' +
		                        '<p>' + (courseData.studyMaterials.length + courseData.unitTests.length + courseData.finalTests.length) + ' materials available</p>' +
		                    '</div>';
		        
		        if (courseData.unitTests.length > 0) {
		            const allCompleted = (takenUnitTests === courseData.unitTests.length);
		            headerHtml += 
		                '<span class="progress-badge ' + (allCompleted ? 'progress-completed' : 'progress-pending') + '">' +
		                    '<i class="fas ' + (allCompleted ? 'fa-check-circle' : 'fa-hourglass-half') + ' me-1"></i>' +
		                    takenUnitTests + '/' + courseData.unitTests.length + ' Unit Tests Completed' +
		                '</span>';
		        }
		        
		        headerHtml += '</div></div>';
		        card.innerHTML = headerHtml;
		        
		        // Materials list
		        let materialsHtml = '<div class="materials-list">';
		        
		        // STUDY MATERIALS SECTION
		        if (courseData.studyMaterials.length > 0) {
		            materialsHtml += '<h6 class="mt-3 mb-2"><i class="fas fa-file me-2" style="color: var(--primary-blue);"></i>Study Materials</h6>';
		            
		            // Remove duplicates from study materials
		            const uniqueStudyMaterials = courseData.studyMaterials.filter((item, index, self) => 
		                index === self.findIndex(s => s.contentId === item.contentId)
		            );
		            
		            for (const item of uniqueStudyMaterials) {
		                const isDocument = item.contentCategory === 'DOCUMENT';
		                
		                materialsHtml += 
		                    '<div class="material-item">' +
		                        '<div class="material-info">' +
		                            '<div class="material-icon ' + (isDocument ? 'document' : 'video') + '">' +
		                                '<i class="fas ' + (isDocument ? 'fa-file-pdf' : 'fa-video') + '"></i>' +
		                            '</div>' +
		                            '<div class="material-details">' +
		                                '<h5>' + escapeHTML(item.contentTitle) + '</h5>' +
		                                '<small>' + (isDocument ? 'Document' : 'Video Lecture') + '</small>' +
		                            '</div>' +
		                        '</div>' +
		                        '<div class="material-actions">';
		                
		                if (isDocument) {
		                    materialsHtml += 
		                        '<a href="' + CONTENT_API + '/download/document/' + item.contentId + '" class="btn-action btn-download" download>' +
		                            '<i class="fas fa-download me-1"></i> Download' +
		                        '</a>';
		                } else {
		                    materialsHtml += 
		                        '<a href="' + escapeHTML(item.mediaLink) + '" class="btn-action btn-watch" target="_blank">' +
		                            '<i class="fas fa-play me-1"></i> Watch' +
		                        '</a>';
		                }
		                
		                materialsHtml += '</div></div>';
		            }
		        }
		        
		        // UNIT TESTS SECTION
		        if (courseData.unitTests.length > 0) {
		            materialsHtml += '<h6 class="mt-3 mb-2"><i class="fas fa-question-circle me-2" style="color: var(--mcq-purple);"></i>Unit Tests</h6>';
		            
		            for (const item of courseData.unitTests) {
		                const isTestCompleted = completedTests.has(item.contentId);
		                
		                materialsHtml += 
		                    '<div class="material-item">' +
		                        '<div class="material-info">' +
		                            '<div class="material-icon mcq">' +
		                                '<i class="fas fa-question-circle"></i>' +
		                            '</div>' +
		                            '<div class="material-details">' +
		                                '<h5>' + escapeHTML(item.contentTitle) + '</h5>' +
		                                '<small>Unit Test</small>' +
		                            '</div>' +
		                        '</div>' +
		                        '<div class="material-actions">';
		                
		                if (isTestCompleted) {
		                    materialsHtml += 
		                        '<a href="' + MCQ_API + '/result/' + studentId + '/' + item.contentId + '" class="btn-action btn-completed">' +
		                            '<i class="fas fa-eye me-1"></i> View Result' +
		                        '</a>';
		                } else {
		                    materialsHtml += 
		                        '<button class="btn-action btn-mcq" onclick="openTestModal(' + item.contentId + ', \'UNIT\', \'' + escapeHTML(item.contentTitle) + '\', \'' + escapeHTML(courseName) + '\')">' +
		                            '<i class="fas fa-play me-1"></i> Take Test' +
		                        '</button>';
		                }
		                
		                materialsHtml += '</div></div>';
		            }
		        }
		        
		        // FINAL TESTS SECTION
		        if (courseData.finalTests.length > 0) {
		            materialsHtml += '<h6 class="mt-3 mb-2" id="final-tests-section"><i class="fas fa-trophy me-2" style="color: var(--warning);"></i>Final Examination</h6>';
		            
		            for (const item of courseData.finalTests) {
		                const isTestCompleted = completedTests.has(item.contentId);
		                
		                materialsHtml += 
		                    '<div class="material-item">' +
		                        '<div class="material-info">' +
		                            '<div class="material-icon mcq" style="background: #fff3e0; color: #f57c00;">' +
		                                '<i class="fas fa-trophy"></i>' +
		                            '</div>' +
		                            '<div class="material-details">' +
		                                '<h5>' + escapeHTML(item.contentTitle) + '</h5>' +
		                                '<small>Final Test</small>' +
		                            '</div>' +
		                        '</div>' +
		                        '<div class="material-actions">';
		                
		                if (isTestCompleted) {
		                    materialsHtml += 
		                        '<a href="' + MCQ_API + '/result/' + studentId + '/' + item.contentId + '" class="btn-action btn-completed">' +
		                            '<i class="fas fa-eye me-1"></i> View Result' +
		                        '</a>';
		                } else if (isCourseEligibleForFinal) {
		                    materialsHtml += 
		                        '<button class="btn-action btn-warning" style="background: #f57c00;" onclick="openTestModal(' + item.contentId + ', \'FINAL\', \'' + escapeHTML(item.contentTitle) + '\', \'' + escapeHTML(courseName) + '\')">' +
		                            '<i class="fas fa-play me-1"></i> Take Final Test' +
		                        '</button>';
		                } else {
		                    let lockReason = 'Locked';
		                    if (courseData.unitTests.length > 0 && takenUnitTests < courseData.unitTests.length) {
		                        lockReason = 'Complete all unit tests first';
		                    } else if (eligibilityData?.courseFinalAttempted?.[courseName]) {
		                        lockReason = 'Final test already attempted';
		                    } else {
		                        lockReason = 'Need 50%+ in all unit tests';
		                    }
		                    
		                    materialsHtml += 
		                        '<span class="btn-action btn-completed" style="background: #6c757d;" title="' + lockReason + '">' +
		                            '<i class="fas fa-lock me-1"></i> ' + lockReason +
		                        '</span>';
		                }
		                
		                materialsHtml += '</div></div>';
		            }
		        }
		        
		        materialsHtml += '</div>';
		        card.innerHTML += materialsHtml;
		        grid.appendChild(card);
		    }
		    
		    updateDebug('Rendered courses');
		}

        function openTestModal(contentId, testType, title, courseName) {
            if (testType === 'FINAL') {
                const isCourseEligible = courseEligibilityMap.get(courseName) || false;
                
                if (!isCourseEligible) {
                    let message = 'You are not eligible for the ' + courseName + ' final test.';
                    
                    const totalTests = eligibilityData?.courseUnitTestsTotal?.[courseName] || 0;
                    const takenTests = eligibilityData?.courseUnitTestsTaken?.[courseName] || 0;
                    const finalAttempted = eligibilityData?.courseFinalAttempted?.[courseName] || false;
                    
                    if (takenTests < totalTests) {
                        message += ' You need to complete all ' + totalTests + ' unit tests first.';
                    } else if (finalAttempted) {
                        message += ' You have already attempted this final test.';
                    } else {
                        message += ' You need to score 50% or above in all unit tests.';
                    }
                    
                    alert(message);
                    return;
                }
            }
            
            currentTestId = contentId;
            currentTestType = testType;
            currentTestCourse = courseName;
            currentTestTitle = title;
            
            document.getElementById('modalTestTitle').textContent = title;
            document.getElementById('modalTotalQuestions').textContent = 'Loading...';
            
            fetch(MCQ_API + '/count/' + contentId)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('modalTotalQuestions').textContent = data.count || 0;
                })
                .catch(() => {
                    document.getElementById('modalTotalQuestions').textContent = '0';
                });
            
            const modal = new bootstrap.Modal(document.getElementById('takeTestModal'));
            modal.show();
        }

        async function startTest() {
            try {
                const startBtn = document.getElementById('startTestBtn');
                startBtn.disabled = true;
                startBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Starting...';
                
                const response = await fetch(MCQ_API + '/start', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        studentId: studentId,
                        studentName: studentName,
                        contentId: currentTestId,
                        testType: currentTestType
                    })
                });
                
                const data = await response.json();
                
                if (data.success) {
                    const modal = bootstrap.Modal.getInstance(document.getElementById('takeTestModal'));
                    modal.hide();
                    
                    window.location.href = '${pageContext.request.contextPath}/api/mcq/take-test?attemptId=' + data.attemptId;
                } else {
                    alert('Error: ' + data.message);
                    startBtn.disabled = false;
                    startBtn.innerHTML = '<i class="fas fa-play me-2"></i> Start Test';
                }
            } catch (error) {
                console.error('Error starting test:', error);
                alert('Failed to start test. Please try again.');
                document.getElementById('startTestBtn').disabled = false;
                document.getElementById('startTestBtn').innerHTML = '<i class="fas fa-play me-2"></i> Start Test';
            }
        }

        function filterMaterials() {
            const filterType = document.getElementById('filterType').value;
            const cards = document.querySelectorAll('.subject-card');
            
            cards.forEach(card => {
                if (filterType === '') {
                    card.style.display = 'block';
                } else if (filterType === 'UNIT_TEST') {
                    const hasUnitTests = Array.from(card.querySelectorAll('.material-details small')).some(small => 
                        small.textContent.includes('Unit Test')
                    );
                    card.style.display = hasUnitTests ? 'block' : 'none';
                } else if (filterType === 'FINAL_TEST') {
                    const hasFinalTests = Array.from(card.querySelectorAll('.material-details small')).some(small => 
                        small.textContent.includes('Final')
                    );
                    card.style.display = hasFinalTests ? 'block' : 'none';
                } else if (filterType === 'STUDY_MATERIALS') {
                    const hasStudyMaterials = card.querySelector('.btn-download') !== null || card.querySelector('.btn-watch') !== null;
                    card.style.display = hasStudyMaterials ? 'block' : 'none';
                } else {
                    const hasMaterialType = Array.from(card.querySelectorAll('.material-icon')).some(icon => {
                        if (filterType === 'DOCUMENT') return icon.classList.contains('document');
                        if (filterType === 'MEDIA') return icon.classList.contains('video');
                        return true;
                    });
                    card.style.display = hasMaterialType ? 'block' : 'none';
                }
            });
        }

        function scrollToFinalTests() {
            const finalSection = document.getElementById('final-tests-section');
            if (finalSection) {
                finalSection.scrollIntoView({ behavior: 'smooth' });
            }
        }

        function diagnoseContentIssue() {
            console.log('=== DIAGNOSING CONTENT ISSUE ===');
            console.log('Student ID:', studentId);
            console.log('Enrolled Courses:', enrolledCourses);
            console.log('All Content from API:', allContent);
            console.log('Final Tests:', finalTests);
            console.log('Course Eligibility Map:', Object.fromEntries(courseEligibilityMap));
        }
    </script>
</body>
</html>