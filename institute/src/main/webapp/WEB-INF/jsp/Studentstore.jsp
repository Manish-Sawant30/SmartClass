<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes" />
    <meta name="theme-color" content="#5a3d6e" />
    <title>Student Management | SmartClass</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
            color: var(--text-dark);
            line-height: 1.6;
            transition: var(--transition);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .header {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            padding: 1.5rem 0;
            color: var(--white);
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 4px solid var(--accent-gold);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo i {
            font-size: 1.8rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 12px;
            border-radius: 50%;
            color: var(--accent-gold);
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin: 25px 0;
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
            font-size: 1.8rem;
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
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: var(--text-dark);
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .actions-bar {
            background: var(--white);
            border-radius: var(--radius);
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            border: 2px solid var(--light-purple);
        }

        .search-form {
            display: flex;
            flex: 1;
            min-width: 250px;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 200px;
        }

        .search-box input {
            width: 100%;
            padding: 14px 20px 14px 45px;
            border: 2px solid var(--light-purple);
            border-radius: 50px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
        }

        .search-box input:focus {
            border-color: var(--soft-purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        .search-box i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--soft-purple);
            font-size: 1rem;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: center;
        }

        /* Export Dropdown Styles */
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

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
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

        .btn-secondary {
            background: var(--royal-purple);
            color: var(--white);
        }

        .btn-secondary:hover {
            background: var(--medium-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(90, 61, 110, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #4caf50, #45a049);
            color: var(--white);
        }

        .btn-success:hover {
            background: transparent;
            border-color: #4caf50;
            color: #4caf50;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }

        .btn-reset {
            background: var(--text-muted);
            color: var(--white);
        }

        .btn-reset:hover {
            background: transparent;
            border-color: var(--text-muted);
            color: var(--text-muted);
            transform: translateY(-2px);
        }

        .table-container {
            background: var(--white);
            border-radius: var(--radius-sm);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            margin-bottom: 30px;
            overflow-x: auto;
            border: 2px solid var(--light-purple);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px;
        }

        thead {
            background: linear-gradient(135deg, var(--royal-purple) 0%, var(--medium-purple) 100%);
            color: var(--white);
        }

        th {
            padding: 18px 16px;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--light-purple);
            color: var(--text-light);
        }

        tbody tr:hover {
            background-color: var(--extra-light-purple);
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: rgba(255, 152, 0, 0.1);
            color: var(--warning);
        }

        .status-active {
            background: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .status-rejected {
            background: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .status-inactive {
            background: rgba(108, 117, 125, 0.1);
            color: var(--text-muted);
        }

        /* Course badges container */
        .course-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
        }

        .course-badge {
            background: var(--extra-light-purple);
            color: var(--text-light);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
            white-space: nowrap;
            border: 1px solid var(--light-purple);
        }

        .course-count {
            background: var(--soft-purple);
            color: var(--white);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: help;
        }

        /* IMPROVED ACTION BUTTONS */
        .action-buttons-container {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            align-items: center;
        }

        .action-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
            min-width: 100px;
            justify-content: center;
            border: 2px solid transparent;
        }

        .action-btn.approve {
            background: var(--success);
            color: var(--white);
        }

        .action-btn.approve:hover {
            background: transparent;
            border-color: var(--success);
            color: var(--success);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }

        .action-btn.reject {
            background: var(--danger);
            color: var(--white);
        }

        .action-btn.reject:hover {
            background: transparent;
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        .action-btn.activate {
            background: var(--info);
            color: var(--white);
        }

        .action-btn.activate:hover {
            background: transparent;
            border-color: var(--info);
            color: var(--info);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(33, 150, 243, 0.3);
        }

        .action-btn.deactivate {
            background: var(--warning);
            color: var(--white);
        }

        .action-btn.deactivate:hover {
            background: transparent;
            border-color: var(--warning);
            color: var(--warning);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);
        }

        .action-btn.delete {
            background: var(--text-muted);
            color: var(--white);
        }

        .action-btn.delete:hover {
            background: transparent;
            border-color: var(--text-muted);
            color: var(--text-muted);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }

        .no-data i {
            font-size: 3.5rem;
            margin-bottom: 15px;
            color: var(--light-purple);
        }

        .no-data h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--text-dark);
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(45, 27, 60, 0.5);
            backdrop-filter: blur(3px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 2000;
            padding: 20px;
        }

        .modal-content {
            background: var(--white);
            border-radius: var(--radius);
            width: 100%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: var(--shadow);
            animation: modalSlideIn 0.3s ease;
            border: 2px solid var(--light-purple);
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-header {
            padding: 25px 25px 15px;
            border-bottom: 1px solid var(--light-purple);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--royal-purple);
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 1.8rem;
            cursor: pointer;
            color: var(--text-muted);
            transition: var(--transition);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-btn:hover {
            background: var(--extra-light-purple);
            color: var(--danger);
        }

        .modal-body {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
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
            font-size: 1rem;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
        }

        .form-control:focus {
            border-color: var(--soft-purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(155, 126, 176, 0.2);
        }

        .form-select {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid var(--light-purple);
            border-radius: var(--radius-sm);
            font-size: 1rem;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
            height: auto;
            min-height: 120px;
        }

        .modal-footer {
            padding: 15px 25px;
            border-top: 1px solid var(--light-purple);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        /* FIXED TOAST STYLES */
        .toast-container {
            position: fixed;
            top: 25px;
            right: 25px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-width: 350px;
        }

        .toast {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 16px 20px;
            box-shadow: var(--shadow);
            display: flex;
            align-items: flex-start;
            gap: 12px;
            min-width: 280px;
            max-width: 350px;
            transform: translateX(100%);
            opacity: 0;
            transition: transform 0.3s ease, opacity 0.3s ease;
            border-left: 4px solid var(--success);
            border: 2px solid var(--light-purple);
            position: relative;
            overflow: hidden;
        }

        .toast.show {
            transform: translateX(0);
            opacity: 1;
        }

        .toast-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            color: var(--white);
            flex-shrink: 0;
        }

        .toast-icon.success { background: var(--success); }
        .toast-icon.error { background: var(--danger); }
        .toast-icon.info { background: var(--info); }
        .toast-icon.warning { background: var(--warning); }

        .toast-content {
            flex: 1;
            word-break: break-word;
        }

        .toast-content p {
            font-size: 0.95rem;
            color: var(--text-dark);
            margin: 0;
            line-height: 1.4;
        }

        .toast-close {
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            font-size: 1.2rem;
            padding: 4px;
            margin-left: auto;
            flex-shrink: 0;
            transition: var(--transition);
        }

        .toast-close:hover {
            color: var(--danger);
        }

        .toast-progress {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            background: var(--success);
            animation: progress 4s linear forwards;
        }

        .toast.error .toast-progress { background: var(--danger); }
        .toast.warning .toast-progress { background: var(--warning); }
        .toast.info .toast-progress { background: var(--info); }

        @keyframes progress {
            from { width: 100%; }
            to { width: 0%; }
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: var(--text-muted);
            font-size: 0.9rem;
            border-top: 2px solid var(--light-purple);
            margin-top: 30px;
        }

        /* SERIAL NUMBER STYLING */
        .serial-number {
            display: inline-block;
            width: 32px;
            height: 32px;
            background: var(--royal-purple);
            color: var(--white);
            border-radius: 50%;
            text-align: center;
            line-height: 32px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-right: 8px;
        }

        @media (max-width: 992px) {
            .header-content {
                padding: 0 15px;
            }
            
            .logo h1 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-form {
                width: 100%;
                flex-direction: column;
            }
            
            .search-box {
                min-width: 100%;
            }
            
            .action-buttons {
                justify-content: center;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .modal-content {
                margin: 10px;
            }
            
            .toast {
                min-width: 250px;
                max-width: 300px;
            }
            
            .action-buttons-container {
                flex-direction: column;
                align-items: stretch;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .header-actions {
                width: 100%;
                justify-content: center;
            }
            
            .btn {
                padding: 10px 16px;
                font-size: 0.9rem;
            }
            
            .logo h1 {
                font-size: 1.3rem;
            }
            
            .toast-container {
                left: 20px;
                right: 20px;
                max-width: none;
            }
            
            .toast {
                max-width: 100%;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn:active,
            .action-btn:active,
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

<div class="header">
    <div class="header-content">
        <div class="logo">
            <i class="fas fa-graduation-cap"></i>
            <h1>Student Management</h1>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/student/signup" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Student
            </a>
        </div>
    </div>
</div>

<div class="container">
    <!-- Stats Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon total">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.totalStudents}</h3>
                <p>Total Students</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon active">
                <i class="fas fa-user-check"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.activeStudents}</h3>
                <p>Active Students</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon pending">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.pendingStudents}</h3>
                <p>Pending Students</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon rejected">
                <i class="fas fa-times-circle"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.rejectedStudents}</h3>
                <p>Rejected Students</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon inactive">
                <i class="fas fa-user-times"></i>
            </div>
            <div class="stat-info">
                <h3>${stats.inactiveStudents}</h3>
                <p>Inactive Students</p>
            </div>
        </div>
    </div>

    <!-- Actions Bar -->
    <div class="actions-bar">
        <form class="search-form" action="${pageContext.request.contextPath}/student/search" method="GET">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" name="searchTerm" placeholder="Search by name, email, course, mobile, or student ID..." value="${param.searchTerm}">
            </div>
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Search
                </button>
                <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-reset">
                    <i class="fas fa-sync-alt"></i> Reset
                </a>
                <!-- Export Dropdown -->
                <div class="export-dropdown">
                    <button type="button" class="btn btn-success" onclick="toggleExportMenu()">
                        <i class="fas fa-download"></i> Export
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
        </form>
    </div>

    <!-- Student Table -->
    <div class="table-container">
        <table id="studentTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Courses</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty students && fn:length(students) > 0}">
                        <c:forEach var="student" items="${students}" varStatus="loop">
                            <tr id="student-row-${student.id}">
                                <td>
                                    <span class="serial-number">${loop.index + 1}</span>
                                </td>
                                <td><strong>${student.studentId}</strong></td>
                                <td>${student.fullName}</td>
                                <td>
                                    <a href="mailto:${student.email}" style="color: var(--text-light); text-decoration: none;">
                                        ${student.email}
                                    </a>
                                </td>
                                <td>${student.mobile}</td>
                                <td>
                                    <div class="course-badges">
                                        <c:forEach var="course" items="${student.courses}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <span class="course-badge">${course}</span>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${student.courses.size() > 3}">
                                            <span class="course-count" title="${student.coursesAsString}">
                                                +${student.courses.size() - 3}
                                            </span>
                                        </c:if>
                                    </div>
                                </td>
                                <td>
                                    <span class="status-badge status-${fn:toLowerCase(student.status)}">
                                        ${student.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons-container">
                                        <!-- APPROVE -->
                                        <c:if test="${student.status == 'Pending'}">
                                            <button type="button" class="action-btn approve"
                                                    onclick="postAction('/student/approve/${student.id}', 'Student approved successfully')">
                                                <i class="fas fa-check"></i> Approve
                                            </button>
                                            
                                            <button type="button" class="action-btn reject"
                                                    onclick="postAction('/student/reject/${student.id}', 'Student rejected successfully')">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </c:if>
                                        
                                        <!-- ACTIVATE -->
                                        <c:if test="${student.status == 'Inactive'}">
                                            <button type="button" class="action-btn activate"
                                                    onclick="postAction('/student/activate/${student.id}', 'Student activated successfully')">
                                                <i class="fas fa-check-circle"></i> Activate
                                            </button>
                                        </c:if>
                                        
                                        <!-- DEACTIVATE -->
                                        <c:if test="${student.status == 'Active'}">
                                            <button type="button" class="action-btn deactivate"
                                                    onclick="postAction('/student/deactivate/${student.id}', 'Student deactivated successfully')">
                                                <i class="fas fa-ban"></i> Deactivate
                                            </button>
                                        </c:if>
                                        
                                        <!-- DELETE (ALWAYS AVAILABLE) -->
                                        <button type="button" class="action-btn delete"
                                                onclick="if(confirm('Are you sure you want to delete this student?')) postAction('/student/delete/${student.id}', 'Student deleted successfully')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8">
                                <div class="no-data">
                                    <i class="fas fa-database"></i>
                                    <h3>No Students Found</h3>
                                    <p>Add your first student to get started</p>
                                    <a href="${pageContext.request.contextPath}/student/signup" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                        <i class="fas fa-plus"></i> Add Student
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- Edit Student Modal - Updated with multiple course selection -->
<div class="modal-overlay" id="editModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Edit Student</h2>
            <button class="close-btn" onclick="closeEditModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="editForm">
                <input type="hidden" id="editId" name="id">
                <div class="form-group">
                    <label for="editFullName">Full Name *</label>
                    <input type="text" id="editFullName" name="fullName" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="editEmail">Email Address *</label>
                    <input type="email" id="editEmail" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="editMobile">Mobile Number *</label>
                    <input type="tel" id="editMobile" name="mobile" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="editCourses">Courses (Select Multiple) *</label>
                    <select id="editCourses" name="courses" class="form-select" multiple size="6" required>
                        <option value="C Programming">C Programming</option>
                        <option value="C++ Programming">C++ Programming</option>
                        <option value="Java Programming">Java Programming</option>
                        <option value="Python Programming">Python Programming</option>
                        <option value="JavaScript">JavaScript</option>
                        <option value="Full Stack Development">Full Stack Development</option>
                        <option value="Android Development">Android Development</option>
                        <option value="Software Engineering">Software Engineering</option>
                        <option value="Git & GitHub">Git & GitHub</option>
                        <option value="Data Structures & Algorithms">Data Structures & Algorithms</option>
                        <option value="Operating Systems">Operating Systems</option>
                        <option value="DBMS">DBMS</option>
                        <option value="Computer Networks">Computer Networks</option>
                        <option value="Artificial Intelligence">Artificial Intelligence</option>
                        <option value="Cloud Computing">Cloud Computing</option>
                        <option value="Cyber Security & Ethical Hacking">Cyber Security & Ethical Hacking</option>
                    </select>
                    <small style="color: var(--text-muted);">Hold Ctrl/Cmd to select multiple courses</small>
                </div>
                <div class="form-group">
                    <label for="editStudentId">Student ID</label>
                    <input type="text" id="editStudentId" name="studentId" class="form-control" readonly>
                </div>
                <div class="form-group">
                    <label for="editStatus">Status *</label>
                    <select id="editStatus" name="status" class="form-select" required>
                        <option value="Pending">Pending</option>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                        <option value="Rejected">Rejected</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editPassword">Password (leave blank to keep current)</label>
                    <input type="password" id="editPassword" name="password" class="form-control">
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-reset" onclick="closeEditModal()">Cancel</button>
            <button type="button" class="btn btn-primary" onclick="updateStudent()">Save Changes</button>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 style="color: var(--danger);">
                <i class="fas fa-exclamation-triangle" style="margin-right: 8px;"></i>Confirm Deletion
            </h2>
            <button class="close-btn" onclick="closeDeleteModal()">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete student: <strong id="deleteStudentName"></strong>?</p>
            <p style="color: var(--danger);">
                <i class="fas fa-info-circle" style="margin-right: 5px;"></i>This action cannot be undone.
            </p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-reset" onclick="closeDeleteModal()">Cancel</button>
            <button type="button" class="btn btn-primary" id="confirmDeleteBtn" style="background: var(--danger);">Delete Student</button>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div class="toast-container" id="toastContainer"></div>

<!-- Footer -->
<footer class="footer">
    <p>© 2025 SmartClass - Student Management System. All rights reserved.</p>
</footer>

<script>
/* ================= CONTEXT PATH ================= */
const ctxPath = "${pageContext.request.contextPath}";
let studentToDelete = null;

/* ================= TOAST ================= */
function showToast(message, type = 'info') {
    // Don't show empty messages
    if (!message || message.trim() === '') {
        console.log('Empty toast message prevented');
        return;
    }
    
    const container = document.getElementById("toastContainer");
    
    // Check for duplicate messages
    const existingToasts = container.querySelectorAll('.toast');
    for (let toast of existingToasts) {
        const toastMessage = toast.querySelector('.toast-content p')?.textContent;
        if (toastMessage === message) {
            return; // Don't show duplicate message
        }
    }
    
    const toast = document.createElement("div");
    toast.className = `toast ${type}`;
    
    let iconClass = 'info-circle';
    if (type === 'success') iconClass = 'check-circle';
    else if (type === 'error') iconClass = 'exclamation-circle';
    else if (type === 'warning') iconClass = 'exclamation-triangle';
    
    toast.innerHTML = `
        <div class="toast-icon ${type}">
            <i class="fas fa-${iconClass}"></i>
        </div>
        <div class="toast-content">
            <p>${message}</p>
        </div>
        <button class="toast-close" onclick="this.parentElement.remove()">×</button>
        <div class="toast-progress"></div>
    `;
    
    container.appendChild(toast);
    
    // Trigger animation
    setTimeout(() => toast.classList.add('show'), 10);
    
    // Auto remove after 4 seconds
    setTimeout(() => {
        if (toast.parentNode) {
            toast.classList.remove('show');
            setTimeout(() => {
                if (toast.parentNode) {
                    toast.remove();
                }
            }, 300);
        }
    }, 4000);
}

/* ================= Toggle Export Menu ================= */
function toggleExportMenu() {
    const menu = document.getElementById('exportMenu');
    menu.classList.toggle('show');
    
    // Close menu when clicking outside
    setTimeout(() => {
        document.addEventListener('click', function closeMenu(e) {
            if (!e.target.closest('.export-dropdown')) {
                menu.classList.remove('show');
                document.removeEventListener('click', closeMenu);
            }
        });
    }, 100);
}

/* ================= Get Current Date for Filename ================= */
function getCurrentDate() {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    return year + '-' + month + '-' + day;
}

/* ================= Get Table Data for Export ================= */
function getTableData() {
    const table = document.getElementById('studentTable');
    const data = [];
    
    // Get headers (excluding Actions column)
    const headers = [];
    table.querySelectorAll('thead th').forEach((th, index) => {
        if (index < 7) { // Skip Actions column (index 7)
            headers.push(th.innerText);
        }
    });
    data.push(headers);
    
    // Get rows
    table.querySelectorAll('tbody tr').forEach(tr => {
        if (tr.innerHTML.includes('No Students Found')) return;
        
        const row = [];
        tr.querySelectorAll('td').forEach((td, index) => {
            if (index < 7) { // Skip Actions column (index 7)
                let text = '';
                
                if (index === 0) {
                    // Get serial number (skip the serial number span text)
                    const serialSpan = td.querySelector('.serial-number');
                    text = serialSpan ? serialSpan.textContent : td.innerText;
                } else if (index === 5) {
                    // Get courses
                    const courses = [];
                    td.querySelectorAll('.course-badge').forEach(badge => {
                        courses.push(badge.innerText);
                    });
                    text = courses.join(', ');
                } else if (index === 6) {
                    // Get status
                    const statusSpan = td.querySelector('.status-badge');
                    if (statusSpan) {
                        text = statusSpan.innerText;
                    }
                } else {
                    text = td.innerText;
                }
                
                row.push(text.trim());
            }
        });
        data.push(row);
    });
    
    return data;
}

/* ================= Export to PDF ================= */
function exportToPDF() {
    try {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        
        // Add title
        doc.setFontSize(18);
        doc.text('Students List - SmartClass', 14, 22);
        
        // Add date
        doc.setFontSize(11);
        doc.text('Export Date: ' + new Date().toLocaleDateString(), 14, 30);
        
        // Get table data
        const tableData = getTableData();
        const headers = [tableData[0]];
        const rows = tableData.slice(1);
        
        // Create table
        doc.autoTable({
            head: headers,
            body: rows,
            startY: 35,
            theme: 'grid',
            styles: { fontSize: 8, cellPadding: 3 },
            headStyles: { fillColor: [90, 61, 110], textColor: [255, 255, 255] }
        });
        
        // Save PDF
        const currentDate = getCurrentDate();
        doc.save('students_list_' + currentDate + '.pdf');
        
        // Close menu and show success message
        document.getElementById('exportMenu').classList.remove('show');
        showToast('PDF exported successfully!', 'success');
    } catch (error) {
        console.error('PDF export error:', error);
        showToast('Error exporting PDF: ' + error.message, 'error');
    }
}

/* ================= Export to Excel ================= */
function exportToExcel() {
    try {
        const tableData = getTableData();
        
        // Create worksheet
        const ws = XLSX.utils.aoa_to_sheet(tableData);
        
        // Create workbook
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, 'Students');
        
        // Save Excel file
        const currentDate = getCurrentDate();
        XLSX.writeFile(wb, 'students_list_' + currentDate + '.xlsx');
        
        // Close menu and show success message
        document.getElementById('exportMenu').classList.remove('show');
        showToast('Excel file exported successfully!', 'success');
    } catch (error) {
        console.error('Excel export error:', error);
        showToast('Error exporting Excel: ' + error.message, 'error');
    }
}

/* ================= Export to CSV ================= */
function exportToCSV() {
    try {
        const tableData = getTableData();
        
        // Convert to CSV
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
        
        // Create download link
        const currentDate = getCurrentDate();
        const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        const url = URL.createObjectURL(blob);
        link.setAttribute('href', url);
        link.setAttribute('download', 'students_list_' + currentDate + '.csv');
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(url);
        
        // Close menu and show success message
        document.getElementById('exportMenu').classList.remove('show');
        showToast('CSV file exported successfully!', 'success');
    } catch (error) {
        console.error('CSV export error:', error);
        showToast('Error exporting CSV: ' + error.message, 'error');
    }
}

/* ================= POST ACTION FUNCTION ================= */
function postAction(url, successMessage) {
    fetch(ctxPath + url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("HTTP error " + response.status);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showToast(successMessage, 'success');
            // Update the serial numbers after successful action
            setTimeout(() => {
                window.location.reload();
            }, 1500);
        } else {
            showToast(data.message || "Action failed", 'error');
        }
    })
    .catch(error => {
        console.error("Error:", error);
        showToast("Server error. Please try again.", 'error');
    });
}

/* ================= MODAL FUNCTIONS ================= */
function openEditModal(id) {
    fetch(`${ctxPath}/student/${id}`)
        .then(res => res.json())
        .then(data => {
            if (!data.success) return showToast(data.message, "error");
            const s = data.student;
            document.getElementById('editId').value = s.id;
            document.getElementById('editFullName').value = s.fullName;
            document.getElementById('editEmail').value = s.email;
            document.getElementById('editMobile').value = s.mobile;
            document.getElementById('editStudentId').value = s.studentId;
            document.getElementById('editStatus').value = s.status;
            
            // Set selected courses
            const coursesSelect = document.getElementById('editCourses');
            const options = coursesSelect.options;
            
            // Clear all selections
            for (let i = 0; i < options.length; i++) {
                options[i].selected = false;
            }
            
            // Select the student's courses
            if (s.courses && s.courses.length > 0) {
                for (let i = 0; i < options.length; i++) {
                    if (s.courses.includes(options[i].value)) {
                        options[i].selected = true;
                    }
                }
            }
            
            document.getElementById('editModal').style.display = "flex";
        });
}

function closeEditModal() {
    document.getElementById('editModal').style.display = "none";
}

function closeDeleteModal() {
    document.getElementById('deleteModal').style.display = "none";
}

/* ================= UPDATE STUDENT ================= */
function updateStudent() {
    const form = document.getElementById('editForm');
    const formData = new FormData(form);
    
    // Get selected courses
    const coursesSelect = document.getElementById('editCourses');
    const selectedCourses = [];
    for (let i = 0; i < coursesSelect.options.length; i++) {
        if (coursesSelect.options[i].selected) {
            selectedCourses.push(coursesSelect.options[i].value);
        }
    }
    
    if (selectedCourses.length === 0) {
        showToast("Please select at least one course", 'error');
        return;
    }
    
    // Build request body
    const requestBody = {
        id: formData.get('id'),
        fullName: formData.get('fullName'),
        email: formData.get('email'),
        mobile: formData.get('mobile'),
        courses: selectedCourses,
        studentId: formData.get('studentId'),
        status: formData.get('status'),
        password: formData.get('password')
    };
    
    fetch(ctxPath + '/student/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestBody)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showToast(data.message, 'success');
            closeEditModal();
            setTimeout(() => location.reload(), 1500);
        } else {
            showToast(data.message, 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showToast('Error updating student', 'error');
    });
}

/* ================= DELETE CONFIRMATION ================= */
function confirmDelete(id, name) {
    studentToDelete = id;
    document.getElementById('deleteStudentName').innerText = name;
    document.getElementById('deleteModal').style.display = "flex";
}

/* ================= UPDATE SERIAL NUMBERS ================= */
function updateSerialNumbers() {
    const serialNumbers = document.querySelectorAll('.serial-number');
    serialNumbers.forEach((span, index) => {
        span.textContent = index + 1;
    });
}

/* ================= EVENT LISTENERS ================= */
document.addEventListener('DOMContentLoaded', function() {
    // Update serial numbers on page load
    updateSerialNumbers();
    
    // Confirm delete button event
    document.getElementById('confirmDeleteBtn').onclick = () => {
        if (!studentToDelete) return;
        
        fetch(`${ctxPath}/student/delete/${studentToDelete}`, { method: "POST" })
            .then(r => r.json())
            .then(d => {
                if (d.success) {
                    showToast("Student deleted successfully", 'success');
                    document.getElementById(`student-row-${studentToDelete}`).remove();
                    closeDeleteModal();
                    // Update serial numbers after deletion
                    updateSerialNumbers();
                } else {
                    showToast(d.message, 'error');
                }
            });
    };
});

// Close modals when clicking outside
window.onclick = function(event) {
    if (event.target.classList.contains('modal-overlay')) {
        closeEditModal();
        closeDeleteModal();
    }
};

// Close modals with Escape key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeEditModal();
        closeDeleteModal();
    }
});
</script>

</body>
</html>