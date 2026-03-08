<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate of Achievement | EduEra</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- html2canvas for certificate download -->
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    
    <style>
        :root {
            --gold: #d4af37;
            --gold-light: #f4e4a6;
            --gold-dark: #b8941f;
            --blue-dark: #002b5c;
            --blue-light: #00509e;
            --white: #ffffff;
            --cream: #f9f6f0;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            padding: 20px;
        }

        /* Certificate Container */
        .certificate-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Certificate Paper */
        .certificate-paper {
            background: var(--white);
            border: 20px solid var(--gold);
            border-radius: 15px;
            padding: 50px;
            position: relative;
            box-shadow: var(--shadow);
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(255, 255, 255, 0.8) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(255, 255, 255, 0.8) 0%, transparent 20%),
                url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><path d="M0,0 L100,0 L100,100 L0,100 Z" fill="none" stroke="%23d4af37" stroke-width="0.5" stroke-dasharray="5,5"/></svg>');
            background-size: cover;
            min-height: 700px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        /* Certificate Border Effects */
        .certificate-paper::before,
        .certificate-paper::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 40px;
            border: 3px solid var(--gold);
        }

        .certificate-paper::before {
            top: -10px;
            left: -10px;
            border-right: none;
            border-bottom: none;
        }

        .certificate-paper::after {
            bottom: -10px;
            right: -10px;
            border-left: none;
            border-top: none;
        }

        /* Certificate Header */
        .certificate-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        .certificate-header::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 25%;
            width: 50%;
            height: 2px;
            background: linear-gradient(to right, transparent, var(--gold), transparent);
        }

        .institute-name {
            font-family: 'Montserrat', sans-serif;
            font-size: 3.5rem;
            font-weight: 700;
            color: var(--blue-dark);
            letter-spacing: 2px;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .institute-tagline {
            font-family: 'Poppins', sans-serif;
            font-size: 1.2rem;
            color: var(--blue-light);
            font-weight: 500;
            letter-spacing: 1px;
        }

        /* Certificate Title */
        .certificate-title {
            text-align: center;
            margin: 40px 0;
        }

        .certificate-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            color: var(--gold-dark);
            text-transform: uppercase;
            letter-spacing: 3px;
            position: relative;
            display: inline-block;
        }

        .certificate-title h1::before,
        .certificate-title h1::after {
            content: '✦';
            color: var(--gold);
            margin: 0 20px;
            font-size: 1.5rem;
        }

        /* Certificate Body */
        .certificate-body {
            text-align: center;
            margin: 40px 0;
            padding: 0 50px;
        }

        .award-text {
            font-size: 1.8rem;
            line-height: 1.6;
            color: #333;
            margin-bottom: 30px;
        }

        .student-name {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 700;
            color: var(--blue-dark);
            margin: 20px 0;
            padding: 20px 0;
            border-top: 3px double var(--gold);
            border-bottom: 3px double var(--gold);
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .course-name {
            font-size: 2.2rem;
            color: var(--blue-light);
            font-weight: 600;
            margin: 20px 0;
            font-style: italic;
        }

        .completion-text {
            font-size: 1.4rem;
            color: #666;
            max-width: 800px;
            margin: 30px auto;
            line-height: 1.8;
        }

        /* Certificate Footer */
        .certificate-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 60px;
            padding-top: 30px;
            border-top: 2px solid var(--gold);
            width: 100%;
        }

        .signature-box {
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
            color: var(--blue-dark);
            margin-top: 5px;
        }

        .signature-title {
            color: #666;
            font-size: 0.9rem;
        }

        .date-box {
            text-align: center;
            flex: 1;
        }

        .date {
            font-weight: 600;
            color: var(--blue-dark);
            font-size: 1.1rem;
        }

        /* Certificate ID Section */
        .certificate-id {
            text-align: center;
            margin-top: 30px;
            padding: 15px;
            background: rgba(212, 175, 55, 0.1);
            border-radius: 8px;
            display: inline-block;
        }

        .certificate-id-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 5px;
        }

        .certificate-id-value {
            font-family: 'Courier New', monospace;
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--blue-dark);
            letter-spacing: 1px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-download {
            background: linear-gradient(135deg, var(--blue-light), var(--blue-dark));
            color: white;
        }

        .btn-download:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 80, 158, 0.3);
        }

        .btn-print {
            background: white;
            color: var(--blue-dark);
            border: 2px solid var(--blue-dark);
        }

        .btn-print:hover {
            background: var(--blue-dark);
            color: white;
        }

        .btn-back {
            background: #6c757d;
            color: white;
        }

        .btn-back:hover {
            background: #5a6268;
        }

        /* Verification Badge */
        .verification-badge {
            position: absolute;
            top: 30px;
            right: 30px;
            background: var(--gold);
            color: var(--blue-dark);
            padding: 10px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(212, 175, 55, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .certificate-paper {
                padding: 30px;
                min-height: 600px;
            }
            
            .institute-name {
                font-size: 2.8rem;
            }
            
            .student-name {
                font-size: 3rem;
            }
            
            .course-name {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 768px) {
            .certificate-paper {
                padding: 20px;
                border-width: 15px;
            }
            
            .institute-name {
                font-size: 2.2rem;
            }
            
            .certificate-title h1 {
                font-size: 2.2rem;
            }
            
            .student-name {
                font-size: 2.5rem;
            }
            
            .course-name {
                font-size: 1.5rem;
            }
            
            .certificate-body {
                padding: 0 20px;
            }
            
            .certificate-footer {
                flex-direction: column;
                gap: 30px;
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .action-btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
            
            .verification-badge {
                position: static;
                margin-bottom: 20px;
            }
        }

        @media (max-width: 480px) {
            .certificate-paper {
                padding: 15px;
                border-width: 10px;
            }
            
            .institute-name {
                font-size: 1.8rem;
            }
            
            .certificate-title h1 {
                font-size: 1.8rem;
            }
            
            .student-name {
                font-size: 2rem;
            }
            
            .award-text {
                font-size: 1.4rem;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .certificate-paper {
            animation: fadeIn 1s ease-out;
        }

        /* Watermark */
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
        }
    </style>
</head>
<body>
    <div class="certificate-container">
        <!-- Certificate Paper -->
        <div class="certificate-paper" id="certificateContent">
            <!-- Watermark -->
            <div class="watermark">EDU ERA</div>
            
            <!-- Verification Badge -->
            <div class="verification-badge">
                <i class="fas fa-shield-alt"></i> VERIFIED CERTIFICATE
            </div>
            
            <!-- Certificate Header -->
            <div class="certificate-header">
                <div class="institute-name">EduEra Institute</div>
                <div class="institute-tagline">Excellence in Education Since 2010</div>
            </div>
            
            <!-- Certificate Title -->
            <div class="certificate-title">
                <h1>Certificate of Achievement</h1>
            </div>
            
            <!-- Certificate Body -->
            <div class="certificate-body">
                <div class="award-text">
                    This certificate is proudly presented to
                </div>
                
                <div class="student-name">
                    ${certificate.fullName}
                </div>
                
                <div class="course-name">
                    For successfully completing the course in<br>
                    <strong>${certificate.courseName}</strong>
                </div>
                
                <div class="completion-text">
                    In recognition of dedication, hard work, and successful completion 
                    of all course requirements. This achievement demonstrates a strong 
                    commitment to learning and professional development.
                </div>
            </div>
            
            <!-- Certificate Footer -->
            <div class="certificate-footer">
                <div class="signature-box">
                    <div class="signature-line"></div>
                    <div class="signature-name">Dr. Sarah Johnson</div>
                    <div class="signature-title">Director, EduEra Institute</div>
                </div>
                
                <div class="date-box">
                    <div>Date of Issue</div>
                    <div class="date">${certificate.issueDate}</div>
                </div>
                
                <div class="signature-box">
                    <div class="signature-line"></div>
                    <div class="signature-name">Prof. Michael Chen</div>
                    <div class="signature-title">Head of Academics</div>
                </div>
            </div>
            
            <!-- Certificate ID -->
            <div class="certificate-id">
                <div class="certificate-id-label">Certificate ID</div>
                <div class="certificate-id-value">${certificate.certificateId}</div>
                <div class="mt-2 small text-muted">
                    <i class="fas fa-qrcode me-1"></i>
                    Verification Code: ${certificate.verificationCode}
                </div>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
            <button class="action-btn btn-download" onclick="downloadCertificate()">
                <i class="fas fa-download"></i> Download Certificate (PDF)
            </button>
            
            <button class="action-btn btn-print" onclick="printCertificate()">
                <i class="fas fa-print"></i> Print Certificate
            </button>
            
            <a href="${pageContext.request.contextPath}/certificate/verify" class="action-btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Verification
            </a>
        </div>
        
        <!-- Additional Info -->
        <div class="alert alert-info mt-4">
            <div class="d-flex align-items-center">
                <i class="fas fa-info-circle fs-4 me-3"></i>
                <div>
                    <strong>Certificate Verification:</strong> This certificate can be verified online using the 
                    verification code. Share this code for authenticity verification.
                </div>
            </div>
        </div>
    </div>

    <script>
        // Store certificate data in JavaScript variable
        const certificateData = {
            fullName: "${certificate.fullName}",
            courseName: "${certificate.courseName}",
            certificateId: "${certificate.certificateId}",
            verificationCode: "${certificate.verificationCode}",
            issueDate: "${certificate.issueDate}"
        };
        
        // Download Certificate as PDF/Image
        function downloadCertificate() {
            const certificate = document.getElementById('certificateContent');
            const downloadBtn = document.querySelector('.btn-download');
            
            // Show loading state
            const originalHtml = downloadBtn.innerHTML;
            downloadBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Generating PDF...';
            downloadBtn.disabled = true;
            
            // Use html2canvas to capture certificate
            html2canvas(certificate, {
                scale: 2,
                useCORS: true,
                backgroundColor: '#ffffff'
            }).then(canvas => {
                // Convert canvas to image
                const imgData = canvas.toDataURL('image/png');
                
                // Create download link
                const link = document.createElement('a');
                link.download = 'EduEra_Certificate_' + certificateData.fullName.replace(/\s+/g, '_') + '_' + new Date().getTime() + '.png';
                link.href = imgData;
                link.click();
                
                // Reset button
                downloadBtn.innerHTML = originalHtml;
                downloadBtn.disabled = false;
                
                // Show success message
                showToast('Certificate downloaded successfully!', 'success');
            }).catch(error => {
                console.error('Error generating certificate:', error);
                downloadBtn.innerHTML = originalHtml;
                downloadBtn.disabled = false;
                showToast('Error downloading certificate. Please try again.', 'error');
            });
        }
        
        // Print Certificate
        function printCertificate() {
            const originalContent = document.body.innerHTML;
            const certificateContent = document.getElementById('certificateContent').innerHTML;
            
            document.body.innerHTML = `
                <!DOCTYPE html>
                <html>
                <head>
                    <title>EduEra Certificate - ` + certificateData.fullName + `</title>
                    <style>
                        @media print {
                            body { margin: 0; padding: 20px; }
                            @page { size: landscape; margin: 0; }
                        }
                        .no-print { display: none !important; }
                        * { box-sizing: border-box; }
                        body { font-family: Arial, sans-serif; }
                    </style>
                </head>
                <body>
                    ` + certificateContent + `
                    <div class="no-print" style="text-align: center; margin-top: 20px;">
                        <button onclick="window.print()">Print Certificate</button>
                        <button onclick="window.close()">Close</button>
                    </div>
                </body>
                </html>
            `;
            
            window.print();
            document.body.innerHTML = originalContent;
            window.location.reload();
        }
        
        // Show Toast Notification
        function showToast(message, type) {
            const toast = document.createElement('div');
            
            // Determine icon based on type
            let iconClass = 'fa-info-circle';
            if (type === 'success') {
                iconClass = 'fa-check-circle';
            } else if (type === 'error') {
                iconClass = 'fa-exclamation-circle';
            } else if (type === 'warning') {
                iconClass = 'fa-exclamation-triangle';
            }
            
            toast.className = 'alert alert-' + type + ' position-fixed';
            toast.style.cssText = 'position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);';
            toast.innerHTML = `
                <div class="d-flex align-items-center">
                    <i class="fas ` + iconClass + ` me-3 fs-5"></i>
                    <div>` + message + `</div>
                    <button type="button" class="btn-close ms-auto" onclick="this.parentElement.parentElement.remove()"></button>
                </div>
            `;
            
            document.body.appendChild(toast);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                if (toast.parentNode) {
                    toast.remove();
                }
            }, 5000);
        }
        
        // Add certificate border animation on load
        document.addEventListener('DOMContentLoaded', function() {
            const certificate = document.querySelector('.certificate-paper');
            certificate.style.animation = 'fadeIn 1s ease-out';
            
            // Add confetti effect on certificate view
            if (Math.random() > 0.5) {
                setTimeout(() => {
                    createConfetti();
                }, 1000);
            }
        });
        
        // Simple confetti effect
        function createConfetti() {
            const colors = ['#d4af37', '#002b5c', '#00509e', '#ffdd59'];
            
            for (let i = 0; i < 50; i++) {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.cssText = 
                    'position: absolute;' +
                    'width: 10px;' +
                    'height: 10px;' +
                    'background: ' + colors[Math.floor(Math.random() * colors.length)] + ';' +
                    'top: -20px;' +
                    'left: ' + (Math.random() * 100) + '%;' +
                    'border-radius: 50%;' +
                    'opacity: 0.7;' +
                    'z-index: 999;' +
                    'animation: fall ' + (Math.random() * 3 + 2) + 's linear forwards;';
                
                document.body.appendChild(confetti);
                
                // Remove confetti after animation
                setTimeout(() => {
                    if (confetti.parentNode) {
                        confetti.remove();
                    }
                }, 5000);
            }
            
            // Add CSS for confetti animation
            const style = document.createElement('style');
            style.textContent = `
                @keyframes fall {
                    to {
                        transform: translateY(100vh) rotate(` + (Math.random() * 360) + `deg);
                        opacity: 0;
                    }
                }
            `;
            document.head.appendChild(style);
        }
    </script>
</body>
</html>