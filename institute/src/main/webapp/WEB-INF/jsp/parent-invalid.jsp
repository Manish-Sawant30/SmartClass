<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduEra - Invalid Student ID</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ff6b6b, #ffb3b3);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box {
            width: 90%;
            max-width: 460px;
            background: white;
            padding: 35px;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 0 20px rgba(0,0,0,0.25);
        }

        h2 {
            color: #d9534f;
            margin-bottom: 15px;
        }

        p {
            font-size: 17px;
            margin-bottom: 25px;
        }

        .btn {
            padding: 12px 25px;
            background: #d9534f;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background: #b52a27;
        }
    </style>
</head>

<body>

    <div class="box">
        <h2>Invalid Student ID</h2>
        <p>The Student ID you entered does not match any registered student in our system.</p>

        <a href="ParentSignUp.html">
            <button class="btn">Try Again</button>
        </a>
    </div>

</body>
</html>
