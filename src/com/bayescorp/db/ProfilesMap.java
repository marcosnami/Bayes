package com.bayescorp.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;



public class ProfilesMap {
	
	public static HashMap<String, String> getProfilesMap(String username) {
		HashMap<String, String> hm = new HashMap<String, String>();
		
		try {
			
			//STEP 1: Get a connection
			ConnectionProvider cp = new ConnectionProvider();
			Connection conn = cp.getConnect();
  
			//STEP 2: Execute a query
	        String sql = "SELECT user_profile.profile_id, profiles.profile FROM  `user_profile` " + 
	        		"INNER JOIN  `profiles` ON user_profile.profile_id = profiles.id " +
	        		"WHERE user_profile.user_id IN (SELECT id FROM users WHERE username = ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            //STEP 3: Extract data from result set
			while (rs.next()) {
				//Retrieve by column name
				String profileId  = rs.getString("profile_id");
				String profile = rs.getString("profile");

				//Display values
				//System.out.print("Profile Id: " + profileId);
				//System.out.print(", Profile: " + profile + "\n");

				hm.put(profileId, profile);
			}
  
			//STEP 6: Clean-up environment
			rs.close();
			conn.close();
		} catch (SQLException se) {
			//Handle errors for JDBC
			se.printStackTrace();
		} catch(Exception e) {
			//Handle errors for Class.forName
			e.printStackTrace();
		} //end try
		
		return hm;
	}

}
