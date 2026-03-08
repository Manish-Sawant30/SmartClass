<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Debug Test Page</h1>
        
        <div class="card mt-3">
            <div class="card-body">
                <h5 class="card-title">System Information</h5>
                <p><strong>Message:</strong> ${message}</p>
                <p><strong>Time:</strong> ${time}</p>
                <p><strong>DB Status:</strong> ${dbStatus}</p>
                <p><strong>Server Time:</strong> <%= new java.util.Date() %></p>
                <p><strong>JSP Path:</strong> <%= application.getRealPath("/") %></p>
            </div>
        </div>
        
        <div class="card mt-3">
            <div class="card-body">
                <h5 class="card-title">Test APIs</h5>
                <button class="btn btn-primary" onclick="testApi('/content/api/all')">Test Content API</button>
                <button class="btn btn-primary" onclick="testApi('/content/api/statistics')">Test Statistics API</button>
                <button class="btn btn-primary" onclick="testApi('/content/api/subjectNames')">Test Subjects API</button>
                
                <div id="apiResult" class="mt-3"></div>
            </div>
        </div>
        
        <div class="card mt-3">
            <div class="card-body">
                <h5 class="card-title">Test Pages</h5>
                <a href="/upload-notes" class="btn btn-success">Test Upload Notes</a>
                <a href="/student-course" class="btn btn-success">Test Student Course</a>
                <a href="/courses" class="btn btn-success">Test Courses</a>
            </div>
        </div>
    </div>
    
    <script>
        async function testApi(url) {
            const resultDiv = document.getElementById('apiResult');
            resultDiv.innerHTML = '<div class="alert alert-info">Testing ' + url + '...</div>';
            
            try {
                const response = await fetch(url);
                const data = await response.json();
                resultDiv.innerHTML = '<div class="alert alert-success"><pre>' + 
                    JSON.stringify(data, null, 2) + '</pre></div>';
            } catch (error) {
                resultDiv.innerHTML = '<div class="alert alert-danger">Error: ' + error.message + '</div>';
            }
        }
    </script>
</body>
</html>