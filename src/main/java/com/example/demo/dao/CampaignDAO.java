package com.example.demo.dao;

import com.example.demo.beans.Campaign;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CampaignDAO {

    @Autowired
    private DataSource dataSource;

    public List<Campaign> getAllCampaigns() {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.campaign_id, c.name, c.description, c.start_time, c.status, c.created_by, i.total_qty, i.available_qty " +
                     "FROM campaigns c " +
                     "LEFT JOIN inventory i ON c.campaign_id = i.campaign_id " +
                     "ORDER BY c.start_time ASC";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Campaign c = mapResultSetToCampaign(rs);
                campaigns.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }

    // Get campaigns created by a specific admin
    public List<Campaign> getCampaignsByAdmin(int adminId) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.campaign_id, c.name, c.description, c.start_time, c.status, c.created_by, i.total_qty, i.available_qty " +
                     "FROM campaigns c " +
                     "LEFT JOIN inventory i ON c.campaign_id = i.campaign_id " +
                     "WHERE c.created_by = ? " +
                     "ORDER BY c.start_time ASC";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adminId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Campaign c = mapResultSetToCampaign(rs);
                    campaigns.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }

    public Campaign getCampaignById(int campaignId) {
        String sql = "SELECT c.campaign_id, c.name, c.description, c.start_time, c.status, c.created_by, i.total_qty, i.available_qty " +
                     "FROM campaigns c " +
                     "LEFT JOIN inventory i ON c.campaign_id = i.campaign_id " +
                     "WHERE c.campaign_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, campaignId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCampaign(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createCampaign(Campaign campaign) {
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Insert Campaign with created_by
            String campSql = "INSERT INTO campaigns (name, description, start_time, status, created_by) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement campStmt = conn.prepareStatement(campSql, Statement.RETURN_GENERATED_KEYS);
            campStmt.setString(1, campaign.getName());
            campStmt.setString(2, campaign.getDescription());
            campStmt.setTimestamp(3, campaign.getStartTime());
            campStmt.setString(4, campaign.getStatus());
            campStmt.setInt(5, campaign.getCreatedBy());
            campStmt.executeUpdate();

            ResultSet rs = campStmt.getGeneratedKeys();
            int campaignId = 0;
            if (rs.next()) {
                campaignId = rs.getInt(1);
            }

            // 2. Insert Inventory
            String invSql = "INSERT INTO inventory (campaign_id, total_qty, available_qty) VALUES (?, ?, ?)";
            PreparedStatement invStmt = conn.prepareStatement(invSql);
            invStmt.setInt(1, campaignId);
            invStmt.setInt(2, campaign.getTotalQty());
            invStmt.setInt(3, campaign.getTotalQty()); // Initially available = total
            invStmt.executeUpdate();

            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public boolean updateCampaign(Campaign campaign) {
        // Only allow update if this admin owns the campaign
        String sql = "UPDATE campaigns SET name = ?, description = ?, start_time = ?, status = ? WHERE campaign_id = ? AND created_by = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, campaign.getName());
            stmt.setString(2, campaign.getDescription());
            stmt.setTimestamp(3, campaign.getStartTime());
            stmt.setString(4, campaign.getStatus());
            stmt.setInt(5, campaign.getCampaignId());
            stmt.setInt(6, campaign.getCreatedBy());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCampaign(int campaignId, int adminId) {
        String invSql = "DELETE FROM inventory WHERE campaign_id = ?";
        String campSql = "DELETE FROM campaigns WHERE campaign_id = ? AND created_by = ?";

        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            conn.setAutoCommit(false);

            PreparedStatement invStmt = conn.prepareStatement(invSql);
            invStmt.setInt(1, campaignId);
            invStmt.executeUpdate();

            PreparedStatement campStmt = conn.prepareStatement(campSql);
            campStmt.setInt(1, campaignId);
            campStmt.setInt(2, adminId);
            campStmt.executeUpdate();

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
             if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private Campaign mapResultSetToCampaign(ResultSet rs) throws SQLException {
        Campaign c = new Campaign();
        c.setCampaignId(rs.getInt("campaign_id"));
        c.setName(rs.getString("name"));
        c.setDescription(rs.getString("description"));
        c.setStartTime(rs.getTimestamp("start_time"));
        c.setStatus(rs.getString("status"));
        
        // Handle potential NULLs from LEFT JOIN for inventory
        int totalQty = rs.getInt("total_qty"); // if null, returns 0
        int availableQty = rs.getInt("available_qty"); // if null, returns 0
        
        c.setTotalQty(totalQty);
        c.setAvailableQty(availableQty);
        c.setCreatedBy(rs.getInt("created_by"));
        return c;
    }
}
