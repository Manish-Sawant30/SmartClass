<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cyber Security Quiz | EduEra</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    :root {
      --primary-blue: #003b8e;
      --dark-blue: #001f54;
      --light-blue: #82e3f6;
      --success-green: #22a65b;
      --warning-orange: #ff9203;
      --danger-red: #dc3545;
      --security-red: #dc2626;
      --security-dark: #991b1b;
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
      background: linear-gradient(135deg, var(--security-red), var(--security-dark));
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
      color: white;
    }

    .progress-bar {
      height: 8px;
      background: rgba(255, 255, 255, 0.2);
      border-radius: 4px;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, #fca5a5, var(--security-red));
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
      background: var(--security-red);
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
      border-color: var(--security-red);
      transform: translateY(-2px);
      box-shadow: var(--shadow);
    }

    .option.selected {
      background: #fee2e2;
      border-color: var(--security-red);
      box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
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
      background: var(--security-red);
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
      background: var(--security-red);
      color: white;
    }

    .btn-next:hover {
      background: var(--security-dark);
      transform: translateX(2px);
      box-shadow: 0 4px 12px rgba(220, 38, 38, 0.2);
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
      color: var(--security-red);
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
      background: var(--security-red);
      color: white;
      border-color: var(--security-red);
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
      background: #fee2e2;
      color: var(--security-red);
    }

    .btn-review:hover {
      background: #fecaca;
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
      background: var(--security-red);
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
      color: var(--security-red);
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
      color: var(--security-red);
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
      background: var(--security-red);
      color: white;
    }

    .modal-btn-primary:hover {
      background: var(--security-dark);
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
        <i class="fas fa-shield-alt"></i>
        Cyber Security Quiz
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
        question: "What is phishing in cybersecurity?",
        options: ["Fraudulent attempt to obtain sensitive information", "Malware that encrypts files", "Unauthorized network access", "Software vulnerability"],
        correct: 0,
        explanation: "Phishing uses deceptive emails/messages to trick users into revealing sensitive information."
      },
      {
        question: "Which is NOT a type of malware?",
        options: ["Virus", "Worm", "Firewall", "Trojan"],
        correct: 2,
        explanation: "Firewall is a security device, not malware. Malware includes viruses, worms, Trojans, etc."
      },
      {
        question: "What does VPN stand for?",
        options: ["Virtual Private Network", "Virtual Public Network", "Verified Private Network", "Virtual Protected Network"],
        correct: 0,
        explanation: "VPN = Virtual Private Network - creates secure encrypted connection over public networks."
      },
      {
        question: "What is two-factor authentication (2FA)?",
        options: ["Using two different authentication methods", "Using password twice", "Two different passwords", "Two security questions"],
        correct: 0,
        explanation: "2FA requires two different authentication factors: something you know (password) and something you have (phone)."
      },
      {
        question: "Which attack floods a network with traffic?",
        options: ["DDoS", "Phishing", "MITM", "SQL Injection"],
        correct: 0,
        explanation: "DDoS (Distributed Denial of Service) floods target with traffic to overwhelm resources."
      },
      {
        question: "What is encryption?",
        options: ["Converting data into secret code", "Deleting sensitive data", "Backing up data", "Scanning for viruses"],
        correct: 0,
        explanation: "Encryption converts plaintext into ciphertext to protect data confidentiality."
      },
      {
        question: "Which is a symmetric encryption algorithm?",
        options: ["AES", "RSA", "ECC", "DSA"],
        correct: 0,
        explanation: "AES (Advanced Encryption Standard) is symmetric encryption using same key for encryption/decryption."
      },
      {
        question: "What is social engineering?",
        options: ["Manipulating people to reveal information", "Hacking software systems", "Breaking encryption", "Network scanning"],
        correct: 0,
        explanation: "Social engineering manipulates people into breaking security procedures or revealing confidential information."
      },
      {
        question: "What does SSL/TLS provide?",
        options: ["Secure communication over networks", "Virus protection", "Firewall protection", "Data backup"],
        correct: 0,
        explanation: "SSL/TLS protocols provide secure encrypted communication between web browsers and servers."
      },
      {
        question: "Which is a network security device?",
        options: ["Firewall", "Router", "Switch", "All of these"],
        correct: 3,
        explanation: "All can include security features, though firewalls are specifically designed for security."
      },
      {
        question: "What is a zero-day vulnerability?",
        options: ["Unknown vulnerability with no patch", "Vulnerability on day zero", "Weak password vulnerability", "Network configuration error"],
        correct: 0,
        explanation: "Zero-day vulnerability is unknown to software vendor with no available patch when discovered."
      },
      {
        question: "Which protocol is used for secure email?",
        options: ["PGP", "SMTP", "POP3", "IMAP"],
        correct: 0,
        explanation: "PGP (Pretty Good Privacy) provides cryptographic privacy and authentication for email."
      },
      {
        question: "What is penetration testing?",
        options: ["Authorized simulated cyberattack", "Unauthorized hacking", "Network monitoring", "Virus scanning"],
        correct: 0,
        explanation: "Penetration testing is authorized simulated attack to evaluate system security."
      },
      {
        question: "Which is NOT a password best practice?",
        options: ["Use common dictionary words", "Use long passwords", "Enable 2FA", "Use password manager"],
        correct: 0,
        explanation: "Using common dictionary words makes passwords easy to crack through dictionary attacks."
      },
      {
        question: "What is ransomware?",
        options: ["Malware that encrypts files for ransom", "Malware that steals data", "Malware that monitors activity", "Malware that spreads rapidly"],
        correct: 0,
        explanation: "Ransomware encrypts victim's files and demands ransom payment for decryption key."
      },
      {
        question: "Which law protects digital privacy in the US?",
        options: ["HIPAA", "GDPR", "CCPA", "All of these"],
        correct: 3,
        explanation: "All are privacy laws: HIPAA (health), GDPR (EU), CCPA (California) protect digital privacy."
      },
      {
        question: "What is a honeypot in cybersecurity?",
        options: ["Decoy system to attract attackers", "Password cracking tool", "Encryption method", "Firewall configuration"],
        correct: 0,
        explanation: "Honeypot is decoy system designed to attract and study cyber attackers."
      },
      {
        question: "Which encryption is asymmetric?",
        options: ["RSA", "AES", "DES", "3DES"],
        correct: 0,
        explanation: "RSA is asymmetric encryption using public/private key pair. Others are symmetric."
      },
      {
        question: "What is SQL injection?",
        options: ["Injecting malicious SQL code", "Stealing SQL databases", "Corrupting SQL servers", "Encrypting SQL data"],
        correct: 0,
        explanation: "SQL injection inserts malicious SQL code into database queries to manipulate databases."
      },
      {
        question: "Which is a biometric authentication method?",
        options: ["Fingerprint scan", "Facial recognition", "Iris scan", "All of these"],
        correct: 3,
        explanation: "All are biometric authentication methods using unique physical characteristics."
      },
      {
        question: "What is the CIA triad in security?",
        options: ["Confidentiality, Integrity, Availability", "Cybersecurity, Internet, Authentication", "Coding, Implementation, Analysis", "Confidentiality, Identification, Authorization"],
        correct: 0,
        explanation: "CIA triad: Confidentiality (privacy), Integrity (accuracy), Availability (accessibility)."
      },
      {
        question: "Which tool is used for network analysis?",
        options: ["Wireshark", "Nmap", "Metasploit", "Burp Suite"],
        correct: 0,
        explanation: "Wireshark is network protocol analyzer for capturing and analyzing network traffic."
      },
      {
        question: "What is a security audit?",
        options: ["Systematic evaluation of security", "Random security check", "Daily security scan", "Annual security training"],
        correct: 0,
        explanation: "Security audit is systematic evaluation of security controls and compliance with policies."
      },
      {
        question: "Which is NOT a cybersecurity certification?",
        options: ["CEH", "CISSP", "CCNA", "MBA"],
        correct: 3,
        explanation: "MBA is business degree, not cybersecurity certification. Others are security certifications."
      },
      {
        question: "What is the purpose of incident response plan?",
        options: ["Prepare for security incidents", "Prevent all attacks", "Replace security tools", "Train all employees"],
        correct: 0,
        explanation: "Incident response plan prepares organization to detect, respond to, and recover from security incidents."
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
      localStorage.setItem('currentQuiz', 'cybersecurity');
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
        quizName: 'Cyber Security Quiz',
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