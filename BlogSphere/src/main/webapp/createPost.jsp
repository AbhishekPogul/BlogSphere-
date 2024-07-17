<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Post</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #007bff;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }
        input[type="text"], textarea, input[type="file"] {
            display: block;
            width: 100%;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        textarea {
            /* Make the textarea larger */
            height: 200px; /* Adjust height as needed */
            resize: vertical; /* Allow vertical resizing */
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        .success {
            color: green;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h2>Create New Post</h2>
    <form action="createPost" method="post" enctype="multipart/form-data">
        Title: <input type="text" name="title" required><br>
        Content: <textarea name="content" required></textarea><br>
        Image: <input type="file" name="image" accept="image/*"><br>
        Video: <input type="file" name="video" accept="video/*"><br>
        <button type="submit">Create Post</button>
    </form>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
        <p class="success"><%= request.getAttribute("success") %></p>
    <% } %>

    <a href="adminDashboard">Back to Dashboard</a>
</body>
</html>
