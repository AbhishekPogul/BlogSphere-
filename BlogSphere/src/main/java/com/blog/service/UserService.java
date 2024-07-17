package com.blog.service;

import com.blog.dao.UserDAO;
import com.blog.model.User;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    // Create a new user
    public boolean createUser(User user) {
        return userDAO.createUser(user);
    }

    // Get a user by email
    public User getUserByEmail(String email) throws SQLException {
        return userDAO.getUserByEmail(email);
    }

    // Get a user by ID
    public User getUserById(int id) throws SQLException {
        return userDAO.getUserById(id);
    }

    // Get all users
    public List<User> getAllUsers() throws SQLException {
        return userDAO.getAllUsers();
    }

    // Update user details
    public boolean updateUser(User user) throws SQLException {
        return userDAO.updateUser(user);
    }

    // Delete a user
    public boolean deleteUser(int id) throws SQLException {
        return userDAO.deleteUser(id);
    }
}
