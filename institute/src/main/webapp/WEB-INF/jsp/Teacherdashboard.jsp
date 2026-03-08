<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduEra - Teacher Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2563eb;
            --dark-blue: #1e40af;
            --light-blue: #dbeafe;
            --accent-yellow: #fbbf24;
            --success-green: #10b981;
            --warning-orange: #f59e0b;
            --danger-red: #ef4444;
            --gray-light: #f3f4f6;
            --gray-medium: #9ca3af;
            --gray-dark: #4b5563;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
            color: #1f2937;
            margin: 0;
            padding: 0;
        }

        /* ------------------ NAVBAR FIXED ------------------ */
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

        /* ------------------ TEACHER DASHBOARD HEADER ------------------ */
        .dashboard-header {
            background: linear-gradient(to right, var(--primary-blue), #3b82f6);
            color: white;
            padding: 30px 0;
            margin-top: 0;
            border-radius: 0 0 20px 20px;
        }

        .teacher-profile {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .teacher-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-blue);
            font-size: 32px;
            font-weight: 600;
            border: 4px solid rgba(255, 255, 255, 0.3);
        }

        .teacher-info h1 {
            font-size: 28px;
            font-weight: 700;
            margin: 0;
        }

        .teacher-info p {
            font-size: 16px;
            opacity: 0.9;
            margin: 5px 0 0 0;
        }

        /* ------------------ DASHBOARD STATS ------------------ */
        .stats-container {
            margin-top: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: transform 0.2s ease;
            height: 100%;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-content h3 {
            font-size: 28px;
            font-weight: 700;
            margin: 0;
            color: var(--dark-blue);
        }

        .stat-content p {
            font-size: 14px;
            color: var(--gray-dark);
            margin: 5px 0 0 0;
        }

        /* ------------------ QUICK ACTIONS ------------------ */
        .quick-actions {
            margin: 30px 0;
        }

        .quick-actions h2 {
            font-size: 22px;
            font-weight: 600;
            color: var(--dark-blue);
            margin-bottom: 20px;
        }

        .action-card {
            background: white;
            border-radius: 12px;
            padding: 25px 20px;
            box-shadow: var(--card-shadow);
            text-align: center;
            transition: all 0.2s ease;
            height: 100%;
            border: 1px solid #e5e7eb;
        }

        .action-card:hover {
            border-color: var(--primary-blue);
            transform: translateY(-3px);
        }

        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin: 0 auto 15px;
        }

        .action-card h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .action-card p {
            font-size: 14px;
            color: var(--gray-dark);
            margin: 0;
        }

        /* ------------------ UPCOMING CLASSES ------------------ */
        .classes-container {
            margin: 30px 0;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: var(--dark-blue);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .class-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: var(--card-shadow);
            border-left: 4px solid var(--primary-blue);
            transition: all 0.2s ease;
        }

        .class-card:hover {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .class-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .class-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark-blue);
        }

        .class-time {
            background: var(--light-blue);
            color: var(--primary-blue);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        .class-details {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: var(--gray-dark);
        }

        .class-detail {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* ------------------ RECENT ACTIVITY ------------------ */
        .activity-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--card-shadow);
            height: 100%;
        }

        .activity-item {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #f3f4f6;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .activity-content h5 {
            font-size: 15px;
            font-weight: 600;
            margin: 0 0 5px 0;
        }

        .activity-content p {
            font-size: 13px;
            color: var(--gray-dark);
            margin: 0;
        }

        .activity-time {
            font-size: 12px;
            color: var(--gray-medium);
        }

        /* ------------------ FEATURE SLIDER ------------------ */
        .feature-slider {
            width: 90%;
            height: 180px;
            margin: 40px auto;
            position: relative;
            overflow: hidden;
            border-radius: 12px;
            background: linear-gradient(to bottom right, #f7f8f9, #82e3f6);
            color: rgb(23, 3, 66);
            padding: 20px;
            box-shadow: var(--card-shadow);
        }

        .slide {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 0.8s ease-in-out;
            padding: 20px;
            border-radius: 10px;
        }

        .slide.active {
            opacity: 1;
        }

        .slide h2 {
            margin: 0;
            font-size: 28px;
            font-weight: bold;
        }

        .slide p {
            margin-top: 12px;
            font-size: 18px;
            line-height: 1.4;
        }

        /* Color variants for slides */
        .slide:nth-child(1) { background: linear-gradient(to right, #2563eb, #3b82f6); color: white; }
        .slide:nth-child(2) { background: linear-gradient(to right, #10b981, #34d399); color: white; }
        .slide:nth-child(3) { background: linear-gradient(to right, #f59e0b, #fbbf24); color: #1f2937; }
        .slide:nth-child(4) { background: linear-gradient(to right, #8b5cf6, #a78bfa); color: white; }

        /* ARROWS */
        .arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
            font-weight: bold;
            color: white;
            background: rgba(0,0,0,0.3);
            padding: 8px 12px;
            border-radius: 50%;
            cursor: pointer;
            user-select: none;
            transition: background 0.2s;
        }

        .arrow:hover {
            background: rgba(0,0,0,0.5);
        }

        .arrow-left { left: 10px; }
        .arrow-right { right: 10px; }

        /* ------------------ FOOTER ------------------ */
        .footer {
            background: var(--dark-blue);
            color: white;
            padding: 40px 0 20px;
            margin-top: 50px;
            border-radius: 20px 20px 0 0;
        }

        .footer h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #fbbf24;
        }

        .footer p {
            font-size: 14px;
            opacity: 0.9;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            margin-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 14px;
            opacity: 0.8;
        }

        /* ------------------ RESPONSIVE ------------------ */
        @media (max-width: 768px) {
            .teacher-profile {
                flex-direction: column;
                text-align: center;
            }
            
            .stat-card, .action-card {
                margin-bottom: 15px;
            }
            
            .dashboard-header {
                padding: 20px 0;
            }
            
            .feature-slider {
                height: 160px;
            }
            
            .slide h2 {
                font-size: 24px;
            }
            
            .slide p {
                font-size: 16px;
            }
        }
    </style>
</head>

<body>
	<!-- ================= NAVIGATION BAR ================= -->
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
	          <a class="nav-link active" href="${pageContext.request.contextPath}/teacher/dashboard">
	            <i class="fas fa-home"></i> Home
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="${pageContext.request.contextPath}/upload-notes">
	            <i class="fas fa-book"></i> Courses
	          </a>
	        </li>
	        <!-- ADDED: Teacher Test Scores in Navigation -->
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

	<!-- ================= TEACHER PROFILE SECTION ================= -->
	<div class="dashboard-header">
	  <div class="container">
	    <div class="teacher-profile">
	      <div class="teacher-avatar">
	        <i class="fas fa-chalkboard-teacher"></i>
	      </div>
	      <div class="teacher-info">
	        <h1 id="teacherName">Welcome, Teacher</h1>
	        <p id="teacherDetails">Manage your courses, students, and academic activities</p>
	      </div>
	    </div>
	    
	    <!-- ADDED: Teacher Test Scores Banner -->
	    <div class="row mt-4">
	      <div class="col-12">
	        <div class="p-3" style="background: rgba(255,255,255,0.15); border-radius: 10px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
	          <div>
	            <i class="fas fa-chart-line me-2"></i>
	            <strong>Student Performance Analytics</strong> - View detailed test results, pass rates, and performance metrics for your courses
	          </div>
	          <a href="${pageContext.request.contextPath}/teachertestscore" class="btn" style="background: white; color: var(--primary-blue); font-weight: 600; padding: 10px 25px; border-radius: 30px;">
	            <i class="fas fa-arrow-right me-2"></i>View Student Results
	          </a>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

	<div class="container mt-4">
	  

	  <!-- ================= QUICK ACTIONS ================= -->
	  <div class="quick-actions">
	    <h2>Quick Actions</h2>
	    <div class="row g-4">
	     
	      <div class="col-md-3 col-sm-6">
	        <a href="${pageContext.request.contextPath}/upload-notes" class="text-decoration-none">
	          <div class="action-card">
	            <div class="action-icon" style="background-color: var(--success-green); color: white;">
	              <i class="fas fa-upload"></i>
	            </div>
	            <h4>Upload Notes</h4>
	            <p>Share study material with students</p>
	          </div>
	        </a>
	      </div>
	      
	      <!-- ADDED: Teacher Test Scores Quick Action -->
	      <div class="col-md-3 col-sm-6">
	        <a href="${pageContext.request.contextPath}/teachertestscore" class="text-decoration-none">
	          <div class="action-card">
	            <div class="action-icon" style="background-color: #8b5cf6; color: white;">
	              <i class="fas fa-chart-line"></i>
	            </div>
	            <h4>Student Results</h4>
	            <p>View test scores and performance analytics</p>
	          </div>
	        </a>
	      </div>
	      <div class="col-md-3 col-sm-6">
	        <a href="${pageContext.request.contextPath}/parentstore" class="text-decoration-none">
	          <div class="action-card">
	            <div class="action-icon" style="background-color: #ec4899; color: white;">
	              <i class="fas fa-users"></i>
	            </div>
	            <h4>Parents</h4>
	            <p>Manage parent information and contacts</p>
	          </div>
	        </a>
	      </div>
	      <div class="col-md-3 col-sm-6">
	        <a href="${pageContext.request.contextPath}/studentstore" class="text-decoration-none">
	          <div class="action-card">
	            <div class="action-icon" style="background-color: #14b8a6; color: white;">
	              <i class="fas fa-user-graduate"></i>
	            </div>
	            <h4>View Students</h4>
	            <p>Check student profiles & performance</p>
	          </div>
	        </a>
	      </div>
	    </div>
	  </div>

	 
<!-- ================= SLIDER SCRIPT ================= -->
<script>
    let slides = document.querySelectorAll(".slide");
    let index = 0;

    function showSlide(i) {
        slides.forEach(slide => slide.classList.remove("active"));
        slides[i].classList.add("active");
    }

    function nextSlide() {
        index = (index + 1) % slides.length;
        showSlide(index);
    }

    function prevSlide() {
        index = (index - 1 + slides.length) % slides.length;
        showSlide(index);
    }

    // Auto slide every 4 seconds
    setInterval(nextSlide, 4000);
    
    // Update active nav on click
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', function() {
            document.querySelectorAll('.nav-link').forEach(item => {
                item.classList.remove('active');
            });
            this.classList.add('active');
        });
    });
    
    // Set teacher name from session (if available)
    // In a real app, you'd get this from the server
    const teacherName = "${sessionScope.teacher != null ? sessionScope.teacher.fullName : 'Teacher'}";
    if (teacherName && teacherName !== 'Teacher') {
        document.getElementById('teacherName').textContent = 'Welcome, ' + teacherName;
    }
    
    // Set active nav based on current URL
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(link => {
        const href = link.getAttribute('href');
        if (href && currentPath.includes(href)) {
            link.classList.add('active');
        }
    });
</script>

</body>
</html>