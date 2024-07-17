package com.blog.controller;

import com.blog.model.BlogPost;
import com.blog.service.BlogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.List;
import org.apache.tomcat.util.http.fileupload.impl.FileSizeLimitExceededException;

@WebServlet(urlPatterns = {"/createPost", "/editPost", "/deletePost", "/managePosts", "/viewPost", "/getImage", "/getVideo"})
@MultipartConfig(
	    fileSizeThreshold = 50 * 1024 * 1024,  // 50 MB
	    maxFileSize = 100 * 1024 * 1024,      // 100 MB
	    maxRequestSize = 100 * 1024 * 1024    // 100 MB
	)
public class BlogServlet extends HttpServlet {
    private BlogService blogService = new BlogService();
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/createPost":
                    createPost(request, response);
                    break;
                case "/editPost":
                    editPost(request, response);
                    break;
                case "/deletePost":
                    deletePost(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        } catch (FileSizeLimitExceededException e) {
            request.setAttribute("error", "File size exceeds the maximum allowed limit of 50 MB.");
            request.getRequestDispatcher("createPost.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/managePosts":
                    managePosts(request, response);
                    break;
                case "/viewPost":
                    viewPost(request, response);
                    break;
                case "/getImage":
                    getImage(request, response);
                    break;
                case "/getVideo":
                    getVideo(request, response);
                    break;
                case "/editPost":
                    showEditForm(request, response);  // Make sure this case is correctly handled
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void createPost(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        try {
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            byte[] image = extractBytes(request.getPart("image"));
            byte[] video = extractBytes(request.getPart("video"));

            int userId = (Integer) request.getSession().getAttribute("userId");

            BlogPost post = new BlogPost();
            post.setTitle(title);
            post.setContent(content);
            post.setImage(image);
            post.setVideo(video);
            post.setUserId(userId);

            boolean isCreated = blogService.createPost(post);
            if (isCreated) {
                // Redirect to admin dashboard
                response.sendRedirect("adminDashboard");
            } else {
                request.setAttribute("error", "Failed to create post.");
                request.getRequestDispatcher("createPost.jsp").forward(request, response);
            }
        } catch (FileSizeLimitExceededException e) {
            request.setAttribute("error", "File size exceeds the maximum allowed limit of 50 MB.");
            request.getRequestDispatcher("createPost.jsp").forward(request, response);
        }
    }


    private void editPost(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String method = request.getMethod();
        if (method.equalsIgnoreCase("GET")) {
            showEditForm(request, response);
        } else if (method.equalsIgnoreCase("POST")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            byte[] image = extractBytes(request.getPart("image"));
            byte[] video = extractBytes(request.getPart("video"));

            BlogPost post = new BlogPost();
            post.setId(id);
            post.setTitle(title);
            post.setContent(content);
            post.setImage(image);
            post.setVideo(video);

            boolean isUpdated = blogService.updatePost(post);
            if (isUpdated) {
                // Redirect to admin dashboard
                response.sendRedirect("adminDashboard");
            } else {
                request.setAttribute("error", "Failed to update post.");
                request.setAttribute("post", post);
                request.getRequestDispatcher("editPost.jsp").forward(request, response);
            }
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        BlogPost post = blogService.getPostById(id);
        request.setAttribute("post", post);
        request.getRequestDispatcher("editPost.jsp").forward(request, response);
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        blogService.deletePost(id);
        response.sendRedirect("adminDashboard");
    }

    private void managePosts(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1; // Default to page 1 if there's an error
            }
        }

        List<BlogPost> posts = blogService.getAllPosts(page, PAGE_SIZE);
        int totalPosts = blogService.getTotalPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);

        request.setAttribute("posts", posts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("adminDashboard").forward(request, response);
    }

    private void viewPost(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        BlogPost post = blogService.getPostById(id);
        request.setAttribute("post", post);
        request.getRequestDispatcher("viewPost.jsp").forward(request, response);
    }

    private void getImage(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        BlogPost post = blogService.getPostById(id);
        byte[] image = post.getImage();

        if (image != null) {
            response.setContentType("image/jpeg");
            try (OutputStream out = response.getOutputStream()) {
                out.write(image);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void getVideo(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        BlogPost post = blogService.getPostById(id);
        byte[] video = post.getVideo();

        if (video != null) {
            response.setContentType("video/mp4");
            try (OutputStream out = response.getOutputStream()) {
                out.write(video);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private byte[] extractBytes(Part part) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }

        try (InputStream inputStream = part.getInputStream();
             ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
            int nRead;
            byte[] data = new byte[16384];
            while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }
            buffer.flush();
            return buffer.toByteArray();
        }
    }
}
