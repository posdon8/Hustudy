/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class reviews {
    private int reviewid;
    private String comment;
    private int rating;
    private users userid;
    private courses courseid;

    public reviews() {
    }

    public reviews(int reviewid, String comment, int rating, users userid, courses courseid) {
        this.reviewid = reviewid;
        this.comment = comment;
        this.rating = rating;
        this.userid = userid;
        this.courseid = courseid;
    }

    public int getReviewid() {
        return reviewid;
    }

    public void setReviewid(int reviewid) {
        this.reviewid = reviewid;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public users getUserid() {
        return userid;
    }

    public void setUserid(users userid) {
        this.userid = userid;
    }

    public courses getCourseid() {
        return courseid;
    }

    public void setCourseid(courses courseid) {
        this.courseid = courseid;
    }

    
}
