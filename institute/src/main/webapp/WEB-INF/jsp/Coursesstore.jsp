<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Administrator</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #ff9e00;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --light-gray: #e9ecef;
        }

        body {
            background-color: #f5f7fb;
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--light-gray);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo i {
            color: var(--primary);
            font-size: 28px;
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary);
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 25px;
        }

        .page-title i {
            color: var(--secondary);
            font-size: 26px;
        }

        .page-title h2 {
            font-size: 22px;
            font-weight: 600;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .search-box {
            display: flex;
            align-items: center;
            background-color: white;
            border-radius: 8px;
            padding: 10px 15px;
            width: 300px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .search-box i {
            color: var(--gray);
            margin-right: 10px;
        }

        .search-box input {
            border: none;
            outline: none;
            width: 100%;
            font-size: 15px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            font-size: 15px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
        }

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #3ab8d9;
            transform: translateY(-2px);
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #e11575;
            transform: translateY(-2px);
        }

        .btn-warning {
            background-color: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background-color: #e68e00;
            transform: translateY(-2px);
        }

        .btn-outline {
            background-color: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .btn-outline:hover {
            background-color: rgba(67, 97, 238, 0.1);
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }

        .courses-table {
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: var(--primary);
            color: white;
        }

        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 15px;
        }

        td {
            padding: 18px 15px;
            border-bottom: 1px solid var(--light-gray);
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: rgba(67, 97, 238, 0.03);
        }

        .course-code {
            font-weight: 600;
            color: var(--primary);
        }

        .course-name {
            font-weight: 500;
        }

        .course-instructor {
            color: var(--gray);
            font-size: 14px;
        }

        .course-credits {
            display: inline-block;
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
        }

        .course-status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-active {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .status-upcoming {
            background-color: rgba(255, 158, 0, 0.1);
            color: var(--warning);
        }

        .status-ended {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--danger);
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: white;
            width: 90%;
            max-width: 500px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            animation: modalFade 0.3s ease;
        }

        @keyframes modalFade {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .modal-header {
            padding: 20px 25px;
            border-bottom: 1px solid var(--light-gray);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 20px;
            font-weight: 600;
            color: var(--primary);
        }

        .modal-body {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            transition: border 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .modal-footer {
            padding: 20px 25px;
            border-top: 1px solid var(--light-gray);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .close {
            background: none;
            border: none;
            font-size: 22px;
            cursor: pointer;
            color: var(--gray);
        }

        .close:hover {
            color: var(--dark);
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-icon.blue {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }

        .stat-icon.green {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .stat-icon.purple {
            background-color: rgba(114, 9, 183, 0.1);
            color: var(--secondary);
        }

        .stat-icon.orange {
            background-color: rgba(255, 158, 0, 0.1);
            color: var(--warning);
        }

        .stat-info h3 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--gray);
            font-size: 14px;
        }

        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            color: white;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            z-index: 1100;
            transform: translateY(100px);
            opacity: 0;
            transition: all 0.4s ease;
        }

        .toast.show {
            transform: translateY(0);
            opacity: 1;
        }

        .toast-success {
            background-color: var(--success);
        }

        .toast-danger {
            background-color: var(--danger);
        }

        .toast-warning {
            background-color: var(--warning);
        }

        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: var(--gray);
        }

        .empty-state i {
            font-size: 60px;
            color: var(--light-gray);
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: var(--dark);
        }

        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .search-box {
                width: 100%;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .actions {
                flex-direction: column;
            }
            
            th, td {
                padding: 12px 10px;
            }
            
            .course-credits, .course-status {
                font-size: 12px;
                padding: 3px 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">
                <i class="fas fa-graduation-cap"></i>
                <h1>EduAdmin</h1>
            </div>
            <div class="admin-info">
                <div class="admin-avatar">AJ</div>
                <div>
                    <div class="admin-name">Admin John</div>
                    <div class="admin-role" style="font-size: 13px; color: var(--gray);">Course Administrator</div>
                </div>
            </div>
        </header>

        <div class="page-title">
            <i class="fas fa-book-open"></i>
            <h2>Course Management</h2>
        </div>

        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-icon blue">
                    <i class="fas fa-book"></i>
                </div>
                <div class="stat-info">
                    <h3 id="total-courses">12</h3>
                    <p>Total Courses</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green">
                    <i class="fas fa-play-circle"></i>
                </div>
                <div class="stat-info">
                    <h3 id="active-courses">8</h3>
                    <p>Active Courses</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <div class="stat-info">
                    <h3 id="total-instructors">9</h3>
                    <p>Instructors</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3>342</h3>
                    <p>Total Students</p>
                </div>
            </div>
        </div>

        <div class="controls">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="search-input" placeholder="Search courses...">
            </div>
            <button class="btn btn-primary" id="add-course-btn">
                <i class="fas fa-plus-circle"></i> Add New Course
            </button>
        </div>

        <div class="courses-table">
            <table>
                <thead>
                    <tr>
                        <th>Course Code</th>
                        <th>Course Name</th>
                        <th>Instructor</th>
                        <th>Credits</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="courses-table-body">
                    <!-- Courses will be populated here by JavaScript -->
                </tbody>
            </table>
        </div>

        <!-- Modal for Add/Edit Course -->
        <div id="course-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modal-title">Add New Course</h3>
                    <button class="close" id="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form id="course-form">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="course-code">Course Code *</label>
                                <input type="text" id="course-code" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="course-credits">Credits *</label>
                                <input type="number" id="course-credits" class="form-control" min="1" max="10" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="course-name">Course Name *</label>
                            <input type="text" id="course-name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="course-instructor">Instructor *</label>
                            <input type="text" id="course-instructor" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="course-description">Description</label>
                            <textarea id="course-description" class="form-control" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="course-status">Status *</label>
                            <select id="course-status" class="form-control" required>
                                <option value="active">Active</option>
                                <option value="upcoming">Upcoming</option>
                                <option value="ended">Ended</option>
                            </select>
                        </div>
                        <input type="hidden" id="course-id" value="">
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" id="cancel-btn">Cancel</button>
                    <button class="btn btn-primary" id="save-course-btn">Save Course</button>
                </div>
            </div>
        </div>

        <!-- Toast Notification -->
        <div id="toast" class="toast">
            <i id="toast-icon" class="fas fa-check-circle"></i>
            <span id="toast-message">Course added successfully!</span>
        </div>
    </div>

    <script>
        // Sample course data
        let courses = [
            { id: 1, code: "CS101", name: "Introduction to Programming", instructor: "Dr. Sarah Johnson", credits: 3, status: "active", description: "Basic programming concepts and problem-solving techniques." },
            { id: 2, code: "MATH201", name: "Calculus II", instructor: "Prof. Michael Chen", credits: 4, status: "active", description: "Advanced topics in differential and integral calculus." },
            { id: 3, code: "PHY150", name: "Physics for Engineers", instructor: "Dr. Robert Williams", credits: 4, status: "upcoming", description: "Fundamental principles of physics with engineering applications." },
            { id: 4, code: "ENG101", name: "English Composition", instructor: "Prof. Emily Davis", credits: 3, status: "active", description: "Development of writing skills for academic and professional contexts." },
            { id: 5, code: "CS301", name: "Data Structures", instructor: "Dr. James Miller", credits: 3, status: "active", description: "Study of fundamental data structures and algorithms." },
            { id: 6, code: "HIST202", name: "World History", instructor: "Prof. Linda Garcia", credits: 3, status: "ended", description: "Survey of world civilizations from ancient times to present." },
            { id: 7, code: "ART110", name: "Drawing Fundamentals", instructor: "Ms. Olivia Wilson", credits: 2, status: "active", description: "Introduction to basic drawing techniques and concepts." },
            { id: 8, code: "BIO101", name: "General Biology", instructor: "Dr. Thomas Brown", credits: 4, status: "upcoming", description: "Introduction to biological principles and processes." }
        ];

        // DOM elements
        const coursesTableBody = document.getElementById('courses-table-body');
        const courseModal = document.getElementById('course-modal');
        const courseForm = document.getElementById('course-form');
        const modalTitle = document.getElementById('modal-title');
        const closeModalBtn = document.getElementById('close-modal');
        const cancelBtn = document.getElementById('cancel-btn');
        const addCourseBtn = document.getElementById('add-course-btn');
        const saveCourseBtn = document.getElementById('save-course-btn');
        const searchInput = document.getElementById('search-input');
        const toast = document.getElementById('toast');
        const toastMessage = document.getElementById('toast-message');
        const toastIcon = document.getElementById('toast-icon');
        
        // Form fields
        const courseIdField = document.getElementById('course-id');
        const courseCodeField = document.getElementById('course-code');
        const courseNameField = document.getElementById('course-name');
        const courseInstructorField = document.getElementById('course-instructor');
        const courseCreditsField = document.getElementById('course-credits');
        const courseDescriptionField = document.getElementById('course-description');
        const courseStatusField = document.getElementById('course-status');

        // Statistics elements
        const totalCoursesElement = document.getElementById('total-courses');
        const activeCoursesElement = document.getElementById('active-courses');
        const totalInstructorsElement = document.getElementById('total-instructors');

        // Initialize the page
        document.addEventListener('DOMContentLoaded', function() {
            renderCourses();
            updateStatistics();
            
            // Event listeners
            addCourseBtn.addEventListener('click', openAddCourseModal);
            closeModalBtn.addEventListener('click', closeModal);
            cancelBtn.addEventListener('click', closeModal);
            saveCourseBtn.addEventListener('click', saveCourse);
            searchInput.addEventListener('input', filterCourses);
            
            // Close modal when clicking outside of it
            window.addEventListener('click', function(event) {
                if (event.target === courseModal) {
                    closeModal();
                }
            });
        });

        // Render courses in the table
        function renderCourses(filteredCourses = courses) {
            coursesTableBody.innerHTML = '';
            
            if (filteredCourses.length === 0) {
                coursesTableBody.innerHTML = `
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <i class="fas fa-book"></i>
                                <h3>No courses found</h3>
                                <p>Try adjusting your search or add a new course</p>
                            </div>
                        </td>
                    </tr>
                `;
                return;
            }
            
            filteredCourses.forEach(course => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>
                        <div class="course-code">${course.code}</div>
                    </td>
                    <td>
                        <div class="course-name">${course.name}</div>
                        <div class="course-description" style="font-size: 13px; color: var(--gray); margin-top: 5px;">${course.description.substring(0, 60)}${course.description.length > 60 ? '...' : ''}</div>
                    </td>
                    <td>
                        <div class="course-instructor">${course.instructor}</div>
                    </td>
                    <td>
                        <span class="course-credits">${course.credits} Credits</span>
                    </td>
                    <td>
                        <span class="course-status status-${course.status}">${course.status.charAt(0).toUpperCase() + course.status.slice(1)}</span>
                    </td>
                    <td>
                        <div class="actions">
                            <button class="btn btn-sm btn-warning edit-course" data-id="${course.id}">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <button class="btn btn-sm btn-danger delete-course" data-id="${course.id}">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </div>
                    </td>
                `;
                coursesTableBody.appendChild(row);
            });
            
            // Add event listeners to edit and delete buttons
            document.querySelectorAll('.edit-course').forEach(button => {
                button.addEventListener('click', function() {
                    const courseId = parseInt(this.getAttribute('data-id'));
                    openEditCourseModal(courseId);
                });
            });
            
            document.querySelectorAll('.delete-course').forEach(button => {
                button.addEventListener('click', function() {
                    const courseId = parseInt(this.getAttribute('data-id'));
                    deleteCourse(courseId);
                });
            });
        }

        // Update statistics
        function updateStatistics() {
            totalCoursesElement.textContent = courses.length;
            
            const activeCourses = courses.filter(course => course.status === 'active').length;
            activeCoursesElement.textContent = activeCourses;
            
            // Get unique instructors
            const instructors = [...new Set(courses.map(course => course.instructor))];
            totalInstructorsElement.textContent = instructors.length;
        }

        // Filter courses based on search input
        function filterCourses() {
            const searchTerm = searchInput.value.toLowerCase();
            const filteredCourses = courses.filter(course => 
                course.code.toLowerCase().includes(searchTerm) ||
                course.name.toLowerCase().includes(searchTerm) ||
                course.instructor.toLowerCase().includes(searchTerm) ||
                course.description.toLowerCase().includes(searchTerm)
            );
            renderCourses(filteredCourses);
        }

        // Open modal to add a new course
        function openAddCourseModal() {
            modalTitle.textContent = 'Add New Course';
            courseForm.reset();
            courseIdField.value = '';
            courseModal.style.display = 'flex';
        }

        // Open modal to edit an existing course
        function openEditCourseModal(id) {
            const course = courses.find(c => c.id === id);
            if (!course) return;
            
            modalTitle.textContent = 'Edit Course';
            courseIdField.value = course.id;
            courseCodeField.value = course.code;
            courseNameField.value = course.name;
            courseInstructorField.value = course.instructor;
            courseCreditsField.value = course.credits;
            courseDescriptionField.value = course.description;
            courseStatusField.value = course.status;
            
            courseModal.style.display = 'flex';
        }

        // Close modal
        function closeModal() {
            courseModal.style.display = 'none';
        }

        // Save course (add or update)
        function saveCourse() {
            if (!courseForm.checkValidity()) {
                courseForm.reportValidity();
                return;
            }
            
            const id = courseIdField.value ? parseInt(courseIdField.value) : null;
            const courseData = {
                code: courseCodeField.value,
                name: courseNameField.value,
                instructor: courseInstructorField.value,
                credits: parseInt(courseCreditsField.value),
                description: courseDescriptionField.value,
                status: courseStatusField.value
            };
            
            if (id) {
                // Update existing course
                const index = courses.findIndex(c => c.id === id);
                courses[index] = { ...courses[index], ...courseData };
                showToast('Course updated successfully!', 'success');
            } else {
                // Add new course
                const newId = courses.length > 0 ? Math.max(...courses.map(c => c.id)) + 1 : 1;
                courses.push({ id: newId, ...courseData });
                showToast('Course added successfully!', 'success');
            }
            
            renderCourses();
            updateStatistics();
            closeModal();
        }

        // Delete course
        function deleteCourse(id) {
            if (!confirm('Are you sure you want to delete this course?')) {
                return;
            }
            
            const courseIndex = courses.findIndex(c => c.id === id);
            if (courseIndex !== -1) {
                const courseName = courses[courseIndex].name;
                courses.splice(courseIndex, 1);
                renderCourses();
                updateStatistics();
                showToast(`Course "${courseName}" deleted successfully!`, 'danger');
            }
        }

        // Show toast notification
        function showToast(message, type) {
            toastMessage.textContent = message;
            toast.className = 'toast';
            
            // Set icon and color based on type
            if (type === 'success') {
                toastIcon.className = 'fas fa-check-circle';
                toast.classList.add('toast-success');
            } else if (type === 'danger') {
                toastIcon.className = 'fas fa-exclamation-circle';
                toast.classList.add('toast-danger');
            } else if (type === 'warning') {
                toastIcon.className = 'fas fa-exclamation-triangle';
                toast.classList.add('toast-warning');
            }
            
            // Show toast
            setTimeout(() => {
                toast.classList.add('show');
            }, 100);
            
            // Hide toast after 3 seconds
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }
    </script>
</body>
</html>