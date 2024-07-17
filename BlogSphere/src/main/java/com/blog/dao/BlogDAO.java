package com.blog.dao;

import com.blog.model.BlogPost;
import com.blog.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {
    private Connection conn;

    public BlogDAO() {
        conn = DBUtil.getConnection();
    }

    // Create a new blog post
    public boolean createPost(BlogPost post) {
        String query = "INSERT INTO blog_posts (title, content, image, video, user_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setBytes(3, post.getImage());
            stmt.setBytes(4, post.getVideo());
            stmt.setInt(5, post.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update an existing blog post
    public boolean updatePost(BlogPost post) {
        String query = "UPDATE blog_posts SET title = ?, content = ?, image = ?, video = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setBytes(3, post.getImage());
            stmt.setBytes(4, post.getVideo());
            stmt.setInt(5, post.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a blog post by ID
    public boolean deletePost(int id) {
        String query = "DELETE FROM blog_posts WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all blog posts
    public List<BlogPost> getAllPosts() {
        List<BlogPost> posts = new ArrayList<>();
        String query = "SELECT * FROM blog_posts";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                posts.add(new BlogPost(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getBytes("image"),
                        rs.getBytes("video"),
                        rs.getInt("user_id")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Get a blog post by ID
    public BlogPost getPostById(int id) {
        String query = "SELECT * FROM blog_posts WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new BlogPost(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getBytes("image"),
                        rs.getBytes("video"),
                        rs.getInt("user_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<BlogPost> getPostsByUserId(int userId) {
        List<BlogPost> posts = new ArrayList<>();
        String query = "SELECT * FROM blog_posts WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BlogPost post = new BlogPost();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setImage(rs.getBytes("image"));
                post.setVideo(rs.getBytes("video"));
                post.setUserId(rs.getInt("user_id"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }
    public List<BlogPost> getAllPosts(int page, int pageSize) throws SQLException {
        List<BlogPost> posts = new ArrayList<>();
        String query = "SELECT * FROM blog_posts LIMIT ?, ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, (page - 1) * pageSize);
            pstmt.setInt(2, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                BlogPost post = new BlogPost();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setImage(rs.getBytes("image"));
                post.setVideo(rs.getBytes("video"));
                posts.add(post);
            }
        }
        return posts;
    }
    
    // Get total number of posts
    public int getTotalPosts() throws SQLException {
        String query = "SELECT COUNT(*) FROM blog_posts";
        try (PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
