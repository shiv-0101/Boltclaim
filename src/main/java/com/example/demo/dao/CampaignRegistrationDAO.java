package com.example.demo.dao;

import com.example.demo.beans.CampaignRegistration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CampaignRegistrationDAO {

    @Autowired
    private DataSource dataSource;

    /**
     * Register a user for a campaign
     */
    public boolean registerUserForCampaign(int userId, int campaignId) {
        // First check if already registered
        if (isUserRegistered(userId, campaignId)) {
            return false; // Already registered
        }

        String sql = "INSERT INTO campaign_registrations (campaign_id, user_id, registered_at) VALUES (?, ?, NOW())";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, campaignId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Check if user is already registered for a campaign
     */
    public boolean isUserRegistered(int userId, int campaignId) {
        String sql = "SELECT COUNT(*) FROM campaign_registrations WHERE user_id = ? AND campaign_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, campaignId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Get all registrations for campaigns owned by a specific admin
     */
    public List<CampaignRegistration> getRegistrationsByAdmin(int adminId) {
        List<CampaignRegistration> registrations = new ArrayList<>();
        String sql = """
            SELECT cr.registration_id, cr.campaign_id, cr.user_id, cr.registered_at,
                   p.username, u.email, p.full_name, c.name as campaign_name
            FROM campaign_registrations cr
            JOIN users u ON cr.user_id = u.user_id
            LEFT JOIN USER_PROFILES p ON u.user_id = p.user_id
            JOIN campaigns c ON cr.campaign_id = c.campaign_id
            WHERE c.created_by = ?
            ORDER BY cr.registered_at DESC
        """;
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            System.out.println("Fetching registrations for adminId: " + adminId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CampaignRegistration reg = new CampaignRegistration();
                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setCampaignId(rs.getInt("campaign_id"));
                reg.setUserId(rs.getInt("user_id"));
                reg.setRegisteredAt(rs.getTimestamp("registered_at"));
                reg.setUserName(rs.getString("username"));
                reg.setUserEmail(rs.getString("email"));
                reg.setUserFullName(rs.getString("full_name"));
                reg.setCampaignName(rs.getString("campaign_name"));
                registrations.add(reg);
                System.out.println("Found registration: " + reg.getUserName() + " for " + reg.getCampaignName());
            }
            System.out.println("Total registrations found: " + registrations.size());
        } catch (SQLException e) {
            System.err.println("Error in getRegistrationsByAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return registrations;
    }

    /**
     * Get registrations for a specific campaign
     */
    public List<CampaignRegistration> getRegistrationsByCampaign(int campaignId) {
        List<CampaignRegistration> registrations = new ArrayList<>();
        String sql = """
            SELECT cr.registration_id, cr.campaign_id, cr.user_id, cr.registered_at,
                   p.username, u.email, p.full_name, c.name as campaign_name
            FROM campaign_registrations cr
            JOIN users u ON cr.user_id = u.user_id
            LEFT JOIN USER_PROFILES p ON u.user_id = p.user_id
            JOIN campaigns c ON cr.campaign_id = c.campaign_id
            WHERE cr.campaign_id = ?
            ORDER BY cr.registered_at DESC
        """;
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, campaignId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CampaignRegistration reg = new CampaignRegistration();
                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setCampaignId(rs.getInt("campaign_id"));
                reg.setUserId(rs.getInt("user_id"));
                reg.setRegisteredAt(rs.getTimestamp("registered_at"));
                reg.setUserName(rs.getString("username"));
                reg.setUserEmail(rs.getString("email"));
                reg.setUserFullName(rs.getString("full_name"));
                reg.setCampaignName(rs.getString("campaign_name"));
                registrations.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registrations;
    }

    /**
     * Get count of registrations for admin's campaigns
     */
    public int getRegistrationCountByAdmin(int adminId) {
        String sql = """
            SELECT COUNT(*) FROM campaign_registrations cr
            JOIN users u ON cr.user_id = u.user_id
            JOIN campaigns c ON cr.campaign_id = c.campaign_id
            WHERE c.created_by = ?
        """;
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in getRegistrationCountByAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Get list of campaign IDs that a user is registered for
     */
    public List<Integer> getUserRegisteredCampaigns(int userId) {
        List<Integer> campaignIds = new ArrayList<>();
        String sql = "SELECT campaign_id FROM campaign_registrations WHERE user_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                campaignIds.add(rs.getInt("campaign_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaignIds;
    }
}
