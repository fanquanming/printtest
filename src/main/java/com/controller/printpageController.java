package com.controller;
import com.entity.Printpage;
import com.serviceImpl.PrintpageserviceImpl;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/printpage")

public class printpageController {

    @Autowired
    PrintpageserviceImpl printpageservice;
    @RequestMapping("/findAll")

    public void selectAll(HttpServletResponse httpServletResponse) throws IOException {
       List<Printpage> list = printpageservice.selectAll();
       for(Printpage p:list){
           System.out.println(p);
       }
        //解决json数据传入前台乱码问题
        httpServletResponse.setCharacterEncoding("utf-8");
        httpServletResponse.getWriter().println(""+list.get(0).getContent());
        //把字符串写入一个文件
        String s = list.get(0).getContent();
        FileWriter fw = null;
        File f = new File("C:\\Users\\Dell\\Desktop\\SpringCloud\\printtestmaven\\src\\main\\webapp\\a.html");

        try {
            if(!f.exists()){
                f.createNewFile();
            }
            fw = new FileWriter(f);
            BufferedWriter out = new BufferedWriter(fw);
            out.write(s, 0, s.length()-1);
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    @RequestMapping("/save")

    public void save(Printpage printpage, HttpServletResponse httpServletResponse) throws IOException {
        String s = printpage.getContent();
        System.out.println(s);
        //JSONObject json_test = JSONObject.fromObject(s);
        //得到json串中key对于的value的值。
       // String stwo = json_test.get("page").toString();
       // System.out.println(stwo);
        //改变printpage里面的content内容
       // printpage.setContent(stwo);
        //解决json数据传入前台乱码问题
        httpServletResponse.setCharacterEncoding("utf-8");
        if(!"".equals(printpage.getContent())) {
            httpServletResponse.getWriter().println("保存成功");
            printpageservice.save(printpage);
        }
        else {
            httpServletResponse.getWriter().println("保存失败");
        }

    }
}
