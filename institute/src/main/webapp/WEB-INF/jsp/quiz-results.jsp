<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quiz Results | EduEra</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    :root {
      --primary-blue: #003b8e;
      --dark-blue: #001f54;
      --light-blue: #82e3f6;
      --success-green: #22a65b;
      --warning-orange: #ff9203;
      --danger-red: #dc3545;
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

    .header {
      background: linear-gradient(135deg, var(--primary-blue), var(--dark-blue));
      color: white;
      padding: 25px 0;
      box-shadow: var(--shadow);
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
    }

    .main-container {
      max-width: 1200px;
      margin: 30px auto;
      padding: 0 20px;
    }

    /* Summary Card */
    .summary-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      padding: 30px;
      box-shadow: var(--shadow);
      margin-bottom: 30px;
      text-align: center;
    }

    .score-display {
      font-size: 72px;
      font-weight: 800;
      color: var(--primary-blue);
      margin: 20px 0;
      line-height: 1;
    }

    .score-percentage {
      font-size: 24px;
      color: var(--text-light);
      margin-bottom: 30px;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 15px;
      margin: 30px 0;
    }

    @media (max-width: 768px) {
      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }

    @media (max-width: 480px) {
      .stats-grid {
        grid-template-columns: 1fr;
      }
    }

    .stat-item {
      padding: 20px;
      border-radius: 8px;
      background: #f8fafc;
    }

    .stat-value {
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 5px;
    }

    .correct .stat-value { color: var(--success-green); }
    .incorrect .stat-value { color: var(--danger-red); }
    .skipped .stat-value { color: var(--warning-orange); }
    .time .stat-value { color: var(--primary-blue); }

    .stat-label {
      font-size: 14px;
      color: var(--text-light);
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    /* Detailed Results */
    .detailed-results {
      background: var(--card-bg);
      border-radius: var(--radius);
      padding: 30px;
      box-shadow: var(--shadow);
      margin-bottom: 30px;
    }

    .section-title {
      font-size: 22px;
      font-weight: 600;
      margin-bottom: 25px;
      color: var(--primary-blue);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .question-list {
      display: grid;
      grid-template-columns: 1fr;
      gap: 20px;
    }

    .question-item {
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 20px;
      transition: all 0.3s ease;
    }

    .question-item.correct {
      border-color: var(--success-green);
      background: #f0fdf4;
    }

    .question-item.incorrect {
      border-color: var(--danger-red);
      background: #fef2f2;
    }

    .question-item.unanswered {
      border-color: var(--warning-orange);
      background: #fffbeb;
    }

    .question-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }

    .question-number {
      background: var(--primary-blue);
      color: white;
      width: 40px;
      height: 40px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
    }

    .question-status {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 600;
    }

    .correct .question-status { background: var(--success-green); color: white; }
    .incorrect .question-status { background: var(--danger-red); color: white; }
    .unanswered .question-status { background: var(--warning-orange); color: white; }

    .question-text {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 15px;
      line-height: 1.5;
    }

    .options-list {
      display: grid;
      grid-template-columns: 1fr;
      gap: 10px;
      margin-bottom: 15px;
    }

    .option {
      padding: 12px 15px;
      border-radius: 6px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .option.correct {
      background: #d1fae5;
      border: 1px solid var(--success-green);
    }

    .option.incorrect {
      background: #fee2e2;
      border: 1px solid var(--danger-red);
    }

    .option.selected {
      background: #dbeafe;
      border: 1px solid var(--primary-blue);
    }

    .option-letter {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      background: #f3f4f6;
    }

    .option.correct .option-letter {
      background: var(--success-green);
      color: white;
    }

    .option.incorrect .option-letter {
      background: var(--danger-red);
      color: white;
    }

    .option.selected .option-letter {
      background: var(--primary-blue);
      color: white;
    }

    .explanation {
      padding: 15px;
      background: #f8fafc;
      border-radius: 6px;
      margin-top: 15px;
      border-left: 4px solid var(--primary-blue);
    }

    .explanation strong {
      color: var(--primary-blue);
      margin-right: 5px;
    }

    /* Action Buttons */
    .action-buttons {
      display: flex;
      gap: 15px;
      margin: 30px 0;
      flex-wrap: wrap;
    }

    .action-btn {
      padding: 14px 28px;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      text-decoration: none;
      font-size: 16px;
    }

    .btn-primary {
      background: var(--primary-blue);
      color: white;
    }

    .btn-primary:hover {
      background: var(--dark-blue);
      transform: translateY(-2px);
    }

    .btn-secondary {
      background: #f3f4f6;
      color: var(--text-dark);
    }

    .btn-secondary:hover {
      background: #e5e7eb;
    }

    .btn-success {
      background: var(--success-green);
      color: white;
    }

    .btn-success:hover {
      background: #1a9550;
    }

    /* Performance Chart */
    .performance-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      padding: 30px;
      box-shadow: var(--shadow);
      margin-bottom: 30px;
    }

    .performance-bar {
      height: 24px;
      background: #e5e7eb;
      border-radius: 12px;
      overflow: hidden;
      margin: 20px 0;
      position: relative;
    }

    .performance-fill {
      height: 100%;
      border-radius: 12px;
      transition: width 1s ease;
    }

    .fill-correct {
      background: var(--success-green);
    }

    .fill-incorrect {
      background: var(--danger-red);
    }

    .fill-skipped {
      background: var(--warning-orange);
    }

    .performance-labels {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
      font-size: 14px;
      color: var(--text-light);
    }

    .no-results {
      text-align: center;
      padding: 60px 20px;
      color: var(--text-light);
    }

    .no-results i {
      font-size: 64px;
      margin-bottom: 20px;
      color: #d1d5db;
    }
  </style>
</head>
<body>
  <header class="header">
    <div class="header-content">
      <h1 class="quiz-title">
        <i class="fas fa-chart-bar"></i>
        Quiz Results
      </h1>
      <p class="quiz-subtitle">Detailed performance analysis and review</p>
    </div>
  </header>

  <main class="main-container">
    <div id="noResults" class="no-results" style="display: none;">
      <i class="fas fa-clipboard-question"></i>
      <h2>No Quiz Results Available</h2>
      <p>Complete a quiz to see your results here.</p>
      <div class="action-buttons" style="justify-content: center; margin-top: 30px;">
        <a href="/" class="action-btn btn-primary">
          <i class="fas fa-home"></i>
          Back to Quizzes
        </a>
      </div>
    </div>

    <div id="resultsContent" style="display: none;">
      <!-- Summary Card -->
      <div class="summary-card">
        <h2 id="quizSubject">Quiz Results</h2>
        <div class="score-display" id="finalScoreDisplay">0/25</div>
        <div class="score-percentage" id="percentageScore">0%</div>
        
        <div class="stats-grid">
          <div class="stat-item correct">
            <div class="stat-value" id="correctAnswers">0</div>
            <div class="stat-label">Correct</div>
          </div>
          <div class="stat-item incorrect">
            <div class="stat-value" id="incorrectAnswers">0</div>
            <div class="stat-label">Incorrect</div>
          </div>
          <div class="stat-item skipped">
            <div class="stat-value" id="skippedAnswers">0</div>
            <div class="stat-label">Skipped</div>
          </div>
          <div class="stat-item time">
            <div class="stat-value" id="timeSpent">0:00</div>
            <div class="stat-label">Time Spent</div>
          </div>
        </div>

        <div class="action-buttons">
          <a href="/" class="action-btn btn-secondary">
            <i class="fas fa-home"></i>
            Back to Quizzes
          </a>
          <button class="action-btn btn-primary" onclick="restartQuiz()">
            <i class="fas fa-redo"></i>
            Retake Quiz
          </button>
          <button class="action-btn btn-success" onclick="shareResults()">
            <i class="fas fa-share-alt"></i>
            Share Results
          </button>
        </div>
      </div>

      <!-- Performance Chart -->
      <div class="performance-card">
        <h3 class="section-title">
          <i class="fas fa-chart-pie"></i>
          Performance Breakdown
        </h3>
        <div class="performance-bar">
          <div class="performance-fill fill-correct" id="correctBar" style="width: 0%"></div>
          <div class="performance-fill fill-incorrect" id="incorrectBar" style="width: 0%"></div>
          <div class="performance-fill fill-skipped" id="skippedBar" style="width: 0%"></div>
        </div>
        <div class="performance-labels">
          <span>Correct: <span id="correctPercent">0%</span></span>
          <span>Incorrect: <span id="incorrectPercent">0%</span></span>
          <span>Skipped: <span id="skippedPercent">0%</span></span>
        </div>
      </div>

      <!-- Detailed Results -->
      <div class="detailed-results">
        <h3 class="section-title">
          <i class="fas fa-list-check"></i>
          Question-wise Analysis
        </h3>
        <div class="question-list" id="questionList">
          <!-- Questions will be dynamically inserted by JavaScript -->
        </div>
      </div>
    </div>
  </main>

  <script>
    // Get results from localStorage
    const results = JSON.parse(localStorage.getItem('quizResults'));
    const noResultsDiv = document.getElementById('noResults');
    const resultsContent = document.getElementById('resultsContent');

    if (!results) {
      noResultsDiv.style.display = 'block';
    } else {
      resultsContent.style.display = 'block';
      displayResults(results);
    }

    function displayResults(results) {
      // Update summary
      document.getElementById('finalScoreDisplay').textContent = 
        results.score + '/' + results.total;
      
      const percentage = Math.round((results.score / results.total) * 100);
      document.getElementById('percentageScore').textContent = percentage + '%';
      
      // Calculate stats
      const correct = results.score;
      const incorrect = results.answers.filter(function(answer, i) {
        return answer !== null && answer !== results.questions[i].correct;
      }).length;
      const skipped = results.answers.filter(function(answer) {
        return answer === null;
      }).length;
      
      document.getElementById('correctAnswers').textContent = correct;
      document.getElementById('incorrectAnswers').textContent = incorrect;
      document.getElementById('skippedAnswers').textContent = skipped;
      
      // Time spent
      const minutes = Math.floor(results.timeSpent / 60);
      const seconds = results.timeSpent % 60;
      document.getElementById('timeSpent').textContent = 
        minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
      
      // Performance chart
      const correctPercent = (correct / results.total) * 100;
      const incorrectPercent = (incorrect / results.total) * 100;
      const skippedPercent = (skipped / results.total) * 100;
      
      document.getElementById('correctBar').style.width = correctPercent + '%';
      document.getElementById('incorrectBar').style.width = incorrectPercent + '%';
      document.getElementById('skippedBar').style.width = skippedPercent + '%';
      
      document.getElementById('correctPercent').textContent = Math.round(correctPercent) + '%';
      document.getElementById('incorrectPercent').textContent = Math.round(incorrectPercent) + '%';
      document.getElementById('skippedPercent').textContent = Math.round(skippedPercent) + '%';
      
      // Display detailed questions
      const questionList = document.getElementById('questionList');
      questionList.innerHTML = '';
      
      results.questions.forEach(function(question, index) {
        const userAnswer = results.answers[index];
        const isCorrect = userAnswer === question.correct;
        const isSkipped = userAnswer === null;
        
        const questionItem = document.createElement('div');
        questionItem.className = 'question-item ' + (isCorrect ? 'correct' : isSkipped ? 'unanswered' : 'incorrect');
        
        let statusText = isCorrect ? 'Correct' : isSkipped ? 'Skipped' : 'Incorrect';
        
        // Build options HTML
        let optionsHTML = '';
        question.options.forEach(function(option, i) {
          let optionClass = 'option';
          if (i === question.correct) optionClass += ' correct';
          if (i === userAnswer && !isCorrect) optionClass += ' incorrect';
          if (i === userAnswer) optionClass += ' selected';
          
          optionsHTML += '<div class="' + optionClass + '">' +
            '<div class="option-letter">' + String.fromCharCode(65 + i) + '</div>' +
            '<div class="option-text">' + option + '</div>' +
            '</div>';
        });
        
        // Build question HTML
        questionItem.innerHTML = 
          '<div class="question-header">' +
            '<div class="question-number">' + (index + 1) + '</div>' +
            '<div class="question-status">' + statusText + '</div>' +
          '</div>' +
          '<div class="question-text">' + question.question + '</div>' +
          '<div class="options-list">' + optionsHTML + '</div>' +
          (question.explanation ? 
            '<div class="explanation">' +
              '<strong>Explanation:</strong> ' + question.explanation +
            '</div>' : '');
        
        questionList.appendChild(questionItem);
      });
    }

    function restartQuiz() {
      // Get the current quiz subject from localStorage
      const quizSubject = localStorage.getItem('currentQuiz');
      if (quizSubject) {
        window.location.href = '/' + quizSubject + '-quiz';
      } else {
        window.location.href = '/';
      }
    }

    function shareResults() {
      const results = JSON.parse(localStorage.getItem('quizResults'));
      if (!results) return;
      
      const percentage = Math.round((results.score / results.total) * 100);
      const shareText = 'I scored ' + results.score + '/' + results.total + ' (' + percentage + '%) on the programming quiz! Test your skills at EduEra.';
      
      if (navigator.share) {
        navigator.share({
          title: 'My Quiz Results',
          text: shareText,
          url: window.location.href
        });
      } else {
        // Fallback: Copy to clipboard
        navigator.clipboard.writeText(shareText + ' ' + window.location.href)
          .then(function() {
            alert('Results copied to clipboard!');
          });
      }
    }

    // Set quiz subject in header if available
    const quizSubject = localStorage.getItem('currentQuiz');
    if (quizSubject) {
      const subjectNames = {
        'c': 'C Programming',
        'cpp': 'C++ Programming',
        'java': 'Java Programming',
        'python': 'Python Programming',
        'javascript': 'JavaScript',
        'fullstack': 'Full-Stack Development',
        'android': 'Android Development',
        'software-engineering': 'Software Engineering',
        'git': 'Git & GitHub',
        'dsa': 'Data Structures & Algorithms',
        'os': 'Operating Systems',
        'dbms': 'Database Management System',
        'networks': 'Computer Networks',
        'ai': 'Artificial Intelligence',
        'cloud': 'Cloud Computing',
        'cybersecurity': 'Cyber Security'
      };
      
      document.getElementById('quizSubject').textContent = 
        (subjectNames[quizSubject] || 'Quiz') + ' Results';
    }
  </script>
</body>
</html>