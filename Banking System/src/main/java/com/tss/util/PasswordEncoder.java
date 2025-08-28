package com.tss.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordEncoder {
    public static String hash(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    public static boolean matches(String rawPassword, String hashed) {
        return BCrypt.checkpw(rawPassword, hashed);
    }
    
    public static void main(String[] args) {
    	String hashedPassword = hash("admin123");
        System.out.println("Password: " + hashedPassword);
	}
}