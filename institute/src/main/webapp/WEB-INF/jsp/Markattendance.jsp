<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance | ${course.courseName}</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --primary-blue: #003b8e;
            --dark-blue: #001f54;
        }
        
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(to bottom right, #f7f8f9, #82e3f6);
            padding-bottom: 50px;
        }
        
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
        
        .logo-img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
            margin-right: 10px;
        }
        
        .attendance-container {
            max-width: 1000px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        .course-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eaeaea;
        }
        
        .course-icon {
            width: 80px;
            height: 80px;
            border-radius: 10px;
            object-fit: cover;
            border: 3px solid #0a3d62;
        }
        
        .course-info h2 {
            color: #0a3d62;
            margin-bottom: 5px;
        }
        
        .course-info p {
            color: #666;
            margin-bottom: 0;
        }
        
        .attendance-form {
            margin-bottom: 40px;
        }
        
        .form-card {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            border-left: 5px solid var(--primary-blue);
        }
        
        .today-attendance {
            margin-top: 30px;
        }
        
        .attendance-table th {
            background: var(--primary-blue);
            color: white;
        }
        
        .status-badge {
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
        }
        
        .status-present {
            background: #d4edda;
            color: #155724;
        }
        
        .status-absent {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-late {
            background: #fff3cd;
            color: #856404;
        }
        
        .back-btn {
            margin-top: 20px;
        }
        
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- ================= NAVIGATION BAR ================= -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <img src="${pageContext.request.contextPath}/images/logo2.jpeg" class="logo-img" alt="EduEra Logo">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">EduEra Teacher</a>

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
                        <a class="nav-link" href="${pageContext.request.contextPath}/teacher/attendance/courses">
                            <i class="fas fa-clipboard-check"></i> Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/teacher/attendance/courses">
                            <i class="fas fa-user-check"></i> Mark Attendance
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="attendance-container">
        <!-- Course Header -->
        <div class="course-header">
            <img src="${pageContext.request.contextPath}/images/${course.courseName.replace(' ', '').replace('&', '').toLowerCase()}.jpeg" 
                 alt="${course.courseName}"
                 class="course-icon"
                 onerror="this.src='${pageContext.request.contextPath}/images/cimg.jpeg'">
            <div class="course-info">
                <h2>${course.courseName}</h2>
                <p>${course.courseDescription}</p>
                <p class="text-muted">
                    <i class="fas fa-calendar-day me-1"></i> Date: ${today}
                </p>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Attendance Form -->
        <div class="attendance-form">
            <h4><i class="fas fa-edit me-2"></i>Mark Attendance</h4>
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/teacher/attendance/mark" method="post">
                    <input type="hidden" name="courseId" value="${course.courseId}">
                    
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Student ID *</label>
                            <input type="text" class="form-control" name="studentId" required 
                                   placeholder="Enter Student ID (e.g., S2024001)">
                        </div>
                        
                        <div class="col-md-4">
                            <label class="form-label">Status *</label>
                            <select class="form-select" name="status" required>
                                <option value="">Select Status</option>
                                <option value="PRESENT">Present</option>
                                <option value="ABSENT">Absent</option>
                                <option value="LATE">Late</option>
                            </select>
                        </div>
                        
                        <div class="col-md-4">
                            <label class="form-label">Remarks (Optional)</label>
                            <input type="text" class="form-control" name="remarks" 
                                   placeholder="e.g., Late by 10 minutes">
                        </div>
                    </div>
                    
                    <div class="mt-4">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="fas fa-check-circle me-2"></i> Mark Attendance
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Today's Attendance -->
        <div class="today-attendance">
            <h4><i class="fas fa-list-check me-2"></i>Today's Attendance (${today})</h4>
            
            <c:choose>
                <c:when test="${not empty todayAttendance and not todayAttendance.isEmpty()}">
                    <div class="table-responsive">
                        <table class="table table-hover attendance-table">
                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Student Name</th>
                                    <th>Status</th>
                                    <th>Remarks</th>
                                    <th>Marked At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="att" items="${todayAttendance}">
                                    <tr>
                                        <td>${att.studentId}</td>
                                        <td>${att.studentName}</td>
                                        <td>
                                            <span class="status-badge status-${att.status.toString().toLowerCase()}">
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
                        <i class="fas fa-info-circle me-2"></i> No attendance marked for today yet.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Back Button -->
        <div class="back-btn">
            <a href="${pageContext.request.contextPath}/teacher/attendance/courses" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i> Back to Courses
            </a>
        </div>
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
        
        // Form focus
        document.querySelector('input[name="studentId"]').focus();
    </script>
</body>
</html>