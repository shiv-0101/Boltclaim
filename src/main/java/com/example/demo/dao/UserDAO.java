package com.example.demo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {

    @Autowired
    private DataSource dataSource;

    public boolean saveUser(String username, String fullName, String email, String password) {
        try (Connection conn = dataSource.getConnection()) {
            // Insert into users table
            String userSql = "INSERT INTO users (email, password) VALUES (?, ?)";
            PreparedStatement userStmt = conn.prepareStatement(userSql, PreparedStatement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, email);
            userStmt.setString(2, password);
            userStmt.executeUpdate();

            // Get generated user_id
            ResultSet keys = userStmt.getGeneratedKeys();
            int userId = 0;
            if (keys.next()) {
                userId = keys.getInt(1);
            }

            // Insert into USER_PROFILES table
            String profileSql = "INSERT INTO USER_PROFILES (user_id, username, full_name) VALUES (?, ?, ?)";
            PreparedStatement profileStmt = conn.prepareStatement(profileSql);
            profileStmt.setInt(1, userId);
            profileStmt.setString(2, username);
            profileStmt.setString(3, fullName);
            profileStmt.executeUpdate();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String validateUser(String email, String password) {
        try (Connection conn = dataSource.getConnection()) {
            String sql = "SELECT u.user_id, p.username FROM users u " +
                         "JOIN USER_PROFILES p ON u.user_id = p.user_id " +
                         "WHERE u.email = ? AND u.password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("username");
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}