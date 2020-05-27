package com.mapper;

import com.entity.Printpage;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;



public interface PrintpageMapper {
     List<Printpage> selectAll();
     void save(Printpage printpage);
}

