package com.bayescorp.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

    public Connection getConnect() {
        try {
            Class.forName(Provider.DRIVER);
            Connection con = DriverManager.getConnection(Provider.CONNECTION_URL, Provider.USERNAME, Provider.PASSWORD);
            return con;
        } catch(Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }
	
}
