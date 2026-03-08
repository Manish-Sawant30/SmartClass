<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Teacher Management | SmartClass</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- SheetJS for Excel export -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <!-- jsPDF for PDF export -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <!-- jspdf-autotable for PDF tables -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.29/jspdf.plugin.autotable.min.js"></script>
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
            --pending: #ff9800;
            --rejected: #f44336;
            --inactive: #6c757d;
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
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        /* Header */
        .header {
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

        .header h1 {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .logo-area {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--accent-gold);
            background: var(--white);
            padding: 2px;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 25px 30px;
        }

        .stat-card {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 20px;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            gap: 15px;
            border-left: 4px solid var(--royal-purple);
            transition: var(--transition);
            border: 2px solid transparent;
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
            font-size: 1.5rem;
            color: var(--white);
            transition: var(--transition);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-icon.total { background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple)); }
        .stat-icon.active { background: linear-gradient(135deg, #4caf50, #45a049); }
        .stat-icon.pending { background: linear-gradient(135deg, #ff9800, #f57c00); }
        .stat-icon.rejected { background: linear-gradient(135deg, #f44336, #d32f2f); }
        .stat-icon.inactive { background: linear-gradient(135deg, #6c757d, #5a6268); }

        .stat-info h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: var(--text-dark);
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            position: relative;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 50px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
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
            box-shadow: 0 5px 15px rgba(230, 184, 0, 0.3);
        }

        .btn-secondary {
            background: var(--royal-purple);
            color: var(--white);
        }

        .btn-secondary:hover {
            background: var(--medium-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(90, 61, 110, 0.3);
        }

        /* Export Dropdown */
        .export-dropdown {
            position: relative;
            display: inline-block;
        }

        .export-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--white);
            border-radius: var(--radius-sm);
            box-shadow: var(--shadow);
            min-width: 180px;
            z-index: 1000;
            margin-top: 5px;
            display: none;
            overflow: hidden;
            border: 2px solid var(--light-purple);
        }

        .export-menu.show {
            display: block;
        }

        .export-option {
            padding: 12px 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            color: var(--text-dark);
            border-bottom: 1px solid var(--light-purple);
        }

        .export-option:last-child {
            border-bottom: none;
        }

        .export-option:hover {
            background: var(--extra-light-purple);
            transform: translateX(5px);
        }

        .export-option i {
            width: 20px;
            font-size: 1.1rem;
        }

        .export-option.pdf i { color: #f44336; }
        .export-option.excel i { color: #4caf50; }
        .export-option.csv i { color: #ff9800; }

        /* Main Content */
        .content {
            padding: 0 30px 30px;
        }

        /* Search and Filter */
        .search-filter {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-form {
            flex: 1;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 250px;
        }

        .search-box input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 2px solid var(--light-purple);
            border-radius: 50px;
            font-size: 16px;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--soft-purple);
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        .search-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--soft-purple);
            font-size: 16px;
        }

        /* Table Container */
        .table-container {
            overflow-x: auto;
            border-radius: var(--radius-sm);
            border: 2px solid var(--light-purple);
            box-shadow: var(--shadow-sm);
            background: var(--white);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        thead {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
        }

        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            color: var(--white);
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        td {
            padding: 16px 15px;
            border-bottom: 1px solid var(--light-purple);
            color: var(--text-light);
            font-size: 14px;
        }

        tr:last-child td {
            border-bottom: none;
        }

		tbody tr:hover {
		    background-color: var(--extra-light-purple);
		}
        .status {
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status.active {
            background: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .status.inactive {
            background: rgba(108, 117, 125, 0.1);
            color: var(--inactive);
        }

        .status.pending {
            background: rgba(255, 152, 0, 0.1);
            color: var(--pending);
        }

        .status.rejected {
            background: rgba(244, 67, 54, 0.1);
            color: var(--rejected);
        }

        /* Specialization badges */
        .specialization-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
        }

        .spec-badge {
            background: var(--extra-light-purple);
            color: var(--text-light);
            padding: 4px 8px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 500;
            display: inline-block;
            white-space: nowrap;
            border: 1px solid var(--light-purple);
        }

        .spec-count {
            background: var(--soft-purple);
            color: var(--white);
            padding: 4px 8px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 500;
            cursor: help;
        }

        .action-btns {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn-icon {
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
            font-size: 14px;
            border: 2px solid transparent;
        }

        .btn-icon.edit {
            background: var(--warning);
        }

        .btn-icon.edit:hover {
            background: transparent;
            border-color: var(--warning);
            color: var(--warning);
            transform: translateY(-2px);
        }

        .btn-icon.delete {
            background: var(--danger);
        }

        .btn-icon.delete:hover {
            background: transparent;
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
        }

        .btn-icon.approve {
            background: var(--success);
        }

        .btn-icon.approve:hover {
            background: transparent;
            border-color: var(--success);
            color: var(--success);
            transform: translateY(-2px);
        }

        .btn-icon.reject {
            background: var(--danger);
        }

        .btn-icon.reject:hover {
            background: transparent;
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
        }

        /* Edit Dialog */
        #editTeacherOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(45, 27, 60, 0.5);
            backdrop-filter: blur(3px);
            z-index: 1999;
        }

        #editTeacherDialog {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            z-index: 2000;
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            border: 2px solid var(--light-purple);
            padding: 25px;
        }

        #editTeacherDialog h3 {
            color: var(--dark-purple);
            font-size: 22px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--light-purple);
        }

        #editTeacherDialog label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: var(--text-dark);
        }

        #editTeacherDialog input,
        #editTeacherDialog select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            font-size: 15px;
            transition: var(--transition);
            margin-bottom: 15px;
            background: var(--white);
            color: var(--text-dark);
        }

        #editTeacherDialog input:focus,
        #editTeacherDialog select:focus {
            outline: none;
            border-color: var(--soft-purple);
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        #editTeacherDialog input[readonly] {
            background: var(--extra-light-purple);
            color: var(--text-muted);
        }

        .dialog-buttons {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-top: 25px;
        }

        .dialog-buttons button {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            font-size: 15px;
            border: 2px solid transparent;
        }

        .dialog-buttons .cancel-btn {
            background: var(--inactive);
            color: var(--white);
        }

        .dialog-buttons .cancel-btn:hover {
            background: transparent;
            border-color: var(--inactive);
            color: var(--inactive);
        }

        .dialog-buttons .save-btn {
            background: var(--success);
            color: var(--white);
        }

        .dialog-buttons .save-btn:hover {
            background: transparent;
            border-color: var(--success);
            color: var(--success);
        }

        /* Toast Notification */
        .toast-container {
            position: fixed;
            bottom: 25px;
            right: 25px;
            z-index: 1000;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .toast {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 16px 20px;
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            gap: 15px;
            min-width: 300px;
            max-width: 400px;
            transform: translateX(100%);
            opacity: 0;
            transition: transform 0.3s ease, opacity 0.3s ease;
            border-left: 4px solid var(--success);
            border: 2px solid var(--light-purple);
        }

        .toast.show {
            transform: translateX(0);
            opacity: 1;
        }

        .toast-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: var(--white);
            flex-shrink: 0;
        }

        .toast-icon.success { background: var(--success); }
        .toast-icon.error { background: var(--danger); }
        .toast-icon.info { background: var(--info); }
        .toast-icon.warning { background: var(--warning); }

        .toast-content {
            flex: 1;
        }

        .toast-content p {
            font-size: 0.95rem;
            color: var(--text-dark);
        }

        .toast-close {
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            font-size: 1.2rem;
            padding: 4px;
            transition: var(--transition);
        }

        .toast-close:hover {
            color: var(--danger);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 50px 20px;
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
                padding: 20px 25px;
            }
            
            .stats-container {
                margin: 20px;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .action-buttons {
                width: 100%;
                justify-content: flex-start;
            }
            
            .search-form {
                width: 100%;
                flex-direction: column;
            }
            
            .search-box {
                width: 100%;
            }
            
            .content {
                padding: 0 20px 20px;
            }
            
            .stats-container {
                margin: 15px;
                grid-template-columns: repeat(2, 1fr);
            }
            
            .stat-info h3 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 576px) {
            .header {
                padding: 15px 20px;
            }
            
            .header h1 {
                font-size: 24px;
            }
            
            .btn {
                padding: 10px 20px;
                font-size: 14px;
                width: 100%;
                justify-content: center;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .export-dropdown {
                width: 100%;
            }
            
            .export-menu {
                width: 100%;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .stat-card {
                padding: 15px;
            }
            
            .stat-icon {
                width: 45px;
                height: 45px;
                font-size: 1.2rem;
            }
            
            .stat-info h3 {
                font-size: 1.4rem;
            }
            
            .toast {
                min-width: 250px;
                max-width: 300px;
                padding: 12px 15px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .btn-icon:active,
            .export-option:active {
                transform: scale(0.98);
            }
            
            .stat-card:active {
                transform: translateY(-2px);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="logo-area">
                <img src="${pageContext.request.contextPath}/images/logo2.jpeg" alt="SmartClass Logo" class="logo-img">
                <h1><i class="fas fa-chalkboard-teacher" style="margin-right: 10px;"></i>Teacher Management</h1>
            </div>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/teacher/signup" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Teacher
                </a>
                <div class="export-dropdown">
                    <button class="btn btn-secondary" onclick="toggleExportMenu()">
                        <i class="fas fa-download"></i> Export Data
                    </button>
                    <div class="export-menu" id="exportMenu">
                        <div class="export-option pdf" onclick="exportToPDF()">
                            <i class="fas fa-file-pdf"></i> Export as PDF
                        </div>
                        <div class="export-option excel" onclick="exportToExcel()">
                            <i class="fas fa-file-excel"></i> Export as Excel
                        </div>
                        <div class="export-option csv" onclick="exportToCSV()">
                            <i class="fas fa-file-csv"></i> Export as CSV
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon total"><i class="fas fa-users"></i></div>
                <div class="stat-info">
                    <h3>${totalTeachers}</h3>
                    <p>Total Teachers</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon active"><i class="fas fa-user-check"></i></div>
                <div class="stat-info">
                    <h3>${activeTeachers}</h3>
                    <p>Active Teachers</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon pending"><i class="fas fa-clock"></i></div>
                <div class="stat-info">
                    <h3>${pendingTeachers}</h3>
                    <p>Pending Approval</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon rejected"><i class="fas fa-times-circle"></i></div>
                <div class="stat-info">
                    <h3>${rejectedTeachers}</h3>
                    <p>Rejected</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon inactive"><i class="fas fa-user-slash"></i></div>
                <div class="stat-info">
                    <h3>${inactiveTeachers}</h3>
                    <p>Inactive</p>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Search and Filter -->
            <div class="search-filter">
                <form action="${pageContext.request.contextPath}/teacher/store" method="get" class="search-form">
                    <div class="search-box">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" name="keyword" id="searchInput" 
                               placeholder="Search teachers by name, email, or ID..."
                               value="${param.keyword}">
                    </div>
                    <button type="submit" class="btn btn-secondary" style="min-width: 100px;">
                        <i class="fas fa-search"></i> Search
                    </button>
                    <a href="${pageContext.request.contextPath}/teacher/store" class="btn" style="background: var(--inactive); color: white;">
                        <i class="fas fa-sync-alt"></i> Reset
                    </a>
                </form>
            </div>

            <!-- Teachers Table -->
            <div class="table-container">
                <table id="teachersTable">
                    <thead>
                        <tr>
                            <th>Teacher ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Specializations</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <c:choose>
                            <c:when test="${not empty teachers}">
                                <c:forEach var="teacher" items="${teachers}">
                                    <tr>
                                        <td><span style="font-weight: 600;">${teacher.teacherId}</span></td>
                                        <td>${teacher.fullName}</td>
                                        <td>${teacher.email}</td>
                                        <td>
                                            <div class="specialization-badges">
                                                <c:forEach var="spec" items="${teacher.specializations}" varStatus="status">
                                                    <c:if test="${status.index < 3}">
                                                        <span class="spec-badge">${spec}</span>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${teacher.specializations.size() > 3}">
                                                    <span class="spec-count" title="${teacher.specialization}">
                                                        +${teacher.specializations.size() - 3}
                                                    </span>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="status ${teacher.status.toLowerCase()}">${teacher.status}</span>
                                        </td>
                                        <td>
                                            <div class="action-btns">
                                                <c:if test="${teacher.status == 'PENDING'}">
                                                    <button class="btn-icon approve" onclick="approveTeacher(${teacher.id})" title="Approve">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                    <button class="btn-icon reject" onclick="rejectTeacher(${teacher.id})" title="Reject">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </c:if>
                                                <c:if test="${teacher.status != 'PENDING'}">
                                                    <button class="btn-icon edit" onclick="editTeacher(${teacher.id})" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn-icon delete" onclick="deleteTeacher(${teacher.id})" title="Delete">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="empty-state">
                                        <i class="fas fa-users-slash"></i>
                                        <h3>No Teachers Found</h3>
                                        <p>No teachers are currently registered in the system.</p>
                                        <a href="${pageContext.request.contextPath}/teacher/signup" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                            <i class="fas fa-plus"></i> Add First Teacher
                                        </a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer"></div>

    <script>
        // Get current date for filename
        function getCurrentDate() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            return year + '-' + month + '-' + day;
        }

        // Toggle export menu
        function toggleExportMenu() {
            const menu = document.getElementById('exportMenu');
            menu.classList.toggle('show');
            
            setTimeout(() => {
                document.addEventListener('click', function closeMenu(e) {
                    if (!e.target.closest('.export-dropdown')) {
                        menu.classList.remove('show');
                        document.removeEventListener('click', closeMenu);
                    }
                });
            }, 100);
        }

        // Get table data for export
        function getTableData() {
            const table = document.getElementById('teachersTable');
            const data = [];
            
            const headers = [];
            table.querySelectorAll('thead th').forEach((th, index) => {
                if (index < 5) {
                    headers.push(th.innerText);
                }
            });
            data.push(headers);
            
            table.querySelectorAll('tbody tr').forEach(tr => {
                if (tr.querySelector('.empty-state')) return;
                
                const row = [];
                tr.querySelectorAll('td').forEach((td, index) => {
                    if (index < 5) {
                        let text = td.innerText;
                        
                        if (index === 3) {
                            const specBadges = td.querySelectorAll('.spec-badge');
                            if (specBadges.length > 0) {
                                text = Array.from(specBadges).map(b => b.textContent).join(', ');
                            }
                        }
                        
                        if (index === 4) {
                            const statusSpan = td.querySelector('.status');
                            if (statusSpan) {
                                text = statusSpan.innerText;
                            }
                        }
                        
                        row.push(text.trim());
                    }
                });
                data.push(row);
            });
            
            return data;
        }

        // Export to PDF
        function exportToPDF() {
            try {
                const { jsPDF } = window.jspdf;
                const doc = new jsPDF();
                
                doc.setFontSize(18);
                doc.text('Teachers List - SmartClass', 14, 22);
                
                doc.setFontSize(11);
                doc.text('Export Date: ' + new Date().toLocaleDateString(), 14, 30);
                
                const tableData = getTableData();
                const headers = tableData[0];
                const rows = tableData.slice(1);
                
                doc.autoTable({
                    head: [headers],
                    body: rows,
                    startY: 35,
                    theme: 'grid',
                    styles: { fontSize: 8, cellPadding: 3 },
                    headStyles: { fillColor: [90, 61, 110], textColor: [255, 255, 255] }
                });
                
                const currentDate = getCurrentDate();
                doc.save('teachers_list_' + currentDate + '.pdf');
                
                document.getElementById('exportMenu').classList.remove('show');
                showToast('PDF exported successfully!', 'success');
            } catch (error) {
                console.error('PDF export error:', error);
                showToast('Error exporting PDF: ' + error.message, 'error');
            }
        }

        // Export to Excel
        function exportToExcel() {
            try {
                const tableData = getTableData();
                
                const ws = XLSX.utils.aoa_to_sheet(tableData);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, 'Teachers');
                
                const currentDate = getCurrentDate();
                XLSX.writeFile(wb, 'teachers_list_' + currentDate + '.xlsx');
                
                document.getElementById('exportMenu').classList.remove('show');
                showToast('Excel file exported successfully!', 'success');
            } catch (error) {
                console.error('Excel export error:', error);
                showToast('Error exporting Excel: ' + error.message, 'error');
            }
        }

        // Export to CSV
        function exportToCSV() {
            try {
                const tableData = getTableData();
                
                let csv = '';
                tableData.forEach(row => {
                    const escapedRow = row.map(cell => {
                        if (cell.includes(',') || cell.includes('"')) {
                            return '"' + cell.replace(/"/g, '""') + '"';
                        }
                        return cell;
                    });
                    csv += escapedRow.join(',') + '\n';
                });
                
                const currentDate = getCurrentDate();
                const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
                const link = document.createElement('a');
                const url = URL.createObjectURL(blob);
                link.setAttribute('href', url);
                link.setAttribute('download', 'teachers_list_' + currentDate + '.csv');
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                URL.revokeObjectURL(url);
                
                document.getElementById('exportMenu').classList.remove('show');
                showToast('CSV file exported successfully!', 'success');
            } catch (error) {
                console.error('CSV export error:', error);
                showToast('Error exporting CSV: ' + error.message, 'error');
            }
        }

        // ==================== Approval Functions ====================
        async function approveTeacher(id) {
            console.log('Approving teacher ID:', id);
            
            if (confirm('Are you sure you want to approve this teacher? The teacher will be able to login after approval.')) {
                try {
                    showToast('Approving teacher...', 'info');
                    
                    const response = await fetch('${pageContext.request.contextPath}/teacher/approve/' + id, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        }
                    });
                    
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    
                    const result = await response.json();
                    console.log('Approve response:', result);
                    
                    if (result.success) {
                        showToast('Teacher approved successfully!', 'success');
                        setTimeout(() => { location.reload(); }, 1500);
                    } else {
                        showToast('Error: ' + result.message, 'error');
                    }
                } catch (error) {
                    console.error('Approve error:', error);
                    showToast('Error approving teacher: ' + error.message, 'error');
                }
            }
        }

        // ==================== Reject Function ====================
        async function rejectTeacher(id) {
            console.log('Rejecting teacher ID:', id);
            
            if (confirm('Are you sure you want to reject this teacher? The teacher will not be able to login.')) {
                try {
                    showToast('Rejecting teacher...', 'info');
                    
                    const response = await fetch('${pageContext.request.contextPath}/teacher/reject/' + id, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        }
                    });
                    
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    
                    const result = await response.json();
                    console.log('Reject response:', result);
                    
                    if (result.success) {
                        showToast('Teacher rejected successfully!', 'success');
                        setTimeout(() => { location.reload(); }, 1500);
                    } else {
                        showToast('Error: ' + result.message, 'error');
                    }
                } catch (error) {
                    console.error('Reject error:', error);
                    showToast('Error rejecting teacher: ' + error.message, 'error');
                }
            }
        }

		// ==================== FIXED DELETE TEACHER FUNCTION ====================
		async function deleteTeacher(id) {
		    console.log('Delete teacher ID:', id);
		    
		    if (confirm('⚠️ Are you sure you want to delete this teacher?\n\nThis will also delete:\n• All content uploaded by this teacher\n• All MCQ questions created by this teacher\n• All student test attempts for this teacher\'s content\n\nThis action CANNOT be undone!')) {
		        try {
		            showToast('Deleting teacher and all associated data...', 'info');
		            
		            // Get the button that was clicked
		            const button = event?.target?.closest('button');
		            if (button) {
		                button.disabled = true;
		                button.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
		            }
		            
		            const response = await fetch('${pageContext.request.contextPath}/teacher/delete/' + id, {
		                method: 'POST',
		                headers: {
		                    'Content-Type': 'application/json',
		                    'Accept': 'application/json'
		                }
		            });
		            
		            console.log('Delete response status:', response.status);
		            
		            let result;
		            const contentType = response.headers.get('content-type');
		            
		            if (contentType && contentType.includes('application/json')) {
		                result = await response.json();
		            } else {
		                const text = await response.text();
		                console.log('Response text:', text);
		                
		                if (response.ok) {
		                    result = { success: true, message: 'Teacher deleted successfully' };
		                } else {
		                    throw new Error(text || 'Delete failed');
		                }
		            }
		            
		            console.log('Delete result:', result);
		            
		            if (result.success) {
		                showToast('✅ ' + (result.message || 'Teacher deleted successfully!'), 'success');
		                
		                // Find the row containing the teacher
		                const row = document.querySelector(`button[onclick*="deleteTeacher(${id})"]`)?.closest('tr');
		                
		                if (row) {
		                    row.style.transition = 'all 0.3s ease';
		                    row.style.opacity = '0';
		                    row.style.transform = 'translateX(20px)';
		                    
		                    setTimeout(() => {
		                        if (row && row.parentNode) {
		                            row.remove();
		                            
		                            // Check if table is empty and show empty state
		                            const tbody = document.getElementById('tableBody');
		                            if (tbody && tbody.children.length === 0) {
		                                tbody.innerHTML = `
		                                    <tr>
		                                        <td colspan="6" class="empty-state">
		                                            <i class="fas fa-users-slash"></i>
		                                            <h3>No Teachers Found</h3>
		                                            <p>No teachers are currently registered in the system.</p>
		                                            <a href="${pageContext.request.contextPath}/teacher/signup" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
		                                                <i class="fas fa-plus"></i> Add First Teacher
		                                            </a>
		                                        </td>
		                                    </tr>
		                                `;
		                            }
		                            
		                            // Update stats after deletion
		                            updateStatsAfterDelete();
		                        }
		                    }, 300);
		                } else {
		                    // If we can't find the row, just reload the page
		                    setTimeout(() => {
		                        window.location.reload();
		                    }, 1500);
		                }
		            } else {
		                showToast('❌ Error: ' + (result.message || 'Delete failed'), 'error');
		                if (button) {
		                    button.disabled = false;
		                    button.innerHTML = '<i class="fas fa-trash"></i>';
		                }
		            }
		        } catch (error) {
		            console.error('Delete error:', error);
		            showToast('❌ Error deleting teacher: ' + error.message, 'error');
		            
		            const button = event?.target?.closest('button');
		            if (button) {
		                button.disabled = false;
		                button.innerHTML = '<i class="fas fa-trash"></i>';
		            }
		        }
		    }
		}

		// Helper function to update stats after deletion
		function updateStatsAfterDelete() {
		    const totalStat = document.querySelector('.stat-card .stat-info h3');
		    if (totalStat) {
		        const currentTotal = parseInt(totalStat.textContent) || 0;
		        totalStat.textContent = Math.max(0, currentTotal - 1);
		    }
		}
        // ==================== Edit Teacher ====================
        async function editTeacher(id) {
            console.log('Edit teacher ID:', id);
            
            const teacherRow = document.querySelector('button[onclick*="editTeacher(' + id + ')"]').closest('tr');
            if (!teacherRow) {
                showToast('Could not find teacher row', 'error');
                return;
            }
            
            const teacherId = teacherRow.cells[0].textContent;
            const teacherName = teacherRow.cells[1].textContent;
            const teacherEmail = teacherRow.cells[2].textContent;
            const statusSpan = teacherRow.cells[4].querySelector('.status');
            const currentStatus = statusSpan ? statusSpan.textContent : 'ACTIVE';
            
            let editForm = '<h3><i class="fas fa-edit" style="margin-right: 10px; color: var(--accent-gold);"></i>Edit Teacher: ' + teacherName + '</h3>';
            
            editForm += '<div style="margin-bottom: 5px;">';
            editForm += '<label>Teacher ID:</label>';
            editForm += '<input type="text" value="' + teacherId + '" readonly>';
            editForm += '</div>';
            
            editForm += '<div>';
            editForm += '<label>Full Name:</label>';
            editForm += '<input type="text" id="editFullName" value="' + teacherName + '">';
            editForm += '</div>';
            
            editForm += '<div>';
            editForm += '<label>Email:</label>';
            editForm += '<input type="email" id="editEmail" value="' + teacherEmail + '">';
            editForm += '</div>';
            
            editForm += '<div>';
            editForm += '<label>Change Status:</label>';
            editForm += '<select id="editStatus">';
            
            const statuses = ['ACTIVE', 'INACTIVE', 'PENDING', 'REJECTED'];
            
            statuses.forEach(function(status) {
                editForm += '<option value="' + status + '"';
                if (currentStatus === status) {
                    editForm += ' selected';
                }
                editForm += '>' + status + '</option>';
            });
            
            editForm += '</select>';
            editForm += '</div>';
            
            editForm += '<div class="dialog-buttons">';
            editForm += '<button class="cancel-btn" onclick="closeEditDialog()"><i class="fas fa-times"></i> Cancel</button>';
            editForm += '<button class="save-btn" onclick="saveTeacherChanges(' + id + ')"><i class="fas fa-save"></i> Save Changes</button>';
            editForm += '</div>';
            
            showEditDialog(editForm);
        }

        function showEditDialog(content) {
            const existingDialog = document.getElementById('editTeacherDialog');
            if (existingDialog) existingDialog.remove();
            
            const existingOverlay = document.getElementById('editTeacherOverlay');
            if (existingOverlay) existingOverlay.remove();
            
            const overlay = document.createElement('div');
            overlay.id = 'editTeacherOverlay';
            
            const dialog = document.createElement('div');
            dialog.id = 'editTeacherDialog';
            dialog.innerHTML = content;
            
            document.body.appendChild(overlay);
            document.body.appendChild(dialog);
            
            overlay.onclick = closeEditDialog;
        }

        function closeEditDialog() {
            const dialog = document.getElementById('editTeacherDialog');
            const overlay = document.getElementById('editTeacherOverlay');
            if (dialog) dialog.remove();
            if (overlay) overlay.remove();
        }

        async function saveTeacherChanges(id) {
            const fullName = document.getElementById('editFullName').value.trim();
            const email = document.getElementById('editEmail').value.trim();
            const status = document.getElementById('editStatus').value;
            
            if (!fullName) {
                showToast('Full name is required', 'error');
                return;
            }
            
            if (!email) {
                showToast('Email is required', 'error');
                return;
            }
            
            try {
                showToast('Updating teacher...', 'info');
                
                const formData = new URLSearchParams();
                formData.append('fullName', fullName);
                formData.append('email', email);
                formData.append('status', status);
                
                const response = await fetch('${pageContext.request.contextPath}/teacher/updateStatus/' + id, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData
                });
                
                if (!response.ok) {
                    throw new Error('Network response was not ok: ' + response.status);
                }
                
                const result = await response.json();
                
                if (result.success) {
                    showToast('Teacher updated successfully!', 'success');
                    closeEditDialog();
                    setTimeout(() => { location.reload(); }, 1500);
                } else {
                    showToast('Error: ' + result.message, 'error');
                }
            } catch (error) {
                console.error('Save error:', error);
                showToast('Error saving changes: ' + error.message, 'error');
            }
        }

        // ==================== Toast Notification ====================
        function showToast(message, type) {
            if (!type) type = 'info';
            
            try {
                const toastContainer = document.getElementById('toastContainer');
                const toastId = 'toast-' + Date.now();
                const icons = {
                    'success': 'fas fa-check-circle',
                    'error': 'fas fa-exclamation-circle',
                    'warning': 'fas fa-exclamation-triangle',
                    'info': 'fas fa-info-circle'
                };
                
                const toast = document.createElement('div');
                toast.className = 'toast';
                toast.id = toastId;
                toast.innerHTML = '<div class="toast-icon ' + type + '"><i class="' + icons[type] + '"></i></div>' +
                                '<div class="toast-content"><p>' + message + '</p></div>' +
                                '<button class="toast-close" onclick="removeToast(\'' + toastId + '\')"><i class="fas fa-times"></i></button>';
                
                toastContainer.appendChild(toast);
                setTimeout(function() { toast.classList.add('show'); }, 10);
                setTimeout(function() { removeToast(toastId); }, 5000);
            } catch (error) {
                console.error('Toast error:', error);
                alert(message);
            }
        }

        function removeToast(id) {
            try {
                const toast = document.getElementById(id);
                if (toast) {
                    toast.classList.remove('show');
                    setTimeout(function() {
                        if (toast.parentNode) {
                            toast.parentNode.removeChild(toast);
                        }
                    }, 300);
                }
            } catch (error) {
                console.error('Remove toast error:', error);
            }
        }

        // ==================== Event Listeners ====================
        document.addEventListener('DOMContentLoaded', function() {
            try {
                const searchInput = document.getElementById('searchInput');
                if (searchInput) {
                    searchInput.addEventListener('keydown', function(e) {
                        if (e.key === 'Escape') {
                            this.value = '';
                            this.form.submit();
                        }
                    });
                }
                
                const successMessage = '${successMessage}';
                if (successMessage && successMessage.trim() !== '') {
                    showToast(successMessage, 'success');
                }
                
                console.log('Teacher Store page loaded successfully');
            } catch (error) {
                console.error('DOM loaded error:', error);
            }
        });

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeEditDialog();
            }
        });
    </script>
</body>
</html>