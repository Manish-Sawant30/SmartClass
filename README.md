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
<img width="1340" height="616" alt="image" src="https://github.com/user-attachments/assets/b0ee2c4c-66f8-4aca-a5a4-0839ea07d756" />
<img width="1357" height="616" alt="Screenshot 2026-03-08 143218" src="https://github.com/user-attachments/assets/abe0d5a0-548f-4614-9ac3-ac349babe045" />
<img width="1095" height="567" alt="image" src="https://github.com/user-attachments/assets/e68be943-7d83-480b-95d9-5d9626e63032" />

#AdminModule
<img width="1223" height="601" alt="image" src="https://github.com/user-attachments/assets/1fd8c1e5-9bad-4354-965a-3e19793114ce" />
<img width="648" height="605" alt="image" src="https://github.com/user-attachments/assets/b86da34c-3029-4d74-90d8-920f00db5f5c" />
<img width="1317" height="464" alt="image" src="https://github.com/user-attachments/assets/f98414d2-2788-4816-bfe4-d99160dddecb" />
<img width="1352" height="596" alt="image" src="https://github.com/user-attachments/assets/191dd77e-1108-4c51-a6ab-33f839a7c28c" />
<img width="1212" height="593" alt="image" src="https://github.com/user-attachments/assets/b923d473-02c3-409a-9587-6acc701f1d63" />
<img width="1359" height="550" alt="image" src="https://github.com/user-attachments/assets/709831ac-9767-4666-9bfc-989fd3f21123" />
<img width="971" height="553" alt="image" src="https://github.com/user-attachments/assets/5a3577b6-cf56-4708-b634-5b6b989aa9dd" />

#StudentModule
<img width="1328" height="488" alt="image" src="https://github.com/user-attachments/assets/704b4f5b-9d44-4929-a24c-f60b1178967b" />
<img width="1307" height="637" alt="image" src="https://github.com/user-attachments/assets/241a730a-2d8e-4317-8cd6-f7399c2b48d5" />
<img width="1328" height="638" alt="image" src="https://github.com/user-attachments/assets/ae489956-f7ba-4b75-bee1-05e50cf442d6" />
<img width="592" height="557" alt="image" src="https://github.com/user-attachments/assets/4f0512f1-4c9d-410d-87ee-a06028592972" />
<img width="715" height="619" alt="image" src="https://github.com/user-attachments/assets/0656f3c5-56aa-4b5c-8ae1-2fa4468ea56e" />

#ParentModule
<img width="1338" height="649" alt="image" src="https://github.com/user-attachments/assets/8aec310b-b7a5-4f12-b177-e8fb3d72f590" />
<img width="1329" height="612" alt="image" src="https://github.com/user-attachments/assets/6b65a775-eca8-415e-aba0-1530de82960a" />
<img width="1341" height="340" alt="image" src="https://github.com/user-attachments/assets/516c4443-de1c-4519-bc1d-afcf97c3bc61" />
<img width="531" height="571" alt="image" src="https://github.com/user-attachments/assets/b57883d0-e135-4266-9d9a-21a4185d68a5" />
<img width="1363" height="560" alt="image" src="https://github.com/user-attachments/assets/d2852a74-fc66-4307-a8ee-b69ed06204a8" />



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
