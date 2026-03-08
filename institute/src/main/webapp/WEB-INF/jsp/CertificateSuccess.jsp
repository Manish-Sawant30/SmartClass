<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate of Completion | EduEra</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <!-- html2canvas for certificate download -->
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    
    <style>
        :root {
            --primary-blue: #002b5c;
            --secondary-blue: #00509e;
            --accent-gold: #d4af37;
            --dark-gold: #b8860b;
            --light-bg: #f8f9fa;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .certificate-wrapper {
            max-width: 1100px;
            width: 100%;
        }

        .certificate {
            background: white;
            padding: 60px;
            border-radius: 20px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.3);
            position: relative;
            border: 15px solid #f0f0f0;
            text-align: center;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(212, 175, 55, 0.05) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(0, 43, 92, 0.05) 0%, transparent 20%);
        }

        .certificate::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 20px;
            right: 20px;
            bottom: 20px;
            border: 2px solid var(--accent-gold);
            border-radius: 10px;
            pointer-events: none;
        }

        .watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-45deg);
            font-size: 120px;
            color: rgba(212, 175, 55, 0.1);
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 20px;
            pointer-events: none;
            white-space: nowrap;
            font-family: 'Montserrat', sans-serif;
            z-index: 0;
        }

        .certificate-content {
            position: relative;
            z-index: 1;
        }

        .certificate-header {
            margin-bottom: 40px;
        }

        .institute-name {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 700;
            color: var(--primary-blue);
            letter-spacing: 2px;
            margin-bottom: 10px;
        }

        .institute-tagline {
            font-size: 1.1rem;
            color: #666;
            letter-spacing: 1px;
        }

        .certificate-title {
            font-size: 2.5rem;
            color: var(--accent-gold);
            font-weight: 600;
            margin: 30px 0;
            text-transform: uppercase;
            letter-spacing: 3px;
            position: relative;
            display: inline-block;
        }

        .certificate-title::before,
        .certificate-title::after {
            content: '✦';
            color: var(--accent-gold);
            margin: 0 20px;
            font-size: 1.5rem;
        }

        .awarded-to {
            font-size: 1.2rem;
            color: #666;
            margin: 20px 0 10px;
        }

        .student-name {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            color: var(--primary-blue);
            margin: 10px 0;
            padding: 20px 0;
            border-top: 3px solid var(--accent-gold);
            border-bottom: 3px solid var(--accent-gold);
        }

        .course-name {
            font-size: 2rem;
            color: var(--secondary-blue);
            font-weight: 600;
            margin: 20px 0;
        }

        .completion-text {
            font-size: 1.1rem;
            color: #666;
            max-width: 600px;
            margin: 20px auto;
            line-height: 1.8;
        }

        .performance-details {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            padding: 30px;
            margin: 30px 0;
            border: 1px solid var(--accent-gold);
        }

        .performance-title {
            color: var(--primary-blue);
            font-weight: 600;
            margin-bottom: 20px;
            font-size: 1.3rem;
        }

        .score-box {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            height: 100%;
        }

        .score-label {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .score-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-blue);
        }

        .score-unit {
            font-size: 1rem;
            color: #999;
        }

        .grade-box {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, var(--accent-gold), var(--dark-gold));
            color: white;
            border-radius: 50px;
            font-size: 2rem;
            font-weight: 700;
            margin: 10px;
            box-shadow: 0 4px 10px rgba(212, 175, 55, 0.3);
        }

        .certificate-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 50px;
            padding-top: 30px;
            border-top: 2px solid var(--accent-gold);
        }

        .signature {
            text-align: center;
            flex: 1;
        }

        .signature-line {
            width: 200px;
            height: 2px;
            background: #333;
            margin: 10px auto;
        }

        .signature-name {
            font-weight: 600;
            color: var(--primary-blue);
            margin-top: 5px;
        }

        .signature-title {
            color: #666;
            font-size: 0.9rem;
        }

        .certificate-id {
            margin-top: 30px;
            padding: 15px;
            background: var(--light-bg);
            border-radius: 8px;
            display: inline-block;
        }

        .certificate-id-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 5px;
        }

        .certificate-id-value {
            font-family: monospace;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary-blue);
            letter-spacing: 1px;
        }

        .issue-date {
            margin-top: 10px;
            color: #666;
            font-size: 0.95rem;
        }

        .action-buttons {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .btn-custom {
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-download {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
        }

        .btn-print {
            background: white;
            color: var(--primary-blue);
            border: 2px solid var(--primary-blue);
        }

        .btn-back {
            background: #6c757d;
            color: white;
        }

        .btn-download:hover, .btn-print:hover, .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .not-eligible {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .not-eligible i {
            color: #dc3545;
        }

        .verification-badge {
            position: absolute;
            top: 30px;
            right: 30px;
            background: var(--accent-gold);
            color: var(--primary-blue);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            z-index: 2;
        }

        @media print {
            body { 
                background: white; 
                padding: 0; 
            }
            .action-buttons, .no-print { 
                display: none; 
            }
            .certificate { 
                box-shadow: none; 
                border: 2px solid #000;
                padding: 40px;
            }
            .verification-badge {
                background: #f0f0f0;
                color: #333;
            }
        }

        @media (max-width: 768px) {
            .certificate {
                padding: 30px 20px;
            }
            
            .institute-name {
                font-size: 2.5rem;
            }
            
            .certificate-title {
                font-size: 1.8rem;
            }
            
            .student-name {
                font-size: 2.2rem;
            }
            
            .course-name {
                font-size: 1.5rem;
            }
            
            .certificate-footer {
                flex-direction: column;
                gap: 30px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-custom {
                width: 100%;
                justify-content: center;
            }
            
            .verification-badge {
                position: static;
                margin-bottom: 20px;
                display: inline-block;
            }
        }
    </style>
</head>
<body>
    <div class="certificate-wrapper">
        <c:choose>
            <c:when test="${not empty certificate}">
                <!-- Certificate -->
                <div class="certificate" id="certificateContent">
                    <div class="watermark">EDU ERA</div>
                    
                    <!-- Verification Badge -->
                    <div class="verification-badge">
                        <i class="fas fa-shield-alt me-2"></i>VERIFIED CERTIFICATE
                    </div>
                    
                    <div class="certificate-content">
                        <!-- Header -->
                        <div class="certificate-header">
                            <div class="institute-name">EduEra Institute</div>
                            <div class="institute-tagline">Excellence in Education Since 2010</div>
                        </div>
                        
                        <!-- Title -->
                        <div class="certificate-title">Certificate of Achievement</div>
                        
                        <!-- Body -->
                        <div class="awarded-to">This certificate is proudly presented to</div>
                        <div class="student-name">${certificate.studentName}</div>
                        
                        <div class="course-name">${certificate.courseName}</div>
                        
                        <div class="completion-text">
                            In recognition of outstanding academic achievement and successful completion 
                            of all course requirements with demonstrated excellence.
                        </div>
                        <center>
                        <!-- Performance Details -->
                        <div class="performance-details">
                            <div class="performance-title">
                                <i class="fas fa-chart-line me-2"></i>Academic Performance Summary
                            </div>
                            <div class="row">
                                <div class="col-md-4 mb-3 mb-md-0">
                                    <div class="score-box">
                                        <div class="score-label">Unit Tests Average</div>
                                        <div class="score-value">
                                            ${unitTestAvg}%
                                        </div>
                                    </div>
                                </div>
                               
                                <div class="col-md-4">
                                    <div class="score-box">
                                        <div class="score-label">Overall Grade</div>
                                        <div class="grade-box">${grade}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </center>
                        <!-- Footer -->
                        <div class="certificate-footer">
                            <div class="signature">
                                <div class="signature-line"></div>
                                <div class="signature-name">Dr. Sarah Johnson</div>
                                <div class="signature-title">Director, EduEra Institute</div>
                            </div>
                            <div class="signature">
                                <div class="signature-line"></div>
                                <div class="signature-name">Prof. Michael Chen</div>
                                <div class="signature-title">Head of Academics</div>
                            </div>
                        </div>
                        
                        <!-- Certificate ID -->
                        <div class="certificate-id">
                            <div class="certificate-id-label">Certificate ID</div>
                            <div class="certificate-id-value">${certificate.certificateId}</div>
                        </div>
                        
                        <!-- Issue Date - SIMPLIFIED VERSION -->
                        <div class="issue-date">
                            <i class="fas fa-calendar-alt me-2"></i>
                            Issued on: ${issueDate}
                        </div>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons no-print">
                    <button class="btn-custom btn-download" onclick="downloadCertificate()">
                        <i class="fas fa-download me-2"></i>Download Certificate
                    </button>
                    <button class="btn-custom btn-print" onclick="window.print()">
                        <i class="fas fa-print me-2"></i>Print Certificate
                    </button>
                    <a href="${pageContext.request.contextPath}/certificate/verify" class="btn-custom btn-back">
                        <i class="fas fa-arrow-left me-2"></i>Back to Verification
                    </a>
                </div>
                
                <!-- Share Info -->
                <div class="alert alert-info mt-4 no-print">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-info-circle fs-4 me-3"></i>
                        <div>
                            <strong>Certificate Verification:</strong> This certificate can be verified online using the certificate ID: <strong>${certificate.certificateId}</strong>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Not Eligible Message -->
                <div class="not-eligible">
                    <i class="fas fa-exclamation-triangle fa-4x" style="color: #dc3545;"></i>
                    <h2 class="mt-4">Certificate Not Available</h2>
                    <p class="lead">You are not eligible for a certificate at this time.</p>
                    <div class="alert alert-info mt-4 text-start">
                        <h5><i class="fas fa-clipboard-list me-2"></i>Requirements for Certificate:</h5>
                        <ul class="mt-3">
                            <li class="mb-2">✓ Complete all unit tests with minimum 50% score</li>
                            <li class="mb-2">✓ Pass the final test with minimum 50% score</li>
                            <li class="mb-2">✓ Maintain active student status</li>
                        </ul>
                    </div>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/student-course" class="btn btn-primary btn-lg me-2">
                            <i class="fas fa-book-open me-2"></i>Go to Courses
                        </a>
                        <a href="${pageContext.request.contextPath}/certificate/verify" class="btn btn-secondary btn-lg">
                            <i class="fas fa-redo me-2"></i>Try Again
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function downloadCertificate() {
            const certificate = document.getElementById('certificateContent');
            const studentName = '${certificate.studentName}'.replace(/\s+/g, '_');
            
            // Show loading state
            const downloadBtn = document.querySelector('.btn-download');
            const originalHtml = downloadBtn.innerHTML;
            downloadBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Generating...';
            downloadBtn.disabled = true;
            
            html2canvas(certificate, {
                scale: 2,
                backgroundColor: '#ffffff',
                logging: false,
                allowTaint: true,
                useCORS: true
            }).then(canvas => {
                // Create download link
                const link = document.createElement('a');
                link.download = 'EduEra_Certificate_' + studentName + '_' + new Date().getTime() + '.png';
                link.href = canvas.toDataURL('image/png');
                link.click();
                
                // Reset button
                downloadBtn.innerHTML = originalHtml;
                downloadBtn.disabled = false;
            }).catch(error => {
                console.error('Error generating certificate:', error);
                alert('Error generating certificate. Please try again.');
                downloadBtn.innerHTML = originalHtml;
                downloadBtn.disabled = false;
            });
        }
        
        // Add certificate border animation on load
        document.addEventListener('DOMContentLoaded', function() {
            const certificate = document.querySelector('.certificate');
            if (certificate) {
                certificate.style.animation = 'fadeIn 1s ease-out';
            }
        });
        
        // Simple confetti effect for celebration
        function createConfetti() {
            if (Math.random() > 0.5) {
                const colors = ['#d4af37', '#002b5c', '#00509e', '#ffdd59'];
                
                for (let i = 0; i < 30; i++) {
                    const confetti = document.createElement('div');
                    confetti.style.cssText = 
                        'position: fixed;' +
                        'width: 10px;' +
                        'height: 10px;' +
                        'background: ' + colors[Math.floor(Math.random() * colors.length)] + ';' +
                        'top: -20px;' +
                        'left: ' + (Math.random() * 100) + '%;' +
                        'border-radius: 50%;' +
                        'opacity: 0.7;' +
                        'z-index: 9999;' +
                        'animation: fall ' + (Math.random() * 3 + 2) + 's linear forwards;' +
                        'pointer-events: none;';
                    
                    document.body.appendChild(confetti);
                    
                    setTimeout(() => {
                        if (confetti.parentNode) {
                            confetti.remove();
                        }
                    }, 5000);
                }
                
                // Add CSS for confetti animation if not exists
                if (!document.getElementById('confetti-style')) {
                    const style = document.createElement('style');
                    style.id = 'confetti-style';
                    style.textContent = `
                        @keyframes fall {
                            to {
                                transform: translateY(100vh) rotate(360deg);
                                opacity: 0;
                            }
                        }
                    `;
                    document.head.appendChild(style);
                }
            }
        }
        
        // Trigger confetti on page load for celebration
        window.addEventListener('load', function() {
            if ('${not empty certificate}') {
                setTimeout(createConfetti, 500);
            }
        });
    </script>
</body>
</html>