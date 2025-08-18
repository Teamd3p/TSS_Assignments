package model;

public class User {
    private int idUsers;
    private String username;
    private String password;

    public User() {}

    public User(int idUsers, String username, String password) {
        this.idUsers = idUsers;
        this.username = username;
        this.password = password;
    }
    
    public int getIdUsers() {
        return idUsers;
    }

    public void setIdUsers(int idUsers) {
        this.idUsers = idUsers;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
