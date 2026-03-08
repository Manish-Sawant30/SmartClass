<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduEra - Student Progress</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial;
            background: #eef7ff;
        }

        .navbar {
            background: #003d7a;
            padding: 15px;
            color: #fff;
            text-align: center;
            font-size: 22px;
        }

        .container {
            width: 90%;
            margin: auto;
            margin-top: 30px;
        }

        .box {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }

        h2, h3 {
            color: #003d7a;
            margin-top: 0;
        }

        .progress-bar {
            width: 100%;
            height: 25px;
            background: #cfe6ff;
            border-radius: 20px;
            margin-top: 10px;
        }

        .progress-fill {
            height: 25px;
            width: 70%; /* Progress percentage */
            background: #003d7a;
            border-radius: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }

        th {
            background: #e1efff;
            color: #003d7a;
        }
    </style>
</head>
<body>

<div class="navbar">Student Progress</div>

<div class="container">

    <div class="box">
        <h2>Name: Riya Mhatre</h2>
        <h3>Course: Java Programming</h3>

        <p><b>Progress:</b></p>
        <div class="progress-bar">
            <div class="progress-fill"></div>
        </div>
    </div>

    <div class="box">
        <h3>Attendance</h3>
        <table>
            <tr>
                <th>Session</th>
                <th>Status</th>
            </tr>
            <tr><td>Session 1</td><td>Present</td></tr>
            <tr><td>Session 2</td><td>Present</td></tr>
            <tr><td>Session 3</td><td>Absent</td></tr>
        </table>
    </div>

    <div class="box">
        <h3>Recent Activity</h3>
        <table>
            <tr>
                <th>Date</th>
                <th>Activity</th>
            </tr>
            <tr><td>02 Dec 2025</td><td>Watched: OOP Concepts</td></tr>
            <tr><td>03 Dec 2025</td><td>Downloaded: Java Notes (PDF)</td></tr>
        </table>
    </div>

</div>

</body>
</html>
