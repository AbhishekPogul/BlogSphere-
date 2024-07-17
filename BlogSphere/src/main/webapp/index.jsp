<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.blog.model.BlogPost" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="static/css/style.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #ffecd2, #fcb69f);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #333;
        }
        .header {
            width: 100%;
            background-color: #007bff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            position: relative;
        }
        .header h2 {
            margin: 0;
        }
        .logout-link {
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .logout-link:hover {
            background-color: #c82333;
        }
        .content {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
        }
        h3 {
            text-align: center;
            color: #007bff;
        }
        .post-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .card {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 16px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            max-width: 300px;
            flex: 1 1 calc(33% - 40px);
            margin: 10px;
        }
        .card:hover {
            transform: translateY(-10px);
        }
        .card img {
            max-width: 100%;
            height: auto;
            border-bottom: 1px solid #ccc;
            padding-bottom: 16px;
        }
        .card h3 {
            margin: 16px 0;
            color: #333;
        }
        .card a {
            display: block;
            margin-top: 16px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .card a:hover {
            background-color: #0056b3;
        }
        .user-info {
            position: absolute;
            top: 50%;
            right: 150px;
            transform: translateY(-50%);
            color: #ffffff;
            font-weight: bold;
            font-size: 1.3em;
            background: #343a40;
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
            border: 2px solid #007bff;
        }
    </style>
</head>
<body>
    <%
        HttpSession lsession = request.getSession(false);
        Object userName = lsession.getAttribute("userName");

        if (lsession == null || lsession.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="header">
        <h2>Welcome to BlogSphere</h2>
        <div class="user-info">
             <%= userName %>
        </div>
        <a href="logout" class="logout-link">Logout</a>
    </div>
    <div class="content">
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
    </div>
</body>
</html>
