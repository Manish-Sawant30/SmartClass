<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>C Programming Quiz | EduEra</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
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

    /* Header */
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

    /* Progress Bar */
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

    /* Main Container */
    .main-container {
      max-width: 1200px;
      margin: 30px auto;
      padding: 0 20px;
      display: grid;
      grid-template-columns: 1fr 300px;
      gap: 30px;
    }

    /* Question Card */
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

    /* Options */
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

    /* Navigation Controls */
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

    /* Sidebar */
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

    /* Question Grid */
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

    /* Quiz Stats */
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

    /* Action Buttons */
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

    /* Modal */
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

    /* Responsive Design */
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
  <!-- Header -->
  <header class="quiz-header">
    <div class="header-content">
      <h1 class="quiz-title">
        <i class="fas fa-code"></i>
        C Programming Quiz
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

  <!-- Main Content -->
  <main class="main-container">
    <!-- Question Section -->
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

    <!-- Sidebar -->
    <aside class="sidebar">
      <div class="sidebar-card">
        <h3 class="sidebar-title">
          <i class="fas fa-list-ol"></i>
          Question Navigation
        </h3>
        <div class="question-grid" id="questionGrid">
          <!-- Question numbers will be generated here -->
        </div>
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

  <!-- Results Modal -->
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
    // Questions Data
    const questions = [
      {
        question: "Which of the following is a valid C identifier?",
        options: ["2value", "_num", "float", "long-int"],
        correct: 1,
        explanation: "Identifiers cannot start with numbers, cannot be keywords, and cannot contain hyphens."
      },
      {
        question: "Which header file is required for printf() and scanf()?",
        options: ["<stdlib.h>", "<stdio.h>", "<string.h>", "<ctype.h>"],
        correct: 1,
        explanation: "stdio.h stands for Standard Input Output header file."
      },
      {
        question: "What is the default return type of a function in C if not specified?",
        options: ["void", "int", "float", "undefined"],
        correct: 1,
        explanation: "In C, if no return type is specified, int is assumed by default."
      },
      {
        question: "Which operator is used to access the value at an address?",
        options: ["&", "*", "->", "%"],
        correct: 1,
        explanation: "The * operator is used for dereferencing pointers."
      },
      {
        question: "Which of the following is NOT a storage class in C?",
        options: ["auto", "register", "mutable", "extern"],
        correct: 2,
        explanation: "mutable is a C++ keyword, not available in C."
      },
      {
        question: "How do you declare a pointer to an integer?",
        options: ["int p;", "int *p;", "pointer p;", "int &p;"],
        correct: 1,
        explanation: "int *p; declares p as a pointer to an integer."
      },
      {
        question: "Which of these is used for dynamic memory allocation?",
        options: ["malloc()", "calloc()", "realloc()", "All of these"],
        correct: 3,
        explanation: "All three functions are used for dynamic memory allocation in C."
      },
      {
        question: "What is the size of int on most 32-bit systems?",
        options: ["1 byte", "2 bytes", "4 bytes", "8 bytes"],
        correct: 2,
        explanation: "On most 32-bit systems, int is 4 bytes (32 bits)."
      },
      {
        question: "Which function compares two strings?",
        options: ["strcmp()", "strcat()", "strlen()", "strcopy()"],
        correct: 0,
        explanation: "strcmp() returns 0 if strings are equal, negative if first is less, positive if greater."
      },
      {
        question: "Arrays in C are:",
        options: ["Zero-indexed", "One-indexed", "User-defined index", "Dynamic by default"],
        correct: 0,
        explanation: "C arrays always start at index 0."
      },
      {
        question: "Which of these is a correct function prototype?",
        options: ["void sum(a,b);", "sum(int a, int b);", "int sum(int,int);", "function sum(int a, int b);"],
        correct: 2,
        explanation: "Function prototype includes return type and parameter types."
      },
      {
        question: "Which keyword is used to define a constant value?",
        options: ["static", "immutable", "const", "constant"],
        correct: 2,
        explanation: "const keyword makes a variable read-only."
      },
      {
        question: "What is the output type of sizeof operator?",
        options: ["int", "float", "size_t", "double"],
        correct: 2,
        explanation: "sizeof returns size_t, an unsigned integer type."
      },
      {
        question: "Which of these is used to exit a loop?",
        options: ["stop", "exit", "break", "terminate"],
        correct: 2,
        explanation: "break statement terminates the loop immediately."
      },
      {
        question: "A string in C is terminated by:",
        options: ["EOF", "\\n", "\\0", "NULL"],
        correct: 2,
        explanation: "Null character '\\0' marks the end of a string."
      },
      {
        question: "Which operator has highest precedence?",
        options: ["+", "=", "*", "()"],
        correct: 3,
        explanation: "Parentheses have the highest precedence in C."
      },
      {
        question: "Which function is used to open a file in C?",
        options: ["fread()", "open()", "fopen()", "fileopen()"],
        correct: 2,
        explanation: "fopen() opens a file and returns a FILE pointer."
      },
      {
        question: "The correct syntax for a structure is:",
        options: ["struct { } name;", "structure name { };", "struct name() { };", "struct:name{ }"],
        correct: 0,
        explanation: "Structure definition uses struct keyword followed by braces."
      },
      {
        question: "Which keyword is used to create a user-defined type?",
        options: ["type", "newtype", "typedef", "alias"],
        correct: 2,
        explanation: "typedef creates an alias for existing types."
      },
      {
        question: "Which of these is a valid pointer declaration?",
        options: ["int *p;", "int p*;", "pointer *p;", "int &p"],
        correct: 0,
        explanation: "Asterisk (*) goes before the pointer variable name."
      },
      {
        question: "Which of these loops will execute at least once?",
        options: ["for", "while", "do-while", "None"],
        correct: 2,
        explanation: "do-while checks condition after executing the loop body."
      },
      {
        question: "What is recursion?",
        options: ["Function calling itself", "Loop inside loop", "Pointer arithmetic", "Calling library functions"],
        correct: 0,
        explanation: "Recursion involves a function calling itself."
      },
      {
        question: "Which header file defines malloc()?",
        options: ["<math.h>", "<stdio.h>", "<stdlib.h>", "<memory.h>"],
        correct: 2,
        explanation: "stdlib.h contains memory allocation functions."
      },
      {
        question: "Which keyword is used to return a value from a function?",
        options: ["send", "return", "give", "back"],
        correct: 1,
        explanation: "return statement sends a value back to the caller."
      },
      {
        question: "What will (5/2) evaluate to in C (integer division)?",
        options: ["2.5", "3", "2", "Error"],
        correct: 2,
        explanation: "Integer division truncates the decimal part."
      }
    ];

    // Quiz State
    let currentQuestion = 0;
    let answers = new Array(questions.length).fill(null);
    let markedQuestions = new Set();
    let startTime = Date.now();
    let timeLimit = 30 * 60; // 30 minutes in seconds
    let timerInterval;

    // DOM Elements
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

    // Initialize Quiz
    function initQuiz() {
      loadQuestion(currentQuestion);
      generateQuestionGrid();
      startTimer();
      updateStats();
      updateProgress();
      // Store current quiz subject
      localStorage.setItem('currentQuiz', 'c');
    }

    // Load Question
    function loadQuestion(index) {
      const question = questions[index];
      
      // Update question number
      currentQuestionNumber.textContent = index + 1;
      
      // Update question text
      questionText.textContent = question.question;
      
      // Clear and create options
      optionsContainer.innerHTML = '';
      question.options.forEach((option, i) => {
        const optionElement = document.createElement('div');
        optionElement.className = 'option';
        if (answers[index] === i) {
          optionElement.classList.add('selected');
        }
        
        // Fixed: Use JavaScript to create letter from char code
        const optionLetterDiv = document.createElement('div');
        optionLetterDiv.className = 'option-letter';
        optionLetterDiv.textContent = String.fromCharCode(65 + i); // A, B, C, D
        
        const optionTextDiv = document.createElement('div');
        optionTextDiv.className = 'option-text';
        optionTextDiv.textContent = option;
        
        optionElement.appendChild(optionLetterDiv);
        optionElement.appendChild(optionTextDiv);
        
        optionElement.addEventListener('click', function() { selectOption(i); });
        optionsContainer.appendChild(optionElement);
      });
      
      // Update question grid
      updateQuestionGrid();
      
      // Update button states
      prevBtn.style.display = index === 0 ? 'none' : 'flex';
      nextBtn.style.display = index === questions.length - 1 ? 'none' : 'flex';
      submitBtn.style.display = index === questions.length - 1 ? 'flex' : 'none';
    }

    // Select Option
    function selectOption(optionIndex) {
      answers[currentQuestion] = optionIndex;
      
      // Update UI
      const options = document.querySelectorAll('.option');
      options.forEach((opt, i) => {
        opt.classList.remove('selected');
        if (i === optionIndex) {
          opt.classList.add('selected');
        }
      });
      
      // Update stats
      updateStats();
      updateProgress();
      updateQuestionGrid();
    }

    // Generate Question Grid
    function generateQuestionGrid() {
      questionGrid.innerHTML = '';
      questions.forEach((_, i) => {
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
        gridItem.addEventListener('click', function() { jumpToQuestion(i); });
        questionGrid.appendChild(gridItem);
      });
    }

    // Update Question Grid
    function updateQuestionGrid() {
      const gridItems = document.querySelectorAll('.grid-item');
      gridItems.forEach((item, i) => {
        item.classList.remove('current', 'answered');
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

    // Jump to Question
    function jumpToQuestion(index) {
      currentQuestion = index;
      loadQuestion(currentQuestion);
    }

    // Update Statistics
    function updateStats() {
      const answered = answers.filter(function(a) { return a !== null; }).length;
      const remaining = questions.length - answered;
      
      answeredCount.textContent = answered;
      remainingCount.textContent = remaining;
      markedCount.textContent = markedQuestions.size;
    }

    // Update Progress
    function updateProgress() {
      const answered = answers.filter(function(a) { return a !== null; }).length;
      const progress = (answered / questions.length) * 100;
      
      // FIXED: String concatenation instead of template literals
      progressText.textContent = answered + '/' + questions.length;
      progressFill.style.width = progress + '%';
    }

    // Timer Functions
    function startTimer() {
      updateTimerDisplay();
      timerInterval = setInterval(updateTimerDisplay, 1000);
    }

    function updateTimerDisplay() {
      const elapsed = Math.floor((Date.now() - startTime) / 1000);
      const remaining = Math.max(0, timeLimit - elapsed);
      
      const minutes = Math.floor(remaining / 60);
      const seconds = remaining % 60;
      
      // FIXED: String concatenation instead of template literals
      const timeString = minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');
      
      timerDisplay.textContent = timeString;
      timeLeft.textContent = timeString;
      
      // Update timer color warning
      if (remaining < 300) { // 5 minutes
        timer.classList.add('warning');
      }
      
      if (remaining === 0) {
        clearInterval(timerInterval);
        submitQuiz();
      }
    }

    // Navigation
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

    // Clear Answers
    clearBtn.addEventListener('click', function() {
      if (confirm('Are you sure you want to clear all answers?')) {
        answers.fill(null);
        markedQuestions.clear();
        loadQuestion(currentQuestion);
        updateStats();
        updateProgress();
      }
    });

    // Mark for Review
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

    // Submit Quiz
    function submitQuiz() {
      clearInterval(timerInterval);
      
      // Calculate results
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
      // FIXED: String concatenation instead of template literals
      const timeString = Math.floor(elapsed / 60) + ':' + (elapsed % 60).toString().padStart(2, '0');
      
      // Update modal - FIXED: String concatenation
      finalScore.textContent = correct + '/' + questions.length;
      correctCount.textContent = correct;
      incorrectCount.textContent = incorrect;
      accuracyRate.textContent = accuracy + '%';
      timeTaken.textContent = timeString;
      
      // Store results
      const results = {
        score: correct,
        total: questions.length,
        answers: [...answers],
        questions: questions.map(function(q, i) {
          return {
            question: q.question,
            options: q.options,
            correct: q.correct,
            selected: answers[i],
            explanation: q.explanation
          };
        }),
        timeSpent: elapsed
      };
      
      localStorage.setItem('quizResults', JSON.stringify(results));
      
      // Show modal
      resultsModal.style.display = 'flex';
    }

    submitBtn.addEventListener('click', submitQuiz);
    sidebarSubmitBtn.addEventListener('click', submitQuiz);

    // View Detailed Results
    viewResultsBtn.addEventListener('click', function() {
      window.location.href = '/quiz-results';
    });

    // Review Answers
    reviewAnswersBtn.addEventListener('click', function() {
      resultsModal.style.display = 'none';
      questions.forEach(function(q, i) {
        if (answers[i] !== null) {
          const options = document.querySelectorAll('.option');
          if (answers[i] === q.correct) {
            options[answers[i]].classList.add('correct');
          } else {
            options[answers[i]].classList.add('incorrect');
            options[q.correct].classList.add('correct');
          }
        }
      });
    });

    // Close modal when clicking outside
    resultsModal.addEventListener('click', function(e) {
      if (e.target === resultsModal) {
        resultsModal.style.display = 'none';
      }
    });

    // Initialize
    document.addEventListener('DOMContentLoaded', initQuiz);
  </script>
</body>
</html>