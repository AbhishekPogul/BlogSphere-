<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.blog.model.BlogPost" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="static/css/style.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #2c2c2c;
            margin: 0;
            padding: 20px;
            color: #e0e0e0;
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            background: #333;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            position: relative;
        }
        h2 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #f8f9fa;
            text-align: center;
        }
        .action-links {
            margin: 20px 0;
            text-align: center;
        }
        .action-links a {
            margin: 0 10px;
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-weight: bold;
        }
        .action-links a:hover {
            background-color: #0056b3;
        }
        .post-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-around;
        }
        .card {
            background-color: #444;
            border: 1px solid #555;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            width: 300px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.7);
        }
        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        .card h3 {
            margin: 15px;
            font-size: 1.2em;
            color: #e0e0e0;
        }
        .card-actions {
            display: flex;
            justify-content: space-around;
            padding: 10px;
            background-color: #555;
            border-top: 1px solid #666;
        }
        .card-actions a {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .card-actions a:hover {
            background-color: #0056b3;
        }
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a {
            display: inline-block;
            margin: 0 5px;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .pagination a.active {
            background-color: #0056b3;
        }
        .pagination a:hover {
            background-color: #0056b3;
        }
        .logout-link {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .logout-link:hover {
            background-color: #c82333;
        }
         .user-info {
            position: absolute;
            top: 20px;
            right: 120px;
            color: #e0e0e0;
            font-weight: bold;
            font-size: 1.3em;
            background: #444;
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

    if (lsession == null || lsession.getAttribute("userId") == null || !"Admin".equals(lsession.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="dashboard-container">
     <div class="user-info">
        <%= userName %>
        </div>
        <a href="logout" class="logout-link">Logout</a>
        
        <h2>Admin Dashboard</h2>
        <div class="action-links">
            <a href="createPost.jsp">Create New Post</a>
        </div>

        <h3>Manage Posts</h3>
        <div class="post-cards">
            <%
            List<BlogPost> posts = (List<BlogPost>) request.getAttribute("posts");
            if (posts != null) {
                for (BlogPost post : posts) {
            %>
            <div class="card">
                <%
                if (post.getImage() != null) {
                %>
                    <img src="getImage?id=<%= post.getId() %>" alt="Post Image">
                <%
                }
                %>
                <h3><%= post.getTitle() %></h3>
                <div class="card-actions">
                    <a href="editPost?id=<%= post.getId() %>">Edit</a>
<form action="deletePost" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= post.getId() %>">
                <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 8px 16px; border-radius: 5px; font-weight: bold;">Delete</button>
            </form>                </div>
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

        <div class="pagination">
            <%
            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");
            if (currentPage == null) currentPage = 1;
            if (totalPages == null) totalPages = 1;

            for (int i = 1; i <= totalPages; i++) {
                if (i == currentPage) {
            %>
                <a href="managePosts?page=<%= i %>" class="active"><%= i %></a>
            <%
                } else {
            %>
                <a href="managePosts?page=<%= i %>"><%= i %></a>
            <%
                }
            }
            %>
        </div>
    </div>

</body>
</html>
