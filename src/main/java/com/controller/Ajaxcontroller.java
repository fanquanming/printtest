package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/ajax")
public class Ajaxcontroller {
    @RequestMapping("/a1")
    public void ajax(String name, HttpServletResponse httpServletResponse) throws IOException {
        System.out.println(name);
        if("admin".equals(name)) {
            httpServletResponse.getWriter().println("i can do it");
        }else{
            httpServletResponse.getWriter().println("not do it");
        }
    }
}
