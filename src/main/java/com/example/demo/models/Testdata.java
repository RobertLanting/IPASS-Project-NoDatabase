package com.example.demo.models;

import com.example.demo.AlbertHeijn;

import java.util.ArrayList;

public class Testdata {

    private static ArrayList<Shoplist> lijstjes= new ArrayList<>();
    private static ArrayList<User> users = new ArrayList<>();
    private static User user = new User("robert", "123", "robertlanting@gmail.com");

    public static void maakLijstjes() {
        users.add(user);
        lijstjes.add(new Shoplist("eten", user));
        lijstjes.add(new Shoplist("eten2", user));
        lijstjes.add(new Shoplist("eten3", user));
        lijstjes.add(new Shoplist("eten4", user));

        for (Shoplist s : lijstjes) {
            s.addItem(AlbertHeijn.searchProducts("kaas").get(0));
            s.addItem(AlbertHeijn.searchProducts("bier").get(0));
            s.addItem(AlbertHeijn.searchProducts("brood").get(0));
        }

    }

    public static ArrayList<Shoplist> getLijstjes() {
        return lijstjes;
    }

    public static User getUser() {
        return user;
    }

    public static ArrayList<User> getUsers() {
        return users;
    }
}
