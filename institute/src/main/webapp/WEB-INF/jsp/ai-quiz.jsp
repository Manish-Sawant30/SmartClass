<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Artificial Intelligence Quiz | EduEra</title>
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
        <i class="fas fa-robot"></i>
        Artificial Intelligence Quiz
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
        question: "What does AI stand for?",
        options: ["Artificial Intelligence", "Automated Intelligence", "Advanced Intelligence", "Artificial Interaction"],
        correct: 0,
        explanation: "AI = Artificial Intelligence."
      },
      {
        question: "Which is NOT a type of machine learning?",
        options: ["Supervised Learning", "Unsupervised Learning", "Reinforcement Learning", "Random Learning"],
        correct: 3,
        explanation: "Random Learning is not a recognized ML type."
      },
      {
        question: "What is neural network inspired by?",
        options: ["Human brain", "Computer circuits", "Mathematics", "Statistics"],
        correct: 0,
        explanation: "Neural networks are inspired by human brain neurons."
      },
      {
        question: "Which algorithm is used for classification?",
        options: ["K-Nearest Neighbors", "Linear Regression", "K-Means", "Apriori"],
        correct: 0,
        explanation: "K-NN is used for classification tasks."
      },
      {
        question: "What is NLP?",
        options: ["Natural Language Processing", "Neural Language Processing", "Natural Learning Processing", "Neural Learning Processing"],
        correct: 0,
        explanation: "NLP = Natural Language Processing."
      },
      {
        question: "Which is a deep learning framework?",
        options: ["TensorFlow", "PyTorch", "Keras", "All of these"],
        correct: 3,
        explanation: "All are popular deep learning frameworks."
      },
      {
        question: "What is overfitting in ML?",
        options: ["Model learns training data too well", "Model doesn't learn enough", "Model is too simple", "Model has high bias"],
        correct: 0,
        explanation: "Overfitting: model performs well on training but poorly on test data."
      },
      {
        question: "Which is NOT an AI application?",
        options: ["Self-driving cars", "Recommendation systems", "Spreadsheet calculations", "Chatbots"],
        correct: 2,
        explanation: "Spreadsheet calculations are not typically AI applications."
      },
      {
        question: "What is computer vision?",
        options: ["AI for visual data", "AI for audio data", "AI for text data", "AI for numerical data"],
        correct: 0,
        explanation: "Computer vision deals with visual data like images/videos."
      },
      {
        question: "Which is a reinforcement learning concept?",
        options: ["Reward", "Penalty", "Agent", "All of these"],
        correct: 3,
        explanation: "All are key concepts in reinforcement learning."
      },
      {
        question: "What is the Turing Test for?",
        options: ["Testing machine intelligence", "Testing algorithm speed", "Testing data quality", "Testing hardware"],
        correct: 0,
        explanation: "Turing Test assesses if machine can exhibit intelligent behavior."
      },
      {
        question: "Which is a clustering algorithm?",
        options: ["K-Means", "Decision Tree", "SVM", "Logistic Regression"],
        correct: 0,
        explanation: "K-Means is a clustering (unsupervised) algorithm."
      },
      {
        question: "What is transfer learning?",
        options: ["Using pre-trained models", "Training from scratch", "Manual feature engineering", "Data augmentation"],
        correct: 0,
        explanation: "Transfer learning uses pre-trained models for new tasks."
      },
      {
        question: "Which is NOT an activation function?",
        options: ["ReLU", "Sigmoid", "Tanh", "Linear Regression"],
        correct: 3,
        explanation: "Linear Regression is not an activation function."
      },
      {
        question: "What is feature engineering?",
        options: ["Creating new features from data", "Selecting best features", "Both A and B", "Training models"],
        correct: 2,
        explanation: "Feature engineering involves creating and selecting features."
      },
      {
        question: "Which is used for image recognition?",
        options: ["CNN", "RNN", "LSTM", "GRU"],
        correct: 0,
        explanation: "CNN (Convolutional Neural Networks) are for image recognition."
      },
      {
        question: "What is bias in AI?",
        options: ["Systematic error", "Random error", "Model complexity", "Training time"],
        correct: 0,
        explanation: "Bias is systematic error in predictions."
      },
      {
        question: "Which is a supervised learning algorithm?",
        options: ["Linear Regression", "Decision Tree", "Random Forest", "All of these"],
        correct: 3,
        explanation: "All are supervised learning algorithms."
      },
      {
        question: "What is data augmentation?",
        options: ["Creating more training data", "Cleaning data", "Normalizing data", "Reducing data"],
        correct: 0,
        explanation: "Data augmentation creates more training data through transformations."
      },
      {
        question: "Which is used for sequence data?",
        options: ["RNN", "LSTM", "GRU", "All of these"],
        correct: 3,
        explanation: "All are used for sequence data like text/time series."
      },
      {
        question: "What is precision in classification?",
        options: ["True positives / (True positives + False positives)", "True positives / (True positives + False negatives)", "Correct predictions / Total predictions", "Accuracy of positive predictions"],
        correct: 0,
        explanation: "Precision = TP / (TP + FP)."
      },
      {
        question: "Which is an unsupervised learning task?",
        options: ["Clustering", "Classification", "Regression", "Prediction"],
        correct: 0,
        explanation: "Clustering is unsupervised; others are supervised."
      },
      {
        question: "What is backpropagation?",
        options: ["Algorithm for training neural networks", "Data preprocessing technique", "Model evaluation method", "Feature selection method"],
        correct: 0,
        explanation: "Backpropagation trains neural networks by adjusting weights."
      },
      {
        question: "Which is NOT a machine learning library?",
        options: ["scikit-learn", "TensorFlow", "PyTorch", "Java"],
        correct: 3,
        explanation: "Java is a programming language, not an ML library."
      },
      {
        question: "What is the goal of AI ethics?",
        options: ["Ensure responsible AI development", "Make AI faster", "Reduce AI costs", "Increase AI complexity"],
        correct: 0,
        explanation: "AI ethics ensures responsible and fair AI development."
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
      localStorage.setItem('currentQuiz', 'ai');
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
        
        // FIXED: Create option elements using DOM methods instead of template literals
        const optionLetterDiv = document.createElement('div');
        optionLetterDiv.className = 'option-letter';
        optionLetterDiv.textContent = String.fromCharCode(65 + i);
        
        const optionTextDiv = document.createElement('div');
        optionTextDiv.className = 'option-text';
        optionTextDiv.textContent = option;
        
        optionElement.appendChild(optionLetterDiv);
        optionElement.appendChild(optionTextDiv);
        
        optionElement.addEventListener('click', function() { 
          selectOption(i); 
        });
        optionsContainer.appendChild(optionElement);
      });
      
      updateQuestionGrid();
      prevBtn.style.display = index === 0 ? 'none' : 'flex';
      nextBtn.style.display = index === questions.length - 1 ? 'none' : 'flex';
      submitBtn.style.display = index === questions.length - 1 ? 'flex' : 'none';
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
      
      // FIXED: String concatenation instead of template literals
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
      
      // FIXED: String concatenation instead of template literals
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
      
      // FIXED: String concatenation instead of template literals
      const timeString = Math.floor(elapsed / 60) + ':' + (elapsed % 60).toString().padStart(2, '0');
      
      // FIXED: String concatenation instead of template literals
      finalScore.textContent = correct + '/' + questions.length;
      correctCount.textContent = correct;
      incorrectCount.textContent = incorrect;
      accuracyRate.textContent = accuracy + '%';
      timeTaken.textContent = timeString;
      
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
      resultsModal.style.display = 'flex';
    }

    submitBtn.addEventListener('click', submitQuiz);
    sidebarSubmitBtn.addEventListener('click', submitQuiz);

    viewResultsBtn.addEventListener('click', function() {
      window.location.href = '/quiz-results';
    });

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

    resultsModal.addEventListener('click', function(e) {
      if (e.target === resultsModal) {
        resultsModal.style.display = 'none';
      }
    });

    document.addEventListener('DOMContentLoaded', initQuiz);
  </script>
</body>
</html>