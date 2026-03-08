<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JavaScript Quiz | EduEra</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    /* Same CSS structure as previous quizzes - only changing colors for variety */
    :root {
      --primary-blue: #003b8e;
      --dark-blue: #001f54;
      --light-blue: #82e3f6;
      --success-green: #22a65b;
      --warning-orange: #ff9203;
      --danger-red: #dc3545;
      --light-bg: #f8fafc;
      --card-bg: #ffffff;
      --text-dark: #1f2937;
      --text-light: #6b7280;
      --border-color: #e5e7eb;
      --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
      --radius: 12px;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
      color: var(--text-dark);
      min-height: 100vh;
    }

    .quiz-header {
      background: linear-gradient(135deg, var(--primary-blue), var(--dark-blue));
      color: white;
      padding: 25px 0;
      box-shadow: var(--shadow);
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .header-content {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    .quiz-title {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .quiz-subtitle {
      font-size: 16px;
      opacity: 0.9;
      line-height: 1.5;
    }

    .progress-container {
      max-width: 1200px;
      margin: 25px auto 0;
      padding: 0 20px;
    }

    .progress-info {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
      font-size: 14px;
      color: var(--text-dark);
    }

    .progress-bar {
      height: 8px;
      background: #e5e7eb;
      border-radius: 4px;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, var(--primary-blue), var(--light-blue));
      width: 0%;
      transition: width 0.3s ease;
      border-radius: 4px;
    }

    .main-container {
      max-width: 1200px;
      margin: 30px auto;
      padding: 0 20px;
      display: grid;
      grid-template-columns: 1fr 300px;
      gap: 30px;
    }

    .question-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      padding: 30px;
      box-shadow: var(--shadow);
      margin-bottom: 20px;
    }

    .question-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 25px;
      padding-bottom: 15px;
      border-bottom: 1px solid var(--border-color);
    }

    .question-number {
      background: var(--primary-blue);
      color: white;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      font-weight: 700;
    }

    .timer {
      background: #fff3cd;
      color: #856404;
      padding: 8px 16px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .timer.warning {
      background: #f8d7da;
      color: #721c24;
    }

    .question-text {
      font-size: 20px;
      font-weight: 600;
      line-height: 1.6;
      margin-bottom: 25px;
      color: var(--text-dark);
    }

    .options-container {
      display: grid;
      grid-template-columns: 1fr;
      gap: 12px;
      margin-bottom: 30px;
    }

    .option {
      padding: 18px 20px;
      border: 2px solid var(--border-color);
      border-radius: 10px;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .option:hover {
      background: #f8fafc;
      border-color: var(--primary-blue);
      transform: translateY(-2px);
      box-shadow: var(--shadow);
    }

    .option.selected {
      background: #e0f2fe;
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 3px rgba(0, 59, 142, 0.1);
    }

    .option.correct {
      background: #d1fae5;
      border-color: var(--success-green);
    }

    .option.incorrect {
      background: #fee2e2;
      border-color: var(--danger-red);
    }

    .option-letter {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      background: #f3f4f6;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      color: var(--text-dark);
      flex-shrink: 0;
    }

    .option.selected .option-letter {
      background: var(--primary-blue);
      color: white;
    }

    .option-text {
      flex: 1;
      font-size: 16px;
      line-height: 1.5;
    }

    .nav-controls {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid var(--border-color);
    }

    .nav-btn {
      padding: 12px 28px;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 16px;
    }

    .btn-prev {
      background: #f3f4f6;
      color: var(--text-dark);
    }

    .btn-prev:hover {
      background: #e5e7eb;
      transform: translateX(-2px);
    }

    .btn-next {
      background: var(--primary-blue);
      color: white;
    }

    .btn-next:hover {
      background: var(--dark-blue);
      transform: translateX(2px);
      box-shadow: 0 4px 12px rgba(0, 59, 142, 0.2);
    }

    .btn-submit {
      background: var(--success-green);
      color: white;
    }

    .btn-submit:hover {
      background: #1a9550;
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(34, 166, 91, 0.2);
    }

    .sidebar {
      position: sticky;
      top: 120px;
      height: fit-content;
    }

    .sidebar-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      padding: 25px;
      box-shadow: var(--shadow);
      margin-bottom: 20px;
    }

    .sidebar-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 20px;
      color: var(--primary-blue);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .question-grid {
      display: grid;
      grid-template-columns: repeat(5, 1fr);
      gap: 10px;
    }

    .grid-item {
      width: 100%;
      aspect-ratio: 1;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s ease;
      background: #f3f4f6;
      border: 2px solid #e5e7eb;
    }

    .grid-item:hover {
      background: #e5e7eb;
      transform: scale(1.05);
    }

    .grid-item.answered {
      background: var(--primary-blue);
      color: white;
      border-color: var(--primary-blue);
    }

    .grid-item.current {
      background: var(--warning-orange);
      color: white;
      border-color: var(--warning-orange);
      box-shadow: 0 0 0 3px rgba(255, 146, 3, 0.2);
    }

    .grid-item.marked {
      background: #fef3c7;
      color: #92400e;
      border-color: #f59e0b;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 15px;
      margin-bottom: 20px;
    }

    .stat-item {
      text-align: center;
      padding: 15px;
      border-radius: 8px;
      background: #f8fafc;
    }

    .stat-value {
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 5px;
    }

    .stat-label {
      font-size: 12px;
      color: var(--text-light);
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .action-buttons {
      display: grid;
      grid-template-columns: 1fr;
      gap: 12px;
    }

    .action-btn {
      padding: 12px;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .btn-clear {
      background: #f3f4f6;
      color: var(--text-dark);
    }

    .btn-clear:hover {
      background: #e5e7eb;
    }

    .btn-review {
      background: #e0f2fe;
      color: var(--primary-blue);
    }

    .btn-review:hover {
      background: #bae6fd;
    }

    .modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
      z-index: 1000;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .modal-content {
      background: white;
      width: 100%;
      max-width: 500px;
      border-radius: var(--radius);
      overflow: hidden;
      animation: modalSlide 0.3s ease;
    }

    @keyframes modalSlide {
      from { transform: translateY(-20px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .modal-header {
      background: var(--primary-blue);
      color: white;
      padding: 25px;
      text-align: center;
    }

    .modal-header h2 {
      font-size: 24px;
      margin-bottom: 8px;
    }

    .modal-body {
      padding: 30px;
      text-align: center;
    }

    .modal-score {
      font-size: 48px;
      font-weight: 800;
      color: var(--primary-blue);
      margin: 20px 0;
    }

    .modal-stats {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 15px;
      margin: 25px 0;
    }

    .modal-stat {
      padding: 15px;
      border-radius: 8px;
      background: #f8fafc;
    }

    .modal-stat-value {
      font-size: 24px;
      font-weight: 700;
      color: var(--primary-blue);
    }

    .modal-stat-label {
      font-size: 13px;
      color: var(--text-light);
      margin-top: 5px;
    }

    .modal-actions {
      display: flex;
      gap: 15px;
      margin-top: 25px;
    }

    .modal-btn {
      flex: 1;
      padding: 14px;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .modal-btn-primary {
      background: var(--primary-blue);
      color: white;
    }

    .modal-btn-primary:hover {
      background: var(--dark-blue);
    }

    .modal-btn-secondary {
      background: #f3f4f6;
      color: var(--text-dark);
    }

    .modal-btn-secondary:hover {
      background: #e5e7eb;
    }

    @media (max-width: 992px) {
      .main-container {
        grid-template-columns: 1fr;
      }
      
      .sidebar {
        position: static;
        margin-top: 30px;
      }
    }

    @media (max-width: 768px) {
      .quiz-title {
        font-size: 24px;
      }
      
      .question-text {
        font-size: 18px;
      }
      
      .question-grid {
        grid-template-columns: repeat(4, 1fr);
      }
      
      .nav-controls {
        flex-direction: column;
        gap: 15px;
      }
      
      .nav-btn {
        width: 100%;
        justify-content: center;
      }
    }

    @media (max-width: 480px) {
      .question-grid {
        grid-template-columns: repeat(3, 1fr);
      }
      
      .stats-grid {
        grid-template-columns: 1fr;
      }
      
      .modal-actions {
        flex-direction: column;
      }
      
      .modal-btn {
        width: 100%;
      }
    }
  </style>
</head>

<body>
  <header class="quiz-header">
    <div class="header-content">
      <h1 class="quiz-title">
        <i class="fab fa-js"></i>
        JavaScript Quiz
      </h1>
      <p class="quiz-subtitle">
        Test your knowledge with 25 multiple choice questions. Time limit: 30 minutes.
      </p>
    </div>
    
    <div class="progress-container">
      <div class="progress-info">
        <span>Progress: <span id="progressText">0/25</span></span>
        <span>Time: <span id="timerDisplay">30:00</span></span>
      </div>
      <div class="progress-bar">
        <div class="progress-fill" id="progressFill"></div>
      </div>
    </div>
  </header>

  <main class="main-container">
    <div class="question-section">
      <div class="question-card">
        <div class="question-header">
          <div class="question-number" id="currentQuestionNumber">1</div>
          <div class="timer" id="timer">
            <i class="fas fa-clock"></i>
            <span id="timeLeft">30:00</span>
          </div>
        </div>
        
        <div class="question-text" id="questionText"></div>
        
        <div class="options-container" id="optionsContainer"></div>
        
        <div class="nav-controls">
          <button class="nav-btn btn-prev" id="prevBtn">
            <i class="fas fa-arrow-left"></i>
            Previous
          </button>
          <button class="nav-btn btn-next" id="nextBtn">
            Next
            <i class="fas fa-arrow-right"></i>
          </button>
          <button class="nav-btn btn-submit" id="submitBtn" style="display: none;">
            <i class="fas fa-paper-plane"></i>
            Submit Quiz
          </button>
        </div>
      </div>
    </div>

    <aside class="sidebar">
      <div class="sidebar-card">
        <h3 class="sidebar-title">
          <i class="fas fa-list-ol"></i>
          Question Navigation
        </h3>
        <div class="question-grid" id="questionGrid"></div>
      </div>

      <div class="sidebar-card">
        <h3 class="sidebar-title">
          <i class="fas fa-chart-bar"></i>
          Quiz Statistics
        </h3>
        <div class="stats-grid">
          <div class="stat-item">
            <div class="stat-value" id="answeredCount">0</div>
            <div class="stat-label">Answered</div>
          </div>
          <div class="stat-item">
            <div class="stat-value" id="remainingCount">25</div>
            <div class="stat-label">Remaining</div>
          </div>
          <div class="stat-item">
            <div class="stat-value" id="markedCount">0</div>
            <div class="stat-label">Marked</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">25</div>
            <div class="stat-label">Total</div>
          </div>
        </div>
      </div>

      <div class="sidebar-card">
        <h3 class="sidebar-title">
          <i class="fas fa-cogs"></i>
          Actions
        </h3>
        <div class="action-buttons">
          <button class="action-btn btn-clear" id="clearBtn">
            <i class="fas fa-eraser"></i>
            Clear Answers
          </button>
          <button class="action-btn btn-review" id="reviewBtn">
            <i class="fas fa-flag"></i>
            Mark for Review
          </button>
          <button class="action-btn btn-submit" id="sidebarSubmitBtn">
            <i class="fas fa-paper-plane"></i>
            Submit Quiz
          </button>
        </div>
      </div>
    </aside>
  </main>

  <div class="modal" id="resultsModal">
    <div class="modal-content">
      <div class="modal-header">
        <h2><i class="fas fa-trophy"></i> Quiz Completed!</h2>
        <p>Your results are ready</p>
      </div>
      <div class="modal-body">
        <div class="modal-score" id="finalScore">0/25</div>
        <div class="modal-stats">
          <div class="modal-stat">
            <div class="modal-stat-value" id="correctCount">0</div>
            <div class="modal-stat-label">Correct</div>
          </div>
          <div class="modal-stat">
            <div class="modal-stat-value" id="incorrectCount">0</div>
            <div class="modal-stat-label">Incorrect</div>
          </div>
          <div class="modal-stat">
            <div class="modal-stat-value" id="accuracyRate">0%</div>
            <div class="modal-stat-label">Accuracy</div>
          </div>
          <div class="modal-stat">
            <div class="modal-stat-value" id="timeTaken">0:00</div>
            <div class="modal-stat-label">Time Taken</div>
          </div>
        </div>
        <div class="modal-actions">
          <button class="modal-btn modal-btn-secondary" id="reviewAnswersBtn">
            <i class="fas fa-chart-bar"></i>
            Review Answers
          </button>
          <button class="modal-btn modal-btn-primary" id="viewResultsBtn">
            <i class="fas fa-external-link-alt"></i>
            View Detailed Results
          </button>
        </div>
      </div>
    </div>
  </div>

  <script>
    const questions = [
      {
        question: "Which of the following is NOT a JavaScript data type?",
        options: ["Number", "String", "Boolean", "Float"],
        correct: 3,
        explanation: "JavaScript has Number (includes float), String, Boolean, Object, etc., but not separate Float type."
      },
      {
        question: "What is the result of: console.log(typeof null)?",
        options: ["'null'", "'object'", "'undefined'", "Error"],
        correct: 1,
        explanation: "typeof null returns 'object' (known JavaScript quirk)."
      },
      {
        question: "Which keyword is used to declare a variable in ES6?",
        options: ["var", "let", "const", "All of these"],
        correct: 3,
        explanation: "ES6 introduced let and const, while var existed before."
      },
      {
        question: "What does the '===' operator do?",
        options: ["Checks equality without type conversion", "Checks equality with type conversion", "Assigns value", "Compares types only"],
        correct: 0,
        explanation: "'===' checks strict equality (value and type)."
      },
      {
        question: "Which is used to convert string to number?",
        options: ["parseInt()", "parseFloat()", "Number()", "All of these"],
        correct: 3,
        explanation: "All can convert strings to numbers."
      },
      {
        question: "What is closure in JavaScript?",
        options: ["Function with access to outer scope", "Closed function", "Private method", "Async function"],
        correct: 0,
        explanation: "Closure gives function access to its outer lexical scope."
      },
      {
        question: "Which method adds elements to end of array?",
        options: ["push()", "pop()", "shift()", "unshift()"],
        correct: 0,
        explanation: "push() adds elements to end, returns new length."
      },
      {
        question: "What is hoisting in JavaScript?",
        options: ["Moving declarations to top", "Lifting variables", "Function elevation", "Variable promotion"],
        correct: 0,
        explanation: "Hoisting moves variable and function declarations to top."
      },
      {
        question: "Which is NOT a JavaScript framework?",
        options: ["React", "Angular", "Vue", "Django"],
        correct: 3,
        explanation: "Django is Python framework."
      },
      {
        question: "What does JSON stand for?",
        options: ["JavaScript Object Notation", "JavaScript Online Network", "JSON Object Notation", "JavaScript Oriented Notation"],
        correct: 0,
        explanation: "JSON = JavaScript Object Notation."
      },
      {
        question: "Which keyword creates a promise?",
        options: ["new Promise()", "Promise()", "createPromise()", "promise()"],
        correct: 0,
        explanation: "new Promise(executor) creates a promise."
      },
      {
        question: "What is event bubbling?",
        options: ["Events propagate upward", "Events propagate downward", "Multiple events", "Event queue"],
        correct: 0,
        explanation: "Event bubbling: events propagate from target to root."
      },
      {
        question: "Which method is used for HTTP requests?",
        options: ["fetch()", "XMLHttpRequest", "axios()", "All of these"],
        correct: 3,
        explanation: "All can make HTTP requests."
      },
      {
        question: "What is the purpose of 'this' keyword?",
        options: ["Refers to current object", "Refers to parent object", "Refers to global object", "Depends on context"],
        correct: 3,
        explanation: "'this' depends on how function is called."
      },
      {
        question: "Which is used for async/await?",
        options: ["Promise-based syntax", "Callback syntax", "Generator syntax", "Event syntax"],
        correct: 0,
        explanation: "async/await is syntactic sugar over promises."
      },
      {
        question: "What does DOM stand for?",
        options: ["Document Object Model", "Data Object Model", "Document Oriented Model", "Display Object Model"],
        correct: 0,
        explanation: "DOM = Document Object Model."
      },
      {
        question: "Which method creates a new array?",
        options: ["map()", "filter()", "reduce()", "All of these"],
        correct: 3,
        explanation: "All return new arrays (except reduce returns single value)."
      },
      {
        question: "What is arrow function syntax?",
        options: ["() => {}", "function() {}", "=>()", "->{}"],
        correct: 0,
        explanation: "Arrow functions use () => {} syntax."
      },
      {
        question: "Which stores data locally in browser?",
        options: ["localStorage", "sessionStorage", "Cookies", "All of these"],
        correct: 3,
        explanation: "All store data in browser with different scopes/lifetimes."
      },
      {
        question: "What is CORS?",
        options: ["Cross-Origin Resource Sharing", "Cross-Origin Request Security", "Cross-Origin Response Sharing", "Cross-Origin Restriction Security"],
        correct: 0,
        explanation: "CORS = Cross-Origin Resource Sharing."
      },
      {
        question: "Which is NOT a JavaScript runtime?",
        options: ["Node.js", "Deno", "Bun", "JVM"],
        correct: 3,
        explanation: "JVM is Java Virtual Machine."
      },
      {
        question: "What does 'use strict' do?",
        options: ["Enables strict mode", "Disables strict mode", "Optimizes code", "Enables ES6"],
        correct: 0,
        explanation: "'use strict' enables strict mode for safer code."
      },
      {
        question: "Which handles errors in JavaScript?",
        options: ["try-catch", "throw", "finally", "All of these"],
        correct: 3,
        explanation: "All are part of error handling."
      },
      {
        question: "What is prototype in JavaScript?",
        options: ["Mechanism for inheritance", "Object template", "Class blueprint", "Function property"],
        correct: 0,
        explanation: "Prototypes enable inheritance in JavaScript."
      },
      {
        question: "Which is used for module imports in ES6?",
        options: ["import", "require", "include", "Both A and B"],
        correct: 3,
        explanation: "ES6 uses import, CommonJS uses require."
      }
    ];

    let currentQuestion = 0;
    let answers = new Array(questions.length).fill(null);
    let markedQuestions = new Set();
    let startTime = Date.now();
    let timeLimit = 30 * 60;
    let timerInterval;

    const questionText = document.getElementById('questionText');
    const optionsContainer = document.getElementById('optionsContainer');
    const questionGrid = document.getElementById('questionGrid');
    const currentQuestionNumber = document.getElementById('currentQuestionNumber');
    const progressText = document.getElementById('progressText');
    const progressFill = document.getElementById('progressFill');
    const answeredCount = document.getElementById('answeredCount');
    const remainingCount = document.getElementById('remainingCount');
    const markedCount = document.getElementById('markedCount');
    const timerDisplay = document.getElementById('timerDisplay');
    const timeLeft = document.getElementById('timeLeft');
    const timer = document.getElementById('timer');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');
    const sidebarSubmitBtn = document.getElementById('sidebarSubmitBtn');
    const clearBtn = document.getElementById('clearBtn');
    const reviewBtn = document.getElementById('reviewBtn');
    const resultsModal = document.getElementById('resultsModal');
    const finalScore = document.getElementById('finalScore');
    const correctCount = document.getElementById('correctCount');
    const incorrectCount = document.getElementById('incorrectCount');
    const accuracyRate = document.getElementById('accuracyRate');
    const timeTaken = document.getElementById('timeTaken');
    const reviewAnswersBtn = document.getElementById('reviewAnswersBtn');
    const viewResultsBtn = document.getElementById('viewResultsBtn');

    function initQuiz() {
      loadQuestion(currentQuestion);
      generateQuestionGrid();
      startTimer();
      updateStats();
      updateProgress();
      localStorage.setItem('currentQuiz', 'javascript');
    }

    function loadQuestion(index) {
      const question = questions[index];
      currentQuestionNumber.textContent = index + 1;
      questionText.textContent = question.question;
      optionsContainer.innerHTML = '';
      
      question.options.forEach(function(option, i) {
        const optionElement = document.createElement('div');
        optionElement.className = 'option';
        if (answers[index] === i) {
          optionElement.classList.add('selected');
        }
        optionElement.innerHTML = '<div class="option-letter">' + String.fromCharCode(65 + i) + '</div><div class="option-text">' + option + '</div>';
        optionElement.addEventListener('click', function() {
          selectOption(i);
        });
        optionsContainer.appendChild(optionElement);
      });
      
      updateQuestionGrid();
      prevBtn.style.display = index === 0 ? 'none' : 'flex';
      nextBtn.style.display = index === questions.length - 1 ? 'none' : 'flex';
      submitBtn.style.display = index === questions.length - 1 ? 'flex' : 'none';
      updateReviewButton();
    }

    function updateReviewButton() {
      if (markedQuestions.has(currentQuestion)) {
        reviewBtn.innerHTML = '<i class="fas fa-flag-checkered"></i> Remove Mark';
      } else {
        reviewBtn.innerHTML = '<i class="fas fa-flag"></i> Mark for Review';
      }
    }

    function selectOption(optionIndex) {
      answers[currentQuestion] = optionIndex;
      const options = document.querySelectorAll('.option');
      options.forEach(function(opt, i) {
        opt.classList.remove('selected');
        if (i === optionIndex) {
          opt.classList.add('selected');
        }
      });
      updateStats();
      updateProgress();
      updateQuestionGrid();
    }

    function generateQuestionGrid() {
      questionGrid.innerHTML = '';
      questions.forEach(function(_, i) {
        const gridItem = document.createElement('div');
        gridItem.className = 'grid-item';
        if (i === currentQuestion) {
          gridItem.classList.add('current');
        }
        if (answers[i] !== null) {
          gridItem.classList.add('answered');
        }
        if (markedQuestions.has(i)) {
          gridItem.classList.add('marked');
        }
        gridItem.textContent = i + 1;
        gridItem.addEventListener('click', function() {
          jumpToQuestion(i);
        });
        questionGrid.appendChild(gridItem);
      });
    }

    function updateQuestionGrid() {
      const gridItems = document.querySelectorAll('.grid-item');
      gridItems.forEach(function(item, i) {
        item.classList.remove('current', 'answered', 'marked');
        if (i === currentQuestion) {
          item.classList.add('current');
        }
        if (answers[i] !== null) {
          item.classList.add('answered');
        }
        if (markedQuestions.has(i)) {
          item.classList.add('marked');
        }
      });
    }

    function jumpToQuestion(index) {
      currentQuestion = index;
      loadQuestion(currentQuestion);
    }

    function updateStats() {
      const answered = answers.filter(function(a) {
        return a !== null;
      }).length;
      const remaining = questions.length - answered;
      answeredCount.textContent = answered;
      remainingCount.textContent = remaining;
      markedCount.textContent = markedQuestions.size;
    }

    function updateProgress() {
      const answered = answers.filter(function(a) {
        return a !== null;
      }).length;
      const progress = (answered / questions.length) * 100;
      progressText.textContent = answered + '/' + questions.length;
      progressFill.style.width = progress + '%';
    }

    function startTimer() {
      updateTimerDisplay();
      timerInterval = setInterval(updateTimerDisplay, 1000);
    }

    function updateTimerDisplay() {
      const elapsed = Math.floor((Date.now() - startTime) / 1000);
      const remaining = Math.max(0, timeLimit - elapsed);
      const minutes = Math.floor(remaining / 60);
      const seconds = remaining % 60;
      const timeString = minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');
      timerDisplay.textContent = timeString;
      timeLeft.textContent = timeString;
      
      if (remaining < 300) {
        timer.classList.add('warning');
      }
      
      if (remaining === 0) {
        clearInterval(timerInterval);
        submitQuiz();
      }
    }

    prevBtn.addEventListener('click', function() {
      if (currentQuestion > 0) {
        currentQuestion--;
        loadQuestion(currentQuestion);
      }
    });

    nextBtn.addEventListener('click', function() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        loadQuestion(currentQuestion);
      }
    });

    clearBtn.addEventListener('click', function() {
      if (confirm('Are you sure you want to clear all answers?')) {
        answers.fill(null);
        markedQuestions.clear();
        loadQuestion(currentQuestion);
        updateStats();
        updateProgress();
      }
    });

    reviewBtn.addEventListener('click', function() {
      if (markedQuestions.has(currentQuestion)) {
        markedQuestions.delete(currentQuestion);
        reviewBtn.innerHTML = '<i class="fas fa-flag"></i> Mark for Review';
      } else {
        markedQuestions.add(currentQuestion);
        reviewBtn.innerHTML = '<i class="fas fa-flag-checkered"></i> Remove Mark';
      }
      updateQuestionGrid();
      updateStats();
    });

    function submitQuiz() {
      clearInterval(timerInterval);
      let correct = 0;
      let incorrect = 0;
      let unanswered = 0;
      
      answers.forEach(function(answer, i) {
        if (answer === null) {
          unanswered++;
        } else if (answer === questions[i].correct) {
          correct++;
        } else {
          incorrect++;
        }
      });
      
      const accuracy = Math.round((correct / questions.length) * 100);
      const elapsed = Math.floor((Date.now() - startTime) / 1000);
      const minutes = Math.floor(elapsed / 60);
      const seconds = elapsed % 60;
      const timeString = minutes + ':' + seconds.toString().padStart(2, '0');
      
      finalScore.textContent = correct + '/' + questions.length;
      correctCount.textContent = correct;
      incorrectCount.textContent = incorrect;
      accuracyRate.textContent = accuracy + '%';
      timeTaken.textContent = timeString;
      
      const results = {
        subject: 'JavaScript',
        score: correct,
        total: questions.length,
        answers: answers.slice(),
        questions: questions.map(function(q, i) {
          return {
            question: q.question,
            options: q.options,
            correct: q.correct,
            selected: answers[i],
            explanation: q.explanation
          };
        }),
        timeSpent: elapsed,
        timestamp: new Date().toISOString()
      };
      
      localStorage.setItem('quizResults', JSON.stringify(results));
      resultsModal.style.display = 'flex';
    }

    submitBtn.addEventListener('click', submitQuiz);
    sidebarSubmitBtn.addEventListener('click', submitQuiz);

    viewResultsBtn.addEventListener('click', function() {
      window.location.href = '/quiz-results';
    });

    reviewAnswersBtn.addEventListener('click', function() {
      resultsModal.style.display = 'none';
      currentQuestion = 0;
      loadQuestion(currentQuestion);
      
      const options = document.querySelectorAll('.option');
      questions.forEach(function(q, i) {
        if (answers[i] !== null) {
          const currentOptions = document.querySelectorAll('.option');
          if (answers[i] === q.correct) {
            currentOptions[answers[i]].classList.add('correct');
          } else {
            currentOptions[answers[i]].classList.add('incorrect');
            currentOptions[q.correct].classList.add('correct');
          }
        }
      });
    });

    resultsModal.addEventListener('click', function(e) {
      if (e.target === resultsModal) {
        resultsModal.style.display = 'none';
      }
    });

    document.addEventListener('DOMContentLoaded', initQuiz);
  </script>
</body>
</html>