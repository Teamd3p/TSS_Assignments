package com.user;

public class Authentication {
    private static final String ADMIN_ID = "admin";
    private static final String ADMIN_PASSWORD = "admin@123";
	
	public static void authentication(String id, String password) {
		 if (id.equals(ADMIN_ID) && password.equals(ADMIN_PASSWORD)) {
	            AdminUI.showAdminMenu();
	        } else {
	            System.out.println("Invalid Admin credentials.");
	        }
	}

}
