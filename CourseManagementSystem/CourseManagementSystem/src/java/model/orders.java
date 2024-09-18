/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class orders {
    private int orderid;
    private Date orderdate;
    private String note;
    private int totalamount;
    private users userid;

    public orders() {
    }

    public orders(int orderid, Date orderdate, String note, int totalamount, users userid) {
        this.orderid = orderid;
        this.orderdate = orderdate;
        this.note = note;
        this.totalamount = totalamount;
        this.userid = userid;
    }

    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public Date getOrderdate() {
        return orderdate;
    }

    public void setOrderdate(Date orderdate) {
        this.orderdate = orderdate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getTotalamount() {
        return totalamount;
    }

    public void setTotalamount(int totalamount) {
        this.totalamount = totalamount;
    }

    public users getUserid() {
        return userid;
    }

    public void setUserid(users userid) {
        this.userid = userid;
    }

    
}
