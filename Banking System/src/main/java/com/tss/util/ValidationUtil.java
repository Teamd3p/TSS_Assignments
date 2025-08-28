package com.tss.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public final class ValidationUtil {
    private ValidationUtil() {}

    private static final Pattern EMAIL = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern PHONE = Pattern.compile("^[0-9]{10,15}$");
    private static final Pattern USERNAME = Pattern.compile("^[A-Za-z0-9_.-]{4,50}$");

    public static List<String> validateRegistration(String username, String password, String fullName, String email, String phone) {
        List<String> errors = new ArrayList<>();
        if (username == null || !USERNAME.matcher(username).matches()) {
            errors.add("Invalid username. Use 4-50 characters: letters, numbers, _ . -");
        }
        if (password == null || password.length() < 6) {
            errors.add("Password must be at least 6 characters long");
        }
        if (fullName == null || fullName.trim().length() < 3) {
            errors.add("Full name must be at least 3 characters long");
        }
        if (email == null || !EMAIL.matcher(email).matches()) {
            errors.add("Invalid email address");
        }
        if (phone == null || !PHONE.matcher(phone).matches()) {
            errors.add("Invalid phone number");
        }
        return errors;
    }

    public static boolean isNullOrEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}

