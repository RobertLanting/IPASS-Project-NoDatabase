package com.example.demo;

import com.example.demo.models.Product;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;

public class AlbertHeijn {
    public static ArrayList<Product> searchProducts(String search) {
        try {
            ArrayList<Product> products = new ArrayList<>();
            Document doc = Jsoup.connect("https://www.ah.nl/zoeken?query=" + search + "&page=3").get();
            Elements articles = doc.select("article");
            for (Element article : articles) {
                ArrayList<String> text = new ArrayList<>();
                String albertid = null;
                for (Element href : article.getElementsByAttribute("href")) {
                    Elements spans = href.getElementsByTag("span");
                    for (Element span : spans) {
                        if (!span.getClass().toString().contains("shield")) {
                            text.add(span.text());
                        }
                    }
                    Element a = href.getElementsByTag("a").first();
                    if (a.getElementsByTag("figure").isEmpty()) {
                        if (a.attr("href").split("/")[3].contains("wi")) {
                            albertid = a.attr("href").split("/")[3];
                        }
                    }
                }
                if (text.size() < 8 && albertid != null) {
                    Product p = new Product(text.get(text.size() - 1),
                            text.get(3),
                            Double.parseDouble(text.get(0) + text.get(1) + text.get(2)),
                            0);
                    products.add(p);
                    p.setPicture(article.getElementsByTag("img").get(0).attr("src"));
                    p.setAlbertID(albertid);
                }
                else if (albertid != null) {
                    Product p = new Product(
                            text.get(text.size() - 1),
                            text.get(6),
                            Double.parseDouble(text.get(3) + text.get(4) + text.get(5)),
                            Double.parseDouble(text.get(0) + text.get(1) + text.get(2)));
                    products.add(p);
                    p.setPicture(article.getElementsByTag("img").get(0).attr("src"));
                    p.setAlbertID(albertid);
                }
            }
            return products;
        } catch (Exception e) {
            System.out.println(e);
            return new ArrayList<>();
        }
    }
}
