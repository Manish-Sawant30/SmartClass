<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Parent Suggestions | SmartClass</title>
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
            --pending: #ff9800;
            --read: #2196f3;
            --responded: #4caf50;
            --closed: #6c757d;
            --total: var(--royal-purple);
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
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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
            gap: 15px;
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
            width: 50px;
            height: 50px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: var(--white);
            transition: var(--transition);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-icon.pending { background: linear-gradient(135deg, #ff9800, #f57c00); }
        .stat-icon.read { background: linear-gradient(135deg, #2196f3, #1976d2); }
        .stat-icon.responded { background: linear-gradient(135deg, #4caf50, #45a049); }
        .stat-icon.closed { background: linear-gradient(135deg, #6c757d, #5a6268); }
        .stat-icon.total { background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple)); }

        .stat-info h3 {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 500;
        }

        .filter-bar {
            background: var(--white);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            box-shadow: var(--shadow-sm);
            border: 2px solid var(--light-purple);
        }

        .filter-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 2px solid transparent;
        }

        .filter-btn.all {
            background: var(--royal-purple);
            color: var(--white);
        }

        .filter-btn.pending {
            background: var(--pending);
            color: var(--white);
        }

        .filter-btn.read {
            background: var(--read);
            color: var(--white);
        }

        .filter-btn.responded {
            background: var(--responded);
            color: var(--white);
        }

        .filter-btn.closed {
            background: var(--closed);
            color: var(--white);
        }

        .filter-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            filter: brightness(1.1);
        }

        .filter-btn.active {
            border-color: var(--accent-gold);
            box-shadow: 0 0 0 2px var(--accent-gold);
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
            padding: 15px;
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

        .status-badge {
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-pending {
            background: rgba(255, 152, 0, 0.1);
            color: var(--pending);
        }

        .status-read {
            background: rgba(33, 150, 243, 0.1);
            color: var(--read);
        }

        .status-responded {
            background: rgba(76, 175, 80, 0.1);
            color: var(--responded);
        }

        .status-closed {
            background: rgba(108, 117, 125, 0.1);
            color: var(--closed);
        }

        .parent-info {
            font-weight: 600;
            color: var(--text-dark);
        }

        .parent-email {
            font-size: 12px;
            color: var(--text-muted);
        }

        .student-id {
            display: inline-block;
            background: var(--extra-light-purple);
            color: var(--royal-purple);
            padding: 4px 8px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 500;
            border: 1px solid var(--light-purple);
        }

        .student-name {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 3px;
        }

        .suggestion-preview {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: var(--text-light);
            font-size: 13px;
        }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 8px 14px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 2px solid transparent;
        }

        .action-btn.view {
            background: var(--read);
            color: var(--white);
        }

        .action-btn.view:hover {
            background: transparent;
            border-color: var(--read);
            color: var(--read);
            transform: translateY(-2px);
        }

        .action-btn.respond {
            background: var(--responded);
            color: var(--white);
        }

        .action-btn.respond:hover {
            background: transparent;
            border-color: var(--responded);
            color: var(--responded);
            transform: translateY(-2px);
        }

        .action-btn.delete {
            background: #f44336;
            color: var(--white);
        }

        .action-btn.delete:hover {
            background: transparent;
            border-color: #f44336;
            color: #f44336;
            transform: translateY(-2px);
        }

        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--responded);
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
            background: #f44336;
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
            
            .stats-cards {
                grid-template-columns: 1fr;
            }
            
            .filter-bar {
                justify-content: center;
            }
            
            .filter-btn {
                flex: 1;
                justify-content: center;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
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
                width: 45px;
                height: 45px;
                font-size: 18px;
            }
            
            .stat-info h3 {
                font-size: 20px;
            }
            
            .filter-btn {
                width: 100%;
                justify-content: center;
            }
            
            td, th {
                padding: 12px 10px;
                font-size: 13px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .filter-btn:active,
            .action-btn:active,
            .stat-card:active {
                transform: scale(0.98);
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
        <button onclick="this.parentElement.remove()" style="background: none; border: none; color: white; margin-left: auto; cursor: pointer; font-size: 1.2rem;">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="success-message error-message" id="errorMessage">
        <i class="fas fa-exclamation-circle"></i>
        <span>${errorMessage}</span>
        <button onclick="this.parentElement.remove()" style="background: none; border: none; color: white; margin-left: auto; cursor: pointer; font-size: 1.2rem;">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>

<div class="header">
    <div class="logo">
        <h1><i class="fas fa-comments"></i> Parent Suggestions</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admindash"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/notices"><i class="fas fa-bullhorn"></i> Notices</a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/list" class="active"><i class="fas fa-comment"></i> Suggestions</a>
    </div>
</div>

<div class="container">
    <!-- Stats Cards -->
    <div class="stats-cards">
        <div class="stat-card">
            <div class="stat-icon pending">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.pendingCount}</h3>
                <p>Pending</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon read">
                <i class="fas fa-eye"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.readCount}</h3>
                <p>Read</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon responded">
                <i class="fas fa-reply"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.respondedCount}</h3>
                <p>Responded</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon closed">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.closedCount}</h3>
                <p>Closed</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon total">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.totalSuggestions}</h3>
                <p>Total</p>
            </div>
        </div>
    </div>

    <!-- Filter Bar -->
    <div class="filter-bar">
        <a href="${pageContext.request.contextPath}/suggestions/admin/list" class="filter-btn all ${empty currentFilter ? 'active' : ''}">
            <i class="fas fa-list"></i> All
        </a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/filter/PENDING" class="filter-btn pending ${currentFilter == 'PENDING' ? 'active' : ''}">
            <i class="fas fa-clock"></i> Pending
        </a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/filter/READ" class="filter-btn read ${currentFilter == 'READ' ? 'active' : ''}">
            <i class="fas fa-eye"></i> Read
        </a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/filter/RESPONDED" class="filter-btn responded ${currentFilter == 'RESPONDED' ? 'active' : ''}">
            <i class="fas fa-reply"></i> Responded
        </a>
        <a href="${pageContext.request.contextPath}/suggestions/admin/filter/CLOSED" class="filter-btn closed ${currentFilter == 'CLOSED' ? 'active' : ''}">
            <i class="fas fa-check-circle"></i> Closed
        </a>
    </div>

    <!-- Suggestions Table -->
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Parent</th>
                    <th>Student</th>
                    <th>Subject</th>
                    <th>Message</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty suggestions}">
                        <c:forEach var="suggestion" items="${suggestions}">
                            <tr>
                                <td><strong>${suggestion.suggestionId}</strong></td>
                                <td>
                                    <div class="parent-info">${suggestion.parentName}</div>
                                    <div class="parent-email">${suggestion.parentEmail}</div>
                                </td>
                                <td>
                                    <span class="student-id">${suggestion.studentId}</span>
                                    <div class="student-name">${suggestion.studentName}</div>
                                </td>
                                <td>${suggestion.subject}</td>
                                <td>
                                    <div class="suggestion-preview">${suggestion.message}</div>
                                </td>
                                <td>
                                    <span class="status-badge status-${fn:toLowerCase(suggestion.status)}">
                                        ${suggestion.status.displayName}
                                    </span>
                                </td>
                                <td>${fn:substring(suggestion.createdAt, 0, 16)}</td>
                                <td>
                                    <div class="actions">
                                        <a href="${pageContext.request.contextPath}/suggestions/admin/view/${suggestion.id}" class="action-btn view">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <c:if test="${suggestion.status == 'PENDING' || suggestion.status == 'READ'}">
                                            <a href="${pageContext.request.contextPath}/suggestions/admin/view/${suggestion.id}#respond" class="action-btn respond">
                                                <i class="fas fa-reply"></i> Respond
                                            </a>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/suggestions/admin/delete/${suggestion.id}" method="post" style="display: inline;"
                                              onsubmit="return confirm('Are you sure you want to delete this suggestion?');">
                                            <button type="submit" class="action-btn delete">
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
                                <i class="fas fa-comment-slash"></i>
                                <h3>No Suggestions Found</h3>
                                <p>There are no suggestions to display</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
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
        const touchElements = document.querySelectorAll('.filter-btn, .action-btn, .stat-card');
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