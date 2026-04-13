package com.islington.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConfig — centralised JDBC database configuration.
 * Provides a static method to obtain a MySQL connection
 * following the JDBC 6-step workflow taught in Week 6.
 */
public class DBConfig {

    // Database URL pointing to the safespace schema on localhost
    private static final String URL = "jdbc:mysql://localhost:3306/safespace";

    // Database credentials — default XAMPP MySQL root user
    private static final String USER = "root";
    private static final String PASS = "";

    /**
     * getConnection — opens and returns a new MySQL connection.
     * Follows JDBC Step 1 (Load Driver) and Step 2 (Get Connection).
     *
     * @return a live Connection object to the safespace database
     * @throws RuntimeException if the driver is missing or connection fails
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Step 1: Load the MySQL JDBC driver class into memory
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Step 2: Establish the connection using DriverManager
            conn = DriverManager.getConnection(URL, USER, PASS);

        } catch (ClassNotFoundException e) {
            // Driver JAR is missing from WEB-INF/lib
            e.printStackTrace();
            throw new RuntimeException("MySQL JDBC Driver not found. Please add mysql-connector-j JAR to WEB-INF/lib.");
        } catch (SQLException e) {
            // Connection failed — wrong URL, credentials, or MySQL not running
            e.printStackTrace();
            throw new RuntimeException("Failed to connect to the database. Please ensure MySQL is running.");
        }
        return conn;
    }
}
