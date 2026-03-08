<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Result | EduEra</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-blue: #002b5c;
            --secondary-blue: #00509e;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
        }

        body {
            background-color: #f5f7ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 30px;
        }

        .result-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .result-header {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .result-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .score-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            border-left: 5px solid var(--primary-blue);
        }

        .score-circle {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
        }

        .score-circle.passed {
            background: linear-gradient(135deg, var(--success), #20c997);
        }

        .score-circle.failed {
            background: linear-gradient(135deg, var(--danger), #c82333);
        }

        .question-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-left: 4px solid #dee2e6;
        }

        .question-card.correct {
            border-left-color: var(--success);
            background-color: #f0fff4;
        }

        .question-card.incorrect {
            border-left-color: var(--danger);
            background-color: #fff5f5;
        }

        .option-item {
            padding: 10px 15px;
            border-radius: 8px;
            margin: 5px 0;
            border: 1px solid #dee2e6;
        }

        .option-item.correct-option {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .option-item.selected-option {
            background-color: #cce5ff;
            border-color: #b8daff;
            color: #004085;
            font-weight: 600;
        }

        .badge-correct {
            background: var(--success);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
        }

        .badge-wrong {
            background: var(--danger);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
        }

        .explanation-box {
            background: #e7f3ff;
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
            border-left: 4px solid var(--info);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn-custom {
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,80,158,0.3);
        }

        .btn-outline {
            background: white;
            color: var(--primary-blue);
            border: 2px solid var(--primary-blue);
        }

        .btn-outline:hover {
            background: var(--primary-blue);
            color: white;
        }

        @media (max-width: 768px) {
            body { padding: 15px; }
            .result-header { padding: 25px; }
            .result-header h1 { font-size: 2rem; }
        }
    </style>
</head>
<body>
    <div class="result-container">
        <!-- Header -->
        <div class="result-header">
            <h1><i class="fas fa-clipboard-check me-3"></i>Test Result</h1>
            <p class="mb-0">Detailed analysis of your performance</p>
        </div>

        <!-- Score Card -->
        <div class="score-card text-center">
            <div class="score-circle ${attempt.percentage >= 50 ? 'passed' : 'failed'}">
                ${Math.round(attempt.percentage)}%
            </div>
            <h2>${attempt.contentTitle}</h2>
            <p class="text-muted">${attempt.testType} Test</p>
            <div class="row mt-4">
                <div class="col-md-4">
                    <h4>${attempt.score}/${attempt.totalQuestions}</h4>
                    <p class="text-muted">Correct Answers</p>
                </div>
                <div class="col-md-4">
                    <h4>${attempt.totalQuestions}</h4>
                    <p class="text-muted">Total Questions</p>
                </div>
                <div class="col-md-4">
                    <h4>${attempt.status}</h4>
                    <p class="text-muted">Status</p>
                </div>
            </div>
        </div>

        <!-- Questions Analysis -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3><i class="fas fa-question-circle me-2" style="color: var(--primary-blue);"></i>Question-wise Analysis</h3>
        </div>

        <div id="questionsContainer">
            <c:forEach var="answer" items="${answers}" varStatus="status">
                <div class="question-card ${answer.correct ? 'correct' : 'incorrect'}">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <h5 class="mb-0">Question ${status.index + 1}</h5>
                        <span class="badge ${answer.correct ? 'bg-success' : 'bg-danger'}">
                            ${answer.correct ? 'Correct' : 'Incorrect'}
                        </span>
                    </div>
                    <p class="fw-bold mb-3">${answer.questionText}</p>
                    
                    <div class="options-container">
                        <div class="option-item ${answer.correctOption == 'A' ? 'correct-option' : ''} ${answer.selectedOption == 'A' ? 'selected-option' : ''}">
                            <strong>A.</strong> ${answer.optionA}
                            <c:if test="${answer.correctOption == 'A'}">
                                <span class="badge-correct ms-2"><i class="fas fa-check me-1"></i>Correct Answer</span>
                            </c:if>
                            <c:if test="${answer.selectedOption == 'A' && answer.correctOption != 'A'}">
                                <span class="badge-wrong ms-2"><i class="fas fa-times me-1"></i>Your Answer</span>
                            </c:if>
                        </div>
                        
                        <div class="option-item ${answer.correctOption == 'B' ? 'correct-option' : ''} ${answer.selectedOption == 'B' ? 'selected-option' : ''}">
                            <strong>B.</strong> ${answer.optionB}
                            <c:if test="${answer.correctOption == 'B'}">
                                <span class="badge-correct ms-2"><i class="fas fa-check me-1"></i>Correct Answer</span>
                            </c:if>
                            <c:if test="${answer.selectedOption == 'B' && answer.correctOption != 'B'}">
                                <span class="badge-wrong ms-2"><i class="fas fa-times me-1"></i>Your Answer</span>
                            </c:if>
                        </div>
                        
                        <div class="option-item ${answer.correctOption == 'C' ? 'correct-option' : ''} ${answer.selectedOption == 'C' ? 'selected-option' : ''}">
                            <strong>C.</strong> ${answer.optionC}
                            <c:if test="${answer.correctOption == 'C'}">
                                <span class="badge-correct ms-2"><i class="fas fa-check me-1"></i>Correct Answer</span>
                            </c:if>
                            <c:if test="${answer.selectedOption == 'C' && answer.correctOption != 'C'}">
                                <span class="badge-wrong ms-2"><i class="fas fa-times me-1"></i>Your Answer</span>
                            </c:if>
                        </div>
                        
                        <div class="option-item ${answer.correctOption == 'D' ? 'correct-option' : ''} ${answer.selectedOption == 'D' ? 'selected-option' : ''}">
                            <strong>D.</strong> ${answer.optionD}
                            <c:if test="${answer.correctOption == 'D'}">
                                <span class="badge-correct ms-2"><i class="fas fa-check me-1"></i>Correct Answer</span>
                            </c:if>
                            <c:if test="${answer.selectedOption == 'D' && answer.correctOption != 'D'}">
                                <span class="badge-wrong ms-2"><i class="fas fa-times me-1"></i>Your Answer</span>
                            </c:if>
                        </div>
                    </div>
                    
                    <c:if test="${not empty answer.explanation}">
                        <div class="explanation-box">
                            <i class="fas fa-lightbulb me-2" style="color: var(--info);"></i>
                            <strong>Explanation:</strong> ${answer.explanation}
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/student-course" class="btn-custom btn-primary">
                <i class="fas fa-book-open me-2"></i>Back to Courses
            </a>
            <a href="${pageContext.request.contextPath}/studenttestscore" class="btn-custom btn-outline">
                <i class="fas fa-chart-line me-2"></i>View All Results
            </a>
        </div>
    </div>
</body>
</html>