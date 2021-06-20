package com.example.demo.models;

import java.util.ArrayList;
import java.util.UUID;

public class Product {

    private static ArrayList<Product> products = new ArrayList<>();

    private UUID id;
    private String name;
    private String description;
    private double price;
    private double OldPrice;
    private String albertID;
    private String picture;

    public Product() {

    }

    public Product(String nm, String bsch, double prs, double oprs){
        this.id = UUID.randomUUID();
        this.name = nm;
        this.description = bsch;
        this.price = prs;
        this.OldPrice = oprs;
    }

    public static ArrayList<Product> getProducts() {
        return products;
    }

    public UUID getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public String getAlbertID() {
        return albertID;
    }

    public void setAlbertID(String albertID) {
        this.albertID = albertID;
    }

    public double getOldPrice() {
        return OldPrice;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setOldPrice(double oldPrice) {
        OldPrice = oldPrice;
    }
}
