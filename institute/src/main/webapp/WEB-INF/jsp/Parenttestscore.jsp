<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Child's Progress | Parent Portal</title>
    
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
            --purple: #6f42c1;
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
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header h1 {
            font-size: 2.2rem;
            margin-bottom: 5px;
        }

        .back-btn {
            background: white;
            color: var(--primary-blue);
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .child-info {
            background: linear-gradient(135deg, var(--purple), #8a2be2);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .stats-grid {
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

        .stat-value {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary-blue);
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            margin-top: 5px;
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
            align-items: center;
        }

        .filter-select {
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            min-width: 150px;
            background: white;
        }

        .filter-select:focus {
            border-color: var(--primary-blue);
            outline: none;
        }

        .btn-filter {
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-filter:hover {
            background: var(--secondary-blue);
            transform: translateY(-2px);
        }

        .btn-reset {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-reset:hover {
            background: #5a6268;
            transform: translateY(-2px);
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

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-passed {
            background: #d4edda;
            color: #155724;
        }

        .status-failed {
            background: #f8d7da;
            color: #721c24;
        }

        .test-type {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .type-unit {
            background: #e3f2fd;
            color: #1976d2;
        }

        .type-final {
            background: #fff3e0;
            color: #f57c00;
        }

        .course-badge {
            background: #e2eafc;
            color: var(--primary-blue);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            margin: 2px;
            display: inline-block;
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

        .loading-spinner {
            text-align: center;
            padding: 40px;
        }

        .loading-spinner i {
            font-size: 40px;
            color: var(--primary-blue);
        }

        @media (max-width: 768px) {
            body { padding: 15px; }
            .header { flex-direction: column; text-align: center; }
            .stats-grid { grid-template-columns: 1fr; }
            .filter-section { flex-direction: column; }
            .filter-select, .btn-filter, .btn-reset { width: 100%; }
            table { display: block; overflow-x: auto; }
        }
    </style>
</head>
<body>
    <%
        // Check if parent is logged in
        com.example.institute.model.Parent parent = (com.example.institute.model.Parent) session.getAttribute("parent");
        if (parent == null) {
            response.sendRedirect(request.getContextPath() + "/parents/login");
            return;
        }
        
        String parentId = parent.getParentId();
        String parentName = parent.getFullName();
        String childStudentId = parent.getStudentId();
    %>

    <input type="hidden" id="parentId" value="<%= parentId %>">
    <input type="hidden" id="childStudentId" value="<%= childStudentId %>">

    <div class="container-fluid">
        <!-- Header -->
        <div class="header">
            <div>
                <h1><i class="fas fa-chart-line me-3"></i>My Child's Progress</h1>
                <p class="mb-0">Track your child's academic performance</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/parent/dashboard" class="back-btn">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Child Information (will be populated by JS) -->
        <div id="childInfoContainer">
            <div class="child-info">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h3><i class="fas fa-spinner fa-spin me-2"></i>Loading child information...</h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid" id="statsContainer">
            <div class="stat-card">
                <div class="stat-value" id="totalTests">0</div>
                <div class="stat-label">Tests Taken</div>
            </div>
            <div class="stat-card">
                <div class="stat-value" id="avgScore">0%</div>
                <div class="stat-label">Average Score</div>
            </div>
            <div class="stat-card">
                <div class="stat-value" id="passedTests">0</div>
                <div class="stat-label">Tests Passed</div>
            </div>
            <div class="stat-card">
                <div class="stat-value" id="finalStatus">-</div>
                <div class="stat-label">Final Test</div>
            </div>
        </div>

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
            <button class="btn-filter" onclick="applyFilters()">
                <i class="fas fa-filter me-2"></i>Apply Filters
            </button>
            <button class="btn-reset" onclick="resetFilters()">
                <i class="fas fa-sync-alt me-2"></i>Reset
            </button>
        </div>

        <!-- Results Table -->
        <h3 class="mb-3"><i class="fas fa-chart-line me-2" style="color: var(--primary-blue);"></i>Test Performance Details</h3>
        
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
                    </tr>
                </thead>
                <tbody id="resultsTableBody">
                    <tr>
                        <td colspan="7" class="loading-spinner">
                            <i class="fas fa-spinner fa-spin fa-3x"></i>
                            <h4 class="mt-3">Loading child's results...</h4>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

	<script>
	    const API_BASE = '${pageContext.request.contextPath}';
	    const childStudentId = document.getElementById('childStudentId').value;
	    
	    let allResults = [];
	    let filteredResults = [];
	    let childName = '';

	    document.addEventListener('DOMContentLoaded', function() {
	        loadChildResults();
	    });

	    async function loadChildResults() {
	        try {
	            console.log('Loading results for child student ID:', childStudentId);
	            
	            // Try multiple possible endpoints for student info
	            let studentData = null;
	            
	            // Try endpoint 1
	            try {
	                const response1 = await fetch(API_BASE + '/api/student/' + childStudentId);
	                if (response1.ok) {
	                    studentData = await response1.json();
	                    console.log('Student data from /api/student:', studentData);
	                }
	            } catch (e) {
	                console.log('Endpoint /api/student failed:', e);
	            }
	            
	            // Try endpoint 2 if first failed
	            if (!studentData) {
	                try {
	                    const response2 = await fetch(API_BASE + '/student/' + childStudentId);
	                    if (response2.ok) {
	                        studentData = await response2.json();
	                        console.log('Student data from /student:', studentData);
	                    }
	                } catch (e) {
	                    console.log('Endpoint /student failed:', e);
	                }
	            }
	            
	            // Try endpoint 3 (with studentId parameter)
	            if (!studentData) {
	                try {
	                    const response3 = await fetch(API_BASE + '/student?studentId=' + childStudentId);
	                    if (response3.ok) {
	                        studentData = await response3.json();
	                        console.log('Student data from /student?studentId:', studentData);
	                    }
	                } catch (e) {
	                    console.log('Endpoint /student?studentId failed:', e);
	                }
	            }
	            
	            // Display student info if we got data
	            if (studentData) {
	                displayChildInfo(studentData);
	                childName = studentData.fullName || studentData.name || 'Child';
	            } else {
	                // Show placeholder if no student data
	                displayPlaceholderChildInfo();
	            }
	            
	            // Load test results - try multiple endpoints
	            let resultsData = null;
	            
	            // Try MCQ results endpoint
	            try {
	                const resultsResponse = await fetch(API_BASE + '/api/mcq/student/' + childStudentId + '/results');
	                if (resultsResponse.ok) {
	                    resultsData = await resultsResponse.json();
	                    console.log('Results from /api/mcq/student:', resultsData);
	                }
	            } catch (e) {
	                console.log('MCQ endpoint failed:', e);
	            }
	            
	            // Try alternative results endpoint
	            if (!resultsData) {
	                try {
	                    const altResponse = await fetch(API_BASE + '/api/results/student/' + childStudentId);
	                    if (altResponse.ok) {
	                        resultsData = await altResponse.json();
	                        console.log('Results from /api/results/student:', resultsData);
	                    }
	                } catch (e) {
	                    console.log('Alternative results endpoint failed:', e);
	                }
	            }
	            
	            // Process the results based on the actual response structure
	            if (resultsData) {
	                // Handle different possible response structures
	                if (Array.isArray(resultsData)) {
	                    allResults = resultsData;
	                } else if (resultsData.results && Array.isArray(resultsData.results)) {
	                    allResults = resultsData.results;
	                } else if (resultsData.data && Array.isArray(resultsData.data)) {
	                    allResults = resultsData.data;
	                } else {
	                    allResults = [];
	                }
	                
	                // Update stats based on actual data
	                updateStatsFromResults(allResults);
	                renderResults(allResults);
	            } else {
	                console.log('No results data received');
	                showNoResults();
	            }
	            
	        } catch (error) {
	            console.error('Error loading child results:', error);
	            showNoResults();
	            displayPlaceholderChildInfo();
	        }
	    }

	    function displayPlaceholderChildInfo() {
	        const container = document.getElementById('childInfoContainer');
	        container.innerHTML = 
	            '<div class="child-info">' +
	                '<div class="row align-items-center">' +
	                    '<div class="col-md-12">' +
	                        '<h2><i class="fas fa-user-graduate me-2"></i>Student ID: ' + escapeHTML(childStudentId) + '</h2>' +
	                        '<p class="mb-0 text-light">Loading complete student information...</p>' +
	                    '</div>' +
	                '</div>' +
	            '</div>';
	    }

	    function displayChildInfo(student) {
	        const container = document.getElementById('childInfoContainer');
	        
	        // Handle different possible property names
	        const fullName = student.fullName || student.name || student.studentName || 'Student';
	        const studentId = student.studentId || student.id || childStudentId;
	        const status = student.status || 'Active';
	        
	        // Handle courses (might be array or string)
	        let coursesHtml = '';
	        if (student.courses) {
	            if (Array.isArray(student.courses)) {
	                student.courses.forEach(course => {
	                    coursesHtml += '<span class="course-badge me-2">' + escapeHTML(course) + '</span>';
	                });
	            } else {
	                coursesHtml = '<span class="text-light">' + escapeHTML(student.courses) + '</span>';
	            }
	        } else {
	            coursesHtml = '<span class="text-light">No courses enrolled</span>';
	        }
	        
	        container.innerHTML = 
	            '<div class="child-info">' +
	                '<div class="row align-items-center">' +
	                    '<div class="col-md-8">' +
	                        '<h2><i class="fas fa-user-graduate me-2"></i>' + escapeHTML(fullName) + '</h2>' +
	                        '<p class="mb-2"><strong>Student ID:</strong> ' + studentId + '</p>' +
	                        '<div class="mt-2"><strong>Enrolled Courses:</strong> ' + coursesHtml + '</div>' +
	                    '</div>' +
	                    '<div class="col-md-4 text-md-end mt-3 mt-md-0">' +
	                        '<span class="badge bg-light text-dark p-3">' +
	                            '<i class="fas fa-circle me-2 ' + (status === 'Active' ? 'text-success' : 'text-warning') + '"></i>' +
	                            'Status: ' + status +
	                        '</span>' +
	                    '</div>' +
	                '</div>' +
	            '</div>';
	    }

	    function updateStatsFromResults(results) {
	        if (!results || results.length === 0) {
	            document.getElementById('totalTests').textContent = '0';
	            document.getElementById('avgScore').textContent = '0%';
	            document.getElementById('passedTests').textContent = '0';
	            document.getElementById('finalStatus').textContent = 'Not Attempted';
	            return;
	        }
	        
	        // Calculate stats based on actual data structure
	        const totalTests = results.length;
	        
	        // Calculate average percentage
	        let totalPercentage = 0;
	        let passedCount = 0;
	        let finalTestInfo = 'Not Attempted';
	        
	        results.forEach(result => {
	            // Handle different possible property names for score/percentage
	            const percentage = result.percentage || 
	                              (result.score && result.totalQuestions ? (result.score/result.totalQuestions)*100 : 0);
	            
	            if (percentage) {
	                totalPercentage += percentage;
	                
	                // Check if passed (assuming 50% is passing)
	                if (percentage >= 50) {
	                    passedCount++;
	                }
	            }
	            
	            // Check for final test
	            const testType = result.testType || result.type || '';
	            if (testType === 'FINAL' || testType === 'final') {
	                const score = result.score || 0;
	                const total = result.totalQuestions || result.totalMarks || 100;
	                const finalPercentage = result.percentage || ((score/total)*100).toFixed(2);
	                finalTestInfo = score + '/' + total + ' (' + Math.round(finalPercentage) + '%)';
	            }
	        });
	        
	        const avgPercentage = totalTests > 0 ? Math.round(totalPercentage / totalTests) : 0;
	        
	        document.getElementById('totalTests').textContent = totalTests;
	        document.getElementById('avgScore').textContent = avgPercentage + '%';
	        document.getElementById('passedTests').textContent = passedCount;
	        document.getElementById('finalStatus').textContent = finalTestInfo;
	    }

	    function renderResults(results) {
	        const tbody = document.getElementById('resultsTableBody');
	        filteredResults = results;
	        
	        if (!results || results.length === 0) {
	            showNoResults();
	            return;
	        }
	        
	        // Sort by date (newest first) - handle different date property names
	        results.sort((a, b) => {
	            const dateA = new Date(a.completedAt || a.date || a.testDate || 0);
	            const dateB = new Date(b.completedAt || b.date || b.testDate || 0);
	            return dateB - dateA;
	        });
	        
	        tbody.innerHTML = '';
	        
	        results.forEach(result => {
	            // Handle different possible property names
	            const contentTitle = result.contentTitle || result.testName || result.title || 'Untitled Test';
	            const subjectName = result.subjectName || result.courseName || result.subject || 'N/A';
	            const testType = result.testType || result.type || 'UNIT';
	            const score = result.score || result.marksObtained || 0;
	            const totalQuestions = result.totalQuestions || result.totalMarks || result.maxMarks || 100;
	            const percentage = result.percentage || ((score/totalQuestions)*100).toFixed(2);
	            const passed = percentage >= 50;
	            
	            // Format date
	            let dateStr = 'N/A';
	            const dateValue = result.completedAt || result.date || result.testDate;
	            if (dateValue) {
	                try {
	                    dateStr = new Date(dateValue).toLocaleDateString('en-IN', {
	                        day: '2-digit',
	                        month: 'short',
	                        year: 'numeric'
	                    });
	                } catch (e) {
	                    dateStr = 'Invalid Date';
	                }
	            }
	            
	            const row = document.createElement('tr');
	            row.innerHTML = 
	                '<td><strong>' + escapeHTML(contentTitle) + '</strong></td>' +
	                '<td>' + escapeHTML(subjectName) + '</td>' +
	                '<td><span class="test-type type-' + (testType || 'unit').toString().toLowerCase() + '">' + escapeHTML(testType) + '</span></td>' +
	                '<td>' + escapeHTML(score) + '/' + escapeHTML(totalQuestions) + '</td>' +
	                '<td>' + Math.round(percentage) + '%</td>' +
	                '<td><span class="status-badge status-' + (passed ? 'passed' : 'failed') + '">' + (passed ? 'PASSED' : 'FAILED') + '</span></td>' +
	                '<td>' + dateStr + '</td>';
	            
	            tbody.appendChild(row);
	        });
	    }

	    function showNoResults() {
	        const tbody = document.getElementById('resultsTableBody');
	        tbody.innerHTML = 
	            '<tr>' +
	                '<td colspan="7" class="empty-state">' +
	                    '<i class="fas fa-database fa-3x"></i>' +
	                    '<h4 class="mt-3">No test results found</h4>' +
	                    '<p class="text-muted">Your child hasn\'t taken any tests yet.</p>' +
	                '</td>' +
	            '</tr>';
	    }

	    function applyFilters() {
	        const testType = document.getElementById('testTypeFilter').value;
	        const status = document.getElementById('statusFilter').value;
	        
	        let filtered = allResults;
	        
	        if (testType) {
	            filtered = filtered.filter(r => {
	                const type = r.testType || r.type || '';
	                return type.toUpperCase() === testType;
	            });
	        }
	        
	        if (status) {
	            const passed = status === 'PASSED';
	            filtered = filtered.filter(r => {
	                const percentage = r.percentage || 
	                                  (r.score && r.totalQuestions ? (r.score/r.totalQuestions)*100 : 0);
	                return (percentage >= 50) === passed;
	            });
	        }
	        
	        renderResults(filtered);
	    }

	    function resetFilters() {
	        document.getElementById('testTypeFilter').value = '';
	        document.getElementById('statusFilter').value = '';
	        renderResults(allResults);
	    }

	    function escapeHTML(text) {
	        if (!text && text !== 0) return '';
	        return String(text)
	            .replace(/&/g, '&amp;')
	            .replace(/</g, '&lt;')
	            .replace(/>/g, '&gt;')
	            .replace(/"/g, '&quot;')
	            .replace(/'/g, '&#39;');
	    }
	</script>
</body>
</html>