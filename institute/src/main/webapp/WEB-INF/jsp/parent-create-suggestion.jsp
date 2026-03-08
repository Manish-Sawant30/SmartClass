<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Suggestion - Parent Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
        }

        .card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 30px;
        }

        .card-header h1 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .card-header p {
            opacity: 0.9;
            font-size: 15px;
        }

        .card-body {
            padding: 30px;
        }

        .info-box {
            background: #e3f2fd;
            border-left: 4px solid var(--primary);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }

        .info-box h3 {
            color: var(--primary);
            margin-bottom: 10px;
            font-size: 16px;
        }

        .info-box p {
            color: var(--gray);
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }

        .student-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .student-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }

        .student-details h3 {
            font-size: 18px;
            color: var(--dark);
        }

        .student-details p {
            color: var(--gray);
            font-size: 14px;
        }

        .course-badge {
            display: inline-block;
            background: #e3f2fd;
            color: var(--primary);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .btn {
            padding: 14px 28px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            width: 100%;
            justify-content: center;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        .btn-secondary {
            background: #e9ecef;
            color: var(--dark);
        }

        .btn-secondary:hover {
            background: #dee2e6;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            text-decoration: none;
            margin-bottom: 20px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .student-info {
                flex-direction: column;
                text-align: center;
            }
            
            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <a href="/parent/dashboard" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
    
    <div class="card">
        <div class="card-header">
            <h1><i class="fas fa-comment"></i> Submit a Suggestion</h1>
            <p>Your feedback helps us improve the learning experience</p>
        </div>
        
        <div class="card-body">
            <!-- Student Information -->
            <div class="student-info">
                <div class="student-avatar">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="student-details">
                    <h3>${student.fullName}</h3>
                    <p>Student ID: ${student.studentId}</p>
                    <div style="margin-top: 5px;">
                        <c:forEach var="course" items="${student.courses}">
                            <span class="course-badge">${course}</span>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div class="info-box">
                <h3><i class="fas fa-info-circle"></i> Guidelines</h3>
                <p>• Be specific and clear in your suggestion</p>
                <p>• Include relevant details that can help us understand your point better</p>
                <p>• Your identity and student information will be visible to administrators</p>
                <p>• You will receive a response within 2-3 working days</p>
            </div>
            
			<form action="${pageContext.request.contextPath}/suggestions/parent/create" method="post">
                <div class="form-group">
                    <label for="courseName">Related Course (Optional)</label>
                    <select id="courseName" name="courseName" class="form-control">
                        <option value="">-- Select a course (optional) --</option>
                        <c:forEach var="course" items="${student.courses}">
                            <option value="${course}">${course}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="subject">Subject *</label>
                    <input type="text" id="subject" name="subject" class="form-control" 
                           placeholder="Brief summary of your suggestion" required>
                </div>
                
                <div class="form-group">
                    <label for="message">Your Suggestion *</label>
                    <textarea id="message" name="message" class="form-control" 
                              placeholder="Write your suggestion in detail..." required></textarea>
                </div>
                
                <div class="button-group">
                    <a href="/parent/dashboard" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane"></i> Submit Suggestion
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>