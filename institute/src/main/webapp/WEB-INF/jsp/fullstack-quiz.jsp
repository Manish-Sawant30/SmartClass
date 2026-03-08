<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Full-Stack Development Quiz | EduEra</title>
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
      background: var(--warning-orange);
      color: white;
      border-color: var(--warning-orange);
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
        <i class="fas fa-layer-group"></i>
        Full-Stack Development Quiz
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
          <div class="timer" id="timerElement">
            <i class="fas fa-clock"></i>
            <span id="timeLeft">30:00</span>
          </div>
        </div>
        
        <div class="question-text" id="questionText"></div>
        
        <div class="optionsContainer" id="optionsContainer"></div>
        
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
    // Full-Stack Development Questions
    var questions = [
      {
        question: "Which of these is NOT a frontend framework?",
        options: ["React", "Angular", "Vue", "Django"],
        correct: 3,
        explanation: "Django is a Python backend framework."
      },
      {
        question: "What does REST stand for in API design?",
        options: ["Representational State Transfer", "Remote Execution System Transfer", "Resource Endpoint System Transfer", "Rapid Execution State Transfer"],
        correct: 0,
        explanation: "REST = Representational State Transfer."
      },
      {
        question: "Which HTTP method is used for creating resources?",
        options: ["GET", "POST", "PUT", "DELETE"],
        correct: 1,
        explanation: "POST is used to create new resources."
      },
      {
        question: "What is the purpose of package.json in Node.js?",
        options: ["Project metadata and dependencies", "Database configuration", "Build scripts", "All of these"],
        correct: 0,
        explanation: "package.json contains project metadata and dependencies."
      },
      {
        question: "Which database is NOT a NoSQL database?",
        options: ["MongoDB", "Redis", "PostgreSQL", "Cassandra"],
        correct: 2,
        explanation: "PostgreSQL is a relational (SQL) database."
      },
      {
        question: "What does CORS stand for?",
        options: ["Cross-Origin Resource Sharing", "Cross-Origin Request Security", "Cross-Origin Response System", "Cross-Origin Resource Security"],
        correct: 0,
        explanation: "CORS = Cross-Origin Resource Sharing."
      },
      {
        question: "Which is used for state management in React?",
        options: ["Redux", "Context API", "MobX", "All of these"],
        correct: 3,
        explanation: "All are state management solutions for React."
      },
      {
        question: "What is the purpose of Docker?",
        options: ["Containerization", "Virtualization", "Package management", "Code compilation"],
        correct: 0,
        explanation: "Docker is a containerization platform."
      },
      {
        question: "Which is NOT a JavaScript runtime?",
        options: ["Node.js", "Deno", "Bun", "JRE"],
        correct: 3,
        explanation: "JRE is Java Runtime Environment."
      },
      {
        question: "What does MVC stand for?",
        options: ["Model View Controller", "Model View Component", "Main View Controller", "Model Visual Controller"],
        correct: 0,
        explanation: "MVC = Model View Controller."
      },
      {
        question: "Which is used for API testing?",
        options: ["Postman", "cURL", "Insomnia", "All of these"],
        correct: 3,
        explanation: "All are tools for API testing."
      },
      {
        question: "What is GraphQL?",
        options: ["Query language for APIs", "Database language", "Frontend framework", "Backend language"],
        correct: 0,
        explanation: "GraphQL is a query language for APIs."
      },
      {
        question: "Which is a CSS preprocessor?",
        options: ["Sass", "Less", "Stylus", "All of these"],
        correct: 3,
        explanation: "All are CSS preprocessors."
      },
      {
        question: "What is the purpose of webpack?",
        options: ["Module bundler", "Task runner", "Package manager", "Code linter"],
        correct: 0,
        explanation: "webpack is a module bundler."
      },
      {
        question: "Which HTTP status code indicates success?",
        options: ["200", "404", "500", "301"],
        correct: 0,
        explanation: "200 OK indicates successful request."
      },
      {
        question: "What is JWT used for?",
        options: ["Authentication", "Authorization", "Both A and B", "Data encryption"],
        correct: 2,
        explanation: "JWT is used for authentication and authorization."
      },
      {
        question: "Which is a cloud platform?",
        options: ["AWS", "Azure", "Google Cloud", "All of these"],
        correct: 3,
        explanation: "All are major cloud platforms."
      },
      {
        question: "What is the purpose of Nginx?",
        options: ["Web server", "Reverse proxy", "Load balancer", "All of these"],
        correct: 3,
        explanation: "Nginx can serve all these purposes."
      },
      {
        question: "Which is a version control system?",
        options: ["Git", "SVN", "Mercurial", "All of these"],
        correct: 3,
        explanation: "All are version control systems."
      },
      {
        question: "What does SSR stand for?",
        options: ["Server-Side Rendering", "Single-Source Rendering", "Static Site Rendering", "Server-Side Routing"],
        correct: 0,
        explanation: "SSR = Server-Side Rendering."
      },
      {
        question: "Which is used for continuous integration?",
        options: ["Jenkins", "GitHub Actions", "GitLab CI", "All of these"],
        correct: 3,
        explanation: "All are CI/CD tools."
      },
      {
        question: "What is the purpose of TypeScript?",
        options: ["Adds static typing to JavaScript", "JavaScript framework", "Backend language", "Database language"],
        correct: 0,
        explanation: "TypeScript adds static typing to JavaScript."
      },
      {
        question: "Which is a mobile app development framework?",
        options: ["React Native", "Flutter", "Ionic", "All of these"],
        correct: 3,
        explanation: "All are mobile app frameworks."
      },
      {
        question: "What is microservices architecture?",
        options: ["Breaking app into small services", "Single large application", "Monolithic design", "Database design"],
        correct: 0,
        explanation: "Microservices break app into independent services."
      },
      {
        question: "Which is used for real-time communication?",
        options: ["WebSockets", "Socket.io", "Firebase", "All of these"],
        correct: 3,
        explanation: "All enable real-time communication."
      }
    ];

    // Quiz State
    var currentQuestion = 0;
    var answers = new Array(questions.length).fill(null);
    var markedQuestions = new Set();
    var startTime = Date.now();
    var timeLimit = 30 * 60;
    var timerInterval;

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
    var timerElement = document.getElementById('timerElement');
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

    // Initialize Quiz
    function initQuiz() {
      loadQuestion(currentQuestion);
      generateQuestionGrid();
      startTimer();
      updateStats();
      updateProgress();
      
      localStorage.setItem('currentQuiz', 'fullstack');
    }

    // Load Question
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
        
        optionElement.innerHTML = '<div class="option-letter">' + 
                                 String.fromCharCode(65 + i) + 
                                 '</div><div class="option-text">' + 
                                 question.options[i] + '</div>';
        
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
      
      // Update review button state
      if (markedQuestions.has(index)) {
        reviewBtn.innerHTML = '<i class="fas fa-flag-checkered"></i> Remove Mark';
      } else {
        reviewBtn.innerHTML = '<i class="fas fa-flag"></i> Mark for Review';
      }
    }

    // Select Option
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

    // Generate Question Grid
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

    // Update Question Grid
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

    // Jump to Question
    function jumpToQuestion(index) {
      currentQuestion = index;
      loadQuestion(currentQuestion);
    }

    // Update Statistics
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

    // Update Progress
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

    // Timer Functions
    function startTimer() {
      updateTimerDisplay();
      timerInterval = setInterval(updateTimerDisplay, 1000);
    }

    function updateTimerDisplay() {
      var elapsed = Math.floor((Date.now() - startTime) / 1000);
      var remaining = Math.max(0, timeLimit - elapsed);
      
      var minutes = Math.floor(remaining / 60);
      var seconds = remaining % 60;
      
      var timeString = (minutes < 10 ? '0' : '') + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
      
      timerDisplay.textContent = timeString;
      timeLeft.textContent = timeString;
      
      if (remaining < 300) {
        timerElement.classList.add('warning');
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
      var minutes = Math.floor(elapsed / 60);
      var seconds = elapsed % 60;
      var timeString = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
      
      finalScore.textContent = correct + '/' + questions.length;
      correctCount.textContent = correct;
      incorrectCount.textContent = incorrect;
      accuracyRate.textContent = accuracy + '%';
      timeTaken.textContent = timeString;
      
      var results = {
        subject: 'Full-Stack Development',
        score: correct,
        total: questions.length,
        answers: answers.slice(),
        questions: [],
        timeSpent: elapsed,
        accuracy: accuracy
      };
      
      // Add questions data
      for (var j = 0; j < questions.length; j++) {
        results.questions.push({
          question: questions[j].question,
          options: questions[j].options,
          correct: questions[j].correct,
          selected: answers[j],
          explanation: questions[j].explanation
        });
      }
      
      localStorage.setItem('quizResults', JSON.stringify(results));
      resultsModal.style.display = 'flex';
    }

    submitBtn.addEventListener('click', submitQuiz);
    sidebarSubmitBtn.addEventListener('click', submitQuiz);

    // View Detailed Results - Redirect to Spring Boot endpoint
    viewResultsBtn.addEventListener('click', function() {
      window.location.href = '/quiz-results';
    });

    // Review Answers
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

    resultsModal.addEventListener('click', function(e) {
      if (e.target === resultsModal) {
        resultsModal.style.display = 'none';
      }
    });

    document.addEventListener('DOMContentLoaded', initQuiz);
  </script>
</body>
</html>