package com.blog.service;

import com.blog.dao.BlogDAO;
import com.blog.model.BlogPost;

import java.sql.SQLException;
import java.util.List;

public class BlogService {
    private BlogDAO blogDAO;

    public BlogService() {
        blogDAO = new BlogDAO();
    }
    // Create a new blog post
    public boolean createPost(BlogPost post) {
        return blogDAO.createPost(post);
    }

    // Update an existing blog post
    public boolean updatePost(BlogPost post) {
        return blogDAO.updatePost(post);
    }

    // Delete a blog post by ID
    public boolean deletePost(int id) {
        return blogDAO.deletePost(id);
    }
    // Get all blog posts
    public List<BlogPost> getAllPosts() {
        return blogDAO.getAllPosts();
    }

    // Get a blog post by ID
    public BlogPost getPostById(int id) {
        return blogDAO.getPostById(id);
    }
    public List<BlogPost> getPostsByUserId(int userId) throws SQLException {
        return blogDAO.getPostsByUserId(userId);
    }
    public List<BlogPost> getAllPosts(int page, int pageSize) throws SQLException {
		return blogDAO.getAllPosts(page, pageSize);

    }

    // Get total number of posts
    public int getTotalPosts() throws SQLException {
        return blogDAO.getTotalPosts();
    }
    
    
}