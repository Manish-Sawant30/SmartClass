<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <!DOCTYPE html>
<html>
<head>
    <title>EduEra - Courses</title>

 <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<style>
/* ------------------ NAVBAR ------------------ */
.navbar-custom {
    background: linear-gradient(to right, #002b5c, #00509e);
    padding: 12px 20px;
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
    box-shadow: 0px 3px 12px rgba(0, 0, 0, 0.25);
}

 .navbar-brand {
    color: #ffffff !important;
    font-weight: bold;
    font-size: 20px;
    margin-left: 10px;
}

.nav-link {
    color: #e2eafc !important;
    font-size: 14px;
    padding: 6px 10px !important;
    transition: 0.3s;
     border-radius: 4px;
    margin-left: 4px;
}

.nav-link:hover {
    background: #a6c8ff;
    color: #002b5c !important;
}

.nav-link.active {
    background: #a6c8ff;
    color: #002b5c !important;
    font-weight: bold;
}

.logo-img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #ffffff;
    margin-right: 10px;
}
</style>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #e8f1fa;
}

.course-container {
    width: 85%;
    margin: 40px auto;
}

.course-box {
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 10px;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.course-name {
    font-size: 22px;
    font-weight: bold;
}

.btn {
    background: rgba(255, 255, 255, 0.85);
    padding: 10px 18px;
    font-size: 16px;
    border-radius: 6px;
    color: #003a66;
    text-decoration: none;
    font-weight: bold;
}

.btn:hover {
    background: white;
}

/* 16 UNIQUE COLORS */
#c1 { background: #005f99; }
#c2 { background: #32cb4e; }
#c3 { background: #dc8d1d; }
#c4 { background: #b10fab; }
#c5 { background: #e73976; }
#c6 { background: #80b5ff; }
#c7 { background: #f388f1; }
#c8 { background: #3ec9dc; }
#c9 { background: #25930d; }
#c10 { background: #1edae0; }
#c11 { background: #d9d607; }
#c12 { background: #b2130a; }
#c13 { background: #006680; }
#c14 { background: #0b0474; }
#c15 { background: #9b9d04; }
#c16 { background: #0b4a5c; }

</style>
</head>

<body>

<!-- ============ NAVBAR ============ -->
<nav class="navbar navbar-expand-lg navbar-custom">
  <div class="container-fluid">
    <img src="logo2.jpeg" class="logo-img" alt="Logo">
    <a class="navbar-brand" href="#">EduEra</a>

    <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
  <li class="nav-item">
          <a class="nav-link " href="screenafterlogin.html">Home</a>
        </li>
         <li class="nav-item">
          <a class="nav-link " href="Courses.html">Courses</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="Courses_Attendance.html">Courses Attendance</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="admission.html">Admission</a>
        </li>

        <li class="nav-item">
          <a class="nav-link active" href="Notes.html">Notes</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="certificateF1.html">Certificate</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="Contact.html">Contact Us</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="Exam.html">Examination</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="MyProfile.html">MyProfile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="Accounts.html">Accounts</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


<!-- ============ UPDATED COURSE LIST ============ -->
<div class="course-container">

    <!-- Programming Languages -->
    <div class="course-box" id="c1"><div class="course-name">1. C Programming</div> <a class="btn" href="AccC.html">Access Notes</a></div>
    <div class="course-box" id="c2"><div class="course-name">2. C++ Programming</div> <a class="btn" href="AccC++.html">Access Notes</a></div>
    <div class="course-box" id="c3"><div class="course-name">3. Java Programming</div> <a class="btn" href="AccJava.html">Access Notes</a></div>
    <div class="course-box" id="c4"><div class="course-name">4. Python Programming</div> <a class="btn" href="AccPy.html">Access Notes</a></div>
    <div class="course-box" id="c5"><div class="course-name">5. JavaScript (Frontend + Backend)</div> <a class="btn" href="AccJS.html">Access Notes</a></div>
    <!-- Web / App / Software Development -->
    <div class="course-box" id="c6"><div class="course-name">6. Full-Stack Web Development</div> <a class="btn" href="AccfullStackWebDev.html">Access Notes</a></div>
    <div class="course-box" id="c7"><div class="course-name">7. Android App Development</div> <a class="btn" href="AccAndroidAppdev.html">Access Notes</a></div>
    <div class="course-box" id="c8"><div class="course-name">8. Software Engineering</div> <a class="btn" href="AccSoftEngg.html">Access Notes</a></div>
    <div class="course-box" id="c9"><div class="course-name">9. Git & GitHub Version Control</div> <a class="btn" href="AccGit.html">Access Notes</a></div>

    <!-- Core CS -->
    <div class="course-box" id="c10"><div class="course-name">10. Data Structures & Algorithms (DSA)</div> <a class="btn" href="AccDSA.html">Access Notes</a></div>
    <div class="course-box" id="c11"><div class="course-name">11. Operating Systems (OS)</div> <a class="btn" href="AccOS.html">Access Notes</a></div>
    <div class="course-box" id="c12"><div class="course-name">12. Database Management System (DBMS)</div> <a class="btn" href="AccDBMS.html">Access Notes</a></div>
    <div class="course-box" id="c13"><div class="course-name">13. Computer Networks</div> <a class="btn" href="AccCompNw.html">Access Notes</a></div>

    <!-- Modern Technologies -->
    <div class="course-box" id="c14"><div class="course-name">14. Artificial Intelligence & Machine Learning</div> <a class="btn" href="AccAIML.html">Access Notes</a></div>
    <div class="course-box" id="c15"><div class="course-name">15. Cloud Computing</div> <a class="btn" href="AccCLC.html">Access Notes</a></div>
    <div class="course-box" id="c16"><div class="course-name">16. Cyber Security & Ethical Hacking</div> <a class="btn" href="AccCyberSec.html">Access Notes</a></div>

</div>

</body>
</html>
