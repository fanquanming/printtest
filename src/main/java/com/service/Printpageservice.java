package com.service;

import com.entity.Printpage;

import java.util.List;

public interface Printpageservice {
    public List<Printpage> selectAll();
    public void save(Printpage printpage);
}
