package com.example.demo.models;

import java.util.ArrayList;
import java.util.UUID;

public class User {

    private String username;
    private String password;
    private String mail;
    private static ArrayList<User> users = Testdata.getUsers();
    private ArrayList<Product> ownProducts = new ArrayList<>();

    public User() {

    }

    public User(String nm, String pswd, String m) {
        this.username = nm;
        this.password = pswd;
        this.mail = m;
    }

    public String getUsername() {
        return username;
    }

    public static ArrayList<User> getUsers() {
        return users;
    }

    public String getPassword() {
        return password;
    }

    public String getMail() {
        return mail;
    }

    public static User findUser(String username) {
        for (User u : users) {
            if (u.getUsername().equals(username)) {
                return u;
            }
        }
        return null;
    }

    public ArrayList<Product> getOwnProducts() {
        return ownProducts;
    }

    public Product findOwnProduct(UUID id) {
        for (Product p : this.getOwnProducts()) {
            if (p.getId().equals(id)) {
                return p;
            }
        }
        return null;
    }

    public static boolean validateLogin(String username, String password) {
        return users.stream().anyMatch(user ->
                        user.getUsername().equals(username) &&
                        user.getPassword().equals(password));

    }
}
