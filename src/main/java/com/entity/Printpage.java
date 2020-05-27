package com.entity;

import java.util.Date;

public class Printpage {
    String company;
    String content;
    Date registertime;
    Date updatetime;

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getRegistertime() {
        return registertime;
    }

    public void setRegistertime(Date registertime) {
        this.registertime = registertime;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    @Override
    public String toString() {
        return "printpage{" +
                "company='" + company + '\'' +
                ", content='" + content + '\'' +
                ", registertime=" + registertime +
                ", updatetime=" + updatetime +
                '}';
    }
}
