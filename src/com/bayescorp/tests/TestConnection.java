package com.bayescorp.tests;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.bayescorp.db.ConnectionProvider;

public class TestConnection {

	public static void main(String[] args) {

		Connection conn = null;
		Statement stmt = null;
   
		try {
			
			//STEP 1: Get a connection
			ConnectionProvider cp = new ConnectionProvider();
			conn = cp.getConnect();
  
			//STEP 2: Execute a query
			System.out.println("Creating statement...");
			stmt = conn.createStatement();
			String sql = "SELECT id, username, password FROM users";
			ResultSet rs = stmt.executeQuery(sql);

			//STEP 3: Extract data from result set
			while (rs.next()) {
				
				//Retrieve by column name
				int id  = rs.getInt("id");
				String username = rs.getString("username");
				String password = rs.getString("password");

				//Display values
				System.out.print("ID: " + id);
				System.out.print(", Username: " + username);
				System.out.print(", Password: " + password + "\n");
			}
  
			//STEP 6: Clean-up environment
			rs.close();
			stmt.close();
			conn.close();
			
		} catch (SQLException se) {
			//Handle errors for JDBC
			se.printStackTrace();
		} catch(Exception e) {
			//Handle errors for Class.forName
			e.printStackTrace();
		} finally {
			//finally block used to close resources
			try {
				if (stmt!=null) {
					stmt.close();
				}
			} catch (SQLException se2) {
			
			} // nothing we can do
		  
			try {
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException se) {
				se.printStackTrace();
			} //end finally try
		} //end try
		
		System.out.println("Getting Profiles");

		try {
			
			//STEP 1: Get a connection
			ConnectionProvider cp = new ConnectionProvider();
			conn = cp.getConnect();
  
			//STEP 2: Execute a query
			System.out.println("Creating statement...");
	        String sql = "SELECT user_profile.profile_id, profiles.profile FROM  `user_profile` " + 
	        		"INNER JOIN  `profiles` ON user_profile.profile_id = profiles.id " +
	        		"WHERE user_profile.user_id IN (SELECT id FROM users WHERE username = ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "marcosnami");
            ResultSet rs = ps.executeQuery();

            //STEP 3: Extract data from result set
			while (rs.next()) {
				
				//Retrieve by column name
				String profileId  = rs.getString("profile_id");
				String profile = rs.getString("profile");

				//Display values
				System.out.print("Profile Id: " + profileId);
				System.out.print(", Profile: " + profile + "\n");
			}
  
			//STEP 6: Clean-up environment
			rs.close();
			stmt.close();
			conn.close();
			
		} catch (SQLException se) {
			//Handle errors for JDBC
			se.printStackTrace();
		} catch(Exception e) {
			//Handle errors for Class.forName
			e.printStackTrace();
		} finally {
			//finally block used to close resources
			try {
				if (stmt!=null) {
					stmt.close();
				}
			} catch (SQLException se2) {
			
			} // nothing we can do
		  
			try {
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException se) {
				se.printStackTrace();
			} //end finally try
		} //end try

		System.out.println("Goodbye!");
				
	}

}
