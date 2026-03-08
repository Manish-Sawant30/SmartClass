<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Test | EduEra</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-blue: #002b5c;
            --secondary-blue: #00509e;
            --accent-yellow: #ffdd59;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
            --mcq-purple: #6f42c1;
        }

        body {
            background-color: #f5f7ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }

        .test-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .test-header {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            position: sticky;
            top: 10px;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .timer-corner {
            background: white;
            color: var(--primary-blue);
            padding: 10px 20px;
            border-radius: 50px;
            font-size: 32px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            min-width: 100px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .timer-warning {
            background: var(--warning);
            color: #333;
            animation: pulse 1s infinite;
        }

        .timer-critical {
            background: var(--danger);
            color: white;
            animation: blink 0.5s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        @keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }

        .question-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            border-left: 4px solid var(--mcq-purple);
            transition: all 0.3s ease;
        }

        .question-card.answered {
            border-left-color: var(--success);
            background-color: #f8fff8;
        }

        .question-number {
            display: inline-block;
            background: var(--mcq-purple);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .question-text {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
        }

        .options-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .option-item {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .option-item:hover {
            border-color: var(--mcq-purple);
            background-color: #f8f9fa;
            transform: translateX(5px);
        }

        .option-item.selected {
            border-color: var(--mcq-purple);
            background-color: rgba(111, 66, 193, 0.05);
            border-width: 3px;
        }

        .option-prefix {
            display: inline-block;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #f0f0f0;
            text-align: center;
            line-height: 35px;
            font-weight: 700;
            margin-right: 15px;
            color: #555;
        }

        .option-item.selected .option-prefix {
            background: var(--mcq-purple);
            color: white;
        }

        .option-text {
            font-size: 16px;
            flex: 1;
        }

        .test-footer {
            position: sticky;
            bottom: 20px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 -4px 12px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
            z-index: 100;
        }

        .progress-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .question-counter {
            background: #e3f2fd;
            padding: 8px 16px;
            border-radius: 20px;
            color: var(--primary-blue);
            font-weight: 600;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--success), #20c997);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-submit:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .progress-bar-container {
            width: 100%;
            height: 8px;
            background: #e0e0e0;
            border-radius: 4px;
            margin-top: 15px;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--success), #20c997);
            transition: width 0.3s ease;
        }

        .time-up-banner {
            background: linear-gradient(135deg, var(--danger), #c82333);
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 18px;
            font-weight: 600;
            animation: slideDown 0.5s ease;
        }

        @keyframes slideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header.bg-success {
            background: linear-gradient(135deg, var(--success), #20c997);
            color: white;
        }

        .modal-header.bg-danger {
            background: linear-gradient(135deg, var(--danger), #c82333);
            color: white;
        }

        .saved-indicator {
            position: fixed;
            bottom: 80px;
            right: 20px;
            background: var(--success);
            color: white;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 14px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            z-index: 1000;
            animation: fadeInOut 2s ease;
        }

        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateY(20px); }
            15% { opacity: 1; transform: translateY(0); }
            85% { opacity: 1; transform: translateY(0); }
            100% { opacity: 0; transform: translateY(-20px); }
        }

        @media (max-width: 768px) {
            .test-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .test-footer {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .progress-info {
                flex-direction: column;
                gap: 10px;
            }
            
            .timer-corner {
                font-size: 28px;
                padding: 8px 15px;
            }
        }
    </style>
</head>
<body>
    <%
        // Check if student is logged in
        if (session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }
    %>

    <input type="hidden" id="attemptId" value="${attempt.attemptId}">
    <input type="hidden" id="contentId" value="${attempt.contentId}">
    <input type="hidden" id="totalQuestions" value="${totalQuestions}">

    <div class="test-container">
        <!-- Test Header with Timer at Right Corner -->
        <div class="test-header">
            <div>
                <h2><i class="fas fa-pencil-alt me-2"></i>${attempt.contentTitle}</h2>
                <p class="mb-0">${totalQuestions} Questions · 1 minute per question</p>
            </div>
            <div class="timer-corner" id="timerContainer">
                <span id="timeDisplay">60</span>
            </div>
        </div>
        
        <!-- Progress Bar -->
        <div class="progress-bar-container mb-3">
            <div class="progress-bar-fill" id="progressBar" style="width: 0%"></div>
        </div>

        <!-- Time Up Banner (Initially Hidden) -->
        <div id="timeUpBanner" class="time-up-banner" style="display: none;">
            <i class="fas fa-clock me-2"></i> Time's up! Your test is being submitted automatically...
        </div>

        <!-- Questions -->
        <form id="testForm">
            <c:forEach var="question" items="${questions}" varStatus="status">
                <div class="question-card" id="question-${question.id}" data-qid="${question.id}">
                    <div class="question-number">Question ${status.index + 1}</div>
                    <div class="question-text">${question.questionText}</div>
                    
                    <div class="options-container">
                        <div class="option-item" onclick="selectOption(${question.id}, 'A')">
                            <span class="option-prefix">A</span>
                            <span class="option-text">${question.optionA}</span>
                        </div>
                        
                        <div class="option-item" onclick="selectOption(${question.id}, 'B')">
                            <span class="option-prefix">B</span>
                            <span class="option-text">${question.optionB}</span>
                        </div>
                        
                        <div class="option-item" onclick="selectOption(${question.id}, 'C')">
                            <span class="option-prefix">C</span>
                            <span class="option-text">${question.optionC}</span>
                        </div>
                        
                        <div class="option-item" onclick="selectOption(${question.id}, 'D')">
                            <span class="option-prefix">D</span>
                            <span class="option-text">${question.optionD}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </form>

        <!-- Footer -->
        <div class="test-footer">
            <div class="progress-info">
                <span class="question-counter">
                    <i class="fas fa-check-circle me-2" style="color: var(--success);"></i>
                    <span id="answeredCount">0</span>/${totalQuestions} Answered
                </span>
                <span class="text-muted">
                    <i class="fas fa-clock me-1"></i>
                    <span id="timeRemaining">${totalQuestions}</span> min left
                </span>
            </div>
            <button class="btn-submit" onclick="showSubmitModal()" id="submitBtn">
                <i class="fas fa-check-circle me-2"></i>Submit Test
            </button>
        </div>
    </div>

    <!-- Submit Confirmation Modal -->
    <div class="modal fade" id="submitModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="fas fa-check-circle me-2"></i>Submit Test</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to submit your test?</p>
                    <p class="text-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        You cannot change your answers after submission.
                    </p>
                    <div class="alert alert-info">
                        <strong>Progress:</strong> <span id="modalAnsweredCount">0</span>/${totalQuestions} questions answered
                        (<span id="modalPercentage">0</span>%)
                    </div>
                    <p><strong>Time remaining:</strong> <span id="modalTimeRemaining">60</span> seconds</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Review Answers</button>
                    <button type="button" class="btn btn-success" onclick="confirmSubmit()" id="confirmSubmitBtn">
                        <i class="fas fa-check me-2"></i>Yes, Submit
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Auto Submit Modal (Time's Up) -->
    <div class="modal fade" id="autoSubmitModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="fas fa-clock me-2"></i>Time's Up!</h5>
                </div>
                <div class="modal-body text-center py-4">
                    <i class="fas fa-hourglass-end fa-4x text-danger mb-3"></i>
                    <h4>Your test time has expired</h4>
                    <p>Your answers are being submitted automatically.</p>
                    <div class="spinner-border text-danger mt-3" role="status">
                        <span class="visually-hidden">Submitting...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Loading Modal -->
    <div class="modal fade" id="loadingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body text-center p-4">
                    <div class="spinner-border text-primary mb-3" style="width: 3rem; height: 3rem;" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <h5>Submitting your test...</h5>
                    <p class="text-muted">Please wait while we process your answers.</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        const API_BASE = '${pageContext.request.contextPath}';
        const MCQ_API = API_BASE + '/api/mcq';
        const attemptId = document.getElementById('attemptId').value;
        const totalQuestions = parseInt(document.getElementById('totalQuestions').value);
        
        // Calculate total time: 1 minute per question = totalQuestions minutes in seconds
        const totalTime = totalQuestions * 60; // in seconds
        let timeLeft = totalTime;
        let answers = {};
        let answeredCount = 0;
        let timerInterval;
        let autoSubmitTriggered = false;

        // DOM Elements
        const timerDisplay = document.getElementById('timeDisplay');
        const timerContainer = document.getElementById('timerContainer');
        const timeRemainingSpan = document.getElementById('timeRemaining');
        const progressBar = document.getElementById('progressBar');
        const timeUpBanner = document.getElementById('timeUpBanner');
        
        // Load saved answers from localStorage (if any)
        loadSavedAnswers();
        
        // Start the timer
        startTimer();
        
        // Update progress bar
        updateProgressBar();

        function startTimer() {
            timerInterval = setInterval(function() {
                if (timeLeft <= 0) {
                    // Time's up - auto submit
                    if (!autoSubmitTriggered) {
                        autoSubmitTriggered = true;
                        clearInterval(timerInterval);
                        autoSubmitTest();
                    }
                    return;
                }
                
                timeLeft--;
                updateTimerDisplay();
                updateTimerStyle();
                
                // Auto-save answers every 30 seconds
                if (timeLeft % 30 === 0) {
                    saveAnswersLocally();
                }
                
            }, 1000);
        }

        function updateTimerDisplay() {
            // Show just seconds (60, 59, 58, etc.)
            timerDisplay.textContent = timeLeft;
            
            // Update minutes remaining text
            const minutesLeft = Math.ceil(timeLeft / 60);
            timeRemainingSpan.textContent = minutesLeft;
            
            // Update modal time if open
            const modalTime = document.getElementById('modalTimeRemaining');
            if (modalTime) {
                modalTime.textContent = timeLeft;
            }
        }

        function updateTimerStyle() {
            // Remove existing classes
            timerContainer.classList.remove('timer-warning', 'timer-critical');
            
            // Add appropriate class based on time left
            const secondsLeft = timeLeft;
            
            if (secondsLeft <= 60) {
                // Last minute - critical
                timerContainer.classList.add('timer-critical');
            } else if (secondsLeft <= 300) {
                // Last 5 minutes (300 seconds) - warning
                timerContainer.classList.add('timer-warning');
            }
        }

        function updateProgressBar() {
            const percentage = (answeredCount / totalQuestions) * 100;
            progressBar.style.width = percentage + '%';
        }

        function selectOption(questionId, option) {
            const questionElement = document.getElementById('question-' + questionId);
            const options = questionElement.querySelectorAll('.option-item');
            
            // Check if this question was previously answered
            const wasAnswered = answers.hasOwnProperty(questionId);
            
            // Remove selected class from all options
            options.forEach(opt => {
                opt.classList.remove('selected');
            });
            
            // Add selected class to clicked option
            const selectedOption = Array.from(options).find(opt => 
                opt.querySelector('.option-prefix').textContent === option
            );
            
            if (selectedOption) {
                selectedOption.classList.add('selected');
            }
            
            // Store answer
            answers[questionId] = option;
            
            // Update answered count
            if (!wasAnswered) {
                answeredCount++;
                questionElement.classList.add('answered');
            }
            
            // Update UI
            document.getElementById('answeredCount').textContent = answeredCount;
            updateProgressBar();
            
            // Auto-save after each answer
            saveAnswersLocally();
        }

        function loadSavedAnswers() {
            try {
                const saved = localStorage.getItem('test_answers_' + attemptId);
                if (saved) {
                    const savedData = JSON.parse(saved);
                    
                    // Check if saved data is from this session (within last hour)
                    if (savedData.timestamp && (Date.now() - savedData.timestamp < 3600000)) {
                        answers = savedData.answers || {};
                        answeredCount = Object.keys(answers).length;
                        
                        // Restore selected options in UI
                        Object.keys(answers).forEach(questionId => {
                            const option = answers[questionId];
                            const questionElement = document.getElementById('question-' + questionId);
                            if (questionElement) {
                                const options = questionElement.querySelectorAll('.option-item');
                                const selectedOption = Array.from(options).find(opt => 
                                    opt.querySelector('.option-prefix').textContent === option
                                );
                                if (selectedOption) {
                                    selectedOption.classList.add('selected');
                                    questionElement.classList.add('answered');
                                }
                            }
                        });
                        
                        document.getElementById('answeredCount').textContent = answeredCount;
                        console.log('Loaded saved answers:', answeredCount);
                    }
                }
            } catch (e) {
                console.log('No saved answers found');
            }
        }

        function saveAnswersLocally() {
            const saveData = {
                answers: answers,
                timestamp: Date.now(),
                answeredCount: answeredCount
            };
            localStorage.setItem('test_answers_' + attemptId, JSON.stringify(saveData));
            
            // Show saved indicator
            showSavedIndicator();
        }

        function showSavedIndicator() {
            // Remove existing indicator
            const existing = document.querySelector('.saved-indicator');
            if (existing) existing.remove();
            
            // Create new indicator
            const indicator = document.createElement('div');
            indicator.className = 'saved-indicator';
            indicator.innerHTML = '<i class="fas fa-check-circle me-2"></i>Progress saved';
            document.body.appendChild(indicator);
            
            // Remove after 2 seconds
            setTimeout(() => {
                if (indicator && indicator.parentNode) {
                    indicator.remove();
                }
            }, 2000);
        }

        function showSubmitModal() {
            // Update modal with current stats
            document.getElementById('modalAnsweredCount').textContent = answeredCount;
            const percentage = Math.round((answeredCount / totalQuestions) * 100);
            document.getElementById('modalPercentage').textContent = percentage;
            document.getElementById('modalTimeRemaining').textContent = timeLeft;
            
            // Show modal
            const submitModal = new bootstrap.Modal(document.getElementById('submitModal'));
            submitModal.show();
        }

        async function confirmSubmit() {
            // Hide confirmation modal
            bootstrap.Modal.getInstance(document.getElementById('submitModal')).hide();
            
            // Clear timer
            clearInterval(timerInterval);
            
            // Submit test
            await submitTest();
        }

        async function autoSubmitTest() {
            // Show time's up banner
            timeUpBanner.style.display = 'block';
            
            // Show auto submit modal
            const autoSubmitModal = new bootstrap.Modal(document.getElementById('autoSubmitModal'));
            autoSubmitModal.show();
            
            // Submit test after a short delay
            setTimeout(async () => {
                await submitTest();
            }, 2000);
        }

        async function submitTest() {
            // Show loading modal
            const loadingModal = new bootstrap.Modal(document.getElementById('loadingModal'));
            loadingModal.show();
            
            try {
                const response = await fetch(MCQ_API + '/submit', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        attemptId: attemptId,
                        answers: answers
                    })
                });
                
                const data = await response.json();
                
                // Hide loading modal
                loadingModal.hide();
                
                if (data.success) {
                    // Clear saved answers
                    localStorage.removeItem('test_answers_' + attemptId);
                    
                    // Redirect to results page
                    window.location.href = MCQ_API + '/result/' + attemptId;
                } else {
                    alert('Error submitting test: ' + data.message);
                }
                
            } catch (error) {
                console.error('Error submitting test:', error);
                loadingModal.hide();
                alert('Failed to submit test. Please try again.');
            }
        }

        // Warn user about leaving the page
        window.addEventListener('beforeunload', function(e) {
            if (answeredCount > 0 && !autoSubmitTriggered) {
                e.preventDefault();
                e.returnValue = 'You have unanswered questions. Are you sure you want to leave? Your progress will be lost.';
            }
        });

        // Save answers before page unload
        window.addEventListener('pagehide', function() {
            if (answeredCount > 0) {
                saveAnswersLocally();
            }
        });
    </script>
</body>
</html>