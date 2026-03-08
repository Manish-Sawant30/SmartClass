<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Notice Details | SmartClass</title>
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
            --success: #4caf50;
            --warning: #ff9800;
            --danger: #f44336;
            --info: #2196f3;
            --primary: var(--royal-purple);
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
            max-width: 1200px;
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

        .notice-card {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            border: 2px solid var(--light-purple);
        }

        .notice-header {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            padding: 25px 30px;
            border-bottom: 4px solid var(--accent-gold);
        }

        .notice-header h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }

        .notice-meta {
            display: flex;
            gap: 30px;
            font-size: 14px;
            opacity: 0.95;
            flex-wrap: wrap;
        }

        .notice-meta i {
            margin-right: 5px;
            color: var(--accent-gold);
        }

        .notice-body {
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
            font-size: 18px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .info-value small {
            font-size: 14px;
            font-weight: normal;
            color: var(--text-muted);
        }

        .badge {
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-all {
            background: rgba(33, 150, 243, 0.1);
            color: #2196f3;
        }

        .badge-course {
            background: rgba(255, 152, 0, 0.1);
            color: #ff9800;
        }

        .badge-student {
            background: rgba(233, 30, 99, 0.1);
            color: #e91e63;
        }

        .content-box {
            background: var(--extra-light-purple);
            padding: 25px;
            border-radius: var(--radius-sm);
            margin-bottom: 30px;
            line-height: 1.8;
            white-space: pre-line;
            border: 2px solid var(--light-purple);
        }

        .content-box h3 {
            color: var(--royal-purple);
            margin-bottom: 15px;
            font-size: 18px;
            font-weight: 600;
        }

        .content-box h3 i {
            color: var(--accent-gold);
            margin-right: 8px;
        }

        .stats-box {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-item {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            color: var(--white);
            padding: 20px;
            border-radius: var(--radius-sm);
            text-align: center;
            border: 2px solid transparent;
            transition: var(--transition);
        }

        .stat-item:hover {
            transform: translateY(-3px);
            border-color: var(--accent-gold);
            box-shadow: var(--shadow);
        }

        .stat-item .stat-number {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-item .stat-label {
            font-size: 13px;
            opacity: 0.95;
            font-weight: 500;
        }

        .stat-item.read {
            background: linear-gradient(135deg, #4caf50, #45a049);
        }

        .stat-item.unread {
            background: linear-gradient(135deg, #ff9800, #f57c00);
        }

        .recipients-section {
            background: var(--white);
            border-radius: var(--radius-sm);
            border: 2px solid var(--light-purple);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .section-title {
            padding: 20px;
            border-bottom: 2px solid var(--light-purple);
            font-size: 18px;
            font-weight: 600;
            color: var(--text-dark);
            background: var(--extra-light-purple);
        }

        .section-title i {
            color: var(--accent-gold);
            margin-right: 8px;
        }

        .recipients-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .recipient-item {
            padding: 15px 20px;
            border-bottom: 1px solid var(--light-purple);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: var(--transition);
        }

        .recipient-item:last-child {
            border-bottom: none;
        }

        .recipient-item:hover {
            background: var(--extra-light-purple);
        }

        .recipient-info {
            display: flex;
            flex-direction: column;
        }

        .recipient-name {
            font-weight: 600;
            color: var(--text-dark);
        }

        .recipient-details {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 3px;
        }

        .recipient-details i {
            margin-right: 5px;
            color: var(--soft-purple);
        }

        .read-status {
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            border: 2px solid transparent;
        }

        .read-status.read {
            background: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .read-status.unread {
            background: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .read-time {
            font-size: 11px;
            color: var(--text-muted);
            margin-top: 5px;
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

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--light-purple);
        }

        .empty-state h3 {
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .header {
                padding: 15px 20px;
            }
            
            .logo h1 {
                font-size: 20px;
            }
            
            .notice-header h2 {
                font-size: 24px;
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
                padding: 6px 12px;
                font-size: 13px;
            }
            
            .notice-meta {
                flex-direction: column;
                gap: 10px;
            }
            
            .recipient-item {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-box {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .container {
                padding: 0 15px;
            }
            
            .notice-header {
                padding: 20px;
            }
            
            .notice-header h2 {
                font-size: 20px;
            }
            
            .notice-body {
                padding: 20px;
            }
            
            .content-box {
                padding: 20px;
            }
            
            .stat-item .stat-number {
                font-size: 28px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .back-link a:active,
            .stat-item:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>

<div class="header">
    <div class="logo">
        <h1><i class="fas fa-bullhorn"></i> Notice Details</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admindash"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/notices" class="active"><i class="fas fa-bullhorn"></i> Notices</a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/list"><i class="fas fa-comment"></i> Suggestions</a>
    </div>
</div>

<div class="container">
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/admin/notices">
            <i class="fas fa-arrow-left"></i> Back to Notices
        </a>
    </div>

    <div class="notice-card">
        <div class="notice-header">
            <h2>${notice.title}</h2>
            <div class="notice-meta">
                <span><i class="fas fa-hashtag"></i> ${notice.noticeId}</span>
                <span><i class="fas fa-calendar"></i> ${fn:substring(notice.createdAt, 0, 16)}</span>
                <span><i class="fas fa-user"></i> ${notice.createdBy}</span>
            </div>
        </div>
        
        <div class="notice-body">
            <!-- Info Grid -->
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Target Type</span>
                    <span class="info-value">
                        <span class="badge badge-${notice.targetType.toString().toLowerCase()}">
                            ${notice.targetType.displayName}
                        </span>
                    </span>
                </div>
                
                <c:if test="${notice.targetType != 'ALL'}">
                    <div class="info-item">
                        <span class="info-label">Target Value</span>
                        <span class="info-value">${notice.targetValue}</span>
                    </div>
                </c:if>
                
                <div class="info-item">
                    <span class="info-label">Total Recipients</span>
                    <span class="info-value">${deliveryStatus.totalRecipients}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Delivery Rate</span>
                    <span class="info-value">${deliveryStatus.readPercentage}% <small>read</small></span>
                </div>
            </div>
            
            <!-- Content Box -->
            <div class="content-box">
                <h3><i class="fas fa-file-alt"></i> Notice Content</h3>
                <p>${notice.content}</p>
            </div>
            
            <!-- Stats Box -->
            <div class="stats-box">
                <div class="stat-item">
                    <div class="stat-number">${deliveryStatus.totalRecipients}</div>
                    <div class="stat-label">Total Recipients</div>
                </div>
                <div class="stat-item read">
                    <div class="stat-number">${deliveryStatus.readCount}</div>
                    <div class="stat-label">Read</div>
                </div>
                <div class="stat-item unread">
                    <div class="stat-number">${deliveryStatus.unreadCount}</div>
                    <div class="stat-label">Unread</div>
                </div>
            </div>
            
            <!-- Recipients List -->
            <div class="recipients-section">
                <div class="section-title">
                    <i class="fas fa-users"></i> Recipients (${notice.recipients.size()})
                </div>
                <div class="recipients-list">
                    <c:choose>
                        <c:when test="${not empty notice.recipients}">
                            <c:forEach var="recipient" items="${notice.recipients}">
                                <div class="recipient-item">
                                    <div class="recipient-info">
                                        <span class="recipient-name">${recipient.parentName}</span>
                                        <span class="recipient-details">
                                            <i class="fas fa-user-graduate"></i> ${recipient.studentId} - ${recipient.studentName}
                                        </span>
                                        <c:if test="${not empty recipient.courseName}">
                                            <span class="recipient-details">
                                                <i class="fas fa-book"></i> ${recipient.courseName}
                                            </span>
                                        </c:if>
                                    </div>
                                    <div>
                                        <span class="read-status ${recipient.read ? 'read' : 'unread'}">
                                            <i class="fas ${recipient.read ? 'fa-check-circle' : 'fa-clock'}"></i>
                                            ${recipient.read ? 'Read' : 'Unread'}
                                        </span>
                                        <c:if test="${recipient.read}">
                                            <div class="read-time">
                                                ${fn:substring(recipient.readAt, 0, 16)}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-user-slash"></i>
                                <h3>No Recipients</h3>
                                <p>This notice has no recipients yet</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/notices" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
                <form action="${pageContext.request.contextPath}/admin/notices/delete/${notice.id}" method="post" 
                      onsubmit="return confirm('Are you sure you want to delete this notice?');">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Notice
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Touch feedback for mobile
    document.addEventListener('DOMContentLoaded', function() {
        const touchElements = document.querySelectorAll('.btn, .back-link a, .stat-item');
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