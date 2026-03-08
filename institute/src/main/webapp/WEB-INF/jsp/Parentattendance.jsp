<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Attendance | EduEra Parent</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        /* Your existing CSS remains the same */
        :root {
            --primary-blue: #003b8e;
            --dark-blue: #001f54;
            --light-blue: #82e3f6;
            --success-green: #22a65b;
            --warning-orange: #ff9203;
            --danger-red: #dc3545;
            --light-bg: #f7f8f9;
        }

 body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e3f2fd 100%);
            min-height: 100vh;
        }

        /* ------------------ NAVBAR ------------------ */
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

        /* Search Bar Styling */
        .search-container {
            margin-right: 20px;
        }

        .search-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .search-input {
            width: 300px;
            padding: 10px 15px 10px 45px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 15px;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .search-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .search-input:focus {
            outline: none;
            border-color: white;
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
            width: 350px;
        }

        .search-icon {
            position: absolute;
            left: 15px;
            color: white;
            font-size: 16px;
        }

        .search-btn {
            background: var(--warning-orange);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 10px 20px;
            margin-left: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .search-btn:hover {
            background: #e67e22;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 146, 3, 0.3);
        }

        /* ------------------ WELCOME BANNER ------------------ */
        .welcome-banner {
            background: linear-gradient(to right, #0a3d62, #1e88e5);
            color: white;
            padding: 30px;
            margin: 20px auto;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(10, 61, 98, 0.2);
            max-width: 95%;
            transition: all 0.3s ease;
        }

        .welcome-banner h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .welcome-banner p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 0;
        }

        .student-info {
            background: rgba(255, 255, 255, 0.15);
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* ------------------ DASHBOARD CARDS ------------------ */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 30px auto;
            max-width: 95%;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-top: 4px solid var(--primary-blue);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .stat-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary-blue);
        }

        .stat-number {
            font-size: 2.2rem;
            font-weight: 700;
            color: #0a3d62;
            margin: 10px 0;
        }

        .stat-label {
            font-size: 0.95rem;
            color: #666;
            font-weight: 500;
        }

        .attendance-high {
            border-top-color: var(--success-green);
        }

        .attendance-high i {
            color: var(--success-green);
        }

        .attendance-medium {
            border-top-color: var(--warning-orange);
        }

        .attendance-medium i {
            color: var(--warning-orange);
        }

        .attendance-low {
            border-top-color: var(--danger-red);
        }

        .attendance-low i {
            color: var(--danger-red);
        }

        /* ------------------ COURSE ATTENDANCE SECTION ------------------ */
        .section-title {
            color: #0a3d62;
            font-size: 1.8rem;
            font-weight: 700;
            margin: 40px 0 25px 0;
            padding-left: 2.5%;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            left: 2.5%;
            bottom: -8px;
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-blue), var(--light-blue));
            border-radius: 2px;
        }

        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin: 0 auto 50px auto;
            max-width: 95%;
        }

        .attendance-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .attendance-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
            border-color: #0a3d62;
        }

        .course-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .course-icon {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            object-fit: cover;
            border: 2px solid #e0e0e0;
        }

        .course-title {
            flex: 1;
        }

        .course-title h4 {
            color: #0a3d62;
            font-size: 1.3rem;
            margin: 0 0 5px 0;
            font-weight: 600;
        }

        .course-title p {
            color: #666;
            font-size: 0.9rem;
            margin: 0;
        }

        /* Progress bar */
        .attendance-progress {
            margin: 20px 0;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.9rem;
            color: #555;
        }

        .progress-bar-container {
            height: 10px;
            background: #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            border-radius: 5px;
            transition: width 1s ease;
        }

        .high-attendance { background: linear-gradient(to right, #22a65b, #28d070); }
        .medium-attendance { background: linear-gradient(to right, #ff9203, #ffaa33); }
        .low-attendance { background: linear-gradient(to right, #dc3545, #ff4757); }

        /* Attendance details */
        .attendance-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .detail-item {
            text-align: center;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .detail-value {
            font-size: 1.3rem;
            font-weight: 700;
            color: #0a3d62;
        }

        .detail-label {
            font-size: 0.8rem;
            color: #666;
            margin-top: 3px;
        }

        /* Status badge */
        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-present { background: #d4edda; color: #155724; }
        .status-warning { background: #fff3cd; color: #856404; }
        .status-absent { background: #f8d7da; color: #721c24; }

        /* ------------------ MONTHLY CHART ------------------ */
        .chart-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin: 30px auto;
            max-width: 95%;
        }

        .chart-title {
            color: #0a3d62;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .month-selector {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .month-btn {
            padding: 8px 20px;
            border: 2px solid #ddd;
            background: white;
            border-radius: 20px;
            font-weight: 500;
            color: #555;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .month-btn.active {
            background: var(--primary-blue);
            color: white;
            border-color: var(--primary-blue);
        }

        .attendance-chart {
            height: 300px;
            display: flex;
            align-items: flex-end;
            gap: 15px;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
            margin-bottom: 20px;
        }

        .chart-day {
            flex: 1;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .chart-bar {
            width: 70%;
            min-height: 5px;
            border-radius: 4px 4px 0 0;
            transition: height 0.8s ease;
            margin-bottom: 8px;
        }

        .chart-day-label {
            font-size: 0.85rem;
            color: #666;
        }

        .chart-legend {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: #555;
        }

        .legend-color {
            width: 15px;
            height: 15px;
            border-radius: 3px;
        }

        /* ------------------ RECENT ACTIVITY ------------------ */
        .activity-list {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin: 30px auto;
            max-width: 95%;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            border-bottom: 1px solid #eee;
            transition: background 0.3s ease;
        }

        .activity-item:hover {
            background: #f8f9fa;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: white;
        }

        .present-icon { background: #22a65b; }
        .absent-icon { background: #dc3545; }
        .late-icon { background: #ff9203; }
        .holiday-icon { background: #6f42c1; }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 3px;
        }

        .activity-time {
            font-size: 0.85rem;
            color: #888;
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 90px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 10px;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            z-index: 1001;
            display: none;
            animation: slideIn 0.3s ease;
        }

        .notification.success {
            background: #28a745;
            color: white;
        }

        .notification.error {
            background: #dc3545;
            color: white;
        }

        .notification.info {
            background: var(--primary-blue);
            color: white;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* ------------------ RESPONSIVE DESIGN ------------------ */
        @media (max-width: 1200px) {
            .course-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
            
            .search-input {
                width: 250px;
            }
            
            .search-input:focus {
                width: 280px;
            }
        }

        @media (max-width: 992px) {
            .search-container {
                margin: 15px 0;
                width: 100%;
            }
            
            .search-wrapper {
                width: 100%;
            }
            
            .search-input {
                width: 100%;
            }
            
            .search-input:focus {
                width: 100%;
            }
            
            .search-btn {
                margin-left: 10px;
            }
        }

        @media (max-width: 768px) {
            .welcome-banner h1 {
                font-size: 1.8rem;
            }
            
            .dashboard-cards {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .course-grid {
                grid-template-columns: 1fr;
            }
            
            .attendance-chart {
                height: 250px;
            }
            
            .search-container {
                order: 3;
                margin-top: 15px;
            }
        }

        @media (max-width: 576px) {
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
            
            .welcome-banner {
                padding: 20px;
            }
            
            .section-title {
                font-size: 1.5rem;
                text-align: center;
            }
            
            .section-title::after {
                left: 50%;
                transform: translateX(-50%);
            }
            
            .attendance-details {
                grid-template-columns: 1fr;
            }
            
            .month-selector {
                justify-content: center;
            }
            
            .search-btn span {
                display: none;
            }
            
            .search-btn {
                padding: 10px 15px;
            }
        }        
        /* Additional styles for attendance data */
        .attendance-data-container {
            max-width: 1200px;
            margin: 20px auto;
        }
        
        .attendance-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            border-left: 4px solid var(--primary-blue);
        }
        
        .course-attendance {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .course-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.06);
            transition: transform 0.3s ease;
        }
        
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .attendance-percentage {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin: 10px 0;
        }
        
        .high-attendance {
            color: var(--success-green);
        }
        
        .medium-attendance {
            color: var(--warning-orange);
        }
        
        .low-attendance {
            color: var(--danger-red);
        }
        
        .attendance-details-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-top: 15px;
        }
        
        .detail-box {
            text-align: center;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .detail-value {
            font-size: 1.2rem;
            font-weight: bold;
            color: #0a3d62;
        }
        
        .detail-label {
            font-size: 0.8rem;
            color: #666;
        }
        
        .recent-attendance {
            margin-top: 30px;
        }
        
        .attendance-table th {
            background: var(--primary-blue);
            color: white;
        }
        
        .no-data {
            text-align: center;
            padding: 50px;
            color: #666;
        }
        
        .no-data i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #ccc;
        }
    </style>
</head>
<body>
    <!-- ================= NAVIGATION BAR ================= -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <img src="${pageContext.request.contextPath}/images/logo2.jpeg" class="logo-img" alt="EduEra Logo">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/parent/dashboard">EduEra Parent Portal</a>

            <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- Search Bar -->
                <div class="search-container ms-auto me-3">
                    <div class="search-wrapper">
                        <form action="${pageContext.request.contextPath}/parent/attendance/search" method="post" class="d-flex">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" id="studentSearch" name="studentId" class="search-input" 
                                   placeholder="Enter Student ID..." value="${param.studentId}">
                            <button type="submit" class="search-btn">
                                <i class="fas fa-search"></i>
                                <span>Search</span>
                            </button>
                        </form>
                    </div>
                </div>

                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/parent/dashboard">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/parent/attendance/view">
                            <i class="fas fa-clipboard-check"></i> Attendance
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/parenttestscore">
                            <i class="fas fa-book"></i> Test Score
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Notification -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" style="max-width: 800px; margin: 20px auto;">
            <i class="fas fa-exclamation-circle me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="attendance-data-container">
        <c:choose>
            <c:when test="${hasData}">
                <!-- ================= STUDENT INFO ================= -->
                <div class="welcome-banner">
                    <div class="container">
                        <h1>📊 ${student.studentName}'s Attendance Overview</h1>
                        <p>Track attendance across all enrolled courses</p>
                        <div class="student-info">
                            <div class="row">
                                <div class="col-md-6">
                                    <strong><i class="fas fa-user-graduate me-2"></i>Student:</strong> 
                                    <span id="studentName">${student.studentName}</span>
                                </div>
                                <div class="col-md-6">
                                    <strong><i class="fas fa-id-card me-2"></i>Student ID:</strong> 
                                    <span id="studentId">${student.studentId}</span>
                                </div>
                                <c:if test="${not empty student.parentName}">
                                    <div class="col-md-6 mt-2">
                                        <strong><i class="fas fa-user-friends me-2"></i>Parent:</strong> 
                                        <span>${student.parentName}</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ================= ATTENDANCE STATISTICS ================= -->
                <div class="dashboard-cards">
                    <div class="stat-card ${attendanceStats.overallPercentage >= 90 ? 'attendance-high' : attendanceStats.overallPercentage >= 75 ? 'attendance-medium' : 'attendance-low'}">
                        <i class="fas fa-calendar-check"></i>
                        <div class="stat-number">${attendanceStats.overallPercentage}%</div>
                        <div class="stat-label">Overall Attendance</div>
                    </div>
                    
                    <div class="stat-card">
                        <i class="fas fa-chalkboard-teacher"></i>
                        <div class="stat-number">${attendanceStats.courseStats != null ? attendanceStats.courseStats.size() : 0}</div>
                        <div class="stat-label">Courses with Attendance</div>
                    </div>
                    
                    <div class="stat-card">
                        <i class="fas fa-check-circle"></i>
                        <div class="stat-number">${attendanceStats.presentCount}</div>
                        <div class="stat-label">Total Present Days</div>
                    </div>
                    
                    <div class="stat-card">
                        <i class="fas fa-calendar-alt"></i>
                        <div class="stat-number">${attendanceStats.totalCount}</div>
                        <div class="stat-label">Total Attendance Days</div>
                    </div>
                </div>

                <!-- ================= COURSE-WISE ATTENDANCE ================= -->
                <h2 class="section-title">Course-wise Attendance Details</h2>
                
                <div class="course-attendance">
                    <c:forEach var="courseEntry" items="${attendanceStats.courseStats}">
                        <c:set var="courseName" value="${courseEntry.key}" />
                        <c:set var="courseData" value="${courseEntry.value}" />
                        <c:set var="percentage" value="${courseData.percentage}" />
                        
                        <div class="course-card">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <h5 class="mb-0">${courseName}</h5>
                                <span class="badge ${percentage >= 90 ? 'bg-success' : percentage >= 75 ? 'bg-warning' : 'bg-danger'}">
                                    ${courseData.status}
                                </span>
                            </div>
                            
                            <div class="attendance-percentage ${percentage >= 90 ? 'high-attendance' : percentage >= 75 ? 'medium-attendance' : 'low-attendance'}">
                                ${percentage}%
                            </div>
                            
                            <div class="attendance-details-grid">
                                <div class="detail-box">
                                    <div class="detail-value">${courseData.present}</div>
                                    <div class="detail-label">Present</div>
                                </div>
                                <div class="detail-box">
                                    <div class="detail-value">${courseData.absent}</div>
                                    <div class="detail-label">Absent</div>
                                </div>
                                <div class="detail-box">
                                    <div class="detail-value">${courseData.late}</div>
                                    <div class="detail-label">Late</div>
                                </div>
                                <div class="detail-box">
                                    <div class="detail-value">${courseData.total}</div>
                                    <div class="detail-label">Total</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- ================= RECENT ATTENDANCE ================= -->
                <div class="recent-attendance">
                    <h2 class="section-title">Recent Attendance Records</h2>
                    
                    <c:choose>
                        <c:when test="${not empty recentAttendance and not recentAttendance.isEmpty()}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Course</th>
                                            <th>Status</th>
                                            <th>Remarks</th>
                                            <th>Marked At</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="att" items="${recentAttendance}" begin="0" end="9">
                                            <tr>
                                                <td>${att.attendanceDate}</td>
                                                <td>${att.courseName}</td>
                                                <td>
                                                    <span class="badge ${att.status == 'PRESENT' ? 'bg-success' : att.status == 'ABSENT' ? 'bg-danger' : 'bg-warning'}">
                                                        ${att.status}
                                                    </span>
                                                </td>
                                                <td>${att.remarks}</td>
                                                <td>${att.markedAt}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i> No attendance records found.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            
            <c:otherwise>
                <!-- ================= DEFAULT VIEW (NO DATA) ================= -->
                <div class="welcome-banner">
                    <div class="container">
                        <h1>📊 Student Attendance Portal</h1>
                        <p>Enter Student ID to view attendance records</p>
                    </div>
                </div>
                
                <div class="no-data">
                    <i class="fas fa-search"></i>
                    <h3>Search Student Attendance</h3>
                    <p>Enter a Student ID in the search bar above to view attendance records</p>
                    
                    
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // Focus on search input if no data
        <c:if test="${!hasData}">
            document.getElementById('studentSearch').focus();
        </c:if>
    </script>
</body>
</html>