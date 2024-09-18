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
public class news {
    private int newsid;
    private String title;
    private String content;
    private Date publisheddate;
    private users adminid;

    public news() {
    }

    public news(int newsid, String title, String content, Date publisheddate) {
        this.newsid = newsid;
        this.title = title;
        this.content = content;
        this.publisheddate = publisheddate;
    }
    
    

    public news(int newsid, String title, String content, Date publisheddate, users adminid) {
        this.newsid = newsid;
        this.title = title;
        this.content = content;
        this.publisheddate = publisheddate;
        this.adminid = adminid;
    }

    public int getNewsid() {
        return newsid;
    }

    public void setNewsid(int newsid) {
        this.newsid = newsid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPublisheddate() {
        return publisheddate;
    }

    public void setPublisheddate(Date publisheddate) {
        this.publisheddate = publisheddate;
    }

    public users getAdminid() {
        return adminid;
    }

    public void setAdminid(users adminid) {
        this.adminid = adminid;
    }

    
}
