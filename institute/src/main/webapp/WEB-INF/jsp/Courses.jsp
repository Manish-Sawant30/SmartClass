<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>

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

        /* PAGE STYLING */
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #f4f4f4, #d2d2ff);
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
            padding: 20px;
            color: #003b8e;
            font-size: 35px;
        }

        .course-container {
            width: 90%;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            padding-bottom: 40px;
        }

        .course-card {
            padding: 20px;
            height: 260px;
            border-radius: 20px;
            color: white;
            box-shadow: 0px 5px 18px rgba(0,0,0,0.25);
            transition: 0.3s ease-in-out;
        }

        .course-card:hover {
            transform: scale(1.05);
            box-shadow: 0px 12px 30px rgba(0,0,0,0.35);
        }

        .course-title {
            font-size: 23px;
            font-weight: bold;
        }

        .price {
            margin-top: 10px;
            font-size: 19px;
            font-weight: bold;
        }

        .desc {
            margin-top: 10px;
            font-size: 15px;
            line-height: 1.4;
        }

        .btn {
            margin-top: 15px;
            padding: 10px 16px;
            background: rgba(255,255,255,0.25);
            color: white;
            border: none;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
        }

        .btn:hover {
            background: rgba(255,255,255,0.4);
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
	          <a class="nav-link" href="${pageContext.request.contextPath}/teacher-dashboard">
	            <i class="fas fa-home"></i> Home
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" href="${pageContext.request.contextPath}/courses">
	            <i class="fas fa-book"></i> Courses
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="${pageContext.request.contextPath}/courses-attendance">
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

	<h1>Explore Our Courses</h1>

	<div class="course-container">
	    <!-- ALL BUTTONS UPDATED TO Upload Notes -->
	    <div class="course-card" style="background: linear-gradient(135deg, #0072ff, #00c6ff);">
	        <div class="course-title">C Programming</div>
	        <div class="price">₹999</div>
	        <div class="desc">Master basic programming concepts.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #ff512f, #dd2476);">
	        <div class="course-title">C++ Programming</div>
	        <div class="price">₹1199</div>
	        <div class="desc">Learn OOP, STL & more.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #f7971e, #ffd200);">
	        <div class="course-title">Java Programming</div>
	        <div class="price">₹1499</div>
	        <div class="desc">OOP, JDBC, multithreading.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #8e2de2, #4a00e0);">
	        <div class="course-title">Python Programming</div>
	        <div class="price">₹1499</div>
	        <div class="desc">Python from basics to automation.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #11998e, #38ef7d);">
	        <div class="course-title">JavaScript</div>
	        <div class="price">₹1299</div>
	        <div class="desc">Build interactive web apps.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #9d50bb, #6e48aa);">
	        <div class="course-title">Full Stack Development</div>
	        <div class="price">₹2999</div>
	        <div class="desc">Frontend + Backend + DB.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #ff0055, #ff7b00);">
	        <div class="course-title">Android Development</div>
	        <div class="price">₹2499</div>
	        <div class="desc">Create Android apps.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #00b4d8, #0077b6);">
	        <div class="course-title">Software Engineering</div>
	        <div class="price">₹999</div>
	        <div class="desc">Understand SDLC & design patterns.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #434343, #000000);">
	        <div class="course-title">Git & GitHub</div>
	        <div class="price">₹499</div>
	        <div class="desc">Master version control.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #004e92, #07158f);">
	        <div class="course-title">Data Structures & Algorithms</div>
	        <div class="price">₹1999</div>
	        <div class="desc">Improve problem solving.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #ff416c, #ff4b2b);">
	        <div class="course-title">Operating Systems</div>
	        <div class="price">₹999</div>
	        <div class="desc">Learn OS concepts.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #654ea3, #eaafc8);">
	        <div class="course-title">DBMS</div>
	        <div class="price">₹999</div>
	        <div class="desc">Database management & SQL.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #00c6ff, #0072ff);">
	        <div class="course-title">Computer Networks</div>
	        <div class="price">₹999</div>
	        <div class="desc">Networking fundamentals.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #f7971e, #ff512f);">
	        <div class="course-title">Artificial Intelligence</div>
	        <div class="price">₹2499</div>
	        <div class="desc">AI, agents & ML basics.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #3f5efb, #fc466b);">
	        <div class="course-title">Cloud Computing</div>
	        <div class="price">₹2599</div>
	        <div class="desc">Cloud services & virtualization.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>

	    <div class="course-card" style="background: linear-gradient(135deg, #d00000, #ff4d4d);">
	        <div class="course-title">Cyber Security & Ethical Hacking</div>
	        <div class="price">₹2999</div>
	        <div class="desc">Security tools & defence.</div>
<button class="btn" onclick="location.href='${pageContext.request.contextPath}/upload-notes'">Upload Notes</button>	    </div>
	</div>

</body>
</html>
