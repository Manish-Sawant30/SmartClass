<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Certificate Error</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #0a1f44; /* darkest blue */
            color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .error-box {
            width: 90%;
            max-width: 500px;
            background: #102c5a; /* dark blue */
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 0 12px rgba(0,0,0,0.4);
        }

        h2 {
            font-size: 26px;
            margin-bottom: 20px;
            color: #ff4d4d;
        }

        p {
            font-size: 18px;
            line-height: 1.5;
        }

        .btn-back {
            margin-top: 25px;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            background: #3a7bd5; /* light */
            color: white;
            cursor: pointer;
        }

        .btn-back:hover {
            background: #5593e8;
        }
    </style>
</head>

<body>

    <div class="error-box">
        <h2>Certificate Not Generated</h2>
        <p>Sorry! You have not completed the required <b>75% attendance</b> or <b>passed the examination</b>.<br><br>
        Your certificate cannot be generated at this moment.</p>

        <button class="btn-back" onclick="goBack()">Go Back</button>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }
    </script>

</body>
</html>