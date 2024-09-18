/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class grades {
    private int gradeid;
    private float midtermscore;
    private float finalscore;
    private float average;
    private enrollments enrollmentid;

    public grades() {
    }

    public grades(int gradeid, float midtermscore, float finalscore, float average, enrollments enrollmentid) {
        this.gradeid = gradeid;
        this.midtermscore = midtermscore;
        this.finalscore = finalscore;
        this.average = average;
        this.enrollmentid = enrollmentid;
    }

    public int getGradeid() {
        return gradeid;
    }

    public void setGradeid(int gradeid) {
        this.gradeid = gradeid;
    }

    public float getMidtermscore() {
        return midtermscore;
    }

    public void setMidtermscore(float midtermscore) {
        this.midtermscore = midtermscore;
    }

    public float getFinalscore() {
        return finalscore;
    }

    public void setFinalscore(float finalscore) {
        this.finalscore = finalscore;
    }

    public float getAverage() {
        return average;
    }

    public void setAverage(float average) {
        this.average = average;
    }

    public enrollments getEnrollmentid() {
        return enrollmentid;
    }

    public void setEnrollmentid(enrollments enrollmentid) {
        this.enrollmentid = enrollmentid;
    }

    
}
