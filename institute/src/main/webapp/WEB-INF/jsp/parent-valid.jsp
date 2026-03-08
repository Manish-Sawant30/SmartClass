<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduEra - Parent Signup Successful</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #0a74cf, #6fd3ff);
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
            color: #0a74cf;
            margin-bottom: 15px;
        }

        p {
            font-size: 17px;
            margin-bottom: 15px;
        }

        .credentials {
            font-size: 16px;
            background: #f0f8ff;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 25px;
            text-align: left;
        }

        .btn {
            padding: 12px 25px;
            background: #0a74cf;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background: #064f8f;
        }
    </style>
</head>

<body>

    <div class="box">
        <h2>Signup Successful</h2>
        <p>Your Parent Account has been successfully created and linked with your child's Student ID.</p>

     
        <a href="parents-login">
            <button class="btn">Go to Login</button>
        </a>
    </div>

    <script>
        // Example: dynamically generate Parent ID and password
        function generateParentId() {
            const randomNum = Math.floor(1000 + Math.random() * 9000); // 4-digit number
            return `EDU-PARENT-${randomNum}`;
        }

        function getParentPassword() {
            // Replace this with the actual password set during signup
            return "parent123"; 
        }

        // Insert dynamically
        document.getElementById("parentId").innerText = generateParentId();
        document.getElementById("parentPassword").innerText = getParentPassword();
    </script>

</body>
</html>
