<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Python Programming Quiz | EduEra</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    /* Same CSS structure as previous quizzes */
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
      border-color: var(--danger-red);
      border-width: 3px;
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
        <i class="fab fa-python"></i>
        Python Programming Quiz
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
    // Quiz questions array
    var questions = [
      {
        question: "Which of the following is NOT a valid Python data type?",
        options: ["list", "tuple", "array", "dictionary"],
        correct: 2,
        explanation: "Python has list, tuple, dict, but 'array' is from array module, not built-in type."
      },
      {
        question: "What is the output of: print(3 * 'abc')?",
        options: ["abcabcabc", "3abc", "Error", "abc abc abc"],
        correct: 0,
        explanation: "Multiplying string by integer repeats the string."
      },
      {
        question: "Which keyword is used to define a function in Python?",
        options: ["function", "def", "func", "define"],
        correct: 1,
        explanation: "Functions are defined using 'def' keyword."
      },
      {
        question: "What does PEP 8 refer to?",
        options: ["Python Enhancement Proposal for style guide", "Python Execution Protocol", "Python Error Prevention", "Package Enhancement Process"],
        correct: 0,
        explanation: "PEP 8 is Python's official style guide."
      },
      {
        question: "Which is used for single-line comments in Python?",
        options: ["//", "#", "/* */", "<!-- -->"],
        correct: 1,
        explanation: "# is used for single-line comments."
      },
      {
        question: "What is the output of: print(5 // 2)?",
        options: ["2.5", "2", "3", "2.0"],
        correct: 1,
        explanation: "// performs floor division (integer division)."
      },
      {
        question: "Which method is used to add an element to a list?",
        options: ["append()", "add()", "insert()", "push()"],
        correct: 0,
        explanation: "append() adds element to end of list."
      },
      {
        question: "What does 'self' represent in Python class methods?",
        options: ["The class itself", "The instance of the class", "The parent class", "The module"],
        correct: 1,
        explanation: "self refers to the instance of the class."
      },
      {
        question: "Which is used to handle exceptions in Python?",
        options: ["try-catch", "try-except", "catch-throw", "error-handle"],
        correct: 1,
        explanation: "Python uses try-except for exception handling."
      },
      {
        question: "What is a lambda function?",
        options: ["Anonymous function", "Named function", "Built-in function", "Class method"],
        correct: 0,
        explanation: "Lambda functions are anonymous functions."
      },
      {
        question: "Which module is used for regular expressions?",
        options: ["regex", "re", "regexp", "pattern"],
        correct: 1,
        explanation: "re module provides regular expression operations."
      },
      {
        question: "What does __init__ method do?",
        options: ["Initializes class variables", "Destroys object", "Imports modules", "Exports functions"],
        correct: 0,
        explanation: "__init__ is the constructor method."
      },
      {
        question: "Which is used to read from a file?",
        options: ["read()", "open()", "load()", "import()"],
        correct: 1,
        explanation: "open() is used to open files for reading/writing."
      },
      {
        question: "What is list comprehension?",
        options: ["Creating lists using loops", "Understanding lists", "Sorting lists", "Merging lists"],
        correct: 0,
        explanation: "List comprehension creates lists in a concise way."
      },
      {
        question: "Which is NOT a valid Python variable name?",
        options: ["_var", "var_name", "123var", "var123"],
        correct: 2,
        explanation: "Variable names cannot start with numbers."
      },
      {
        question: "What is the purpose of 'pass' statement?",
        options: ["Skip iteration", "Do nothing", "Break loop", "Exit program"],
        correct: 1,
        explanation: "pass is a null operation - nothing happens."
      },
      {
        question: "Which is used for mathematical operations?",
        options: ["math module", "numpy", "Both A and B", "statistics module"],
        correct: 2,
        explanation: "Both math and numpy are used for math operations."
      },
      {
        question: "What does 'yield' keyword do?",
        options: ["Returns value", "Creates generator", "Pauses function", "All of these"],
        correct: 3,
        explanation: "yield creates generators and can pause/resume."
      },
      {
        question: "Which is mutable in Python?",
        options: ["tuple", "string", "list", "frozenset"],
        correct: 2,
        explanation: "Lists are mutable, others are immutable."
      },
      {
        question: "What is duck typing?",
        options: ["Dynamic typing", "If it walks like a duck...", "Type checking", "Both A and B"],
        correct: 3,
        explanation: "Duck typing focuses on behavior rather than type."
      },
      {
        question: "Which decorator is used for class methods?",
        options: ["@staticmethod", "@classmethod", "@property", "All of these"],
        correct: 3,
        explanation: "All are valid decorators for class methods."
      },
      {
        question: "What does pip stand for?",
        options: ["Python Install Package", "Pip Installs Packages", "Package Installer for Python", "Python Index Package"],
        correct: 2,
        explanation: "pip is Package Installer for Python."
      },
      {
        question: "Which is used for virtual environments?",
        options: ["venv", "virtualenv", "pipenv", "All of these"],
        correct: 3,
        explanation: "All are tools for creating virtual environments."
      },
      {
        question: "What is __name__ == '__main__' used for?",
        options: ["Check if script is run directly", "Import module", "Define main function", "Set module name"],
        correct: 0,
        explanation: "Checks if script is being run as main program."
      },
      {
        question: "Which is NOT a Python web framework?",
        options: ["Django", "Flask", "Pyramid", "Spring"],
        correct: 3,
        explanation: "Spring is a Java framework, not Python."
      }
    ];

    // Quiz state variables
    var currentQuestion = 0;
    var answers = new Array(questions.length);
    var markedQuestions = new Set();
    var startTime = Date.now();
    var timeLimit = 30 * 60;
    var timerInterval;

    // Initialize all answers to null
    for (var i = 0; i < answers.length; i++) {
      answers[i] = null;
    }

    // DOM Elements
    var questionText = document.getElementById('questionText');
    var optionsContainer = document.getElementById('optionsContainer');
    var questionGrid = document.getElementById('questionGrid');
    var currentQuestionNumber = document.getElementById('currentQuestionNumber');
    var progressText = document.getElementById('progressText');
    var progressFill = document.getElementById('progressFill');
    var answeredCount = document.getElementById('answeredCount');
    var remainingCount = document.getElementById('remainingCount');
    var markedCount = document.getElementById('markedCount');
    var timerDisplay = document.getElementById('timerDisplay');
    var timeLeft = document.getElementById('timeLeft');
    var timer = document.getElementById('timer');
    var prevBtn = document.getElementById('prevBtn');
    var nextBtn = document.getElementById('nextBtn');
    var submitBtn = document.getElementById('submitBtn');
    var sidebarSubmitBtn = document.getElementById('sidebarSubmitBtn');
    var clearBtn = document.getElementById('clearBtn');
    var reviewBtn = document.getElementById('reviewBtn');
    var resultsModal = document.getElementById('resultsModal');
    var finalScore = document.getElementById('finalScore');
    var correctCount = document.getElementById('correctCount');
    var incorrectCount = document.getElementById('incorrectCount');
    var accuracyRate = document.getElementById('accuracyRate');
    var timeTaken = document.getElementById('timeTaken');
    var reviewAnswersBtn = document.getElementById('reviewAnswersBtn');
    var viewResultsBtn = document.getElementById('viewResultsBtn');

    // Initialize the quiz
    function initQuiz() {
      loadQuestion(currentQuestion);
      generateQuestionGrid();
      startTimer();
      updateStats();
      updateProgress();
      localStorage.setItem('currentQuiz', 'python');
    }

    // Load question and options
    function loadQuestion(index) {
      var question = questions[index];
      currentQuestionNumber.textContent = index + 1;
      questionText.textContent = question.question;
      optionsContainer.innerHTML = '';
      
      for (var i = 0; i < question.options.length; i++) {
        var optionElement = document.createElement('div');
        optionElement.className = 'option';
        if (answers[index] === i) {
          optionElement.classList.add('selected');
        }
        
        var optionLetter = document.createElement('div');
        optionLetter.className = 'option-letter';
        optionLetter.textContent = String.fromCharCode(65 + i);
        
        var optionText = document.createElement('div');
        optionText.className = 'option-text';
        optionText.textContent = question.options[i];
        
        optionElement.appendChild(optionLetter);
        optionElement.appendChild(optionText);
        
        optionElement.addEventListener('click', function(optIndex) {
          return function() {
            selectOption(optIndex);
          };
        }(i));
        
        optionsContainer.appendChild(optionElement);
      }
      
      updateQuestionGrid();
      prevBtn.style.display = index === 0 ? 'none' : 'flex';
      nextBtn.style.display = index === questions.length - 1 ? 'none' : 'flex';
      submitBtn.style.display = index === questions.length - 1 ? 'flex' : 'none';
    }

    // Select an option
    function selectOption(optionIndex) {
      answers[currentQuestion] = optionIndex;
      var options = document.querySelectorAll('.option');
      for (var i = 0; i < options.length; i++) {
        options[i].classList.remove('selected');
        if (i === optionIndex) {
          options[i].classList.add('selected');
        }
      }
      updateStats();
      updateProgress();
      updateQuestionGrid();
    }

    // Generate question grid in sidebar
    function generateQuestionGrid() {
      questionGrid.innerHTML = '';
      for (var i = 0; i < questions.length; i++) {
        var gridItem = document.createElement('div');
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
        gridItem.addEventListener('click', function(idx) {
          return function() {
            jumpToQuestion(idx);
          };
        }(i));
        questionGrid.appendChild(gridItem);
      }
    }

    // Update question grid highlights
    function updateQuestionGrid() {
      var gridItems = document.querySelectorAll('.grid-item');
      for (var i = 0; i < gridItems.length; i++) {
        gridItems[i].classList.remove('current', 'answered', 'marked');
        if (i === currentQuestion) {
          gridItems[i].classList.add('current');
        }
        if (answers[i] !== null) {
          gridItems[i].classList.add('answered');
        }
        if (markedQuestions.has(i)) {
          gridItems[i].classList.add('marked');
        }
      }
    }

    // Jump to specific question
    function jumpToQuestion(index) {
      currentQuestion = index;
      loadQuestion(currentQuestion);
    }

    // Update statistics
    function updateStats() {
      var answered = 0;
      for (var i = 0; i < answers.length; i++) {
        if (answers[i] !== null) {
          answered++;
        }
      }
      var remaining = questions.length - answered;
      answeredCount.textContent = answered;
      remainingCount.textContent = remaining;
      markedCount.textContent = markedQuestions.size;
    }

    // Update progress bar
    function updateProgress() {
      var answered = 0;
      for (var i = 0; i < answers.length; i++) {
        if (answers[i] !== null) {
          answered++;
        }
      }
      var progress = (answered / questions.length) * 100;
      progressText.textContent = answered + '/' + questions.length;
      progressFill.style.width = progress + '%';
    }

    // Start the timer
    function startTimer() {
      updateTimerDisplay();
      timerInterval = setInterval(updateTimerDisplay, 1000);
    }

    // Update timer display
    function updateTimerDisplay() {
      var elapsed = Math.floor((Date.now() - startTime) / 1000);
      var remaining = Math.max(0, timeLimit - elapsed);
      var minutes = Math.floor(remaining / 60);
      var seconds = remaining % 60;
      var timeString = minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');
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

    // Previous button click handler
    prevBtn.addEventListener('click', function() {
      if (currentQuestion > 0) {
        currentQuestion--;
        loadQuestion(currentQuestion);
      }
    });

    // Next button click handler
    nextBtn.addEventListener('click', function() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        loadQuestion(currentQuestion);
      }
    });

    // Clear button click handler
    clearBtn.addEventListener('click', function() {
      if (confirm('Are you sure you want to clear all answers?')) {
        for (var i = 0; i < answers.length; i++) {
          answers[i] = null;
        }
        markedQuestions.clear();
        loadQuestion(currentQuestion);
        updateStats();
        updateProgress();
      }
    });

    // Review button click handler
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

    // Submit quiz
    function submitQuiz() {
      clearInterval(timerInterval);
      var correct = 0;
      var incorrect = 0;
      var unanswered = 0;
      
      for (var i = 0; i < answers.length; i++) {
        if (answers[i] === null) {
          unanswered++;
        } else if (answers[i] === questions[i].correct) {
          correct++;
        } else {
          incorrect++;
        }
      }
      
      var accuracy = Math.round((correct / questions.length) * 100);
      var elapsed = Math.floor((Date.now() - startTime) / 1000);
      var minutesSpent = Math.floor(elapsed / 60);
      var secondsSpent = elapsed % 60;
      var timeString = minutesSpent + ':' + secondsSpent.toString().padStart(2, '0');
      
      finalScore.textContent = correct + '/' + questions.length;
      correctCount.textContent = correct;
      incorrectCount.textContent = incorrect;
      accuracyRate.textContent = accuracy + '%';
      timeTaken.textContent = timeString;
      
      var results = {
        score: correct,
        total: questions.length,
        answers: answers.slice(),
        questions: [],
        timeSpent: elapsed,
        quizName: 'Python Programming Quiz',
        timestamp: new Date().toISOString()
      };
      
      for (var i = 0; i < questions.length; i++) {
        results.questions.push({
          question: questions[i].question,
          options: questions[i].options,
          correct: questions[i].correct,
          selected: answers[i],
          explanation: questions[i].explanation
        });
      }
      
      localStorage.setItem('quizResults', JSON.stringify(results));
      resultsModal.style.display = 'flex';
    }

    // Submit button handlers
    submitBtn.addEventListener('click', submitQuiz);
    sidebarSubmitBtn.addEventListener('click', submitQuiz);

    // View results button handler - redirect to Spring Boot endpoint
    viewResultsBtn.addEventListener('click', function() {
      window.location.href = '/quiz-results';
    });

    // Review answers button handler
    reviewAnswersBtn.addEventListener('click', function() {
      resultsModal.style.display = 'none';
      for (var i = 0; i < questions.length; i++) {
        if (answers[i] !== null) {
          var options = document.querySelectorAll('.option');
          if (answers[i] === questions[i].correct) {
            options[answers[i]].classList.add('correct');
          } else {
            options[answers[i]].classList.add('incorrect');
            options[questions[i].correct].classList.add('correct');
          }
        }
      }
    });

    // Close modal when clicking outside
    resultsModal.addEventListener('click', function(e) {
      if (e.target === resultsModal) {
        resultsModal.style.display = 'none';
      }
    });

    // Initialize quiz when page loads
    document.addEventListener('DOMContentLoaded', initQuiz);
  </script>
</body>
</html>