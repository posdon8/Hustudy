/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class courses {
    private int courseid ;
    private String title;
    private String description;
    private int price;
    private String linkimg;
    private typecourse typecourseid;
    private users userid;

    public courses() {
    }

    public courses(int courseid, String title, String description, int price, String linkimg) {
        this.courseid = courseid;
        this.title = title;
        this.description = description;
        this.price = price;
        this.linkimg = linkimg;
    }
    
    

    public courses(int courseid, String title, String description, int price, String linkimg, typecourse typecourseid, users userid) {
        this.courseid = courseid;
        this.title = title;
        this.description = description;
        this.price = price;
        this.linkimg = linkimg;
        this.typecourseid = typecourseid;
        this.userid = userid;
    }

    public int getCourseid() {
        return courseid;
    }

    public void setCourseid(int courseid) {
        this.courseid = courseid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getLinkimg() {
        return linkimg;
    }

    public void setLinkimg(String linkimg) {
        this.linkimg = linkimg;
    }

    public typecourse getTypecourseid() {
        return typecourseid;
    }

    public void setTypecourseid(typecourse typecourseid) {
        this.typecourseid = typecourseid;
    }

    public users getUserid() {
        return userid;
    }

    public void setUserid(users userid) {
        this.userid = userid;
    }

    @Override
    public String toString() {
        return "courses{" + "courseid=" + courseid + ", title=" + title + ", description=" + description + ", price=" + price + ", linkimg=" + linkimg + ", typecourseid=" + typecourseid + ", userid=" + userid + '}';
    }

    
}
