package com.example.demo;

import com.example.demo.controller.UserController;
import com.example.demo.models.Shoplist;
import com.example.demo.models.Testdata;
import com.example.demo.models.User;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import java.util.List;

@SpringBootApplication
@ComponentScan({"com.example.demo.controller"})
public class DemoApplication {

    public static void main(String[] args) {
        Testdata.maakLijstjes();
        SpringApplication.run(DemoApplication.class, args);

    }

}
