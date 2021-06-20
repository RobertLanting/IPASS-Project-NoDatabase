package com.example.demo.models;

public class ProductBundel {

    private int amount = 1;

    private Product product;

    public ProductBundel() {

    }

    public ProductBundel(Product product) {
        this.product = product;
    }

    public void addAmount(){
        amount++;
    }

    public void removeAmount() {
        if (amount != 1) {
            amount--;
        }
    }

    public Product getProduct() {
        return product;
    }

    public int getAmount() {
        return amount;
    }

    public double getPrice() {
        return Utils.round(product.getPrice() * getAmount(), 2);
    }

    public double getOldPrice() {
        return Utils.round(product.getOldPrice() * getAmount(), 2);
    }
}
