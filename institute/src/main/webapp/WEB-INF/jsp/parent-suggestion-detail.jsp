<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suggestion Details - Parent Portal</title>
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
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 24px;
            font-weight: 600;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .nav-links a:hover, .nav-links a.active {
            background: rgba(255,255,255,0.2);
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .back-link {
            margin-bottom: 20px;
            display: inline-block;
        }

        .back-link a {
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        .suggestion-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .suggestion-header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 25px 30px;
        }

        .suggestion-header h2 {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .suggestion-meta {
            display: flex;
            gap: 20px;
            font-size: 14px;
            opacity: 0.9;
        }

        .suggestion-meta i {
            margin-right: 5px;
        }

        .suggestion-body {
            padding: 30px;
        }

        .info-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 12px;
            color: var(--gray);
            margin-bottom: 5px;
        }

        .info-value {
            font-size: 15px;
            font-weight: 600;
            color: var(--dark);
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-badge.pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-badge.read {
            background: #cce5ff;
            color: #004085;
        }

        .status-badge.responded {
            background: #d4edda;
            color: #155724;
        }

        .status-badge.closed {
            background: #e2e3e5;
            color: #383d41;
        }

        .message-section {
            margin-bottom: 30px;
        }

        .message-section h3 {
            color: var(--primary);
            margin-bottom: 15px;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .message-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid var(--primary);
            line-height: 1.8;
            white-space: pre-line;
        }

        .response-section {
            margin-bottom: 30px;
        }

        .response-section h3 {
            color: var(--success);
            margin-bottom: 15px;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .response-box {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid var(--success);
        }

        .response-text {
            line-height: 1.8;
            color: var(--dark);
            margin-bottom: 15px;
        }

        .response-meta {
            font-size: 13px;
            color: var(--gray);
            display: flex;
            gap: 20px;
            padding-top: 10px;
            border-top: 1px dashed #b8daff;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
            }
            
            .suggestion-meta {
                flex-direction: column;
                gap: 10px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <div>
        <h1><i class="fas fa-comment"></i> Suggestion Details</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/parent/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/suggestions/parent/list" class="active"><i class="fas fa-comment"></i> Suggestions</a>
    </div>
</div>

<div class="container">
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/suggestions/parent/list">
            <i class="fas fa-arrow-left"></i> Back to Suggestions
        </a>
    </div>

    <div class="suggestion-card">
        <div class="suggestion-header">
            <h2>${suggestion.subject}</h2>
            <div class="suggestion-meta">
                <span><i class="fas fa-hashtag"></i> ${suggestion.suggestionId}</span>
                <span><i class="fas fa-calendar"></i> ${fn:substring(suggestion.createdAt, 0, 16)}</span>
                <span><i class="fas fa-tag"></i> <span class="status-badge ${fn:toLowerCase(suggestion.status)}">${suggestion.status.displayName}</span></span>
            </div>
        </div>
        
        <div class="suggestion-body">
            <div class="info-box">
                <div class="info-item">
                    <span class="info-label">Student</span>
                    <span class="info-value">${suggestion.studentName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Student ID</span>
                    <span class="info-value">${suggestion.studentId}</span>
                </div>
                <c:if test="${not empty suggestion.courseName}">
                    <div class="info-item">
                        <span class="info-label">Course</span>
                        <span class="info-value">${suggestion.courseName}</span>
                    </div>
                </c:if>
            </div>
            
            <div class="message-section">
                <h3><i class="fas fa-quote-right"></i> Your Suggestion</h3>
                <div class="message-box">
                    ${suggestion.message}
                </div>
            </div>
            
            <c:if test="${not empty suggestion.adminResponse}">
                <div class="response-section">
                    <h3><i class="fas fa-reply"></i> Admin Response</h3>
                    <div class="response-box">
                        <div class="response-text">
                            ${suggestion.adminResponse}
                        </div>
                        <div class="response-meta">
                            <span><i class="fas fa-user"></i> Responded by: ${suggestion.respondedBy}</span>
                            <span><i class="fas fa-calendar"></i> ${fn:substring(suggestion.respondedAt, 0, 16)}</span>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/suggestions/parent/list" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>