<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Test Scores | Student</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-blue: #002b5c;
            --secondary-blue: #00509e;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
        }

        body {
            background-color: #f5f7ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 30px;
        }

        .header {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 2.2rem;
            margin-bottom: 5px;
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
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            text-align: center;
            border-top: 4px solid var(--primary-blue);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2.5rem;
            color: var(--primary-blue);
            margin-bottom: 15px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-blue);
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }

        .eligibility-banner {
            background: linear-gradient(135deg, var(--success), #20c997);
            color: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .eligibility-banner.warning {
            background: linear-gradient(135deg, var(--warning), #fd7e14);
        }

        .eligibility-banner.info {
            background: linear-gradient(135deg, var(--info), #0d6efd);
        }

        .eligibility-btn {
            background: white;
            color: var(--primary-blue);
            padding: 12px 25px;
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

        .results-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
        }

        th {
            padding: 18px 15px;
            font-weight: 600;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .test-type {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .type-unit {
            background: #e3f2fd;
            color: #1976d2;
        }

        .type-final {
            background: #fff3e0;
            color: #f57c00;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-passed {
            background: #d4edda;
            color: #155724;
        }

        .status-failed {
            background: #f8d7da;
            color: #721c24;
        }

        .btn-view {
            background: var(--info);
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 13px;
            transition: all 0.3s;
            display: inline-block;
        }

        .btn-view:hover {
            transform: translateY(-2px);
            filter: brightness(1.1);
            color: white;
        }

        .certificate-btn {
            background: var(--success);
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 13px;
            transition: all 0.3s;
        }

        .certificate-btn:hover {
            transform: translateY(-2px);
            filter: brightness(1.1);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 60px;
            color: #e0e0e0;
            margin-bottom: 20px;
        }

        .filter-section {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .filter-select {
            padding: 8px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            min-width: 150px;
        }

        .filter-select:focus {
            border-color: var(--primary-blue);
            outline: none;
        }

        .course-badge {
            background: var(--light-blue);
            color: var(--primary-blue);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            body { padding: 15px; }
            .header { flex-direction: column; text-align: center; }
            .stats-container { grid-template-columns: 1fr; }
            table { display: block; overflow-x: auto; }
            .filter-section { flex-direction: column; }
            .filter-select { width: 100%; }
        }
    </style>
</head>
<body>
    <%
        // Check if student is logged in
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

    <div class="container-fluid">
        <!-- Header -->
        <div class="header">
            <div>
                <h1><i class="fas fa-chart-line me-3"></i>My Test Scores</h1>
                <p class="mb-0">Track your performance across all tests</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/student-dashboard" class="btn btn-light me-2">
                    <i class="fas fa-home me-2"></i>Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/student-course" class="btn btn-light">
                    <i class="fas fa-book-open me-2"></i>Courses
                </a>
            </div>
        </div>

        <!-- Enrolled Courses Display -->
        <div class="mb-3">
            <strong>Your Courses:</strong>
            <% if (enrolledCourses != null && !enrolledCourses.isEmpty()) { %>
                <% for (String course : enrolledCourses) { %>
                    <span class="course-badge"><i class="fas fa-book me-1"></i><%= course %></span>
                <% } %>
            <% } else { %>
                <span class="text-muted">No courses enrolled</span>
            <% } %>
        </div>

        <!-- Stats Cards -->
        <div class="stats-container" id="statsContainer">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-number" id="unitTestsCount">0</div>
                <div class="stat-label">Unit Tests Taken</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-star"></i></div>
                <div class="stat-number" id="avgPercentage">0%</div>
                <div class="stat-label">Average Score</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-trophy"></i></div>
                <div class="stat-number" id="highestScore">0</div>
                <div class="stat-label">Highest Score</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-flag-checkered"></i></div>
                <div class="stat-number" id="finalTestStatus">-</div>
                <div class="stat-label">Final Test</div>
            </div>
        </div>

        <!-- Eligibility Banner -->
        <div id="eligibilityBanner" style="display: none;"></div>

        <!-- Filter Section -->
        <div class="filter-section">
            <select class="filter-select" id="testTypeFilter">
                <option value="">All Test Types</option>
                <option value="UNIT">Unit Tests</option>
                <option value="FINAL">Final Tests</option>
            </select>
            <select class="filter-select" id="statusFilter">
                <option value="">All Status</option>
                <option value="PASSED">Passed</option>
                <option value="FAILED">Failed</option>
            </select>
            <select class="filter-select" id="courseFilter">
                <option value="">All Courses</option>
                <% if (enrolledCourses != null) { %>
                    <% for (String course : enrolledCourses) { %>
                        <option value="<%= course %>"><%= course %></option>
                    <% } %>
                <% } %>
            </select>
            <button class="btn btn-primary" onclick="applyFilters()">
                <i class="fas fa-filter me-2"></i>Apply Filters
            </button>
            <button class="btn btn-secondary" onclick="resetFilters()">
                <i class="fas fa-sync-alt me-2"></i>Reset
            </button>
        </div>

        <!-- Results Table -->
        <div class="results-table">
            <table>
                <thead>
                    <tr>
                        <th>Test Name</th>
                        <th>Course</th>
                        <th>Type</th>
                        <th>Score</th>
                        <th>Percentage</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="resultsTableBody">
                    <tr>
                        <td colspan="8" class="empty-state">
                            <i class="fas fa-spinner fa-spin fa-3x"></i>
                            <h4>Loading your results...</h4>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const API_BASE = '${pageContext.request.contextPath}';
        const MCQ_API = API_BASE + '/api/mcq';
        const studentId = document.getElementById('studentId').value;
        const studentName = document.getElementById('studentName').value;
        
        let allResults = [];
        let filteredResults = [];

        document.addEventListener('DOMContentLoaded', function() {
            loadStudentResults();
        });

        async function loadStudentResults() {
            try {
                console.log('Loading results for student:', studentId);
                
                const response = await fetch(MCQ_API + '/student/' + studentId + '/results');
                const data = await response.json();
                
                console.log('Results data received:', data);
                
                if (data.success) {
                    allResults = data.results || [];
                    updateStats(data.stats);
                    updateEligibilityBanner(data.eligibility);
                    renderResults(allResults);
                } else {
                    console.error('Error in response:', data.message);
                    loadDemoData();
                }
                
            } catch (error) {
                console.error('Error loading results:', error);
                loadDemoData();
            }
        }

        function updateStats(stats) {
            document.getElementById('unitTestsCount').textContent = stats.unitTestsCount || 0;
            document.getElementById('avgPercentage').textContent = (stats.avgPercentage || 0) + '%';
            document.getElementById('highestScore').textContent = stats.highestScore || 0;
            
            let finalStatus = stats.finalTestStatus || 'Not Attempted';
            if (stats.finalTestScore) {
                finalStatus = stats.finalTestScore + '/' + stats.finalTestTotal + ' (' + Math.round(stats.finalTestPercentage) + '%)';
            }
            document.getElementById('finalTestStatus').textContent = finalStatus;
        }

        function updateEligibilityBanner(eligibility) {
            const banner = document.getElementById('eligibilityBanner');
            
            if (!eligibility) return;
            
            if (eligibility.isEligible && !eligibility.finalAttempted) {
                banner.className = 'eligibility-banner';
                banner.innerHTML = 
                    '<div>' +
                        '<i class="fas fa-check-circle me-2 fa-2x"></i>' +
                        '<div>' +
                            '<h4 class="mb-1">You are eligible for the Final Test!</h4>' +
                            '<p class="mb-0">Your unit test average is ' + eligibility.avgPercentage + '%. You can now attempt the final examination.</p>' +
                        '</div>' +
                    '</div>' +
                    '<a href="' + API_BASE + '/student-course" class="eligibility-btn">' +
                        '<i class="fas fa-arrow-right me-2"></i>Take Final Test' +
                    '</a>';
                banner.style.display = 'flex';
            } else if (eligibility.finalAttempted) {
                banner.className = 'eligibility-banner info';
                banner.innerHTML = 
                    '<div>' +
                        '<i class="fas fa-check-circle me-2 fa-2x"></i>' +
                        '<div>' +
                            '<h4 class="mb-1">Final Test Completed!</h4>' +
                            '<p class="mb-0">Check your final test results in the table below.</p>' +
                        '</div>' +
                    '</div>';
                banner.style.display = 'flex';
            } else if (eligibility.unitTestsTaken > 0) {
                banner.className = 'eligibility-banner warning';
                banner.innerHTML = 
                    '<div>' +
                        '<i class="fas fa-exclamation-triangle me-2 fa-2x"></i>' +
                        '<div>' +
                            '<h4 class="mb-1">Not Eligible for Final Test Yet</h4>' +
                            '<p class="mb-0">You need to score above 50% average in unit tests. Current average: ' + eligibility.avgPercentage + '%</p>' +
                        '</div>' +
                    '</div>';
                banner.style.display = 'flex';
            }
        }

        function renderResults(results) {
            const tbody = document.getElementById('resultsTableBody');
            filteredResults = results;
            
            if (!results || results.length === 0) {
                tbody.innerHTML = 
                    '<tr>' +
                        '<td colspan="8" class="empty-state">' +
                            '<i class="fas fa-database fa-3x"></i>' +
                            '<h4>No test results found</h4>' +
                            '<p>Start taking tests to see your results here.</p>' +
                        '</td>' +
                    '</tr>';
                return;
            }
            
            tbody.innerHTML = '';
            
            results.sort((a, b) => new Date(b.completedAt) - new Date(a.completedAt));
            
            results.forEach(result => {
                const row = document.createElement('tr');
                const percentage = Math.round(result.percentage);
                const passed = percentage >= 50;
                const date = result.completedAt ? new Date(result.completedAt).toLocaleDateString('en-IN') : 'N/A';
                
                row.innerHTML = 
                    '<td><strong>' + escapeHTML(result.contentTitle || 'Untitled Test') + '</strong></td>' +
                    '<td>' + escapeHTML(result.subjectName || 'N/A') + '</td>' +
                    '<td><span class="test-type type-' + (result.testType || 'unit').toLowerCase() + '">' + (result.testType || 'UNIT') + '</span></td>' +
                    '<td>' + (result.score || 0) + '/' + (result.totalQuestions || 0) + '</td>' +
                    '<td>' + percentage + '%</td>' +
                    '<td><span class="status-badge status-' + (passed ? 'passed' : 'failed') + '">' + (passed ? 'PASSED' : 'FAILED') + '</span></td>' +
                    '<td>' + date + '</td>' +
                    '<td>' +
                        '<a href="' + MCQ_API + '/result/' + result.attemptId + '" class="btn-view">' +
                            '<i class="fas fa-eye me-1"></i> View' +
                        '</a>' +
                    '</td>';
                
                tbody.appendChild(row);
            });
        }

        function applyFilters() {
            const testType = document.getElementById('testTypeFilter').value;
            const status = document.getElementById('statusFilter').value;
            const course = document.getElementById('courseFilter').value;
            
            let filtered = allResults;
            
            if (testType) {
                filtered = filtered.filter(r => r.testType === testType);
            }
            
            if (status) {
                const passed = status === 'PASSED';
                filtered = filtered.filter(r => (r.percentage >= 50) === passed);
            }
            
            if (course) {
                filtered = filtered.filter(r => r.subjectName === course);
            }
            
            renderResults(filtered);
        }

        function resetFilters() {
            document.getElementById('testTypeFilter').value = '';
            document.getElementById('statusFilter').value = '';
            document.getElementById('courseFilter').value = '';
            renderResults(allResults);
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

        // Demo data function for testing when API is not available
        function loadDemoData() {
            console.log('Loading demo data');
            
            const demoStats = {
                unitTestsCount: 5,
                avgPercentage: 72,
                highestScore: 9,
                finalTestStatus: 'Not Attempted',
                finalTestScore: null,
                finalTestTotal: null,
                finalTestPercentage: null
            };
            
            const demoEligibility = {
                isEligible: true,
                finalAttempted: false,
                avgPercentage: 72,
                unitTestsTaken: 5
            };
            
            const demoResults = [
                {
                    attemptId: 'ATT001',
                    contentTitle: 'Java Basics Test',
                    subjectName: 'Java Programming',
                    testType: 'UNIT',
                    score: 8,
                    totalQuestions: 10,
                    percentage: 80,
                    completedAt: '2025-02-15T10:30:00'
                },
                {
                    attemptId: 'ATT002',
                    contentTitle: 'Python Fundamentals',
                    subjectName: 'Python Programming',
                    testType: 'UNIT',
                    score: 6,
                    totalQuestions: 10,
                    percentage: 60,
                    completedAt: '2025-02-10T14:20:00'
                },
                {
                    attemptId: 'ATT003',
                    contentTitle: 'OOP Concepts',
                    subjectName: 'Java Programming',
                    testType: 'UNIT',
                    score: 9,
                    totalQuestions: 10,
                    percentage: 90,
                    completedAt: '2025-02-05T09:15:00'
                },
                {
                    attemptId: 'ATT004',
                    contentTitle: 'Data Structures Final',
                    subjectName: 'Data Structures & Algorithms',
                    testType: 'FINAL',
                    score: 18,
                    totalQuestions: 20,
                    percentage: 90,
                    completedAt: '2025-02-20T11:00:00'
                }
            ];
            
            allResults = demoResults;
            updateStats(demoStats);
            updateEligibilityBanner(demoEligibility);
            renderResults(demoResults);
        }
    </script>
</body>
</html>