<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <meta name="theme-color" content="#5a3d6e">
    <title>Parent Management | SmartClass</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        /* Main Content */
        .main-content {
            max-width: 1400px;
            margin: 0 auto;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 2px solid var(--light-purple);
            padding: 30px;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--light-purple);
            margin-bottom: 30px;
        }

        .header h1 {
            color: var(--dark-purple);
            font-size: 2rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .header h1 i {
            color: var(--accent-gold);
            margin-right: 10px;
        }

        /* Stats Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
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
            font-size: 1.8rem;
            color: var(--white);
            transition: var(--transition);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-icon.parents {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
        }

        .stat-icon.active {
            background: linear-gradient(135deg, #4caf50, #45a049);
        }
        
        .stat-icon.pending {
            background: linear-gradient(135deg, #ff9800, #f57c00);
        }
        
        .stat-icon.rejected {
            background: linear-gradient(135deg, #f44336, #d32f2f);
        }
        
        .stat-icon.inactive {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }

        .stat-info h3 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 0.95rem;
            font-weight: 500;
        }

        /* Controls */
        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
            position: relative;
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
            padding: 14px 20px 14px 45px;
            border: 2px solid var(--light-purple);
            border-radius: 50px;
            font-size: 1rem;
            outline: none;
            transition: var(--transition);
            background: var(--white);
            color: var(--text-dark);
        }

        .search-box input:focus {
            border-color: var(--soft-purple);
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

        .filter-buttons {
            display: flex;
            gap: 10px;
            position: relative;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            border: 2px solid transparent;
            text-decoration: none;
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

        .btn-success {
            background: linear-gradient(135deg, #4caf50, #45a049);
            color: var(--white);
        }

        .btn-success:hover {
            background: transparent;
            border-color: #4caf50;
            color: #4caf50;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
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

        /* Table Styles */
        .table-container {
            background-color: var(--white);
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
            min-width: 1200px;
        }

        thead {
            background: linear-gradient(135deg, var(--royal-purple), var(--medium-purple));
        }

        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            color: var(--white);
            font-size: 0.95rem;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid var(--light-purple);
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: var(--extra-light-purple);
        }

        td {
            padding: 15px;
            color: var(--text-light);
        }

        .parent-name {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .parent-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--soft-purple), var(--light-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: var(--white);
            border: 2px solid var(--accent-gold);
        }

        .student-id {
            display: inline-block;
            background: var(--extra-light-purple);
            color: var(--royal-purple);
            padding: 5px 10px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            border: 1px solid var(--light-purple);
        }

        .status {
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }

        .status.active {
            background: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .status.inactive {
            background: rgba(108, 117, 125, 0.1);
            color: var(--text-muted);
        }

        .status.pending {
            background: rgba(255, 152, 0, 0.1);
            color: var(--pending);
        }

        .status.rejected {
            background: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .status.approved {
            background: rgba(33, 150, 243, 0.1);
            color: var(--info);
        }

        .actions {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }

        /* ACTION BUTTON STYLES */
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
            min-width: 85px;
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
            background: var(--success);
            color: var(--white);
        }

        .action-btn.activate:hover {
            background: transparent;
            border-color: var(--success);
            color: var(--success);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
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
            background: var(--danger);
            color: var(--white);
        }

        .action-btn.delete:hover {
            background: transparent;
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        .course-badge {
            display: inline-block;
            background-color: var(--extra-light-purple);
            color: var(--text-light);
            padding: 3px 8px;
            border-radius: 20px;
            margin-right: 5px;
            margin-bottom: 3px;
            font-size: 0.8rem;
            border: 1px solid var(--light-purple);
        }

        .course-count {
            color: var(--text-muted);
            font-size: 0.8rem;
        }

        /* Success message */
        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--success);
            color: var(--white);
            padding: 16px 20px;
            border-radius: var(--radius-sm);
            box-shadow: var(--shadow);
            z-index: 1100;
            display: flex;
            align-items: center;
            gap: 10px;
            max-width: 400px;
            animation: slideIn 0.3s ease;
            border-left: 4px solid var(--accent-gold);
            opacity: 1;
            transition: opacity 0.3s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .success-message.hide {
            animation: slideOut 0.3s ease forwards;
        }

        @keyframes slideOut {
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }

        .success-message button {
            background: none;
            border: none;
            color: var(--white);
            margin-left: auto;
            cursor: pointer;
            font-size: 1.2rem;
            transition: transform 0.2s;
        }

        .success-message button:hover {
            transform: scale(1.2);
        }

        /* Rejection Reason Modal */
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

        .modal-footer {
            padding: 15px 25px;
            border-top: 1px solid var(--light-purple);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 20px;
            color: var(--text-muted);
            font-size: 0.9rem;
            border-top: 2px solid var(--light-purple);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: var(--light-purple);
        }

        .empty-state h3 {
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .main-content {
                padding: 20px;
            }
            
            .header h1 {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-form {
                width: 100%;
                flex-direction: column;
            }
            
            .search-box {
                max-width: 100%;
                width: 100%;
            }
            
            .stats-cards {
                grid-template-columns: 1fr;
            }
            
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .header h1 {
                font-size: 1.5rem;
            }
            
            .filter-buttons {
                width: 100%;
                justify-content: flex-start;
            }
            
            .actions {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media (max-width: 576px) {
            .main-content {
                padding: 15px;
            }
            
            .btn {
                padding: 10px 16px;
                font-size: 13px;
                width: 100%;
                justify-content: center;
            }
            
            .filter-buttons {
                flex-direction: column;
            }
            
            .export-dropdown {
                width: 100%;
            }
            
            .export-menu {
                width: 100%;
            }
            
            .stats-cards {
                gap: 15px;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-icon {
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
            }
            
            .stat-info h3 {
                font-size: 1.6rem;
            }
            
            .action-btn {
                width: 100%;
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
    <!-- Show success message if available -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="success-message" id="successMessage" data-message-id="${sessionScope.messageId}">
            <i class="fas fa-check-circle"></i>
            <span>${sessionScope.successMessage}</span>
            <button onclick="closeSuccessMessage(this)">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <c:remove var="successMessage" scope="session" />
        <c:remove var="messageId" scope="session" />
    </c:if>

    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="success-message" style="background: var(--danger);" id="errorMessage">
            <i class="fas fa-exclamation-circle"></i>
            <span>${sessionScope.errorMessage}</span>
            <button onclick="closeSuccessMessage(this)">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <!-- Rejection Reason Modal -->
    <div class="modal-overlay" id="rejectModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Rejection Reason</h2>
                <button class="close-btn" onclick="closeRejectModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="rejectForm" method="post">
                    <div class="form-group">
                        <label for="rejectionReason">Please provide reason for rejection:</label>
                        <textarea class="form-control" id="rejectionReason" name="rejectionReason" rows="4" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-reset" onclick="closeRejectModal()">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="submitRejectForm()">Submit Rejection</button>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-users"></i> Parent Management</h1>
            <div class="dashboard-link">
                <a href="${pageContext.request.contextPath}/admindash" class="btn btn-secondary">
                    <i class="fas fa-tachometer-alt"></i> Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-icon parents">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3 id="total-parents">${totalParents != null ? totalParents : (not empty parents ? parents.size() : 0)}</h3>
                    <p>Total Parents</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon pending">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <h3>${pendingCount != null ? pendingCount : 0}</h3>
                    <p>Pending Approval</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon active">
                    <i class="fas fa-user-check"></i>
                </div>
                <div class="stat-info">
                    <h3>${activeCount != null ? activeCount : 0}</h3>
                    <p>Active Accounts</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon inactive">
                    <i class="fas fa-user-times"></i>
                </div>
                <div class="stat-info">
                    <h3>${inactiveCount != null ? inactiveCount : 0}</h3>
                    <p>Inactive Accounts</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon rejected">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>${rejectedCount != null ? rejectedCount : 0}</h3>
                    <p>Rejected Accounts</p>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <div class="controls">
            <form action="${pageContext.request.contextPath}/parent/store" method="get" class="search-form">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" name="keyword" 
                           placeholder="Search parents by name, email, or student ID..."
                           value="${searchKeyword}">
                </div>
                <button type="submit" class="btn btn-secondary">
                    <i class="fas fa-search"></i> Search
                </button>
                <a href="${pageContext.request.contextPath}/parent/store" class="btn btn-reset">
                    <i class="fas fa-sync-alt"></i> Reset
                </a>
            </form>
            <div class="filter-buttons">
                <a href="${pageContext.request.contextPath}/parent/store" class="btn btn-secondary" id="filterAll">
                    <i class="fas fa-list"></i> All
                </a>
                <a href="${pageContext.request.contextPath}/parent/store?status=pending" class="btn btn-warning">
                    <i class="fas fa-clock"></i> Pending
                </a>
                <a href="${pageContext.request.contextPath}/parent/store?status=active" class="btn btn-success">
                    <i class="fas fa-check-circle"></i> Active
                </a>
                <button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/parent/signup'">
                    <i class="fas fa-plus"></i> Add Parent
                </button>
                <div class="export-dropdown">
                    <button class="btn btn-success" onclick="toggleExportMenu()">
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
        </div>

        <!-- Parents Table -->
        <div class="table-container">
            <table id="parentsTable">
                <thead>
                    <tr>
                        <th>Parent ID</th>
                        <th>Parent Full Name</th>
                        <th>Email ID</th>
                        <th>Mobile Number</th>
                        <th>Student ID</th>
                        <th>Courses</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="parentsTableBody">
                    <c:choose>
                        <c:when test="${not empty parents}">
                            <c:forEach var="parent" items="${parents}">
                                <tr id="parent-row-${parent.id}">
                                    <td><span style="font-weight: 600;">${parent.parentId}</span></td>
                                    <td>
                                        <div class="parent-name">
                                            <div class="parent-avatar">
                                                <c:set var="nameParts" value="${fn:split(parent.fullName, ' ')}" />
                                                <c:set var="firstInitial" value="${fn:substring(nameParts[0], 0, 1)}" />
                                                <c:choose>
                                                    <c:when test="${fn:length(nameParts) > 1}">
                                                        <c:set var="lastInitial" value="${fn:substring(nameParts[fn:length(nameParts)-1], 0, 1)}" />
                                                        ${firstInitial}${lastInitial}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${firstInitial}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <strong>${parent.fullName}</strong>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${parent.email}</td>
                                    <td>${parent.mobileNumber}</td>
                                    <td><span class="student-id">${parent.studentId}</span></td>
                                    <td>
                                        <div style="max-width: 200px;">
                                            <c:choose>
                                                <c:when test="${not empty parent.courses && parent.courses.size() > 0}">
                                                    <c:forEach var="course" items="${parent.courses}" varStatus="status">
                                                        <c:if test="${status.index < 2}">
                                                            <span class="course-badge">${course.courseName}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${parent.courses.size() > 2}">
                                                        <span class="course-count">+${parent.courses.size() - 2} more</span>
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--text-muted);">No courses</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status ${fn:toLowerCase(parent.status)}">${parent.status}</span>
                                        <c:if test="${parent.status == 'REJECTED' && not empty parent.rejectionReason}">
                                            <i class="fas fa-info-circle" style="color: var(--danger); margin-left: 5px;" 
                                               title="Reason: ${parent.rejectionReason}"></i>
                                        </c:if>
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <!-- PENDING Status - Show Approve and Reject buttons -->
                                            <c:if test="${parent.status == 'PENDING'}">
                                                <form action="${pageContext.request.contextPath}/parent/approve/${parent.id}" method="post" style="display: inline;">
                                                    <button type="submit" class="action-btn approve" title="Approve Parent">
                                                        <i class="fas fa-check-circle"></i> Approve
                                                    </button>
                                                </form>
                                                
                                                <button type="button" class="action-btn reject" title="Reject Parent"
                                                        onclick="openRejectModal(${parent.id})">
                                                    <i class="fas fa-times-circle"></i> Reject
                                                </button>
                                            </c:if>
                                            
                                            <!-- ACTIVE Status - Show Deactivate button -->
                                            <c:if test="${parent.status == 'ACTIVE'}">
                                                <form action="${pageContext.request.contextPath}/parent/deactivate/${parent.id}" method="post" style="display: inline;">
                                                    <button type="submit" class="action-btn deactivate" title="Deactivate Parent">
                                                        <i class="fas fa-ban"></i> Deactivate
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <!-- INACTIVE Status - Show Activate button -->
                                            <c:if test="${parent.status == 'INACTIVE'}">
                                                <form action="${pageContext.request.contextPath}/parent/activate/${parent.id}" method="post" style="display: inline;">
                                                    <button type="submit" class="action-btn activate" title="Activate Parent">
                                                        <i class="fas fa-check-circle"></i> Activate
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <!-- REJECTED Status - Show only Delete button -->
                                            <c:if test="${parent.status == 'REJECTED'}">
                                                <!-- No status change buttons, just delete -->
                                            </c:if>
                                            
                                            <!-- DELETE BUTTON (always available for all statuses) -->
                                            <form action="${pageContext.request.contextPath}/parent/delete/${parent.id}" method="post" style="display: inline;" 
                                                  onsubmit="return confirmDelete('${parent.fullName}')">
                                                <button type="submit" class="action-btn delete" title="Delete Parent">
                                                    <i class="fas fa-trash"></i> Delete
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
                                    <i class="fas fa-users"></i>
                                    <h3>No parents found</h3>
                                    <p>Add a new parent or adjust your search</p>
                                    <a href="${pageContext.request.contextPath}/parent/signup" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                        <i class="fas fa-plus"></i> Add First Parent
                                    </a>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2026 SmartClass - School Management System | Last updated: <span id="current-date"></span></p>
        </div>
    </main>

    <script>
        // Track current parent ID for rejection
        let currentParentId = null;
        
        // Close success message
        function closeSuccessMessage(button) {
            const message = button.closest('.success-message');
            if (message) {
                message.classList.add('hide');
                setTimeout(() => {
                    if (message.parentNode) {
                        message.remove();
                    }
                }, 300);
            }
        }

        // Confirm delete with better message
        function confirmDelete(parentName) {
            return confirm('Are you sure you want to delete ' + parentName + '? This will permanently remove this parent account.');
        }

        // Open rejection modal
        function openRejectModal(parentId) {
            currentParentId = parentId;
            document.getElementById('rejectModal').style.display = 'flex';
        }

        // Close rejection modal
        function closeRejectModal() {
            document.getElementById('rejectModal').style.display = 'none';
            document.getElementById('rejectionReason').value = '';
            currentParentId = null;
        }

        // Submit rejection form
        function submitRejectForm() {
            const reason = document.getElementById('rejectionReason').value.trim();
            if (!reason) {
                alert('Please provide a rejection reason');
                return;
            }
            
            // Create form and submit
            const form = document.createElement('form');
            form.method = 'post';
            form.action = '${pageContext.request.contextPath}/parent/reject/' + currentParentId;
            
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'rejectionReason';
            input.value = reason;
            
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
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

        // Get current date for filename
        function getCurrentDate() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            return year + '-' + month + '-' + day;
        }

        // Get table data for export
        function getTableData() {
            const table = document.getElementById('parentsTable');
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
                if (tr.innerHTML.includes('No parents found')) return;
                
                const row = [];
                tr.querySelectorAll('td').forEach((td, index) => {
                    if (index < 7) { // Skip Actions column (index 7)
                        let text = '';
                        
                        if (index === 1) {
                            // Get parent name from the parent-name div
                            const nameDiv = td.querySelector('.parent-name div:last-child strong');
                            text = nameDiv ? nameDiv.innerText : td.innerText;
                        } else if (index === 4) {
                            // Get student ID
                            const studentIdSpan = td.querySelector('.student-id');
                            text = studentIdSpan ? studentIdSpan.innerText : td.innerText;
                        } else if (index === 5) {
                            // Get courses
                            const courses = [];
                            td.querySelectorAll('.course-badge').forEach(badge => {
                                courses.push(badge.innerText);
                            });
                            text = courses.join(', ');
                        } else if (index === 6) {
                            // Get status (without the info icon)
                            const statusSpan = td.querySelector('.status');
                            text = statusSpan ? statusSpan.innerText : td.innerText;
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

        // Export to PDF
        function exportToPDF() {
            try {
                const { jsPDF } = window.jspdf;
                const doc = new jsPDF();
                
                doc.setFontSize(18);
                doc.text('Parents List - SmartClass', 14, 22);
                
                doc.setFontSize(11);
                doc.text('Export Date: ' + new Date().toLocaleDateString(), 14, 30);
                
                const tableData = getTableData();
                if (tableData.length <= 1) {
                    alert('No data to export');
                    return;
                }
                
                const headers = [tableData[0]];
                const rows = tableData.slice(1);
                
                doc.autoTable({
                    head: headers,
                    body: rows,
                    startY: 35,
                    theme: 'grid',
                    styles: { fontSize: 8, cellPadding: 3 },
                    headStyles: { fillColor: [90, 61, 110], textColor: [255, 255, 255] }
                });
                
                const currentDate = getCurrentDate();
                doc.save('parents_list_' + currentDate + '.pdf');
                
                document.getElementById('exportMenu').classList.remove('show');
                alert('PDF exported successfully!');
            } catch (error) {
                console.error('PDF export error:', error);
                alert('Error exporting PDF: ' + error.message);
            }
        }

        // Export to Excel
        function exportToExcel() {
            try {
                const tableData = getTableData();
                if (tableData.length <= 1) {
                    alert('No data to export');
                    return;
                }
                
                const ws = XLSX.utils.aoa_to_sheet(tableData);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, 'Parents');
                
                const currentDate = getCurrentDate();
                XLSX.writeFile(wb, 'parents_list_' + currentDate + '.xlsx');
                
                document.getElementById('exportMenu').classList.remove('show');
                alert('Excel file exported successfully!');
            } catch (error) {
                console.error('Excel export error:', error);
                alert('Error exporting Excel: ' + error.message);
            }
        }

        // Export to CSV
        function exportToCSV() {
            try {
                const tableData = getTableData();
                if (tableData.length <= 1) {
                    alert('No data to export');
                    return;
                }
                
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
                link.setAttribute('download', 'parents_list_' + currentDate + '.csv');
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                URL.revokeObjectURL(url);
                
                document.getElementById('exportMenu').classList.remove('show');
                alert('CSV file exported successfully!');
            } catch (error) {
                console.error('CSV export error:', error);
                alert('Error exporting CSV: ' + error.message);
            }
        }

        // Auto-hide success message after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                setTimeout(() => {
                    if (successMessage && successMessage.parentNode) {
                        successMessage.classList.add('hide');
                        setTimeout(() => {
                            if (successMessage && successMessage.parentNode) {
                                successMessage.remove();
                            }
                        }, 300);
                    }
                }, 5000);
            }
            
            const errorMessage = document.getElementById('errorMessage');
            if (errorMessage) {
                setTimeout(() => {
                    if (errorMessage && errorMessage.parentNode) {
                        errorMessage.classList.add('hide');
                        setTimeout(() => {
                            if (errorMessage && errorMessage.parentNode) {
                                errorMessage.remove();
                            }
                        }, 300);
                    }
                }, 5000);
            }
            
            // Set current date
            const now = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const dateElement = document.getElementById('current-date');
            if (dateElement) {
                dateElement.textContent = now.toLocaleDateString('en-US', options);
            }
        });

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('rejectModal');
            if (event.target === modal) {
                closeRejectModal();
            }
        };

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeRejectModal();
            }
        });
    </script>
</body>
</html>