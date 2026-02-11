package com.example.demo.beans;

public class UserProfile {
    private int profileId;
    private int userId;
    private String username;
    private String fullName;

    public UserProfile() {
    }

    public UserProfile(int profileId, int userId, String username, String fullName) {
        this.profileId = profileId;
        this.userId = userId;
        this.username = username;
        this.fullName = fullName;
    }

    public int getProfileId() {
        return profileId;
    }

    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    @Override
    public String toString() {
        return "UserProfile{" +
                "profileId=" + profileId +
                ", userId=" + userId +
                ", username='" + username + '\'' +
                ", fullName='" + fullName + '\'' +
                '}';
    }
}
