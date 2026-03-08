![Java](https://img.shields.io/badge/Java-Backend-red)
![SpringBoot](https://img.shields.io/badge/SpringBoot-Framework-green)
![MySQL](https://img.shields.io/badge/MySQL-Database-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)

# SmartClass – Institute Management System

SmartClass is a **Spring Boot based Institute Management System** designed to manage **teachers, students, parents, courses, MCQ tests, results, and certificates** in a single platform.

The system provides role-based access for **Admin, Teacher, Student, and Parent**, ensuring secure and organized management of institute activities.

---

# 🚀 Project Features

## 👨‍🏫 Teacher Module

Teachers can manage study material and MCQ tests for the courses they teach.

Features:

* Teacher signup and login
* View enrolled subjects
* Upload study materials
* Create MCQ questions
* Set correct answer manually
* Create Final MCQ exam
* View student test results

Rule:
Teachers can upload **only for subjects they enrolled in**.

---

## 👨‍🎓 Student Module

Students can access course materials and attempt MCQ tests.

Features:

* Student signup and login
* View enrolled courses
* Access study materials
* Attempt MCQ tests
* View results
* Download certificates

Rule:
Students can access **only enrolled courses**.

---

## 👨‍👩‍👦 Parent Module

Parents can monitor their child's performance.

Features:

* Parent login
* View child test scores
* Track academic progress

Parents can **only see results of their own child**.

---

# 📝 MCQ Test System

Every uploaded study material contains MCQ questions.

MCQ Features:

* 4 options per question
* Teacher sets correct answer
* Single attempt allowed
* Automatic result generation
* Result page shows correct and incorrect answers

Result page:

```
mcqresult.jsp
```

---

# 🎓 Final MCQ Exam

Students must pass unit MCQ tests to attempt final exam.

Eligibility rule:

Student must score **50% or more** in unit MCQ test.

If score < 50%:

* Student is **Not Eligible**
* Final exam cannot be attempted

---

# 📊 Result System

Results are stored in database and shown according to role.

### Student Result Page

```
Studenttestscore.jsp
```

Students can see **only their results**.

---

### Parent Result Page

```
Parenttestscore.jsp
```

Parents see **only their child results**.

---

### Teacher Result Page

```
Teachertestscore.jsp
```

Teachers can see results of **students enrolled in their course only**.

---

# 🏆 Certificate System

Students receive certificate after passing course exams.

Certificate eligibility:

* Pass Unit MCQ tests
* Eligible for Final Test
* Pass Final MCQ exam

If student fails eligibility → certificate not generated.

Certificate pages:

```
CertificateSuccess.jsp
certificateF1.jsp
```

Students access certificate using:

* Student ID
* Password

---

# 🛠 Tech Stack

Backend

* Java
* Spring Boot
* Spring MVC
* Spring Data JPA
* Maven

Frontend

* JSP
* HTML
* CSS
* JavaScript

Database

* MySQL

Tools

* Git
* GitHub
* VS Code / Eclipse
* Maven

---

# 🏗 Architecture

SmartClass follows **Layered Architecture**

Controller → Service → Repository → Database

```
Controller Layer
Handles HTTP requests and responses.

Service Layer
Contains business logic.

Repository Layer
Handles database operations.

Database
Stores users, courses, MCQ tests, results.
```

---

# 📂 Project Structure

```
src/main/java/com/example/institute

controller
service
service/impl
repository
model
dto
config

src/main/resources

static
application.properties

src/main/webapp/WEB-INF/jsp
```

---

# ⚙️ How to Run Project

### Clone Repository

```
git clone https://github.com/Manish-Sawant30/SmartClass.git
```

### Open in IDE

Open project in:

* Eclipse
* IntelliJ


---

### Configure Database

Edit:

```
src/main/resources/application.properties
```

Example:

```
spring.datasource.url=jdbc:mysql://localhost:3306/smartclass
spring.datasource.username=root
spring.datasource.password=root
```

---

### Run Application

Run:

```
institute.java
```

Open browser:

```
http://localhost:8080
```

---

# 📸 Screenshots
<img width="228" height="197" alt="image" src="https://github.com/user-attachments/assets/457d2242-3216-4cf3-a2df-336259672753" />


Example:

Home Page
Admin Dashboard
Teacher Upload Notes
Student Course Page
MCQ Test Page
Result Page
Certificate Page

---

# 👨‍💻 Developer

Manish Sawant

Diploma in Computer Technology
Java Full Stack Developer

GitHub
https://github.com/Manish-Sawant30
