<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blog.model.BlogPost" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Post</title>
    <link rel="stylesheet" href="static/css/style.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h2 {
            color: #007bff;
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"],
        textarea,
        input[type="file"] {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .link-container {
            text-align: center;
            margin-top: 20px;
        }
        .link-container a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .link-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Post</h2>
        <%
            BlogPost post = (BlogPost) request.getAttribute("post");
            if (post != null) {
        %>
        <form action="editPost" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= post.getId() %>">
            
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%= post.getTitle() %>" required><br>

            <label for="content">Content:</label>
            <textarea id="content" name="content" rows="10" cols="30" required><%= post.getContent() %></textarea><br>

            <label for="image">Image:</label>
            <input type="file" id="image" name="image"><br>

            <label for="video">Video:</label>
            <input type="file" id="video" name="video"><br>

            <input type="submit" value="Update Post">
        </form>
        <div class="link-container">
            <a href="adminDashboard">Back to Admin Dashboard</a>
        </div>
        <% 
            } else {
        %>
        <p>Post not found.</p>
        <div class="link-container">
            <a href="adminDashboard">Back to Admin Dashboard</a>
        </div>
        <% 
            }
        %>
    </div>
</body>
</html>
