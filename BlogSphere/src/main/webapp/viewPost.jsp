<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blog.model.BlogPost" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Post</title>
    <link rel="stylesheet" href="static/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f7ff; /* Light cyan background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .post-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff; /* White background for contrast */
            border: 1px solid #b3d7ff; /* Light blue border */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .post-container img {
            width: 80%;
            height: auto;
            border: 2px solid #b3d7ff; /* Light blue border */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .post-container h2 {
            font-size: 2.5em;
            margin: 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #b3d7ff; /* Light blue border */
            color: #3399ff; /* Bright blue color */
        }
        .post-container pre {
            line-height: 1.8;
            margin: 20px 0;
            color: #333333; /* Dark gray text for readability */
            text-align: left;
            white-space: pre-wrap; /* Ensure the text wraps within the container */
            font-size: 1.1em;
            padding: 10px;
            background-color: #f9f9f9; /* Very light gray background for text area */
            border-radius: 8px;
        }
        .post-container video {
            width: 70%;
            height: auto;
            border: 2px solid #b3d7ff; /* Light blue border */
            border-radius: 8px;
            margin-top: 20px;
        }
        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 1.2em;
            text-decoration: none;
            color: #fff;
            background-color: #ff6666; /* Light coral button */
            border: 1px solid #ff6666;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .back-button:hover {
            background-color: #ff4d4d; /* Slightly darker coral on hover */
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="post-container">
        <%
            int postId = Integer.parseInt(request.getParameter("id"));
            BlogPost post = (BlogPost) request.getAttribute("post");
            if (post != null) {
        %>
        <h2><%= post.getTitle() %></h2>
        <h4></h4>
        <% if (post.getImage() != null) { %>
            <img src="getImage?id=<%= postId %>" alt="Post Image">
        <% } %>
        <pre><%= post.getContent() %></pre>
        <% if (post.getVideo() != null) { %>
            <video controls>
                <source src="getVideo?id=<%= postId %>" type="video/mp4">
                Your browser does not support the video tag.
            </video>
        <% } %>
        <% } else { %>
        <p>Post not found.</p>
        <% } %>
        <a class="back-button" href="index">Back to Posts</a>
    </div>
</body>
</html>
