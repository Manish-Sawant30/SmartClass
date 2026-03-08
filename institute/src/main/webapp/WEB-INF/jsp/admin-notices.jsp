<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Notice Management | SmartClass</title>
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
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 25px;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: var(--transition);
            border: 2px solid transparent;
            border-left: 4px solid var(--royal-purple);
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow);
            border-color: var(--light-purple);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--white);
            transition: var(--transition);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-icon.total { background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple)); }
        .stat-icon.all { background: linear-gradient(135deg, #4cc9f0, #4895ef); }
        .stat-icon.course { background: linear-gradient(135deg, #f8961e, #f3722c); }
        .stat-icon.student { background: linear-gradient(135deg, #f72585, #b5179e); }

        .stat-info h3 {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
        }

        .action-bar {
            background: var(--white);
            border-radius: var(--radius);
            padding: 20px 25px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            box-shadow: var(--shadow-sm);
            border: 2px solid var(--light-purple);
        }

        .action-bar h3 {
            color: var(--text-dark);
            font-size: 1.2rem;
            font-weight: 600;
        }

        .action-bar h3 i {
            color: var(--accent-gold);
            margin-right: 8px;
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

        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
        }

        .table-container {
            background: var(--white);
            border-radius: var(--radius-sm);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            border: 2px solid var(--light-purple);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            color: var(--white);
        }

        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid var(--light-purple);
            color: var(--text-light);
        }

        tbody tr:hover {
            background-color: var(--extra-light-purple);
        }

        .badge {
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 12px;
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

        .target-info {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 5px;
        }

        .target-value {
            font-weight: 600;
            color: var(--text-dark);
        }

        .recipient-count {
            display: inline-block;
            background: var(--success);
            color: var(--white);
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
        }

        .read-count {
            display: inline-block;
            background: var(--info);
            color: var(--white);
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            color: var(--white);
            border: 2px solid transparent;
        }

        .action-btn.view {
            background: var(--info);
        }

        .action-btn.view:hover {
            background: transparent;
            border-color: var(--info);
            color: var(--info);
            transform: translateY(-2px);
        }

        .action-btn.delete {
            background: var(--danger);
        }

        .action-btn.delete:hover {
            background: transparent;
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
        }

        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--success);
            color: var(--white);
            padding: 16px 24px;
            border-radius: var(--radius-sm);
            box-shadow: var(--shadow);
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
            border-left: 4px solid var(--accent-gold);
        }

        .error-message {
            background: var(--danger);
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .fade-out {
            animation: fadeOut 0.3s forwards;
        }

        @keyframes fadeOut {
            to { opacity: 0; transform: translateX(100%); }
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
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
            font-size: 1.5rem;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .header {
                padding: 15px 20px;
            }
            
            .logo h1 {
                font-size: 20px;
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
            
            .stats-cards {
                grid-template-columns: 1fr;
            }
            
            .action-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .action-bar h3 {
                text-align: center;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            table {
                font-size: 13px;
            }
            
            th, td {
                padding: 12px 8px;
            }
        }

        @media (max-width: 576px) {
            .container {
                padding: 0 15px;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-icon {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
            
            .stat-info h3 {
                font-size: 24px;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .action-btn {
                width: 100%;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .action-btn:active {
                transform: scale(0.98);
            }
            
            .stat-card:active {
                transform: translateY(-2px);
            }
        }
    </style>
</head>
<body>

<!-- Success/Error Messages -->
<c:if test="${not empty successMessage}">
    <div class="success-message" id="successMessage">
        <i class="fas fa-check-circle"></i>
        <span>${successMessage}</span>
        <button onclick="closeMessage(this)" style="background: none; border: none; color: white; margin-left: auto; cursor: pointer; font-size: 1.2rem;">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="success-message error-message" id="errorMessage">
        <i class="fas fa-exclamation-circle"></i>
        <span>${errorMessage}</span>
        <button onclick="closeMessage(this)" style="background: none; border: none; color: white; margin-left: auto; cursor: pointer; font-size: 1.2rem;">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>

<div class="header">
    <div class="logo">
        <h1><i class="fas fa-bullhorn"></i> Notice Management</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admindash"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/notices" class="active"><i class="fas fa-bullhorn"></i> Notices</a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/list"><i class="fas fa-comment"></i> Suggestions</a>
    </div>
</div>

<div class="container">
    <!-- Stats Cards -->
    <div class="stats-cards">
        <div class="stat-card">
            <div class="stat-icon total">
                <i class="fas fa-bullhorn"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.totalNotices}</h3>
                <p>Total Notices</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon all">
                <i class="fas fa-globe"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.allNotices}</h3>
                <p>To All Parents</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon course">
                <i class="fas fa-book"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.courseNotices}</h3>
                <p>Course Specific</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon student">
                <i class="fas fa-user-graduate"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.studentNotices}</h3>
                <p>Student Specific</p>
            </div>
        </div>
    </div>

    <!-- Action Bar -->
    <div class="action-bar">
        <div>
            <h3><i class="fas fa-list"></i> All Notices</h3>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/notices/create" class="btn btn-primary">
                <i class="fas fa-plus"></i> Create New Notice
            </a>
        </div>
    </div>

    <!-- Notices Table -->
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Notice ID</th>
                    <th>Title</th>
                    <th>Target</th>
                    <th>Created By</th>
                    <th>Recipients</th>
                    <th>Read</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty notices}">
                        <c:forEach var="notice" items="${notices}">
                            <tr>
                                <td><strong>${notice.noticeId}</strong></td>
                                <td>
                                    <div style="font-weight: 600; color: var(--text-dark);">${notice.title}</div>
                                    <div style="font-size: 12px; color: var(--text-muted); max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        ${notice.content}
                                    </div>
                                </td>
                                <td>
                                    <span class="badge badge-${notice.targetType.toString().toLowerCase()}">
                                        ${notice.targetType.displayName}
                                    </span>
                                    <c:if test="${notice.targetType != 'ALL'}">
                                        <div class="target-info">
                                            <span class="target-value">${notice.targetValue}</span>
                                        </div>
                                    </c:if>
                                </td>
                                <td>${notice.createdBy}</td>
                                <td>
                                    <span class="recipient-count">${notice.recipientCount}</span>
                                </td>
                                <td>
                                    <span class="read-count">
                                        ${notice.readCount}/${notice.recipientCount}
                                    </span>
                                </td>
                                <td>${fn:substring(notice.createdAt, 0, 16)}</td>
                                <td>
                                    <div class="actions">
                                        <a href="${pageContext.request.contextPath}/admin/notices/${notice.id}" class="action-btn view" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <form action="${pageContext.request.contextPath}/admin/notices/delete/${notice.id}" method="post" style="display: inline;" 
                                              onsubmit="return confirm('Are you sure you want to delete this notice?');">
                                            <button type="submit" class="action-btn delete" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="empty-state">
                                <i class="fas fa-bullhorn"></i>
                                <h3>No Notices Found</h3>
                                <p>Create your first notice to communicate with parents</p>
                                <a href="${pageContext.request.contextPath}/admin/notices/create" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                    <i class="fas fa-plus"></i> Create Notice
                                </a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<script>
    function closeMessage(button) {
        const message = button.closest('.success-message, .error-message');
        message.classList.add('fade-out');
        setTimeout(() => message.remove(), 300);
    }

    // Auto-hide messages after 5 seconds
    setTimeout(() => {
        document.querySelectorAll('.success-message, .error-message').forEach(msg => {
            msg.classList.add('fade-out');
            setTimeout(() => msg.remove(), 300);
        });
    }, 5000);

    // Touch feedback for mobile
    document.addEventListener('DOMContentLoaded', function() {
        const touchElements = document.querySelectorAll('.btn, .action-btn, .stat-card');
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