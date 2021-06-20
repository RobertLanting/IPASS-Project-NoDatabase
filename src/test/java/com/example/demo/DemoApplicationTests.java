package com.example.demo;

import com.example.demo.models.Product;
import com.example.demo.models.ProductBundel;
import com.example.demo.models.Shoplist;
import com.example.demo.models.User;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
	void addProductTest() {
		User testUser = new User("username", "password", "mail");
		Product testProduct = new Product("test","test", 10.0,0);
		Shoplist testShoplist = new Shoplist("test",testUser);
		testShoplist.addItem(testProduct);
		assert testShoplist.amountItems() == 1;
	}

	@Test
	void addUserTest() {
		User testUser = new User("username", "password", "mail");
		User testUser2 = new User("username2", "password2", "mail2");
		Shoplist testShoplist = new Shoplist("test",testUser);
		testShoplist.addUser(testUser2);
		assert testShoplist.getUsers().size() == 2;
	}

	@Test
	void removeProductTest() {
		User testUser = new User("username", "password", "mail");
		Product testProduct = new Product("test","test", 10.0,0);
		Shoplist testShoplist = new Shoplist("test",testUser);
		testShoplist.addItem(testProduct);
		testShoplist.removeProduct(testProduct.getId());
		assert testShoplist.amountItems() == 0;
	}

	@Test
	void removeUserTest() {
		User testUser = new User("username", "password", "mail");
		User testUser2 = new User("username2", "password2", "mail2");
		Shoplist testShoplist = new Shoplist("test",testUser);
		testShoplist.addUser(testUser2);
		testShoplist.removeUser(testUser);
		assert testShoplist.getUsers().size() == 1;
	}

	@Test
	void productBundelAmountStopAtOne() {
		Product testProduct = new Product("test","test", 10.0,0);
		ProductBundel testProductbundel = new ProductBundel(testProduct);
		testProductbundel.removeAmount();
		assert testProductbundel.getAmount() == 1;
	}

	@Test
	void shoplistDeleteAtZeroUsers() {
		User testUser = new User("username", "password", "mail");
		Shoplist testShoplist = new Shoplist("test",testUser);
		testShoplist.removeUser(testUser);
		assert Shoplist.findList(testShoplist.getId()) == null;
	}

	@Test
	void getListsOfUserTest() {
		User testUser = new User("username", "password", "mail");
		Shoplist testShoplist = new Shoplist("test",testUser);
		Shoplist testShoplist2 = new Shoplist("test2",testUser);
		Shoplist.getLists().add(testShoplist);
		Shoplist.getLists().add(testShoplist2);
		assert Shoplist.getListsOfUser(testUser).size() == 2;
	}
}
