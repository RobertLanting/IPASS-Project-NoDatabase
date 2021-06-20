package com.example.demo.models;

import java.util.ArrayList;
import java.util.UUID;
import java.util.stream.Collectors;

public class Shoplist {

    private static ArrayList<Shoplist> lists = Testdata.getLijstjes();
    private UUID id;
    private String name;
    private ArrayList<User> users = new ArrayList<>();
    private ArrayList<ProductBundel> productlist = new ArrayList<>();

    public Shoplist() {

    }

    public Shoplist(String nm, User u) {
        this.id = UUID.randomUUID();
        this.name = nm;
        this.users.add(u);
    }

    public static ArrayList<Shoplist> getLists() {
        return lists;
    }

    public static ArrayList<Shoplist> getListsOfUser(User u) {
        ArrayList<Shoplist> result = new ArrayList<>();
        for (Shoplist l : lists) {
            if (l.getUsers().contains(u)) {
                result.add(l);
            }
        }
        return result;
    }

    public static Shoplist findList(UUID id) {
        for (Shoplist l : lists) {
            if (l.getId().equals(id)) {
                return l;
            }
        }
        return null;
    }

    public static void removeList(UUID id) {
        lists.remove(Shoplist.findList(id));
    }

    public static void addList(Shoplist l) {
        lists.add(l);
    }


    public ArrayList<User> getUsers() {
        return users;
    }

    public ProductBundel findItem(UUID id) {
        for (ProductBundel pb : productlist) {
            if (pb.getProduct().getId().equals(id)) {
                return pb;
            }
        }
        return null;
    }


    public void addItem(Product p) {

        Product finalP = p;
        if (productlist.stream().anyMatch(pB -> pB.getProduct().equals(finalP))) {
            for (ProductBundel pB: productlist) {
                if (pB.getProduct().equals(p)) {
                    pB.addAmount();
                }
            }

        } else {
            for (Product pr : Product.getProducts()) {
                if (pr.getAlbertID().equals(p.getAlbertID())) {
                    pr.setPrice(p.getPrice());
                    pr.setOldPrice(p.getOldPrice());
                    p = pr;
                }
            }
            ProductBundel productBundel = new ProductBundel(p);
            productlist.add(productBundel);
            Product.getProducts().add(p);
        }
    }

    public void addUser(User u) {
        users.add(u);
    }

    public void removeUser(User u) {
        users.remove(u);
        if (this.getUsers().size() == 0) {
            lists.remove(this);
        }
    }

    public int amountItems() {
        int amount = 0;
        for (ProductBundel pb : productlist) {
            amount += pb.getAmount();
        }
        return amount;
    }

    public String getName() {
        return name;
    }

    public UUID getId() {
        return id;
    }

    public double getTotalPrice() {
        double totaal = 0.0;
        for (ProductBundel pB : productlist) {
            totaal += pB.getProduct().getPrice() * pB.getAmount();
        }
        return Utils.round(totaal, 3);
    }

    public double getBonus() {
        double bonus = 0.0;
        for (ProductBundel pB : productlist) {
            if (pB.getProduct().getOldPrice() > 0) {
                double add = (pB.getProduct().getOldPrice() - pB.getProduct().getPrice()) * pB.getAmount();
                bonus += add;
            }
        }
        return Utils.round(bonus, 3);
    }

    public void removeProduct(UUID id) {
        productlist.removeIf(pB -> pB.getProduct().getId().equals(id));

    }

    public ArrayList<ProductBundel> getProductlist() {
        return productlist;
    }
}
