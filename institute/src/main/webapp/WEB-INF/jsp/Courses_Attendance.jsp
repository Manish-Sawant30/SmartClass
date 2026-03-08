<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        /* Your existing CSS remains the same */
        :root {
            --primary-blue: #003b8e;
            --dark-blue: #001f54;
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

        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
               /* Blue gradient background */
            background: linear-gradient(to bottom right, #f7f8f9, #82e3f6);
        }

        h2 {
            text-align: center;
            margin-top: 25px;
            color: #0a3d62;
            font-size: 32px;
            letter-spacing: 1px;
        }

        .container {
            width: 90%;
            margin: auto;
            margin-top: 30px;
        }

        .course-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 50px;
        }

        .course-card {
             background: linear-gradient(to bottom right, #f8f9fa, #f9fafa);
            padding: 15px;
            border-radius: 14px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
            transition: 0.3s ease;
            border: 2px solid transparent;
        }

        .course-card:hover {
            transform: translateY(-5px);
            border: 2px solid #0a3d62;
            box-shadow: 0px 6px 18px rgba(10, 61, 98, 0.3);
        }

        .course-card img {
            width: 100%;
            height: 170px;
            border-radius: 10px;
            object-fit: cover;
        }

        .course-card h3 {
            margin: 12px 0 8px 0;
            color: #0a3d62;
            font-size: 20px;
        }

        .course-card p {
            margin: 0 0 12px 0;
            color: #333;
            font-size: 14px;
        }

        .buy-btn {
            display: inline-block;
            padding: 10px 18px;
            background: #0a3d62;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: 0.3s;
        }

        .buy-btn:hover {
            background: #062b45;
        }
        /* ------------------ INFO BOX ------------------ */
.info-box {
    width: 90%;
    margin: 30px auto;
    background: linear-gradient(to bottom right, #ff9203, #efe00c);
    padding: 25px;
    border-radius: 16px;
    box-shadow: 0px 5px 18px rgba(0,0,0,0.15);
    text-align: center;
    border-left: 6px solid #00509e;
}

.info-box h2 {
    font-size: 26px;
    font-weight: bold;
    color: #003b6f;
    margin-bottom: 10px;
}

.info-box .subtitle {
    font-size: 16px;
    color: #01579b;
    margin-bottom: 20px;
    font-weight: 500;
}

.features-row {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
    margin-bottom: 20px;
}

.feature {
    background: #ffffff;
    padding: 10px 15px;
    border-radius: 10px;
    box-shadow: 0px 3px 10px rgba(0,0,0,0.08);
    font-size: 15px;
    color: #003b6f;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 8px;
}

.feature span {
    color: #0a3d62;
    font-size: 18px;
    font-weight: bold;
}

.info-box .tagline {
    font-size: 15px;
    color: #004c78;
    margin-top: 10px;
    font-weight: 600;
}
.course-card img {
    width: 100%;
    height: 170px;
    object-fit: contain;    /* shows full image without cutting */
    background: white;      /* clean background */
    border-radius: 10px;
    padding: 5px;
}        
        /* Add new styles for attendance form */
        .attendance-form-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 800px;
        }
        
        .attendance-table {
            margin-top: 20px;
        }
        
        .status-present {
            color: #28a745;
            font-weight: bold;
        }
        
        .status-absent {
            color: #dc3545;
            font-weight: bold;
        }
        
        .status-late {
            color: #ffc107;
            font-weight: bold;
        }
        
        .alert {
            margin: 20px auto;
            max-width: 800px;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/courses">
                            <i class="fas fa-book"></i> Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/teacher/attendance/courses">
                            <i class="fas fa-clipboard-check"></i> Attendance
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/testscore">
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

    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- ================= FEATURE MESSAGE BOX ================= -->
    <div class="info-box">
        <h2>✨ Mark Student Attendance ✨</h2>
        <p class="subtitle">Select a course to mark today's attendance</p>
        <div class="features-row">
            <div class="feature">
                <span>✔</span> Quick attendance marking
            </div>
            <div class="feature">
                <span>✔</span> Real-time updates
            </div>
            <div class="feature">
                <span>✔</span> View today's attendance
            </div>
            <div class="feature">
                <span>✔</span> Add new students
            </div>
        </div>
        <p class="tagline">Mark attendance efficiently for better tracking! 📝✅</p>
    </div>

    <!-- Add New Student Form -->
    <div class="attendance-form-container">
        <h3><i class="fas fa-user-plus me-2"></i>Add New Student</h3>
        <form action="${pageContext.request.contextPath}/teacher/attendance/add-student" method="post" class="row g-3">
            <div class="col-md-3">
                <label class="form-label">Student ID *</label>
                <input type="text" class="form-control" name="studentId" required>
            </div>
            <div class="col-md-4">
                <label class="form-label">Student Name *</label>
                <input type="text" class="form-control" name="studentName" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Parent Name</label>
                <input type="text" class="form-control" name="parentName">
            </div>
            <div class="col-md-2">
                <label class="form-label">&nbsp;</label>
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-plus me-1"></i> Add
                </button>
            </div>
        </form>
    </div>

    <!-- Course Grid -->
    <div class="container">
        <h2>Select Course to Mark Attendance</h2>
        <div class="course-grid">
            <c:forEach var="course" items="${courses}">
                <div class="course-card">
                    <img src="${pageContext.request.contextPath}/images/${course.courseName.replace(' ', '').replace('&', '').toLowerCase()}.jpeg" 
                         alt="${course.courseName}"
                         onerror="this.src='${pageContext.request.contextPath}/images/cimg.jpeg'">
                    <h3>${course.courseName}</h3>
                    <p>${course.courseDescription}</p>
                    <a href="${pageContext.request.contextPath}/teacher/attendance/mark/${course.courseId}" class="buy-btn">
                        <i class="fas fa-clipboard-check me-1"></i> Mark Attendance
                    </a>
                </div>
            </c:forEach>
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
    </script>
</body>
</html>