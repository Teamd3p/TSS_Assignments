package service;

import dao.UserDao;
import model.User;

public class UserService {

    private final UserDao userDao;

    public UserService() {
        this.userDao = new UserDao();
    }

    public boolean register(User user) {
        return userDao.registerUser(user);
    }

    public User login(String username, String password) {
        return userDao.loginUser(username, password);
    }
}
