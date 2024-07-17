package com.blog.controller;

import com.blog.model.User;
import com.blog.model.BlogPost;
import com.blog.service.UserService;
import com.blog.service.BlogService;
import com.blog.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/register", "/login", "/adminDashboard", "/index", "/logout"})
public class UserServlet extends HttpServlet {
    private UserService userService = new UserService();
    private BlogService blogService = new BlogService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/register":
                    registerUser(request, response);
                    break;
                case "/login":
                    loginUser(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/adminDashboard":
                    showAdminDashboard(request, response);
                    break;
                case "/index":
                    showIndex(request, response);
                    break;
                case "/logout":
                    logoutUser(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        String role = request.getParameter("role");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(PasswordUtil.hashPassword(password)); // Hash the password
        user.setRole(role);

        if (userService.createUser(user)) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed");
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        User user = userService.getUserByEmail(email);

        if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("role", user.getRole());
            session.setAttribute("userName", user.getName()); // Set user's name

            if (user.getRole().equals("Admin")) {
                response.sendRedirect("adminDashboard");
            } else {
                response.sendRedirect("index");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }

    private void showAdminDashboard(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session != null && "Admin".equals(session.getAttribute("role"))) {
            int userId = (int) session.getAttribute("userId");
            List<BlogPost> posts = blogService.getPostsByUserId(userId);
            request.setAttribute("posts", posts);
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp?error=Session expired, please login again");
        }
    }

    private void showIndex(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<BlogPost> posts = blogService.getAllPosts();
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void logoutUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("home.jsp");
    }
}
