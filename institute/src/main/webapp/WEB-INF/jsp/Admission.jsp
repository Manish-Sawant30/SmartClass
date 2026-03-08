<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8" />
    <title>EduEra - Admission Form</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />

     
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
            background: #ffffff;
            color: #fafafa !important;
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
        .navbar-custom .nav-link.active {
    background: #ffffff22;       /* light white transparent */
    padding: 8px 14px;
    border-radius: 6px;
    color: #a7eaff !important;   /* highlight color */
    font-weight: 700;
}

        /* Scrollable dropdown */
select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    background-color: #fff;
    max-height: 50px; /* visible height */
    overflow-y: auto;  /* enable vertical scroll */
}

/* Proper scroll inside dropdown options */
select option {
    padding: 10px;
}
         
        /* ------------------------------ PAGE COLORS ------------------------------ */
        :root{
            --bg1: #d7f2ff;
            --bg2: #bce9ff;
            --card-grad1: rgba(255,255,255,0.95);
            --card-grad2: rgba(235,248,255,0.85);
            --accent-dark: #0a3d62;
            --accent-mid: #00509e;
            --muted: #c7e0f4;
            --text: #05314b;
            --radius: 14px;
            --gap-x: 20px;
            --gap-y: 16px;
            --maxw: 940px;
        }

        html,body {
            height: 100%;
            margin: 0;
            font-family: "Segoe UI", Roboto, Arial, sans-serif;
            background: linear-gradient(135deg, var(--bg1), var(--bg2));
        }

        .wrap {
            min-height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 50px 20px;
            box-sizing: border-box;
        }

        .card {
            width: 100%;
            max-width: var(--maxw);
            background: linear-gradient(180deg, var(--card-grad1), var(--card-grad2));
            border-radius: var(--radius);
            padding: 30px;
            box-shadow: 0 18px 50px rgba(6,34,60,0.12);
            border-left: 6px solid var(--accent-dark);
        }

        h1 {
            margin-bottom: 18px;
            text-align: center;
            color: var(--accent-dark);
        }

        p.subtitle {
            text-align: center;
            font-weight: 600;
            margin-bottom: 20px;
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: var(--gap-x);
            row-gap: var(--gap-y);
        }

        .field { display: flex; flex-direction: column; }
        .full { grid-column: 1 / -1; }

        label { font-weight: 700; color: var(--accent-dark); margin-bottom: 6px; }

        input, select, textarea {
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid var(--muted);
            font-size: 14px;
            background: #fff;
            transition: 0.2s;
        }
        textarea { min-height: 90px; }

        input:focus, select:focus, textarea:focus {
            border-color: var(--accent-dark);
            box-shadow: 0 5px 15px rgba(6,34,60,0.08);
        }

        .price-box {
            background: #eaf6ff;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #cfeafc;
            font-weight: 800;
            color: var(--accent-dark);
            display: flex;
            justify-content: space-between;
        }

        .radio-row {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            background: white;
            border: 1px solid #d7edff;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 700;
        }

        input[type="radio"] {
            accent-color: var(--accent-mid);
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .btn {
            padding: 12px 18px;
            border-radius: 10px;
            background: linear-gradient(90deg, var(--accent-dark), var(--accent-mid));
            color: white;
            border: none;
            font-weight: 800;
            cursor: pointer;
        }

        @media (max-width: 860px) {
            form { grid-template-columns: 1fr; }
            .actions { flex-direction: column-reverse; }
            .btn { width: 100%; }
        }
    </style>
</head>
<body>

<!-- ================= NAVBAR ADDED HERE ================= -->
<nav class="navbar navbar-expand-lg navbar-custom">
  <div class="container-fluid">

    <img src="logo2.jpeg" class="logo-img" alt="Logo">
    <a class="navbar-brand text-white" href="#">EduEra</a>

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
          <a class="nav-link active" href="admission.html">Admission</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="Notes.html">Notes</a>
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

<!-- ================= MAIN ADMISSION FORM ================= -->
<div class="wrap">
    <div class="card">
        <h1>🎓 EduEra — Course Admission</h1>
        <p class="subtitle">Choose a course and confirm your seat.</p>

        <form id="admissionForm" onsubmit="event.preventDefault(); handleSubmit();">

            <div class="field full">
                <label>Full Name</label>
                <input type="text" id="fullname" required>
            </div>

            <div class="field">
                <label>Email Address</label>
                <input type="email" id="email" required>
            </div>

            <div class="field">
                <label>Phone Number</label>
                <input type="tel" id="phone" required>
            </div>

            <div class="field">
                <label>Date of Birth</label>
                <input type="date" id="dob" required>
            </div>

            <div class="field">
                <label>Preferred Batch Timing</label>
                <select id="batch">
                    <option>Morning</option>
                    <option>Afternoon</option>
                    <option>Evening</option>
                </select>
            </div>

            <div class="field full">
                <label>Address</label>
                <textarea id="address"></textarea>
            </div>

             <div class="field">
    <label>Select Course</label>
    <select id="courseSelect" onchange="updatePrice()">

        <option value="999">C Programming — ₹999</option>
        <option value="1199">C++ Programming — ₹1199</option>
        <option value="1499">Java Programming — ₹1499</option>
        <option value="1499">Python Programming — ₹1499</option>
        <option value="1299">JavaScript — ₹1299</option>
        <option value="2999">Full Stack Development — ₹2999</option>
        <option value="2499">Android Development — ₹2499</option>
        <option value="999">Software Engineering — ₹999</option>
        <option value="499">Git & GitHub — ₹499</option>
        <option value="1999">Data Structures & Algorithms — ₹1999</option>
        <option value="999">Operating Systems — ₹999</option>
        <option value="999">DBMS — ₹999</option>
        <option value="999">Computer Networks — ₹999</option>
        <option value="2499">Artificial Intelligence — ₹2499</option>
        <option value="2599">Cloud Computing — ₹2599</option>
        <option value="2999">Cyber Security & Ethical Hacking — ₹2999</option>

    </select>
</div>

            <div class="field full">
                <div class="price-box">
                    <span>Selected Course Price</span>
                    <span>₹ <strong id="price">999</strong></span>
                </div>
            </div>

            <div class="field">
                <label>Mode of Learning</label>
                <div class="radio-row">
                    <label class="radio-option">
                        <input type="radio" name="mode" value="Online" checked> Online
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="mode" value="Offline"> Offline
                    </label>
                </div>
            </div>

            <div class="field">
                <label>Payment Method</label>
                <select id="payment">
                    <option>UPI</option>
                    <option>Credit / Debit Card</option>
                    <option>Net Banking</option>
                </select>
            </div>

            <div class="field full">
                <label>Any Comments</label>
                <textarea id="comments"></textarea>
            </div>

     <div class="full">
    <div class="actions">
        <div class="muted">By confirming you agree to our terms.</div>
        <button type="button" class="btn" onclick="validateForm()">
            Confirm Admission
        </button>
    </div>
</div>



        </form>
    </div>
</div>
<script>
function validateForm() {
    // Get all required fields
    const fullname = document.getElementById("fullname").value.trim();
    const email = document.getElementById("email").value.trim();
    const phone = document.getElementById("phone").value.trim();
    const dob = document.getElementById("dob").value.trim();
    const batch = document.getElementById("batch").value;
    const course = document.getElementById("courseSelect").value;
    const mode = document.querySelector('input[name="mode"]:checked').value;
    const payment = document.getElementById("payment").value;

    // Check if any field is empty
    if (!fullname || !email || !phone || !dob || !batch || !course || !mode || !payment) {
        alert("Please fill all required fields before confirming admission.");
        return;
    }

    // If all fields are filled, redirect to success page
    window.location.href = "confirmAdmission.html";
}
</script>
<script>
    function updatePrice() {
        document.getElementById("price").innerText =
            document.getElementById("courseSelect").value;
    }
</script>
</body>
</html>
