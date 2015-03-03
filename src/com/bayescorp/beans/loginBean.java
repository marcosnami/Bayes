package com.bayescorp.beans;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.bayescorp.db.*;

public class loginBean implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

/*    
 * 	public String validate() {
    	
        String sql = "SELECT * FROM users WHERE username = ? and password = ? ";
    	try {
    		ConnectionProvider cp = new ConnectionProvider();
            Connection con = cp.getConnect();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, getUsername());
            ps.setString(2, getPassword());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return "home.jsp";
            } else {
                return "login.jsp";
            }
        } catch (Exception e) {
            return "error.jsp";
        }
    }
*/ 
    // Added Hash and Salt to the password before store to the DB.
    public boolean isValidate() {
        String sql = "SELECT * FROM users WHERE username = ? AND active = 1";
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
            	} else {
            		return false;
            	}
            } else {
                return false;
            }
        } catch (Exception e) {
        	System.out.println(e.getMessage());
            return false;
        }
    }
    
}
