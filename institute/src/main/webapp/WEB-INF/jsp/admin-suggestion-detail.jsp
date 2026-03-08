<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Suggestion Details | SmartClass</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --dark-purple: #2d1b3c;
            --deep-purple: #3e2a4d;
            --royal-purple: #5a3d6e;
            --medium-purple: #7a5a8c;
            --soft-purple: #9b7eb0;
            --light-purple: #c4b0d4;
            --extra-light-purple: #f0eaf5;
            --accent-gold: #e6b800;
            --white: #ffffff;
            --off-white: #faf7ff;
            --text-dark: #2d1b3c;
            --text-light: #5a3d6e;
            --text-muted: #7a5a8c;
            --shadow: 0 8px 20px rgba(90, 61, 110, 0.12);
            --shadow-sm: 0 4px 10px rgba(90, 61, 110, 0.08);
            --radius: 16px;
            --radius-sm: 10px;
            --transition: all 0.3s ease;
            
            /* Status colors */
            --primary: var(--royal-purple);
            --success: #4caf50;
            --danger: #f44336;
            --warning: #ff9800;
            --info: #2196f3;
            --pending: #ff9800;
            --read: #2196f3;
            --responded: #4caf50;
            --closed: #6c757d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background: linear-gradient(135deg, var(--extra-light-purple) 0%, var(--light-purple) 100%);
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            color: var(--white);
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
            border-bottom: 4px solid var(--accent-gold);
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .logo h1 i {
            color: var(--accent-gold);
            margin-right: 10px;
        }

        .nav-links a {
            color: var(--white);
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 15px;
            border-radius: 30px;
            transition: var(--transition);
            font-weight: 500;
            border: 2px solid transparent;
        }

        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--accent-gold);
        }

        .nav-links a.active {
            background: var(--accent-gold);
            color: var(--dark-purple);
            font-weight: 600;
        }

        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .back-link {
            margin-bottom: 20px;
            display: inline-block;
        }

        .back-link a {
            color: var(--royal-purple);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            transition: var(--transition);
            padding: 8px 16px;
            border-radius: 30px;
            background: var(--white);
            border: 2px solid var(--light-purple);
        }

        .back-link a:hover {
            background: var(--extra-light-purple);
            border-color: var(--accent-gold);
            transform: translateX(-3px);
        }

        .suggestion-card {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            border: 2px solid var(--light-purple);
        }

        .suggestion-header {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            padding: 25px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            border-bottom: 4px solid var(--accent-gold);
        }

        .suggestion-header h2 {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .status-badge {
            padding: 8px 20px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 600;
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid transparent;
        }

        .suggestion-body {
            padding: 30px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
            background: var(--extra-light-purple);
            padding: 20px;
            border-radius: var(--radius-sm);
            border: 2px solid var(--light-purple);
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 5px;
            font-weight: 500;
        }

        .info-value {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .info-value small {
            font-size: 14px;
            font-weight: normal;
            color: var(--text-muted);
        }

        .message-box {
            background: var(--extra-light-purple);
            padding: 25px;
            border-radius: var(--radius-sm);
            margin-bottom: 30px;
            border-left: 4px solid var(--accent-gold);
            border: 2px solid var(--light-purple);
        }

        .message-box h3 {
            color: var(--royal-purple);
            margin-bottom: 15px;
            font-size: 18px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .message-box h3 i {
            color: var(--accent-gold);
        }

        .message-content {
            line-height: 1.8;
            color: var(--text-light);
            white-space: pre-line;
        }

        .response-section {
            background: linear-gradient(135deg, var(--extra-light-purple), var(--white));
            padding: 25px;
            border-radius: var(--radius-sm);
            margin-bottom: 30px;
            border: 2px solid var(--light-purple);
        }

        .response-section h3 {
            color: var(--success);
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .response-section h3 i {
            color: var(--accent-gold);
        }

        .response-box {
            background: var(--white);
            padding: 20px;
            border-radius: var(--radius-sm);
            margin-top: 15px;
            border-left: 4px solid var(--success);
            border: 2px solid var(--light-purple);
        }

        .response-meta {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            font-size: 13px;
            color: var(--text-muted);
        }

        .response-text {
            line-height: 1.8;
            color: var(--text-light);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            font-size: 15px;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
        }

        .form-control:focus {
            border-color: var(--soft-purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            border: 2px solid transparent;
        }

        .btn-primary {
            background: var(--accent-gold);
            color: var(--dark-purple);
        }

        .btn-primary:hover {
            background: transparent;
            border-color: var(--accent-gold);
            color: var(--accent-gold);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(230, 184, 0, 0.3);
        }

        .btn-success {
            background: var(--success);
            color: var(--white);
        }

        .btn-success:hover {
            background: transparent;
            border-color: var(--success);
            color: var(--success);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }

        .btn-danger {
            background: var(--danger);
            color: var(--white);
        }

        .btn-danger:hover {
            background: transparent;
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        .btn-secondary {
            background: var(--text-muted);
            color: var(--white);
        }

        .btn-secondary:hover {
            background: transparent;
            border-color: var(--text-muted);
            color: var(--text-muted);
            transform: translateY(-2px);
        }

        .status-select {
            padding: 12px 16px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            font-size: 14px;
            cursor: pointer;
            width: 100%;
            background: var(--white);
            color: var(--text-dark);
            transition: var(--transition);
        }

        .status-select:focus {
            border-color: var(--soft-purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .header {
                padding: 15px 20px;
            }
            
            .logo h1 {
                font-size: 20px;
            }
            
            .nav-links a {
                padding: 6px 12px;
                font-size: 13px;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .nav-links {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 10px;
            }
            
            .nav-links a {
                margin-left: 0;
            }
            
            .suggestion-header {
                flex-direction: column;
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .container {
                padding: 0 15px;
            }
            
            .suggestion-header h2 {
                font-size: 20px;
            }
            
            .suggestion-body {
                padding: 20px;
            }
            
            .message-box {
                padding: 20px;
            }
            
            .response-section {
                padding: 20px;
            }
            
            .response-meta {
                flex-direction: column;
                gap: 10px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .back-link a:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>

<div class="header">
    <div class="logo">
        <h1><i class="fas fa-comment"></i> Suggestion Details</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admindash"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/notices"><i class="fas fa-bullhorn"></i> Notices</a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/list" class="active"><i class="fas fa-comment"></i> Suggestions</a>
    </div>
</div>

<div class="container">
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/suggestions/admin/list">
            <i class="fas fa-arrow-left"></i> Back to Suggestions
        </a>
    </div>

    <div class="suggestion-card">
        <div class="suggestion-header">
            <h2><i class="fas fa-comment"></i> ${suggestion.subject}</h2>
            <span class="status-badge">${suggestion.status.displayName}</span>
        </div>
        
        <div class="suggestion-body">
            <!-- Info Grid -->
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Suggestion ID</span>
                    <span class="info-value">${suggestion.suggestionId}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Parent</span>
                    <span class="info-value">${suggestion.parentName}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Parent Email</span>
                    <span class="info-value">${suggestion.parentEmail}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Student</span>
                    <span class="info-value">${suggestion.studentName} (${suggestion.studentId})</span>
                </div>
                
                <c:if test="${not empty suggestion.courseName}">
                    <div class="info-item">
                        <span class="info-label">Course</span>
                        <span class="info-value">${suggestion.courseName}</span>
                    </div>
                </c:if>
                
                <div class="info-item">
                    <span class="info-label">Submitted On</span>
                    <span class="info-value">${fn:substring(suggestion.createdAt, 0, 16)}</span>
                </div>
            </div>
            
            <!-- Message Box -->
            <div class="message-box">
                <h3><i class="fas fa-quote-right"></i> Suggestion Message</h3>
                <div class="message-content">
                    ${suggestion.message}
                </div>
            </div>
            
            <!-- Response Section -->
            <div class="response-section" id="respond">
                <h3><i class="fas fa-reply"></i> Admin Response</h3>
                
                <c:choose>
                    <c:when test="${not empty suggestion.adminResponse}">
                        <!-- Existing Response -->
                        <div class="response-box">
                            <div class="response-meta">
                                <span><i class="fas fa-user"></i> Responded by: ${suggestion.respondedBy}</span>
                                <span><i class="fas fa-calendar"></i> ${fn:substring(suggestion.respondedAt, 0, 16)}</span>
                            </div>
                            <div class="response-text">
                                ${suggestion.adminResponse}
                            </div>
                        </div>
                        
                        <!-- Update Status Form -->
                        <form action="${pageContext.request.contextPath}/suggestions/admin/respond/${suggestion.id}" method="post" style="margin-top: 20px;">
                            <div class="form-group">
                                <label for="status">Update Status</label>
                                <select id="status" name="status" class="status-select">
                                    <c:forEach var="status" items="${statuses}">
                                        <option value="${status}" ${suggestion.status == status ? 'selected' : ''}>
                                            ${status.displayName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="response">Additional Response (Optional)</label>
                                <textarea id="response" name="response" class="form-control" 
                                          placeholder="Add additional response...">${suggestion.adminResponse}</textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-sync-alt"></i> Update Response
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <!-- Response Form -->
                        <form action="${pageContext.request.contextPath}/suggestions/admin/respond/${suggestion.id}" method="post">
                            <div class="form-group">
                                <label for="response">Your Response *</label>
                                <textarea id="response" name="response" class="form-control" 
                                          placeholder="Write your response to the parent..." required></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="status">Update Status</label>
                                <select id="status" name="status" class="status-select">
                                    <c:forEach var="status" items="${statuses}">
                                        <option value="${status}" ${suggestion.status == status ? 'selected' : ''}>
                                            ${status.displayName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="action-buttons">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-paper-plane"></i> Send Response
                                </button>
                                <a href="${pageContext.request.contextPath}/suggestions/admin/list" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Back
                                </a>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <c:if test="${suggestion.status == 'PENDING'}">
                    <form action="${pageContext.request.contextPath}/suggestions/admin/mark-read/${suggestion.id}" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check"></i> Mark as Read
                        </button>
                    </form>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/suggestions/admin/delete/${suggestion.id}" method="post" 
                      onsubmit="return confirm('Are you sure you want to delete this suggestion?');" style="display: inline;">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Suggestion
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Auto-hide messages after 5 seconds
    setTimeout(() => {
        document.querySelectorAll('.success-message, .error-message').forEach(msg => {
            msg.style.opacity = '0';
            setTimeout(() => msg.remove(), 300);
        });
    }, 5000);

    // Touch feedback for mobile
    document.addEventListener('DOMContentLoaded', function() {
        const touchElements = document.querySelectorAll('.btn, .back-link a, .status-select');
        touchElements.forEach(el => {
            el.addEventListener('touchstart', function() {
                this.style.transform = 'scale(0.98)';
            }, { passive: true });
            
            el.addEventListener('touchend', function() {
                this.style.transform = '';
            }, { passive: true });
            
            el.addEventListener('touchcancel', function() {
                this.style.transform = '';
            }, { passive: true });
        });
    });
</script>

</body>
</html>