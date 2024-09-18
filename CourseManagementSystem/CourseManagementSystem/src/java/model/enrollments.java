/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class enrollments {
    private int enrollmentid;
    private users userid;
    private courses courseid;

    public enrollments() {
    }

    public enrollments(int enrollmentid, users userid, courses courseid) {
        this.enrollmentid = enrollmentid;
        this.userid = userid;
        this.courseid = courseid;
    }

    public int getEnrollmentid() {
        return enrollmentid;
    }

    public void setEnrollmentid(int enrollmentid) {
        this.enrollmentid = enrollmentid;
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
