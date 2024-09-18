/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class orderdetails {
    private int orderdetailid;
    private int price;
    private courses courseid;
    private int orderid;

    public orderdetails() {
    }

    public orderdetails(int orderdetailid, int price, courses courseid, int orderid) {
        this.orderdetailid = orderdetailid;
        this.price = price;
        this.courseid = courseid;
        this.orderid = orderid;
    }

    public int getOrderdetailid() {
        return orderdetailid;
    }

    public void setOrderdetailid(int orderdetailid) {
        this.orderdetailid = orderdetailid;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public courses getCourseid() {
        return courseid;
    }

    public void setCourseid(courses courseid) {
        this.courseid = courseid;
    }

    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    
}
