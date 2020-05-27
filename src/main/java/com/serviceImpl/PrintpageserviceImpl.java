package com.serviceImpl;

import com.entity.Printpage;
import com.mapper.PrintpageMapper;

import com.service.Printpageservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
@Service
public class PrintpageserviceImpl implements Printpageservice {
    @Autowired
    PrintpageMapper printpageMapper;
    @Override
    public List<Printpage> selectAll() {
        return printpageMapper.selectAll();
    }

    @Override
    public void save(Printpage printpage) {
         printpageMapper.save(printpage);
    }
}
