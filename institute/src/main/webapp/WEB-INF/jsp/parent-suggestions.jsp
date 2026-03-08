<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Suggestions - Parent Portal</title>
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
            padding: 25px 30px;
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
            font-size: 28px;
            font-weight: 600;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
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
            background: white;
            color: var(--primary);
        }

        .btn-primary:hover {
            background: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-success:hover {
            background: #3aa8d0;
            transform: translateY(-2px);
        }

        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .stats-icon {
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

        .stats-info h3 {
            font-size: 32px;
            font-weight: 700;
            color: var(--dark);
        }

        .stats-info p {
            color: var(--gray);
            font-size: 14px;
        }

        .suggestions-container {
            display: grid;
            gap: 20px;
        }

        .suggestion-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s;
            border-left: 4px solid transparent;
        }

        .suggestion-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .suggestion-card.pending {
            border-left-color: var(--warning);
        }

        .suggestion-card.responded {
            border-left-color: var(--success);
        }

        .suggestion-header {
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .suggestion-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .status-badge {
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

        .suggestion-meta {
            display: flex;
            gap: 20px;
            color: var(--gray);
            font-size: 13px;
        }

        .suggestion-meta i {
            margin-right: 5px;
            color: var(--primary);
        }

        .suggestion-content {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
        }

        .suggestion-card.expanded .suggestion-content {
            padding: 20px;
            max-height: 500px;
        }

        .message-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            line-height: 1.8;
            white-space: pre-line;
        }

        .response-box {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid var(--success);
        }

        .response-box h4 {
            color: var(--success);
            margin-bottom: 10px;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .response-text {
            line-height: 1.8;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .response-meta {
            font-size: 12px;
            color: var(--gray);
            display: flex;
            gap: 15px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
        }

        .empty-state i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 24px;
            color: var(--gray);
            margin-bottom: 10px;
        }

        .empty-state p {
            color: var(--gray);
            margin-bottom: 20px;
        }

        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, var(--success), #3aa8d0);
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
            }
            
            .suggestion-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .suggestion-meta {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>

<c:if test="${not empty successMessage}">
    <div class="success-message" id="successMessage">
        <i class="fas fa-check-circle"></i>
        <span>${successMessage}</span>
        <button onclick="this.parentElement.remove()" style="background: none; border: none; color: white; margin-left: auto; cursor: pointer;">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>

<div class="header">
    <div>
        <h1><i class="fas fa-comment"></i> My Suggestions</h1>
        <p>Track and view responses to your suggestions</p>
    </div>
    <div class="header-actions">
        <a href="${pageContext.request.contextPath}/parent/dashboard" class="btn btn-primary">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/suggestions/parent/create" class="btn btn-success">
            <i class="fas fa-plus"></i> New Suggestion
        </a>
    </div>
</div>

<div class="stats-card">
    <div class="stats-icon">
        <i class="fas fa-clock"></i>
    </div>
    <div class="stats-info">
        <h3>${fn:length(suggestions)}</h3>
        <p>Total Suggestions</p>
    </div>
</div>

<div class="suggestions-container">
    <c:choose>
        <c:when test="${not empty suggestions}">
            <c:forEach var="suggestion" items="${suggestions}">
                <div class="suggestion-card ${fn:toLowerCase(suggestion.status)}" id="suggestion-${suggestion.id}">
                    <div class="suggestion-header" onclick="toggleSuggestion(${suggestion.id})">
                        <div class="suggestion-title">
                            <i class="fas fa-comment"></i>
                            ${suggestion.subject}
                        </div>
                        <div class="suggestion-meta">
                            <span><i class="fas fa-calendar"></i> ${fn:substring(suggestion.createdAt, 0, 16)}</span>
                            <span><i class="fas fa-user-graduate"></i> ${suggestion.studentName}</span>
                            <span class="status-badge ${fn:toLowerCase(suggestion.status)}">
                                ${suggestion.status.displayName}
                            </span>
                        </div>
                    </div>
                    <div class="suggestion-content" id="content-${suggestion.id}">
                        <div class="message-box">
                            ${suggestion.message}
                        </div>
                        
                        <c:if test="${not empty suggestion.adminResponse}">
                            <div class="response-box">
                                <h4><i class="fas fa-reply"></i> Admin Response</h4>
                                <div class="response-text">
                                    ${suggestion.adminResponse}
                                </div>
                                <div class="response-meta">
                                    <span><i class="fas fa-user"></i> ${suggestion.respondedBy}</span>
                                    <span><i class="fas fa-calendar"></i> ${fn:substring(suggestion.respondedAt, 0, 16)}</span>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-comment-slash"></i>
                <h3>No Suggestions Yet</h3>
                <p>You haven't submitted any suggestions. Share your feedback with us!</p>
                <a href="${pageContext.request.contextPath}/suggestions/parent/create" class="btn btn-success">
                    <i class="fas fa-plus"></i> Submit Your First Suggestion
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function toggleSuggestion(id) {
        const card = document.getElementById('suggestion-' + id);
        const content = document.getElementById('content-' + id);
        
        card.classList.toggle('expanded');
    }
    
    // Auto-hide success message after 5 seconds
    setTimeout(() => {
        const msg = document.getElementById('successMessage');
        if (msg) msg.remove();
    }, 5000);
</script>

</body>
</html>