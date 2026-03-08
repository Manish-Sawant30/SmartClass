<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Notices - Parent Portal</title>
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

        .notices-container {
            display: grid;
            gap: 20px;
        }

        .notice-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s;
            border-left: 4px solid transparent;
        }

        .notice-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .notice-card.unread {
            border-left-color: var(--primary);
            background: linear-gradient(to right, #f0f7ff, white);
        }

        .notice-header {
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }

        .notice-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .unread-badge {
            background: var(--primary);
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .notice-meta {
            display: flex;
            gap: 20px;
            color: var(--gray);
            font-size: 13px;
        }

        .notice-meta i {
            margin-right: 5px;
            color: var(--primary);
        }

        .notice-content {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
            color: var(--gray);
            line-height: 1.6;
        }

        .notice-card.expanded .notice-content {
            padding: 20px;
            max-height: 500px;
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
            
            .notice-header {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
            
            .notice-meta {
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
        <h1><i class="fas fa-bell"></i> My Notices</h1>
        <p>Stay updated with announcements from the school</p>
    </div>
    <div class="header-actions">
        <a href="${pageContext.request.contextPath}/parent/dashboard" class="btn btn-primary">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <c:if test="${unreadCount > 0}">
            <form action="${pageContext.request.contextPath}/parent/notices/mark-all-read" method="post" style="display: inline;">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-check-double"></i> Mark All Read
                </button>
            </form>
        </c:if>
    </div>
</div>

<div class="stats-card">
    <div class="stats-icon">
        <i class="fas fa-envelope-open-text"></i>
    </div>
    <div class="stats-info">
        <h3>${unreadCount}</h3>
        <p>Unread Notices</p>
    </div>
</div>

<div class="notices-container">
    <c:choose>
        <c:when test="${not empty notices}">
            <c:forEach var="notice" items="${notices}">
                <div class="notice-card ${not notice.read ? 'unread' : ''}" id="notice-${notice.id}">
                    <div class="notice-header" onclick="toggleNotice(${notice.id})">
                        <div class="notice-title">
                            <i class="fas fa-bullhorn"></i>
                            ${notice.notice.title}
                            <c:if test="${not notice.read}">
                                <span class="unread-badge">New</span>
                            </c:if>
                        </div>
                        <div class="notice-meta">
                            <span><i class="fas fa-calendar"></i> ${fn:substring(notice.deliveredAt, 0, 16)}</span>
                            <span><i class="fas fa-user-graduate"></i> ${notice.studentName}</span>
                            <c:if test="${not empty notice.courseName}">
                                <span><i class="fas fa-book"></i> ${notice.courseName}</span>
                            </c:if>
                        </div>
                    </div>
                    <div class="notice-content" id="content-${notice.id}">
                        ${notice.notice.content}
                        <div style="margin-top: 15px; font-size: 12px; color: var(--gray);">
                            Sent by: ${notice.notice.createdBy}
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-bell-slash"></i>
                <h3>No Notices Yet</h3>
                <p>You don't have any notices at the moment. Check back later!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function toggleNotice(id) {
        const card = document.getElementById('notice-' + id);
        const content = document.getElementById('content-' + id);
        
        card.classList.toggle('expanded');
        
        // If this was unread, mark as read
        if (card.classList.contains('unread')) {
            fetch('${pageContext.request.contextPath}/parent/notices/mark-read/' + id, { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        card.classList.remove('unread');
                        // Update unread count
                        const unreadElement = document.querySelector('.stats-info h3');
                        if (unreadElement) {
                            const currentCount = parseInt(unreadElement.textContent);
                            unreadElement.textContent = currentCount - 1;
                        }
                    }
                })
                .catch(error => console.error('Error marking as read:', error));
        }
    }
    
    // Auto-hide success message after 5 seconds
    setTimeout(() => {
        const msg = document.getElementById('successMessage');
        if (msg) msg.remove();
    }, 5000);
</script>

</body>
</html>