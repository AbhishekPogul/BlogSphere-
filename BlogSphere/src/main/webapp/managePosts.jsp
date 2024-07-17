<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.model.BlogPost" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Posts</title>
    <link rel="stylesheet" href="static/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .post-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }
        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 16px;
            margin: 16px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            width: 250px;
        }
        .card img {
            max-width: 100%;
            height: auto;
            border-bottom: 1px solid #ccc;
            padding-bottom: 16px;
        }
        .card h3 {
            margin: 16px 0;
        }
        .card a {
            display: block;
            margin-top: 16px;
            padding: 8px 16px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
        .card a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Welcome to the BlogSphere</h2>
    <h3>Recent Posts</h3>
    <div class="post-cards">
        <% 
            List<BlogPost> posts = (List<BlogPost>) request.getAttribute("posts");
            if (posts != null && !posts.isEmpty()) {
                for (BlogPost post : posts) {
        %>
        <div class="card">
            <% if (post.getImage() != null) { %>
                <img src="getImage?id=<%= post.getId() %>" alt="Post Image">
            <% } %>
            <h3><%= post.getTitle() %></h3>
            <a href="viewPost?id=<%= post.getId() %>">View Post</a>
        </div>
        <% 
                }
            } else {
        %>
        <p>No posts available.</p>
        <% 
            }
        %>
    </div>
</body>
</html>
