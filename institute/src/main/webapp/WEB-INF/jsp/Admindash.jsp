<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>SmartClass | Admin Dashboard</title>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

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
            --notice: #ff7e5f;
            --suggestion: #6f42c1;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background-color: var(--extra-light-purple);
            color: var(--text-dark);
            display: flex;
            min-height: 100vh;
            line-height: 1.5;
        }

        /* ================= SIDEBAR STYLES ================= */
        .sidebar {
            width: 280px;
            background: var(--white);
            color: var(--text-dark);
            padding: 25px 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: transform 0.3s ease;
            z-index: 100;
            box-shadow: var(--shadow);
            border-right: 2px solid var(--light-purple);
        }

        .logo-area {
            text-align: center;
            padding: 0 20px 30px;
            border-bottom: 2px solid var(--light-purple);
        }

        .logo-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
            border: 4px solid var(--soft-purple);
            padding: 3px;
            background: var(--white);
        }

        .logo-text {
            font-size: 28px;
            font-weight: 800;
            color: var(--dark-purple);
            letter-spacing: 0.5px;
        }

        .logo-subtext {
            font-size: 13px;
            color: var(--text-muted);
            letter-spacing: 2px;
            margin-top: 5px;
        }

        .nav-menu {
            padding: 20px 0;
        }

        .nav-item {
            padding: 14px 25px;
            display: flex;
            align-items: center;
            color: var(--text-light);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
            margin: 5px 0;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(155, 126, 176, 0.1);
            color: var(--royal-purple);
            border-left-color: var(--accent-gold);
        }

        .nav-item i {
            margin-right: 15px;
            width: 22px;
            text-align: center;
            font-size: 1.2rem;
            color: var(--soft-purple);
        }

        .nav-item:hover i, .nav-item.active i {
            color: var(--accent-gold);
        }

        .nav-text {
            font-size: 16px;
            font-weight: 500;
        }

        /* ================= MAIN CONTENT STYLES ================= */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 25px;
            transition: margin-left 0.3s ease;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--light-purple);
            background: var(--white);
            border-radius: var(--radius);
            padding: 20px 25px;
            box-shadow: var(--shadow-sm);
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark-purple);
        }

        .admin-badge {
            background: rgba(155, 126, 176, 0.1);
            padding: 6px 15px;
            border-radius: 30px;
            font-size: 14px;
            color: var(--royal-purple);
            font-weight: 500;
            margin-left: 15px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 600;
            font-size: 20px;
            border: 2px solid var(--accent-gold);
        }

        .user-details {
            text-align: right;
        }

        .user-name {
            font-weight: 600;
            color: var(--dark-purple);
            font-size: 16px;
        }

        .user-role {
            font-size: 13px;
            color: var(--text-muted);
        }

        /* ================= STATS CARDS ================= */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            transition: var(--transition);
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(to right, var(--soft-purple), var(--accent-gold));
            opacity: 0;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
            border-color: var(--light-purple);
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-icon {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-right: 20px;
            color: var(--white);
            transition: var(--transition);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-icon.teachers {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
        }

        .stat-icon.courses {
            background: linear-gradient(135deg, var(--soft-purple), var(--light-purple));
        }

        .stat-icon.students {
            background: linear-gradient(135deg, #45b7d1, #2a8fb3);
        }

        .stat-icon.parents {
            background: linear-gradient(135deg, #96ceb4, #6baa83);
        }

        .stat-info h3 {
            font-size: 32px;
            font-weight: 800;
            color: var(--dark-purple);
            margin-bottom: 5px;
        }

        .stat-info p {
            font-size: 14px;
            color: var(--text-muted);
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        /* ================= ACTION CARDS ================= */
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .action-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 30px;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: var(--transition);
            border: 2px solid transparent;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            position: relative;
            overflow: hidden;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at top right, rgba(230, 184, 0, 0.05), transparent);
            opacity: 0;
            transition: var(--transition);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
            border-color: var(--soft-purple);
        }

        .action-card:hover::before {
            opacity: 1;
        }

        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: var(--white);
            transition: var(--transition);
        }

        .action-card:hover .action-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .action-card.notice .action-icon {
            background: linear-gradient(135deg, #ff7e5f, #ff9f4b);
        }

        .action-card.suggestion .action-icon {
            background: linear-gradient(135deg, #6f42c1, #b380ff);
        }

        .action-content {
            flex: 1;
        }

        .action-content h3 {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .action-card.notice .action-content h3 {
            color: #ff7e5f;
        }

        .action-card.suggestion .action-content h3 {
            color: #6f42c1;
        }

        .action-content p {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .action-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background: rgba(90, 61, 110, 0.1);
            color: var(--royal-purple);
        }

        /* ================= TABLE STYLES ================= */
        .content-cards {
            display: grid;
            grid-template-columns: 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .content-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: var(--shadow-sm);
            border: 2px solid transparent;
            transition: var(--transition);
        }

        .content-card:hover {
            border-color: var(--light-purple);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--dark-purple);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-title i {
            font-size: 24px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            font-size: 14px;
            border: 2px solid transparent;
        }

        .btn-primary {
            background: var(--royal-purple);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--medium-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(90, 61, 110, 0.3);
        }

        .btn-notice {
            background: linear-gradient(135deg, #ff7e5f, #ff9f4b);
            color: var(--white);
        }

        .btn-notice:hover {
            background: linear-gradient(135deg, #ff6b4b, #ff8f3b);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 126, 95, 0.3);
        }

        .btn-suggestion {
            background: linear-gradient(135deg, #6f42c1, #b380ff);
            color: var(--white);
        }

        .btn-suggestion:hover {
            background: linear-gradient(135deg, #5e3ab0, #a370ff);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(111, 66, 193, 0.3);
        }

        .table-container {
            overflow-x: auto;
            border-radius: var(--radius-sm);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: rgba(155, 126, 176, 0.1);
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--dark-purple);
            font-size: 14px;
            border-bottom: 2px solid var(--light-purple);
        }

        td {
            padding: 15px;
            border-bottom: 1px solid var(--light-purple);
            color: var(--text-light);
            font-size: 14px;
        }

        tr:hover {
            background: rgba(155, 126, 176, 0.05);
        }

        .status {
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status.success {
            background: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .status.warning {
            background: rgba(255, 152, 0, 0.1);
            color: var(--warning);
        }

        .status.danger {
            background: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .status.info {
            background: rgba(33, 150, 243, 0.1);
            color: var(--info);
        }

        .status.primary {
            background: rgba(90, 61, 110, 0.1);
            color: var(--royal-purple);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            font-size: 14px;
        }

        .view-btn {
            background: rgba(33, 150, 243, 0.1);
            color: var(--info);
        }

        .view-btn:hover {
            background: var(--info);
            color: var(--white);
            transform: translateY(-2px);
        }

        .edit-btn {
            background: rgba(255, 152, 0, 0.1);
            color: var(--warning);
        }

        .edit-btn:hover {
            background: var(--warning);
            color: var(--white);
            transform: translateY(-2px);
        }

        .delete-btn {
            background: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .delete-btn:hover {
            background: var(--danger);
            color: var(--white);
            transform: translateY(-2px);
        }

        /* ================= MOBILE MENU ================= */
        .mobile-menu-toggle {
            display: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--dark-purple);
            width: 40px;
            height: 40px;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            background: rgba(155, 126, 176, 0.1);
        }

        /* ================= RESPONSIVE STYLES ================= */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                width: 260px;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .mobile-menu-toggle {
                display: flex;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .header {
                padding: 15px 20px;
            }
            
            .page-title {
                font-size: 24px;
            }
        }

        @media (max-width: 768px) {
            .stats-container {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .action-cards {
                grid-template-columns: 1fr;
            }
            
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .user-info {
                align-self: flex-end;
            }
            
            .card-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-icon {
                width: 50px;
                height: 50px;
                font-size: 22px;
                margin-right: 15px;
            }
            
            .stat-info h3 {
                font-size: 24px;
            }
        }

        @media (max-width: 576px) {
            .main-content {
                padding: 15px;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .user-info {
                flex-direction: row-reverse;
                align-self: flex-start;
                width: 100%;
                justify-content: flex-end;
            }
            
            .user-details {
                text-align: left;
            }
            
            .content-card {
                padding: 20px;
            }
            
            table {
                font-size: 13px;
            }
            
            th, td {
                padding: 12px 8px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }

        /* ================= TOUCH OPTIMIZATIONS ================= */
        @media (hover: none) and (pointer: coarse) {
            .nav-item:active,
            .stat-card:active,
            .action-card:active,
            .btn:active,
            .action-btn:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/logo2.jpeg" alt="SmartClass Logo" class="logo-img">
            <div class="logo-text">SmartClass</div>
            <div class="logo-subtext">ADMIN PANEL</div>
        </div>
        
        <div class="nav-menu">
            <a href="#" class="nav-item active">
                <i class="fas fa-tachometer-alt"></i>
                <span class="nav-text">Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/teacher-store" class="nav-item">
                <i class="fas fa-chalkboard-teacher"></i>
                <span class="nav-text">Teachers</span>
            </a>
            <a href="${pageContext.request.contextPath}/parent/store" class="nav-item">
                <i class="fas fa-users"></i>
                <span class="nav-text">Parents</span>
            </a>
            <a href="${pageContext.request.contextPath}/student/dashboard" class="nav-item">
                <i class="fas fa-user-graduate"></i>
                <span class="nav-text">Students</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/notices" class="nav-item">
                <i class="fas fa-bullhorn"></i>
                <span class="nav-text">Notices</span>
            </a>
            <a href="${pageContext.request.contextPath}/suggestions/admin/list" class="nav-item">
                <i class="fas fa-comment"></i>
                <span class="nav-text">Suggestions</span>
            </a>
            <a href="${pageContext.request.contextPath}/adminlogin" class="nav-item">
                <i class="fas fa-sign-out-alt"></i>
                <span class="nav-text">Logout</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header">
            <div style="display: flex; align-items: center; gap: 15px;">
                <div class="mobile-menu-toggle" id="menuToggle">
                    <i class="fas fa-bars"></i>
                </div>
                <div>
                    <h1 class="page-title">Admin Dashboard</h1>
                    <span class="admin-badge"><i class="fas fa-shield-alt"></i> Administrator Access</span>
                </div>
            </div>
            <div class="user-info">
                <div class="user-details">
                    <div class="user-name">AMPRAD</div>
                    <div class="user-role">Super Admin</div>
                </div>
                <div class="user-avatar">MS</div>
            </div>
        </div>

        

        <!-- Action Cards for Notice and Suggestion -->
        <div class="action-cards">
            <a href="${pageContext.request.contextPath}/admin/notices" class="action-card notice">
                <div class="action-icon">
                    <i class="fas fa-bullhorn"></i>
                </div>
                <div class="action-content">
                    <h3>Notice Board</h3>
                    <p>Create and manage announcements for parents and students. Send targeted notices to specific courses or individuals.</p>
                    <span class="action-badge"><i class="fas fa-circle" style="font-size: 8px; color: #ff7e5f; margin-right: 5px;"></i></span>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/suggestions/admin/list" class="action-card suggestion">
                <div class="action-icon">
                    <i class="fas fa-comment"></i>
                </div>
                <div class="action-content">
                    <h3>Parent Suggestions</h3>
                    <p>Review and respond to feedback from parents. Track suggestions and communicate responses effectively.</p>
                    <span class="action-badge"><i class="fas fa-circle" style="font-size: 8px; color: #6f42c1; margin-right: 5px;"></i></span>
                </div>
            </a>
        </div>

       
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile menu toggle
            const menuToggle = document.getElementById('menuToggle');
            const sidebar = document.getElementById('sidebar');
            
            if (menuToggle) {
                menuToggle.addEventListener('click', function(e) {
                    e.stopPropagation();
                    sidebar.classList.toggle('active');
                });
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                if (window.innerWidth <= 992) {
                    if (!sidebar.contains(event.target) && !menuToggle.contains(event.target)) {
                        sidebar.classList.remove('active');
                    }
                }
            });

            // View button functionality
            document.querySelectorAll('.view-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const id = row.cells[0].textContent.trim();
                    alert(`Viewing details for "${id}"`);
                });
            });

            // Edit button functionality
            document.querySelectorAll('.edit-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const id = row.cells[0].textContent.trim();
                    alert(`Edit functionality for "${id}" would open a form.`);
                });
            });

            // Delete button functionality
            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const id = row.cells[0].textContent.trim();
                    const title = row.cells[1].textContent.trim();
                    
                    if (confirm(`Are you sure you want to delete "${title}" (${id})?`)) {
                        row.style.transition = 'opacity 0.3s';
                        row.style.opacity = '0';
                        setTimeout(() => {
                            row.remove();
                        }, 300);
                    }
                });
            });

            // Touch feedback for mobile
            const touchElements = document.querySelectorAll('.stat-card, .action-card, .btn, .action-btn');
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