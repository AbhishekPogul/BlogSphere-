<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlogSphere Home</title>
    <link rel="stylesheet" href="static/css/style.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #f0f8ff, #e6e6e6);
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }
        .header {
            padding: 30px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .header h1 {
            font-size: 3.5em;
            margin: 0;
            font-weight: bold;
        }
        .content {
            margin-top: 40px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: left;
            font-size: 1.2em;
        }
        .content h2 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #333;
        }
        .content p {
            line-height: 1.8;
            color: #555;
        }
        .buttons {
            margin-top: 30px;
        }
        .buttons a {
            display: inline-block;
            margin: 10px;
            padding: 15px 30px;
            font-size: 1em;
            color: white;
            background: linear-gradient(135deg, #ff6f61, #ff3e2a);
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s, transform 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .buttons a:hover {
            background: linear-gradient(135deg, #ff3e2a, #ff6f61);
            transform: scale(1.05);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.5em;
            }
            .content {
                padding: 20px;
                font-size: 1em;
            }
            .content h2 {
                font-size: 2em;
            }
            .buttons a {
                font-size: 0.9em;
                padding: 12px 24px;
            }
        }

        @media (max-width: 480px) {
            .header h1 {
                font-size: 1.8em;
            }
            .content {
                padding: 15px;
                font-size: 0.9em;
            }
            .content h2 {
                font-size: 1.5em;
            }
            .buttons a {
                font-size: 0.8em;
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>BlogSphere</h1>
        </div>
        <div class="content">
            <h2>Welcome to BlogSphere!</h2>
            <p>
                BlogSphere is your ultimate destination for sharing thoughts, ideas, and stories with the world. Our platform allows you to create, publish, and manage your blog posts effortlessly. Whether you are a seasoned blogger or just starting out, BlogSphere provides a user-friendly interface and powerful features to help you connect with your audience.
            </p>
            <p>
                With BlogSphere, you can customize your blog's appearance, add multimedia content like images and videos, and interact with readers through comments and feedback. Our secure and reliable infrastructure ensures that your content is always accessible and protected. Join our community of passionate writers and start your blogging journey with BlogSphere today!
            </p>
        </div>
        <div class="buttons">
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        </div>
    </div>
</body>
</html>
