package com.example.demo.controller;

import com.example.demo.beans.User;
import com.example.demo.dao.UserDAO;
import com.example.demo.dao.CampaignDAO;
import com.example.demo.dao.CampaignRegistrationDAO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private CampaignDAO campaignDAO;

    @Autowired
    private CampaignRegistrationDAO registrationDAO;

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String handleRegister(@RequestParam String username, 
                                 @RequestParam String fullName,
                                 @RequestParam String email,
                                 @RequestParam String password,
                                 @RequestParam(defaultValue = "USER") String role,
                                 @RequestParam(required = false) String adminKey, 
                                 Model model) {
        
        if ("ADMIN".equals(role)) {
            if (adminKey == null || !userDAO.validateAdminKey(adminKey)) {
                model.addAttribute("error", "Invalid Admin Registration Key!");
                return "register";
            }
        } else {
            role = "USER"; // Force role to USER if not ADMIN (safety check)
        }

        if (userDAO.saveUser(username, fullName, email, password, role)) {
            return "redirect:/";
        } else {
            model.addAttribute("error", "Registration failed. Email may already exist.");
            return "register";
        }
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam String email,
                              @RequestParam String password, 
                              Model model,
                              HttpSession session) {
        User user = userDAO.validateUser(email, password);
        if (user != null) {
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            if ("ADMIN".equals(user.getRole())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/dashboard";
            }
        } else {
            model.addAttribute("error", "Invalid credentials");
            return "login";
        }
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }
        User user = (User) session.getAttribute("user");
        model.addAttribute("username", username);
        // Add active campaigns to the user dashboard
        model.addAttribute("campaigns", campaignDAO.getAllCampaigns());
        // Add list of campaign IDs the user is registered for
        if (user != null) {
            model.addAttribute("registeredCampaigns", registrationDAO.getUserRegisteredCampaigns(user.getUserId()));
        }
        return "dashboard";
    }

    @PostMapping("/register-campaign")
    public String registerForCampaign(@RequestParam int campaignId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        registrationDAO.registerUserForCampaign(user.getUserId(), campaignId);
        return "redirect:/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
