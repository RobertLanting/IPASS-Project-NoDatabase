package com.example.demo.controller;

import com.example.demo.AlbertHeijn;
import com.example.demo.models.*;
import io.jsonwebtoken.*;
import io.jsonwebtoken.impl.crypto.MacProvider;
import org.apache.catalina.connector.Response;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Key;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.UUID;

@Controller
public class UserController {

    private static Shoplist selected = new Shoplist();
    private static ArrayList<Product> foundproducts = AlbertHeijn.searchProducts("");
    private static String searchtext = "";
    final static private Key key = MacProvider.generateKey();


    private String createToken(String username, String role) throws JwtException {
        Calendar expiration = Calendar.getInstance();
        expiration.add(Calendar.MINUTE, 30);

        return Jwts.builder()
                .setSubject(username)
                .setExpiration(expiration.getTime())
                .claim("role", role)
                .signWith(SignatureAlgorithm.HS512, key)
                .compact();
    }

    private User validateUser(Cookie[] cookies) {

        for (Cookie c : cookies) {
            if (c.getName().equals("token")) {
                try {
                    Claims claims = Jwts.parser().setSigningKey(key).parseClaimsJws(c.getValue()).getBody();
                    return User.findUser(claims.getSubject());
                } catch (SignatureException e) {
                    return null;
                }
            }
        }
        return null;
    }

    private void eraseCookie(HttpServletRequest req, HttpServletResponse resp) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null)
            for (Cookie cookie : cookies) {
                cookie.setValue("");
                cookie.setPath("/");
                cookie.setMaxAge(0);
                resp.addCookie(cookie);
            }
    }


    @RequestMapping({"/"})
    public String start(Model model) {
        return "start";
    }



    @RequestMapping({"/search"})
    public String search(@RequestParam(required = false) String search,
                         @RequestParam(required = false) UUID product,
                         HttpServletRequest request, Model model) {

        User currentUser = validateUser(request.getCookies());
        if (currentUser == null) return "login";

        if (product != null) {
            for (Product p : foundproducts) {
                if (p.getId().equals(product)) {
                    selected.addItem(p);
                    model.addAttribute("product", p);
                }
            }
        }
        if (search != null) {
            if (!searchtext.equals(search)) {
                setSearchtext(search);
                foundproducts = AlbertHeijn.searchProducts(search);
            }
        }
        model.addAttribute("products", foundproducts);
        return "search";
    }

    @RequestMapping({"/login"})
    public String login(@RequestParam(required = false) String regmail,
                        @RequestParam(required = false) String regusername,
                        @RequestParam(required = false) String regpassword,
                        @RequestParam(required = false) String username,
                        @RequestParam(required = false) String password,
                        Model model, HttpServletResponse response) {

        if (regmail != null & regusername != null & regpassword != null) {
            for (User u : User.getUsers()) {
                if (u.getUsername().equals(regusername.strip()) || u.getMail().equals(regmail.strip())) {
                    System.out.println("error");
                    model.addAttribute("error", "username of email is al in gebruik");
                    return "register";
                }
                if (regusername.contains(" ") || regmail.contains(" ") || regpassword.contains(" ")) {
                    System.out.println("error");
                    model.addAttribute("error", "er zijn geen spaties toegestaan");
                    return "register";
                }
            }
            User.getUsers().add(new User(regusername.strip(), regpassword.strip(), regmail.strip()));
            return "login";
        }
        if (User.validateLogin(username, password)) {
            String token = createToken(username, "user");
            Cookie cookie = new Cookie("token", token);
            cookie.setMaxAge(60*60);
            response.addCookie(cookie);
            return "main";
        }

        return "login";
    }


        @RequestMapping({"/home"})
    public String home(@RequestParam(required = false) String name,
                       @RequestParam(required = false) UUID id,
                       @RequestParam(required = false) UUID removelist,
                       @RequestParam(required = false) String leavelist,
                       Model model, HttpServletRequest request) {

        User currentUser = validateUser(request.getCookies());
        if (currentUser == null) return "login";

        if (leavelist != null && leavelist.equals("true")) {
            selected.removeUser(currentUser);
        }
        if (removelist != null) {
            Shoplist.removeList(removelist);
        }
        if (name != null) {
            Shoplist.addList(new Shoplist(name, currentUser));
        }
        if (id != null) {
            Shoplist.removeList(id);
        }
        model.addAttribute("name",currentUser.getUsername());
        model.addAttribute("lists", Shoplist.getListsOfUser(currentUser));
        for (Shoplist s : Shoplist.getLists()) {
            for (ProductBundel p : s.getProductlist()) {
                System.out.println(p.getProduct().getId());
            }
        }
        return "main";
    }

    @RequestMapping({"/list"})
    public String list(@RequestParam(required = false) UUID id,
                       @RequestParam(required = false) UUID trash,
                       @RequestParam(required = false) UUID itemplus,
                       @RequestParam(required = false) UUID itemmin,
                       @RequestParam(required = false) String usernameadd,
                       @RequestParam(required = false) String usernameremove,
                       Model model, HttpServletRequest request) {

        User currentUser = validateUser(request.getCookies());
        if (currentUser == null) return "login";

        if (usernameremove != null) {
            User found = null;
            for (User u : selected.getUsers())
                if (u.getUsername().equals(usernameremove)) {
                    found = u;
                }
            selected.removeUser(found);
        }
        if (usernameadd != null) {
            if (User.findUser(usernameadd.strip()) != null && !selected.getUsers().contains(User.findUser(usernameadd.strip()))) {
                selected.addUser(User.findUser(usernameadd.strip()));
            }
        }
        if (itemplus != null) {
            selected.findItem(itemplus).addAmount();
        }
        if (itemmin != null) {
            selected.findItem(itemmin).removeAmount();
        }
        if (id != null) {
            selected = Shoplist.findList(id);
        }
        if (trash != null) {
            selected.removeProduct(trash);
        }
        assert selected != null;
        model.addAttribute("user",currentUser);
        model.addAttribute("userlist",selected);
        return "list";
    }

    @RequestMapping({"/register"})
        public String register( Model model) {

        return "register";
    }

    @RequestMapping({"/bonus"})
        public String bonus(Model model) {
        return "bonus";
    }

    @RequestMapping({"/manual"})
        public String manual(@RequestParam(required = false) String name,
                             @RequestParam(required = false) String description,
                             @RequestParam(required = false) Double price,
                             @RequestParam(required = false) UUID product,
                             @RequestParam(required = false) UUID trashid,
                             Model model, HttpServletRequest request) {

        User currentUser = validateUser(request.getCookies());
        if (currentUser == null) return "login";

        if (trashid != null) {
            currentUser.getOwnProducts().remove(currentUser.findOwnProduct(trashid));
        }
        if (name != null && price != null && price > 0) {
            Product newProduct = new Product(name,description,price,-1);
            currentUser.getOwnProducts().add(newProduct);
        }

        if (product != null) {
                selected.addItem(currentUser.findOwnProduct(product));
            }

        model.addAttribute("products", currentUser.getOwnProducts());
        return "manual";
    }

    @RequestMapping({"/logout"})
        public String logout(HttpServletRequest request, HttpServletResponse response) {
        eraseCookie(request, response);
        return "login";
    }


    public static void setSearchtext(String searchtext) {
        UserController.searchtext = searchtext;
    }
}
