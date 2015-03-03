package com.bayescorp.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.bayescorp.db.ConnectionProvider;
import com.bayescorp.db.PasswordHash;
import com.bayescorp.utils.HashGeneratorUtils;
import com.bayescorp.utils.RandomPasswordGenerator;

public class registerBean {

    private String username;
    private String password;
    private String company;
    private String email;
    private String passwordHash;
    private String emailCode;
    private String newPassword;
    
    public int noOfCAPSAlpha = 1;
    public int noOfDigits = 1;
    public int noOfSplChars = 0;
    public int minLen = 8;
    public int maxLen = 12;


    public void setCompany(String company) {
        this.company = company;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setPasswordHash(String passwordHash) {
    	this.passwordHash = passwordHash;
    }
    
    public void setEmailCode(String emailCode) {
    	this.emailCode = emailCode;
    }
    
    public void setNewPassword(String newPassword) {
    	this.newPassword = newPassword;
    }

    public String getCompany() {
        return company;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }
    
    public String getPasswordHash() {
    	return passwordHash;
    }
    
    public String getEmailCode() {
    	return emailCode;
    }
    
    public String getNewPassword() {
    	return newPassword;
    }

    public boolean usernameExists() {
    	String sql = "SELECT * FROM users WHERE username = ? "; 
        try {
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getUsername());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
            	return true;
            } 
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean emailExists() {
    	String sql = "SELECT * FROM users WHERE email = ? "; 
        try {
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getEmail());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
            	return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    public boolean accountExists() {
    	String sql = "SELECT * FROM users WHERE email = ? AND email_code = ? AND active = 0"; 
        try {
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getEmail());
            ps.setString(2, getEmailCode());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
            	return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    public boolean insert() {
    	String sql = "INSERT INTO users (username, password, company, email, email_code, timestamp) VALUES (?, ?, ?, ?, ?, NOW())";
        try {
        	passwordHash = PasswordHash.createHash(getPassword());
        	emailCode = HashGeneratorUtils.generateSHA256(getUsername() + getEmail());
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getUsername());
            ps.setString(2, getPasswordHash());
            ps.setString(3, getCompany());
            ps.setString(4, getEmail());
            ps.setString(5, getEmailCode());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean activateAccount() {
    	String sql = "UPDATE users SET active = 1 WHERE email = ? AND email_code = ?";
        try {
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getEmail());
            ps.setString(2, getEmailCode());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    public boolean retriveUsername() {
    	String sql = "SELECT username FROM users WHERE email = ? "; 
        try {
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getEmail());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
            	setUsername(rs.getString("username"));
            	return true;
            } 
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;

    }
    
    public boolean passwordMatch() {
        String sql = "SELECT * FROM users WHERE username = ? ";
    	try {
    		ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getUsername());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
            	String correctHash = rs.getString("password");
            	if (PasswordHash.validatePassword(getPassword(), correctHash)) {
            		return true;
            	}
            }
        } catch (Exception e) {
        	System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean resetPassword() {
    	String sql = "UPDATE users SET password = ? WHERE username = ? AND email = ?";
    	char[] pswd = RandomPasswordGenerator.generatePswd(minLen, maxLen, noOfCAPSAlpha, noOfDigits, noOfSplChars);
    	password = String.valueOf(pswd);
        try {
        	passwordHash = PasswordHash.createHash(getPassword());
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getPasswordHash());
            ps.setString(2, getUsername());
            ps.setString(3, getEmail());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean changePassword() {
    	String sql = "UPDATE users SET password = ? WHERE username = ? ";
        try {
        	passwordHash = PasswordHash.createHash(getNewPassword());
        	ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getPasswordHash());
            ps.setString(2, getUsername());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

}
