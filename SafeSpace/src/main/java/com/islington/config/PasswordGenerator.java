package com.islington.config;

/**
 * PasswordGenerator — temporary utility to generate the correct
 * AES-encrypted password and full SQL INSERT statements.
 * Run this class once, copy the SQL from the Console, paste into phpMyAdmin.
 */
public class PasswordGenerator {

    public static void main(String[] args) {
        // The password we want to encrypt for sample users
        String plainPassword = "pass123";

        // Encrypt using AESUtil
        String encrypted = AESUtil.encrypt(plainPassword);

        // Print the encrypted value
        System.out.println("===========================================");
        System.out.println("  SafeSpace Password Generator");
        System.out.println("===========================================");
        System.out.println("  Plain password : " + plainPassword);
        System.out.println("  Encrypted value: " + encrypted);
        System.out.println("===========================================");
        System.out.println();
        System.out.println("  COPY EVERYTHING BELOW AND PASTE INTO phpMyAdmin SQL tab:");
        System.out.println();
        System.out.println("-- =============================================");
        System.out.println("-- Paste this into phpMyAdmin -> SQL tab -> Go");
        System.out.println("-- =============================================");
        System.out.println();
        System.out.println("INSERT INTO users (username, password_hash, role, full_name, student_id, phone, anonymous_token, failed_attempts)");
        System.out.println("VALUES ('counselor', '" + encrypted + "', 'COUNSELOR', 'Dr. Sarah Mitchell', 'STAFF-001', '9800000001', 'TOKEN-COUNSELOR-001', 0);");
        System.out.println();
        System.out.println("INSERT INTO users (username, password_hash, role, full_name, student_id, phone, anonymous_token, failed_attempts)");
        System.out.println("VALUES ('student1', '" + encrypted + "', 'STUDENT', 'Alex Johnson', 'STU-2024-0042', '9800000002', 'TOKEN-ALEX-001', 0);");
        System.out.println();
        System.out.println("INSERT INTO incidents (anonymous_token, category, description, severity, status, submitted_at)");
        System.out.println("VALUES ('TOKEN-ALEX-001', 'Harassment or Bullying', 'I have been experiencing persistent verbal harassment from a group of students in the cafeteria during lunch hours.', 'HIGH', 'PENDING', '2026-04-10 14:30:00');");
        System.out.println();
        System.out.println("INSERT INTO incidents (anonymous_token, category, description, severity, status, submitted_at)");
        System.out.println("VALUES ('TOKEN-ALEX-001', 'Wellness Check Request', 'I am concerned about a fellow student who has been isolating themselves and missing classes for the past week.', 'LOW', 'IN_REVIEW', '2026-04-08 09:15:00');");
        System.out.println();
        System.out.println("-- =============================================");
        System.out.println("-- END OF SQL");
        System.out.println("-- =============================================");
    }
}
