/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class cart {
    private int cartid;
    private courses courseid;
    private users userid;

    public cart() {
    }

    public cart(int cartid, courses courseid, users userid) {
        this.cartid = cartid;
        this.courseid = courseid;
        this.userid = userid;
    }

    public int getCartid() {
        return cartid;
    }

    public void setCartid(int cartid) {
        this.cartid = cartid;
    }

    public courses getCourseid() {
        return courseid;
    }

    public void setCourseid(courses courseid) {
        this.courseid = courseid;
    }

    public users getUserid() {
        return userid;
    }

    public void setUserid(users userid) {
        this.userid = userid;
    }
    
    
}
