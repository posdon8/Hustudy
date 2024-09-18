/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class typecourse {
    private int typecourseid;
    private String typecoursename;
    private category categoryid;

    public typecourse() {
    }

    public typecourse(int typecourseid, String typecoursename, category categoryid) {
        this.typecourseid = typecourseid;
        this.typecoursename = typecoursename;
        this.categoryid = categoryid;
    }

    public int getTypecourseid() {
        return typecourseid;
    }

    public void setTypecourseid(int typecourseid) {
        this.typecourseid = typecourseid;
    }

    public String getTypecoursename() {
        return typecoursename;
    }

    public void setTypecoursename(String typecoursename) {
        this.typecoursename = typecoursename;
    }

    public category getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(category categoryid) {
        this.categoryid = categoryid;
    }

    @Override
    public String toString() {
        return "typecourse{" + "typecourseid=" + typecourseid + ", typecoursename=" + typecoursename + ", categoryid=" + categoryid.toString() + '}';
    }

    
}
