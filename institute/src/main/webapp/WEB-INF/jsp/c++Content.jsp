<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <!DOCTYPE html>
<html>
<head>
    <title>C++ Course Resources</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #144999;
        }

        .container {
            width: 90%;
            margin: auto;
            margin-top: 30px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #ffffff;
        }

        /* Notes Section */
        .notes-box {
            display: flex;
            align-items: center;
            gap: 20px;
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }

        .notes-box img {
            width: 180px;
            height: 120px;
            border-radius: 10px;
            border: 2px solid #ccc;
        }

        .notes-info h3 {
            margin: 0;
            color: #34495e;
        }

        .notes-info p {
            color: #555;
            margin: 8px 0;
        }

        .download-btn {
            display: inline-block;
            padding: 10px 18px;
            background: #0a3d62;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: 0.3s;
        }

        .download-btn:hover {
            background: #074059;
        }

        /* Video Card */
        .video-card {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 20px;
            align-items: center;
            margin-bottom: 40px;
        }

        .video-card img {
            width: 200px;
            height: 120px;
            border-radius: 10px;
        }

        .video-info h3 {
            margin: 0;
            color: #34495e;
        }

        .video-info p {
            color: #555;
            margin: 8px 0;
        }

        .watch-btn {
            display: inline-block;
            padding: 10px 18px;
            background: #c4302b;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .watch-btn:hover {
            background: #a32822;
        }

        /* Compiler Card */
        .compiler-card {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 20px;
            align-items: center;
        }

        /* Image + text overlay */
        .compiler-img-container {
            position: relative;
        }

        .compiler-img {
            width: 200px;
            height: 120px;
            border-radius: 10px;
        }

        .compiler-text {
            position: absolute;
            bottom: 10px;
            left: 10px;
            background: rgba(0,0,0,0.6);
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }

        .compiler-btn {
            display: inline-block;
            padding: 10px 18px;
            background: #1d6d1d;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .compiler-btn:hover {
            background: #145014;
        }
    </style>
</head>
<body>

<div class="container">

    <h2>C++ Course – Notes, Lectures & Compiler</h2>

    <!-- PDF Notes -->
    <div class="notes-box">
        <img src="https://upload.wikimedia.org/wikipedia/commons/1/18/ISO_C%2B%2B_Logo.svg" alt="C++ Image">
        
        <div class="notes-info">
            <h3>C++ Notes (PDF)</h3>
            <p>Download complete C++ course notes in PDF format.</p>
            <a href="c++notes.pdf" class="download-btn" download>Download PDF</a>
        </div>
    </div>

    <!-- YouTube Video -->
    <div class="video-card">
        <img src="https://i.ytimg.com/vi/mlIUKyZIUUU/hqdefault.jpg" alt="C++ Lecture">

        <div class="video-info">
            <h3>Complete C++ Lecture</h3>
            <p>Click below to watch this lecture on YouTube.</p>
            <a href="https://www.youtube.com/watch?v=mlIUKyZIUUU&t=8s" target="_blank" class="watch-btn">Watch on YouTube</a>
        </div>
    </div>

    <!-- Online Compiler -->
    <div class="compiler-card">
        
        <div class="compiler-img-container">
            <img src="https://cdn-icons-png.flaticon.com/512/919/919841.png" class="compiler-img" alt="Compiler">
            <div class="compiler-text">C++ Online Compiler</div>
        </div>

        <div>
            <h3>Run C++ Programs Online</h3>
            <p>Use this online C++ compiler to write and execute your code instantly.</p>
            <a href="https://www.programiz.com/cpp-programming/online-compiler/" target="_blank" class="compiler-btn">Open Compiler</a>
        </div>

    </div>

</div>

</body>
</html>
