package com.example.demo.controller;

import com.example.demo.beans.Campaign;
import com.example.demo.beans.User;
import com.example.demo.dao.CampaignDAO;
import com.example.demo.dao.CampaignRegistrationDAO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CampaignDAO campaignDAO;

    @Autowired
    private CampaignRegistrationDAO registrationDAO;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Each admin must be logged in to see their own dashboard
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }
        User user = (User) session.getAttribute("user");
        model.addAttribute("adminName", user.getUsername());
        model.addAttribute("adminFullName", user.getFullName());
        model.addAttribute("adminEmail", user.getEmail());
        model.addAttribute("adminId", user.getUserId());
        model.addAttribute("adminRole", user.getRole());
        // Each admin only sees their own campaigns
        model.addAttribute("campaigns", campaignDAO.getCampaignsByAdmin(user.getUserId()));
        model.addAttribute("campaignCount", campaignDAO.getCampaignsByAdmin(user.getUserId()).size());
        // Registered users for this admin's campaigns
        model.addAttribute("registrations", registrationDAO.getRegistrationsByAdmin(user.getUserId()));
        model.addAttribute("registrationCount", registrationDAO.getRegistrationCountByAdmin(user.getUserId()));
        return "admin-dashboard";
    }

    @PostMapping("/create-campaign")
    public String createCampaign(@RequestParam String name,
                                 @RequestParam String description,
                                 @RequestParam String startTime,
                                 @RequestParam int totalQty,
                                 @RequestParam String status,
                                 HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) return "redirect:/login";
        User user = (User) session.getAttribute("user");

        Campaign c = new Campaign();
        c.setName(name);
        c.setDescription(description);
        c.setStartTime(Timestamp.valueOf(LocalDateTime.parse(startTime)));
        c.setStatus(status);
        c.setTotalQty(totalQty);
        c.setAvailableQty(totalQty);
        c.setCreatedBy(user.getUserId()); // Tag campaign to this admin

        campaignDAO.createCampaign(c);
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/update-campaign")
    public String updateCampaign(@RequestParam int campaignId,
                                 @RequestParam String name,
                                 @RequestParam String description,
                                 @RequestParam String startTime,
                                 @RequestParam String status,
                                 HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) return "redirect:/login";
        User user = (User) session.getAttribute("user");

        Campaign c = new Campaign();
        c.setCampaignId(campaignId);
        c.setName(name);
        c.setDescription(description);
        c.setStartTime(Timestamp.valueOf(LocalDateTime.parse(startTime)));
        c.setStatus(status);
        c.setCreatedBy(user.getUserId()); // Only owner can update
        
        campaignDAO.updateCampaign(c);
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/delete-campaign")
    public String deleteCampaign(@RequestParam int campaignId, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) return "redirect:/login";
        User user = (User) session.getAttribute("user");

        campaignDAO.deleteCampaign(campaignId, user.getUserId()); // Only owner can delete
        return "redirect:/admin/dashboard";
    }
}
